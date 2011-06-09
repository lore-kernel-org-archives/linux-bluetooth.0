Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikeNWd44kzTSS2N9mSxB3xwNkeX8g@mail.gmail.com>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
	<1305936645-15007-6-git-send-email-andre.guedes@openbossa.org>
	<BANLkTin3Q1cO0-q50fEye7=7KHxTgKmhTg@mail.gmail.com>
	<BANLkTikeNWd44kzTSS2N9mSxB3xwNkeX8g@mail.gmail.com>
Date: Thu, 9 Jun 2011 15:20:21 -0300
Message-ID: <BANLkTin_xJVtRPphqwqwT3XArX=HpxRhZA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] Bluetooth: Advertising entries lifetime
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Tue, Jun 7, 2011 at 4:08 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> Hi Luiz,
>
> On Tue, Jun 7, 2011 at 2:18 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Andre,
>>
>> On Sat, May 21, 2011 at 9:10 AM, Andre Guedes
>> <andre.guedes@openbossa.org> wrote:
>>> This patch adds a timer to clear 'adv_entries' after three minutes.
>>>
>>> After some amount of time, the advertising entries cached during
>>> the last LE scan should be considered expired and they should be
>>> removed from the advertising cache.
>>>
>>> It was chosen a three minutes timeout as an initial attempt. This
>>> value might change in future.
>>>
>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>> ---
>>>  include/net/bluetooth/hci_core.h |    2 ++
>>>  net/bluetooth/hci_core.c         |   14 ++++++++++++++
>>>  net/bluetooth/hci_event.c        |    6 +++++-
>>>  3 files changed, 21 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 10dfb85..af4b0ed 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -188,6 +188,7 @@ struct hci_dev {
>>>        struct list_head        remote_oob_data;
>>>
>>>        struct list_head        adv_entries;
>>> +       struct timer_list       adv_timer;
>>>
>>>        struct hci_dev_stats    stat;
>>>
>>> @@ -535,6 +536,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
>>>                                                                u8 *randomizer);
>>>  int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
>>>
>>> +#define ADV_CLEAR_TIMEOUT (3*60*HZ) /* Three minutes */
>>>  int hci_adv_entries_clear(struct hci_dev *hdev);
>>>  struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
>>>  int hci_add_adv_entry(struct hci_dev *hdev,
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index dd27f97..5040c3f 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -1204,6 +1204,17 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
>>>        return 0;
>>>  }
>>>
>>> +static void hci_clear_adv_cache(unsigned long arg)
>>> +{
>>> +       struct hci_dev *hdev = (void *) arg;
>>> +
>>> +       hci_dev_lock(hdev);
>>> +
>>> +       hci_adv_entries_clear(hdev);
>>> +
>>> +       hci_dev_unlock(hdev);
>>> +}
>>> +
>>>  int hci_adv_entries_clear(struct hci_dev *hdev)
>>>  {
>>>        struct adv_entry *entry, *tmp;
>>> @@ -1332,6 +1343,8 @@ int hci_register_dev(struct hci_dev *hdev)
>>>        INIT_LIST_HEAD(&hdev->remote_oob_data);
>>>
>>>        INIT_LIST_HEAD(&hdev->adv_entries);
>>> +       setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
>>> +                                               (unsigned long) hdev);
>>>
>>>        INIT_WORK(&hdev->power_on, hci_power_on);
>>>        INIT_WORK(&hdev->power_off, hci_power_off);
>>> @@ -1405,6 +1418,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
>>>        hci_unregister_sysfs(hdev);
>>>
>>>        hci_del_off_timer(hdev);
>>> +       del_timer(&hdev->adv_timer);
>>>
>>>        destroy_workqueue(hdev->workqueue);
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 85e12d8..8d6dc1e 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -859,8 +859,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>>>
>>>        hci_dev_lock(hdev);
>>>
>>> -       if (param_scan_enable == 0x01)
>>> +       if (param_scan_enable == 0x01) {
>>> +               del_timer(&hdev->adv_timer);
>>>                hci_adv_entries_clear(hdev);
>>> +       } else if (param_scan_enable == 0x00) {
>>> +               mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
>>> +       }
>>>
>>>        hci_dev_unlock(hdev);
>>>  }
>>> --
>>> 1.7.4.1
>>
>> Maybe we should not trigger the timer if the we are connected to the
>> device, this would be very convenient if a disconnect happen for
>> unknown reason e.g. bug or crash so we can quickly reconnect without
>> having to scan again, once disconnected then we start the entry timer,
>> what do you think?
>>
>
> I think keeping the advertising entry from the devices we are connected to
> may be a good idea.
>
> The spec says "When a device in the directed connectable mode establishes a
> connection, the device will exit this mode and enter the non-connectable mode".
> So, fast reconnection attempts will fail since the device is in non-connectable
> mode. However, once the connection is dropped, some LE applications will enter
> in connectable mode ASAP (see proximity or health thermometer profiles).
>
> So, I'm not sure we will have much gain implementing this approach. But it
> would be nice to do some experiments to see this in practice.
>
> BTW, instead of deactivating/activating the adv timer, I think a bit better
> approach would be modifying the hci_adv_entries_clear() so it doesn't remove
> the adv entries from devices we are connected to. This way we would keep only
> fresh entries in the advertising cache and we can perform a LE scan normally.

Complementing what Andre wrote: This approach will improve re-connections.
However passive scanning combined with automatic connection management
should be our target. After reboot the cache will be lost and an
active or passive
scanning will be necessary to refresh the cache otherwise connection will always
fail.

If we control "automatic" connections in the userspace, the next discussion will
be how to control passive scanning using management interface.

BR,
Claudio

>
>>
>> --
>> Luiz Augusto von Dentz
>> Computer Engineer
>>
>
> BR,
>
> Andre Guedes.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
