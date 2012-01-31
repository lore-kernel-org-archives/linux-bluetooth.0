Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327959864.1955.171.camel@aeonflux>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	<1327531949-29463-6-git-send-email-andre.guedes@openbossa.org>
	<1327959864.1955.171.camel@aeonflux>
Date: Tue, 31 Jan 2012 10:44:59 -0300
Message-ID: <CACJA=fU+ofp3vM=M7Jj-BE7LrKHkCG6zEi26bTidCwDih_utNA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Bluetooth: MGMT start discovery LE-Only support
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 30, 2012 at 6:44 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch adds LE-Only discovery procedure support to MGMT Start
>> Discovery command.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0net/bluetooth/hci_event.c | =A0 13 ++++++++++++-
>> =A0net/bluetooth/mgmt.c =A0 =A0 =A0| =A0 20 +++++++++++++++++++-
>> =A02 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 856ab35..fb2497b 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1033,6 +1033,13 @@ static void hci_cc_le_set_scan_param(struct hci_d=
ev *hdev, struct sk_buff *skb)
>>
>> =A0 =A0 =A0 hdev->le_scan_result =3D -bt_to_errno(status);
>> =A0 =A0 =A0 wake_up(&hdev->le_scan_wait_q);
>> +
>> + =A0 =A0 if (status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_lock(hdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mgmt_start_discovery_failed(hdev, status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_unlock(hdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> =A0}
>>
>> =A0static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>> @@ -1052,8 +1059,12 @@ static void hci_cc_le_set_scan_enable(struct hci_=
dev *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->le_scan_result =3D -bt_to_errno(status=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&hdev->le_scan_wait_q);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_lock(hdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mgmt_start_discovery_failed(hd=
ev, status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_unlock(hdev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> are these two related to the other changes or just actual bug fixes?

These two are related to MGMT Start Discovery command itself. If LE
scan HCI commands fail we have to send mgmt_start_discovery_failed
event.

>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 8970799..0a1fa4c 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -35,6 +35,15 @@
>> =A0#define MGMT_VERSION 0
>> =A0#define MGMT_REVISION =A0 =A0 =A0 =A01
>>
>> +/*
>> + * These LE scan and inquiry parameters were chosen according to LE Gen=
eral
>> + * Discovery Procedure specification.
>> + */
>> +#define LE_SCAN_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01
>> +#define LE_SCAN_WIN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x12
>> +#define LE_SCAN_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x12
>> +#define LE_SCAN_TIMEOUT_LE_ONLY =A0 =A0 =A0 =A0 =A0 =A0 =A010240 =A0 /*=
 TGAP(gen_disc_scan_min) */
>> +
>> =A0#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
>>
>> =A0#define SERVICE_CACHE_TIMEOUT (5 * 1000)
>> @@ -1897,6 +1906,7 @@ static int start_discovery(struct sock *sk, u16 in=
dex,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 unsigned char *data, u16 len)
>> =A0{
>> =A0 =A0 =A0 struct mgmt_cp_start_discovery *cp =3D (void *) data;
>> + =A0 =A0 unsigned long discov_type =3D cp->type;
>> =A0 =A0 =A0 struct pending_cmd *cmd;
>> =A0 =A0 =A0 struct hci_dev *hdev;
>> =A0 =A0 =A0 int err;
>> @@ -1932,7 +1942,15 @@ static int start_discovery(struct sock *sk, u16 i=
ndex,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> + =A0 =A0 if (test_bit(MGMT_ADDR_BREDR, &discov_type))
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR=
);
>> + =A0 =A0 else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_bit(MGMT_=
ADDR_LE_RANDOM, &discov_type))
>
> so test_bit can not check for two bits at the same time?

AFAIK, no. If anyone knows a helper like that, please let me
know.

BR,

Andre
