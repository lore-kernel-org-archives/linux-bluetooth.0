Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <357A3BB3-DE37-4CB5-8360-8DC97EA2369D@holtmann.org>
References: <1417823005-10262-1-git-send-email-jpawlowski@google.com>
	<1417823005-10262-2-git-send-email-jpawlowski@google.com>
	<357A3BB3-DE37-4CB5-8360-8DC97EA2369D@holtmann.org>
Date: Tue, 9 Dec 2014 09:59:34 +0100
Message-ID: <CAD0=r8yZbdHwC-XmEch7U=uEwDfLwxrjP6_2B9gf1sxd40=g_Q@mail.gmail.com>
Subject: Re: [RFC v4 2/2] Bluetooth: Add restarting to service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 9, 2014 at 7:32 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> When using LE_SCAN_FILTER_DUP_ENABLE, controllers would send
>> advertising report from each LE device only once. That means that we
>> don't get any updates on RSSI value, and makes Service Discovery very
>> slow. This patch adds restarting scan when in Service Discovery, and
>> device with filtered uuid is found, but it's not in RSSI range to send
>> event yet. This way if device moves into range, we will quickly get RSSI
>> update.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>> include/net/bluetooth/hci_core.h |  1 +
>> net/bluetooth/mgmt.c             | 34 ++++++++++++++++++++++------------
>> 2 files changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 53e7975..96cf380 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1353,6 +1353,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>> #define DISCOV_INTERLEAVED_TIMEOUT    5120    /* msec */
>> #define DISCOV_INTERLEAVED_INQUIRY_LEN        0x04
>> #define DISCOV_BREDR_INQUIRY_LEN      0x08
>> +#define DISCOV_LE_RESTART_DELAY              200     /* msec */
>>
>> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
>> int mgmt_new_settings(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index a91e484..d40e253 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -6983,6 +6983,12 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
>>       return false;
>> }
>>
>> +static void restart_le_scan(struct hci_dev *hdev)
>> +{
>
> so here you should check if we are scanning or not and if this extra handling of restarts is actually needed.
>
> In addition you might really want to check that this is the LE scanning phase. I know that checking for LE_SCAN would do that, but this is a bit dangerous since this code path can also be entered from BR/EDR inquiry results.
>
>> +     queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
>> +                        msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
>> +}
>> +
>> void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                      u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>>                      u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
>> @@ -7003,18 +7009,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                       return;
>>       }
>>
>> -     /* When using service discovery with a RSSI threshold, then check
>> -      * if such a RSSI threshold is specified. If a RSSI threshold has
>> -      * been specified, then all results with a RSSI smaller than the
>> -      * RSSI threshold will be dropped.
>> -      *
>> -      * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
>> -      * the results are also dropped.
>> -      */
>> -     if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
>> -         (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
>> -             return;
>> -
>
> We are you moving this check around. There is no point in checking for the UUID when the RSSI threshold is not reached. This advertising event should be ignored.
>
> Especially if this is on BR/EDR or the controller is doing the multiple reporting for us, then there is no point in bothering with looking for the UUID.
>
> So I realize it is desired to only restart when the UUIDs we are looking for is actually found, but that does not mean we want to penalize all other paths or controllers that do not need a scan restart in the first place.

Yes, you're right, I'll fix that.

>
>>       /* Make sure that the buffer is big enough. The 5 extra bytes
>>        * are for the potential CoD field.
>>        */
>> @@ -7052,6 +7046,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                                             hdev->discovery.uuids);
>>                       if (!match)
>>                               return;
>> +
>> +                     restart_le_scan(hdev);
>>               }
>>
>>               /* Copy EIR or advertising data into event */
>> @@ -7080,6 +7076,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                                                    hdev->discovery.uuid_count,
>>                                                    hdev->discovery.uuids))
>>                               return;
>> +
>> +                     restart_le_scan(hdev);
>
> Both of these should have a comment on why this is done. You might also run into the problem that this gets run twice if the UUID has been found in advertising data already.

Yes, it's perfectly fine. You can also run on marvell controller (one
I used for tests) that doesn't honor deduplication and get multiple
reports for same device before the job is run:

internally it's only calling queue_delayed_work, and documentation says:

"The return value from these functions [queue_delayed_work] is 0 if
the work was successfully added to the queue; a nonzero result means
that this work_struct structure was already waiting in the queue, and
was not added a second time."

So this way I make sure, that:
- if device is advertising less often than every
DISCOV_LE_RESTART_DELAY (200ms), I'll get mgmt_device_found for each
advertisement (with updated RSSI value), because we restart often
enough,
- if device is advertising more frequently that
DISCOV_LE_RESTART_DELAY, you'll get only one mgmt_device_found every
DISCOV_LE_RESTART_DELAY for that device, because controller will
filter rest.

Also if there was no DISCOV_LE_RESTART_DELAY, you'll get device that
is advertising with big frequency, it would cause your controller to
restart all the time. That might cause only one device, most noisy one
to be discovered.
I might further tune DISCOV_LE_RESTART_DELAY in future when
implementing StartServiceDiscovery in D-BUS, to make sure it's working
nicely. Right now I just made sure that all controllers that I used
during tests would report RSSI change at least 3 times/sec for
frequently advertising device.


>
>>               }
>>
>>               /* Append scan response data to event */
>> @@ -7093,6 +7091,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                       return;
>>       }
>>
>> +     /* When using service discovery with a RSSI threshold, then check
>> +      * if such a RSSI threshold is specified. If a RSSI threshold has
>> +      * been specified, then all results with a RSSI smaller than the
>> +      * RSSI threshold will be dropped.
>> +      *
>> +      * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
>> +      * the results are also dropped.
>> +      */
>> +     if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
>> +         (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
>> +             return;
>> +
>>       ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
>>       ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
>
> Regards
>
> Marcel
>
