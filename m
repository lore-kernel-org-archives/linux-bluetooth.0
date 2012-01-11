Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120111135242.GA27506@x220>
References: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
	<1326230455-9117-5-git-send-email-andre.guedes@openbossa.org>
	<20120111135242.GA27506@x220>
Date: Wed, 11 Jan 2012 11:13:03 -0300
Message-ID: <CACJA=fXUc=qnZs2OWEAGvNsB6i+eEbdGLA2FrcFqf_junsKrrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] Bluetooth: Add helper functions to send LE scan commands
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 11, 2012 at 10:52 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Tue, Jan 10, 2012, Andre Guedes wrote:
>> This patch creates two helper functions to send LE Set Scan
>> Parameters and LE Set Scan Enable commands.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  net/bluetooth/hci_core.c |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 29bc1c6..0f8884f 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -89,6 +89,29 @@ static void hci_notify(struct hci_dev *hdev, int event)
>>       atomic_notifier_call_chain(&hci_notifier, event, hdev);
>>  }
>>
>> +static int send_le_scan_param_cmd(struct hci_dev *hdev, u8 type, u16 interval,
>> +                                                             u16 window)
>> +{
>> +     struct hci_cp_le_set_scan_param cp;
>> +
>> +     memset(&cp, 0, sizeof(cp));
>> +     cp.type = type;
>> +     cp.interval = cpu_to_le16(interval);
>> +     cp.window = cpu_to_le16(window);
>> +
>> +     return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
>> +}
>> +
>> +static int send_le_scan_enable_cmd(struct hci_dev *hdev, u8 enable)
>> +{
>> +     struct hci_cp_le_set_scan_enable cp;
>> +
>> +     memset(&cp, 0, sizeof(cp));
>> +     cp.enable = enable;
>> +
>> +     return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> +}
>> +
>>  /* ---- HCI requests ---- */
>>
>>  void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
>
> This patch generates the following compiler warnings:
>
> net/bluetooth/hci_core.c:92:12: warning: 'send_le_scan_param_cmd' defined but not used [-Wunused-function]
> net/bluetooth/hci_core.c:105:12: warning: 'send_le_scan_enable_cmd' defined but not used [-Wunused-function]
>
> I suppose the functions should only be introduced in a patch that also
> contains some users for them.

These functions are used by the next patch (5/7).

The 5/7 patch is complex so I split this up to keep things easier
to review. If you guys still think it would be better to merge this
patch into 5/7, I do it.

Andre
