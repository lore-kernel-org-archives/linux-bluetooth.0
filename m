Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Add new debugfs parameter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMudyAtaDP84-e+tAcYEMJvKLtE_0ztW-c1q55opsc-v_jA07g@mail.gmail.com>
Date: Sun, 23 Mar 2014 19:30:28 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A35F5783-B5F8-4F6F-AA29-F5FBA3924C5F@holtmann.org>
References: <1395612571-5365-1-git-send-email-lukasz.rymanowski@tieto.com> <38995981-F906-4283-AAC1-9AAEA6012BFD@holtmann.org> <CAMudyAtaDP84-e+tAcYEMJvKLtE_0ztW-c1q55opsc-v_jA07g@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>>> With this patch it is possible to control discovery interleaved
>>> timeout value from debugfs. Default value is 5120 ms.
>>> 
>>> It is useful to control it in case of automated testaces where bredrle
>>> controler is doing discovery and it is waiting for inquiry results. With
>>> this patch we can decrease le scan time and get inquiry results faster.
>>> 
>>> It might be also useful in other test cases.
>>> 
>>> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
>>> ---
>>> include/net/bluetooth/hci_core.h | 2 +-
>>> net/bluetooth/hci_core.c         | 6 ++++++
>>> net/bluetooth/mgmt.c             | 2 +-
>>> 3 files changed, 8 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 5f8bc05..2d63ade 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -194,6 +194,7 @@ struct hci_dev {
>>>      __u16           le_scan_window;
>>>      __u16           le_conn_min_interval;
>>>      __u16           le_conn_max_interval;
>>> +     __u32           discov_interl_timeout;
>>>      __u8            ssp_debug_mode;
>>> 
>>>      __u16           devid_source;
>>> @@ -1205,7 +1206,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>>> #define DISCOV_LE_SCAN_WIN            0x12
>>> #define DISCOV_LE_SCAN_INT            0x12
>>> #define DISCOV_LE_TIMEOUT             msecs_to_jiffies(10240)
>>> -#define DISCOV_INTERLEAVED_TIMEOUT   msecs_to_jiffies(5120)
>>> #define DISCOV_INTERLEAVED_INQUIRY_LEN        0x04
>>> #define DISCOV_BREDR_INQUIRY_LEN      0x08
>>> 
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 1c6ffaa..b2139f1 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -61,6 +61,9 @@ static void hci_notify(struct hci_dev *hdev, int event)
>>> 
>>> /* ---- HCI debugfs entries ---- */
>>> 
>>> +/* Discovery interleaved timeout */
>>> +static u16 discov_timeout_ms = 5120;
>>> +
>>> static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
>>>                           size_t count, loff_t *ppos)
>>> {
>>> @@ -1828,6 +1831,8 @@ static int __hci_init(struct hci_dev *hdev)
>>>                                  &lowpan_debugfs_fops);
>>>              debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
>>>                                  &le_auto_conn_fops);
>>> +             debugfs_create_u16("discov_interleaved_timeout", 0644,
>>> +                                bt_debugfs, &discov_timeout_ms);
>> 
>> please attach a second HCI controller to your system and tell me what happens.
>> 
> Well I'm aware that first controller gets default value unless you
> detach and attach back after this value is chenged. So  yes, you might
> end with different interleaved  timeouts for two controllers. But this
> is debug stuff so I though it is ok.

this is the init routine of the individual controller. And you are registering on bt_debugfs which means that once you attach a second controller, you register the same debugfs entry twice. I am pretty certain the kernel will complain about this. So no matter what this is wrong.

> I was considering to do this value per hdev but case we want to cover
> here is xxx_tester on vhci and we just need to have some way to set
> this interleave value before vhci  is allocated.

Why? Set it before you issue Start Discovery command. Why does it need to be set when the controller gets allocated?

On a more important detail, why not trigger BR/EDR only or LE only discovery. The mgmt interface certainly supports that.

> Other option would be to make this timeout global and we could easly
> change it in the runtime. But then:
> a) do it in mgmt.c where this timeout is used? well IMHO this timeout
> does not belong to mgmt so I dropped it.
> b) do it in hci_core.c and expose somehow to mgmt (some get_function
> or export?) - well did not like it
> 
> Anyway, If this way is not acceptable then what do you suggest? IMHO
> if somebody would like to use this debugfs option he will be able to
> use it correctly.

Either it is per controller or it is global. What is it now. And honestly, I do not see the problem that this solves this. Especially since we can trigger a BR/EDR or LE only scan easily.

Regards

Marcel

