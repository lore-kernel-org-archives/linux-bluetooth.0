Return-Path: <chris2553@googlemail.com>
Subject: Re: 4.5 Regression - mouse not working after resume from suspend
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@intel.com
References: <56B5B0C3.6050208@googlemail.com>
 <56B5DB29.9040208@googlemail.com> <56B5F2B1.5010000@googlemail.com>
 <20160206143300.GA18790@t440s.P-661HNU-F1> <56B61000.6060008@googlemail.com>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <56C26202.4070101@googlemail.com>
Date: Mon, 15 Feb 2016 23:40:50 +0000
MIME-Version: 1.0
In-Reply-To: <56B61000.6060008@googlemail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Is there anything else I can do to help diagnose this regression.

To summarise my BT mouse does not work after resuming from suspend to disk or ram. IT works perfectly in earlier 4.4,
4.3 and 4.2 kernels. I bisected and found the first bad commit is:

2ff13894cfb877cb3d02d96a8402202f0a6f3efd is the first bad commit
commit 2ff13894cfb877cb3d02d96a8402202f0a6f3efd
Author: Johan Hedberg <johan.hedberg@intel.com>
Date:   Wed Nov 25 16:15:44 2015 +0200

    Bluetooth: Perform HCI update for power on synchronously

Johan requested additional information, which I provided. Checking the archive at marc.info, it seems the mail didn't
make it to the mailing list. Maybe it exceeded a size limit, I don't know. Anyway I copied the mail to Johan and Marcel.

A bit more experimentation revealed that I can reactivate the mouse if I restart the bluetooth daemon after the machine
resumes.

Please let me know if I can provide anything else.

Thanks

Chris

On 06/02/16 15:23, Chris Clayton wrote:
> Hi Johan,
> 
> The information you requested has been captured from v4.5-rc2-340-g5af9c2e and is included below.
> 
> On 06/02/16 14:33, Johan Hedberg wrote:
>> Hi Chris,
>>
>> On Sat, Feb 06, 2016, Chris Clayton wrote:
>>> On 06/02/16 11:38, Chris Clayton wrote:
>>>> On 06/02/16 08:37, Chris Clayton wrote:
>>>>> There seems to be a regression in resuming my laptop from a suspend
>>>>> to RAM or disk. The symptom is that my bluetooth
>>>>> mouse doesn't work after the resume. The kernel is built after a
>>>>> pull of Linus' tree this morning (v4.5-rc2-340-g5af9c2e).
>>>>>
>>>>> Attached is the output from dmesg showing the boot, suspend (to
>>>>> RAM) and resume. You'll see that during the resume,
>>>>> error -517 is being reported for some devices. Suspend/resume has worked perfectly with a 4.[234].x kernels.
>>>>>
>>>>> I'll start a bisection, but thought I'd give a heads up in case
>>>>> someone can see the problem before I get done with the
>>>>> bisect.
>>>>
>>>> The bisection ended up at:
>>>>
>>>> 2ff13894cfb877cb3d02d96a8402202f0a6f3efd is the first bad commit
>>>> commit 2ff13894cfb877cb3d02d96a8402202f0a6f3efd
>>>> Author: Johan Hedberg <johan.hedberg@intel.com>
>>>> Date:   Wed Nov 25 16:15:44 2015 +0200
>>>>
>>>>     Bluetooth: Perform HCI update for power on synchronously
>>>>
>>>>     The request to update HCI during power on is always coming either from
>>>>     hdev->req_workqueue or through an ioctl, so it's safe to use
>>>>     hci_req_sync for it. This way we also eliminate potential races with
>>>>     incoming mgmt commands or other actions while powering on.
>>>>
>>>>     Part of this refactoring is the splitting of mgmt_powered() into
>>>>     mgmt_power_on() and __mgmt_power_off() functions. The main reason is
>>>>     the different requirements as far as hdev locking is concerned, as
>>>>     highlighted with the __ prefix of the power off API.
>>>>
>>>>     Since the power on in the case of clearing the AUTO_OFF flag cannot be
>>>>     done synchronously in the set_powered mgmt handler, the hci_power_on
>>>>     work callback is extended to cover this (which also simplifies the
>>>>     set_powered helper a lot).
>>>>
>>>>     Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>>>     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>>
>>>> :040000 040000 a093d0be66f39f99c33a6a4725b2330ca9b41d03 a1eff79cec3ee7208e5aa200ab5069726bbeea8e M      include
>>>> :040000 040000 d2d122193b33d45fcb9c2bc69f2024487a7528a0 0036e1ec2e125f2432cfd420b5f79ca133ec34f7 M      net
>>>
>>> I've just built a kernel at bf943cbf76ecd3b9838a80d5e08777b0f4ccc665
>>> (the commit prior to the one the bisect landed on)
>>> and my BT mouse works fine after a suspend/resume. With a kernel built
>>> at 2ff13894cfb877cb3d02d96a8402202f0a6f3efd, the mouse does not work
>>> after resume.
>>
>> I've moved the thread over to the linux-bluetooth list, since that's where
>> Bluetooth issues are primarily discussed. You had already removed the dmesg
>> output by the time you added me to the thread so I'll copy the relevant
>> (Bluetooth related) parts here that I found in the online archives:
>>
>> [    5.314851] Bluetooth: hci0: read Intel version: 3707100180012d0d1a
>> [    5.315569] Bluetooth: hci0: Intel device is already patched. patch num: 1a
>> [   61.566028] Bluetooth: HIDP socket layer initialized
>> [   61.566498] hid-generic 0005:0A5C:0001.0001: unknown main item tag 0x0
>> [   61.566540] input: Bluetooth 3.0 mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.0/bluetooth/hci0/hci0:256/0005:0A5C:0001.0001/input/input15
>> [   61.566644] hid-generic 0005:0A5C:0001.0001: input: BLUETOOTH HID v1.29 Mouse [Bluetooth 3.0 mouse] on 80:19:34:5a:67:51
>> [  122.711385] Bluetooth: hci0: read Intel version: 3707100180012d0d00
>> [  122.744439] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
>> [  122.895434] Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
>>
>> There's some more information needed to investigate this further:
>>
>>  - What's the state of Bluetooth on your machine after resume? If you do
>>    "hciconfig" does it show hci0 as being "UP"? Does it show "PSCAN"
>>    being enabled? (assuming your mouse is a BR/EDR one)
> 
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 80:19:34:5A:67:51  ACL MTU: 1021:5  SCO MTU: 96:6
>         DOWN
>         RX bytes:1139 acl:0 sco:0 events:122 errors:0
>         TX bytes:17708 acl:0 sco:0 commands:121 errors:0
> 
>>  - Do you see any errors from bluetoothd when you suspend/resume?
> 
> Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSource
> Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSink
> Feb  6 15:06:25 laptop bluetoothd[888]: Failed to obtain handles for "Service Changed" characteristic
> Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSource
> Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSink
> 
>>  - Could you provide the HCI log from btmon for what happens when you
>>    suspend/resume (just keep btmon running over this time)
> 
> That log's a bit long, so I've attached it.
> 
> Hope this helps. Thanks
> 
> Chris
>>
>> Thanks.
>>
>> Johan
>>
