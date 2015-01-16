Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150116104745.GA1630@t440s.lan>
References: <1421240985-28944-1-git-send-email-jpawlowski@google.com>
	<20150116104745.GA1630@t440s.lan>
Date: Fri, 16 Jan 2015 13:11:31 +0100
Message-ID: <CAD0=r8wGXWiD4fxN5CnsDz9t1+oFCno4j8Et5Zt=5kvpO4ZNng@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] Bluetooth: Add le_scan_restart
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Jan 16, 2015 at 11:47 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Jan 14, 2015, Jakub Pawlowski wrote:
>> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status,
>> +                                       u16 opcode)
>> +{
>> +     BT_DBG("%s", hdev->name);
>> +     if (status) {
>> +             BT_ERR("Failed to restart LE scan: status %d", status);
>> +     } else if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
>> +              hdev->discovery.scan_end != 0) {
>> +             long timeout = hdev->discovery.scan_end - jiffies;
>
> To make this consistent with the coding style, could you please format
> it as:
>
>         if (status) {
>                 BT_ERR(...);
>                 return;
>         }
>
>         if (!test_bit(DUP_FILT) || !hdev->discovery_scan_end)
>                 return;
>
>         timeout = ...;
>
>> +static void le_scan_restart_work(struct work_struct *work)
>> +{
>> +     struct hci_dev *hdev = container_of(work, struct hci_dev,
>> +                                         le_scan_restart.work);
>> +     struct hci_request req;
>> +     struct hci_cp_le_set_scan_enable cp;
>> +     int err;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     /* If controller is not scanning we are done. */
>> +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +             return;
>
> Shouldn't you also make sure to cancel this delayed work wherever the
> code clears the HCI_LE_SCAN flag? (i.e. in hci_event.c)

le_scan_restart_work  checks wether HCI_LE_SCAN is set to make sure it
won't accidentally 'restart' the scan when it's disabled.
Or did you wanted to cancel this delayed work to make the code faster ?
This cancel would be executed only if the DEDUPLICATION quirk is set,
so it shouldn't be a gain in speed.

>
> Johan
