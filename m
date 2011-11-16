Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <20111114100806.GC13665@aemeltch-MOBL1>
Date: Wed, 16 Nov 2011 17:36:38 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <95D6271C-626F-409E-B4AB-92F6C7E2AC15@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org> <20111114100806.GC13665@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Nov 14, 2011, at 7:08 AM, Andrei Emeltchenko wrote:

> Hi Andre,
> 
> On Fri, Nov 11, 2011 at 07:50:24PM -0300, Andre Guedes wrote:
>> This patch adds support for LE-Only discovery procedure through
>> management interface.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h      |    1 +
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_event.c        |   25 ++++++++++++++++++++++---
>> net/bluetooth/mgmt.c             |   25 +++++++++++++++++++++++--
>> 4 files changed, 47 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index bd3cecd..ca09998 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -210,6 +210,7 @@ enum {
>> 
>> #define LMP_EV4		0x01
>> #define LMP_EV5		0x02
>> +#define LMP_NO_BREDR	0x20
>> #define LMP_LE		0x40
>> 
>> #define LMP_SNIFF_SUBR	0x02
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 9da5b69..55b78ec 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -678,6 +678,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>> #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>> #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
>> #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>> +#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
>> 
>> /* ----- Extended LMP capabilities ----- */
>> #define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & LMP_HOST_LE)
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index dcbbffe..037c7c0 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -954,24 +954,43 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>> 
>> 	BT_DBG("%s status 0x%x", hdev->name, status);
>> 
>> -	if (status)
>> -		return;
>> -
>> 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
>> 	if (!cp)
>> 		return;
>> 
>> 	if (cp->enable == 0x01) {
> 
> Can we fix also magic number here and below?

I see your point here, but this is not a magic number, it is
just a true/false value.

BR,

Andre

