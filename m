Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [RFC 2/2] btproxy: Add three-wire (h5) protocol initial support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151127103038.GA26866@comms.fi.intel.com>
Date: Fri, 27 Nov 2015 04:25:30 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5FF8776-8359-4906-80C5-88B57E4CF898@holtmann.org>
References: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1448551424-18448-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <4E34A599-0424-4005-B228-DE830E6906E6@holtmann.org> <20151127103038.GA26866@comms.fi.intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> With H5 support it is possible to create pts and attach to it using
>>> hciattach ot btattach with 3wire protocol. This is useful for testing
>>> and developing three-wire protocol.
>>> Implementation is based on kernel hci_h5.c H5 protocol.
>>> 
>>> Simple usage:
>>> To open virtual pts run:
>>> $ sudo tools/btproxy -d --pty -3
>>> Opening pseudoterminal
>>> New pts created: /dev/pts/2
>>> Opening user channel for hci0
>>> 
>>> Now attach to it using hciattach:
>>> $ sudo hciattach -n /dev/pts/2 3wire
>>> Device setup complete
>>> ---
>>> tools/btproxy.c | 541 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 535 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/tools/btproxy.c b/tools/btproxy.c
>>> index 6d78876..c718e48 100644
>>> --- a/tools/btproxy.c
>>> +++ b/tools/btproxy.c
>>> @@ -47,23 +47,22 @@
>>> #include "src/shared/util.h"
>>> #include "src/shared/mainloop.h"
>>> #include "src/shared/ecc.h"
>>> +#include "src/shared/queue.h"
>>> +#include "lib/bluetooth.h"
>>> +#include "lib/hci.h"
>>> #include "monitor/bt.h"
>>> 
>>> #define HCI_BREDR	0x00
>>> #define HCI_AMP		0x01
>>> 
>>> #define BTPROTO_HCI	1
>>> -struct sockaddr_hci {
>>> -	sa_family_t	hci_family;
>>> -	unsigned short	hci_dev;
>>> -	unsigned short  hci_channel;
>>> -};
>>> #define HCI_CHANNEL_USER	1
>> 
>> please do not do this.
> 
> Why? I added #include "lib/hci.h" where this structure defined, why do
> we need redefined it again? It was defined 3 times.

we want to get rid of using libbluetooth over and over again. We need to start somewhere. And I have no idea on what you would gain from including lib/hci.h in this case.

>>> static uint16_t hci_index = 0;
>>> static bool client_active = false;
>>> static bool debug_enabled = false;
>>> static bool emulate_ecc = false;
>>> +static bool three_wire = false;
>>> 
>>> static void hexdump_print(const char *str, void *user_data)
>>> {
>>> @@ -287,6 +286,516 @@ static void host_read_destroy(void *user_data)
>>> 		mainloop_remove_fd(proxy->dev_fd);
>>> }
>>> 
>>> +/* three-wire (H5) packet processing */
>>> +
>>> +#define H5_ACK_TIMEOUT		250
>>> +
>>> +#define HCI_3WIRE_ACK_PKT	0
>>> +#define HCI_3WIRE_LINK_PKT	15
>>> +
>>> +/*
>>> + * Maximum Three-wire packet:
>>> + *     4 byte header + max value for 12-bit length + 2 bytes for CRC
>>> + */
>>> +#define H5_MAX_LEN (4 + 0xfff + 2)
>>> +
>>> +/* Sliding window size */
>>> +#define H5_TX_WIN_MAX		4
>>> +
>>> +#define SLIP_DELIMITER	0xc0
>>> +#define SLIP_ESC	0xdb
>>> +#define SLIP_ESC_DELIM	0xdc
>>> +#define SLIP_ESC_ESC	0xdd
>>> +
>>> +#define H5_RX_ESC	1
>>> +
>>> +#define H5_HDR_SEQ(hdr)		((hdr)[0] & 0x07)
>>> +#define H5_HDR_ACK(hdr)		(((hdr)[0] >> 3) & 0x07)
>>> +#define H5_HDR_CRC(hdr)		(((hdr)[0] >> 6) & 0x01)
>>> +#define H5_HDR_RELIABLE(hdr)	(((hdr)[0] >> 7) & 0x01)
>>> +#define H5_HDR_PKT_TYPE(hdr)	((hdr)[1] & 0x0f)
>>> +#define H5_HDR_LEN(hdr)		((((hdr)[1] >> 4) & 0x0f) + ((hdr)[2] << 4))
>>> +
>>> +#define H5_SET_SEQ(hdr, seq)	((hdr)[0] |= (seq))
>>> +#define H5_SET_ACK(hdr, ack)	((hdr)[0] |= (ack) << 3)
>>> +#define H5_SET_RELIABLE(hdr)	((hdr)[0] |= 1 << 7)
>>> +#define H5_SET_TYPE(hdr, type)	((hdr)[1] |= type)
>>> +#define H5_SET_LEN(hdr, len)	(((hdr)[1] |= ((len) & 0x0f) << 4), \
>>> +						((hdr)[2] |= (len) >> 4))
>>> +
>>> +static const uint8_t sync_req[] = { 0x01, 0x7e };
>>> +static const uint8_t sync_rsp[] = { 0x02, 0x7d };
>>> +static const uint8_t conf_req[] = { 0x03, 0xfc };
>>> +static const uint8_t wakeup_req[] = { 0x05, 0xfa };
>>> +static const uint8_t woken_req[] = { 0x06, 0xf9 };
>>> +static const uint8_t sleep_req[] = { 0x07, 0x78 };
>>> +
>>> +static struct h5 {
>>> +	size_t rx_pending;
>>> +	uint8_t rx_buf[H5_MAX_LEN];
>>> +	uint8_t *rx_ptr;
>>> +	uint8_t flags;
>>> +
>>> +	uint8_t rx_ack;		/* Received last ack number */
>>> +	uint8_t tx_seq;		/* Next seq number to send */
>>> +	uint8_t tx_ack;		/* Next ack number to send */
>>> +
>>> +	uint8_t tx_win;
>>> +
>>> +	enum {
>>> +		H5_UNINITIALIZED,
>>> +		H5_INITIALIZED,
>>> +		H5_ACTIVE,
>>> +	} state;
>>> +
>>> +	int timer_id;
>>> +
>>> +	struct queue *tx_queue_unack;
>>> +	struct queue *tx_queue_unrel;
>>> +	struct queue *tx_queue_rel;
>>> +
>>> +	int (*rx_func)(struct proxy *proxy, uint8_t byte);
>>> +} h5;
>> 
>> No global static variables please. That should be part of struct proxy instead. Global variables will cause problems if you ever try to start two instances.
> 
> OK, I will move it there.
> 
>> 
>>> +
>>> +struct h5_pkt {
>>> +	uint16_t len;
>>> +	uint8_t data[0];
>>> +};
>> 
>> I think using get_unaligned_le16 to get the length would be a lot simpler.
> 
> Sorry, do not get this, how can we use get_unaligned_le16() ?

len = get_unaligned_le16(buf)
data = buf + 2

Regards

Marcel

