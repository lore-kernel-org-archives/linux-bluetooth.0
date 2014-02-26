Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A552BAE1-F573-4940-9E30-CA7AF189D3DD@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-17-git-send-email-andre.guedes@openbossa.org> <A552BAE1-F573-4940-9E30-CA7AF189D3DD@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 26 Feb 2014 16:35:26 -0300
Message-ID: <CACJA=fXAhckOMvy+OuZP-+Lh4JGcr9VFq655jSt7G5N4TMNKTQ@mail.gmail.com>
Subject: Re: [PATCH 16/17] Bluetooth: Create hci_req_add_le_passive_scan helper
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014 at 3:44 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patches creates the hci_req_add_le_passive_scan helper so it can
>> be re-used in the next patch.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_core.c | 54 +++++++++++++++++++++++++++---------------------
>> 1 file changed, 30 insertions(+), 24 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index fb4c961..e776624 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -5095,6 +5095,35 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
>>       hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> }
>>
>> +static void hci_req_add_le_passive_scan(struct hci_request *req,
>> +                                     struct hci_dev *hdev)
>> +{
>
>         struct hci_dev *hdev = req->hdev;

Sure, my bad.

Thanks,

Andre
