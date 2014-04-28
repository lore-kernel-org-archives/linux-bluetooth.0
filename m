Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBdNeCSjc+XfQ-oA8EtYK9=yK2yBiKn=vcQuZY=gjBOHzw@mail.gmail.com>
References: <1397610266-20894-1-git-send-email-armansito@chromium.org>
	<1397610266-20894-2-git-send-email-armansito@chromium.org>
	<CAKT1EBdNeCSjc+XfQ-oA8EtYK9=yK2yBiKn=vcQuZY=gjBOHzw@mail.gmail.com>
Date: Mon, 28 Apr 2014 16:15:02 -0700
Message-ID: <CAHrH25QDHt7NamT-55LD8h98vo21SimN91PenuRYHjAeJwGi+A@mail.gmail.com>
Subject: Re: [RFC 1/2] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Apr 25, 2014 at 6:42 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Arman,
>
> Below are some comments in addition to your findings ...
>
> Remember that incoming and outgoing queues are independent, and there
> isn't "flow control" for notification, it can be sent at any time.

Yes, there will be a separate queue for replies and outgoing requests
and no queue for notifications.

>> +struct bt_att_request {
>> +       unsigned int id;
>> +       uint16_t opcode;
>> +       void *pdu;
>> +       uint16_t len;
>> +       bt_att_request_func_t callback;
>> +       bt_att_destroy_func_t destroy;
>> +       void *user_data;
>
> PDU could be declared as "uint8_t pdu[]" at the end the struct, but if
> you are trying to keep it aligned with mgmt.c it should be better to
> keep it as pointer.

I did indeed want to keep it consistent with mgmt.c

> I think ATT_ERROR_IO is BlueZ specific (internal). Please make sure if
> this error is being handled properly by the caller, maybe it should
> not be used at all.

Yes, it's BlueZ specific and since it's an I/O error here, I figured
that reporting an internal error made sense. I made sure that
ATT_ERROR_IO was explicitly declared in the header as a possible
application error (similar to what's in attrib/att.h).

Though, I see that it is not being reported properly in the code here.
The callback should be invoked with ATT_OP_ERROR_RESP with a "struct
bt_att_error_rsp_param". Fixed in next patch set.

>> +static bool handle_exchange_mtu_rsp(struct bt_att *att, uint8_t opcode,
>> +                                       const uint8_t *pdu, uint16_t pdu_length)
>> +{
>> +       struct bt_att_exchange_mtu_rsp_param param;
>> +
>> +       if (pdu_length != 3)
>> +               return false;
>
> I noticed that length is always "1" + param. Where "1" refers to ATT opcode.

In this case, yes, the pdu_length is expected to be 1 + sizeof(param),
but this won't always be true. For example, the "Find Information"
response has a variable length, in which case the pdu_length won't
depend on the length of the param structure. This will be more clear
when I upload that patch later.

>> +
>> +       param.server_rx_mtu = get_le16(pdu + 1);
>> +
>> +       request_complete(att, ATT_OP_EXCHANGE_MTU_REQ, opcode,
>> +                                                       &param, sizeof(param));
>> +
>> +       return true;
>> +}
>> +
>> +static bool handle_response(struct bt_att *att, uint8_t opcode,
>> +                                       const uint8_t *pdu, uint16_t pdu_length)
>> +{
>
> Is it necessary to inform the opcode? Maybe you could use pdu[0].

You're right, it's a bit unnecessary. Changed this to not take in the opcode.

>
>> +       if (opcode == ATT_OP_ERROR_RESP)
>> +               return handle_error_rsp(att, opcode, pdu, pdu_length);
>> +
>> +       if (opcode == ATT_OP_EXCHANGE_MTU_RESP)
>> +               return handle_exchange_mtu_rsp(att, opcode, pdu, pdu_length);
>> +
>> +       return false;
>> +}
>> +
>> +static void read_watch_destroy(void *user_data)
>> +{
>> +       struct bt_att *att = user_data;
>> +
>> +       if (att->destroyed) {
>> +               queue_destroy(att->pending_list, NULL);
>> +               free(att);
>> +       }
>> +}
>> +
>> +static bool can_read_data(struct io *io, void *user_data)
>> +{
>> +       struct bt_att *att = user_data;
>> +       uint8_t *pdu;
>> +       ssize_t bytes_read;
>> +       uint16_t opcode;
>> +
>> +       bytes_read = read(att->fd, att->buf, att->len);
>> +       if (bytes_read < 0)
>> +               return false;
>> +
>> +       util_hexdump('>', att->buf, bytes_read,
>> +                                       att->debug_callback, att->debug_data);
>> +
>> +       if (bytes_read < 1)
>> +               return true;
>
> Why "1"? What is the smallest ATT PDU? Notification?

It depends. There are a couple of response PDU's that don't have any
parameters (e.g. Write Response). 1 really means "at least one byte
for the opcode". I defined a macro for this to make it more explicit
in the next patch set.

>> +struct bt_att *bt_att_new(int fd)
>> +{
>> +       struct bt_att *att;
>> +
>> +       if (fd < 0)
>> +               return NULL;
>> +
>> +       att = new0(struct bt_att, 1);
>
> Missing memory allocation fail checking.

Done.

> A label for cleanup will be more convenient.

Done.

>> +static bool encode_mtu_req(const void *param, uint16_t length, void *buf,
>> +                                       uint16_t mtu, uint16_t *pdu_length)
>> +{
>> +       const struct bt_att_exchange_mtu_req_param *cp = param;
>> +       const uint16_t len = 3;
>> +
>> +       if (!param || !buf)
>> +               return false;
>> +
>> +       if (length != sizeof(struct bt_att_exchange_mtu_req_param))
>> +               return false;
>> +
>> +       if (len > mtu)
>> +               return false;
>
> If your plan is to use encode_pdu() as a switch for all possible
> requests, maybe it will be better to move the common parameters
> validation to it.

Done.

>> +bool bt_att_cancel(struct bt_att *att, unsigned int id)
>> +{
>
> Does it make sense to cancel only one ATT request?
> In general if some error happens you need to cancel all requests and
> close the socket.

Not sure. I added this to be consistent with mgmt but we can remove it
until we know if we need it or not.

> I recommend do leave them out until you really need these application
> defined errors. Maybe you can propose a solution which doesn't require
> this workaround.
>> +/* Application defined errors */
>> +#define ATT_ERROR_IO                                   0x80
>> +#define ATT_ERROR_TIMEOUT                              0x81
>> +#define ATT_ERROR_ABORTED                              0x82
>>

Maybe leave ATT_ERROR_IO for now?

Cheers,
Arman
