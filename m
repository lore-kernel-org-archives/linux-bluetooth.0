Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLrcAnRFb83oWZUw5_1-3yLUYED8au9tizwP02m2SHxmA@mail.gmail.com>
References: <CACgKv-KJjZ7y=0PeE5rz5NEiPKNFOsJekdyHjz65JN0=LqmNoA@mail.gmail.com>
 <CABBYNZL3yRRvy9FXhko+VXJ0d901iUH=W6DM1Lci3zKRJapb_A@mail.gmail.com>
 <CACgKv-+OuUqu4h5eyMxV_pA=1pvPfje87RgQuTK0SgZ9r9a+8w@mail.gmail.com>
 <CABBYNZ+_i--y2J1WRzp_d_MzgiDkXm=fqWs4FGZzmvkotCoEvg@mail.gmail.com>
 <CABBYNZJgYRtJ-zMVsy4+4gUDx3HNFP+cTeyaScWeSJyKwFK8kw@mail.gmail.com>
 <CACgKv-+ud+s+LZ6+pqKiZoKbaGEuZtJ8d2Q1JJNQVBo8ji47RA@mail.gmail.com> <CABBYNZLrcAnRFb83oWZUw5_1-3yLUYED8au9tizwP02m2SHxmA@mail.gmail.com>
From: Jacob Siverskog <jacob@teenageengineering.com>
Date: Fri, 13 Mar 2015 14:01:44 +0100
Message-ID: <CACgKv-+maoeX8_9A2NR3At-Sxktk-12_3-qnCD0Y-Nc0--f52Q@mail.gmail.com>
Subject: Re: Missing events after reconnect (BLE)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
Seems to work out after applying the patches, thank you very much!

Have a nice weekend.

     Jacob

On Fri, Mar 13, 2015 at 10:11 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Mar 13, 2015 at 10:44 AM, Jacob Siverskog
> <jacob@teenageengineering.com> wrote:
>> Hi Luiz!
>> I'm sorry, which set are you meaning here? I can't see any attached
>> files, recent commit or e-mail that seems to resolve this issue.
>
> Sorry, Ive forgot to sent it yesterday, they should be now in the list.
>
>> Thanks, Jacob
>>
>> On Thu, Mar 12, 2015 at 6:27 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Jacob,
>>>
>>> On Thu, Mar 12, 2015 at 2:42 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Jacob,
>>>>
>>>> On Thu, Mar 12, 2015 at 12:15 PM, Jacob Siverskog
>>>> <jacob@teenageengineering.com> wrote:
>>>>> Hi Luiz!
>>>>> Thanks for the patch, it seems to solve the issue on newly paired
>>>>> devices. However, if I reboot the system it fails when registering
>>>>> GATT service (no device files are created):
>>>>>
>>>>> Thu Mar 12 09:43:01 2015 kern.err kernel: hid-generic
>>>>> 0005:2367:0004.0001: unbalanced collection at end of report
>>>>> description
>>>>> Thu Mar 12 09:43:01 2015 kern.warn kernel: hid-generic: probe of
>>>>> 0005:2367:0004.0001 failed with error -22
>>>>> Thu Mar 12 09:43:03 2015 daemon.err bluetoothd[1509]: Unable to
>>>>> register GATT service with handle 0x0008 for device E7:D8:E4:BB:69:88:
>>>>> Thu Mar 12 09:43:03 2015 daemon.err bluetoothd[1509]: Unable to
>>>>> register GATT service with handle 0x0014 for device E7:D8:E4:BB:69:88:
>>>>> Thu Mar 12 09:43:03 2015 daemon.err bluetoothd[1509]: Unable to
>>>>> register GATT service with handle 0x0025 for device E7:D8:E4:BB:69:88:
>>>>>
>>>>> This is something I have not seen before (without the patch).
>>>>
>>>> Yep, this is caused because once you restart bluetoothd we loose the
>>>> service cache which is probably passed to the kernel for probing, in
>>>> this case we might have to delay the notification for drivers since we
>>>> have to refresh the cache or just implement the persistent storage
>>>> which is causing this to begin with.
>>>>
>>>>> Attached is bluetoothd log and btmon log interleaved with syslog on a
>>>>> newly booted system. The system has one paired device (remote
>>>>> control). The remote control was in sleep until I pressed a button on
>>>>> it (at 3.17 secs in the btmon log).
>>>
>>> Can you try with latest set Ive sent, that should fix the hid problem
>>> after restarting bluetoothd.
>>>
>>>>> Please let me know if you need more information.
>>>>>
>>>>>      Jacob
>>>>>
>>>>> On Wed, Mar 11, 2015 at 8:46 PM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> Hi Jacob,
>>>>>>
>>>>>> On Mon, Mar 9, 2015 at 6:11 PM, Jacob Siverskog
>>>>>> <jacob@teenageengineering.com> wrote:
>>>>>>> Hi!
>>>>>>> We're developing a BLE remote control with a HID profile that goes to
>>>>>>> sleep after being idle some time. It is waken
>>>>>>> up by pressing a button on it, after waking up it performs undirected
>>>>>>> advertising towards the host.
>>>>>>>
>>>>>>> Sometimes we see that the press is not registered by the host. We can
>>>>>>> see the press in btmon but it never ends up in /dev/input/XXX.
>>>>>>> Subsequent presses works fine.
>>>>>>>
>>>>>>> Attached are two btmon logs. What I can see is that the "press event"
>>>>>>> (Handle Value Notification) is received earlier in the working case.
>>>>>>>
>>>>>>> Are we simply sending the event too early? Or is there any other issue?
>>>>>>
>>>>>> Sorry for the delay, for some reason this message went to my spam
>>>>>> folder, anyway the problem we have is that we are not processing
>>>>>> notification while MTU exchange is pending, please try with the
>>>>>> attached patch (not tested so it may actually not work).
>>>>>>
>>>>>> --
>>>>>> Luiz Augusto von Dentz
>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
