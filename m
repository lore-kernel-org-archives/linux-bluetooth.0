Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAO+8wm8f2HTLGWZ64jBtTXRQ+PhBzFXtjBncYQDnG7QXR38HHg@mail.gmail.com>
References: <CAO+8wm_qbHMA8RZmiGQUw-55TDWCXvm+f2zrLCCYXXv7CcL08g@mail.gmail.com>
	<CABBYNZKbPeq9Xxr57EVOqLcY-TTLr6gM2a4yOxP_vBpukM+hqQ@mail.gmail.com>
	<CAO+8wm84JUdm4r5zY_eA5jZ1VjQKT94MdjEU0gQiHMekEiP3QA@mail.gmail.com>
	<CAO+8wm8f2HTLGWZ64jBtTXRQ+PhBzFXtjBncYQDnG7QXR38HHg@mail.gmail.com>
Date: Mon, 1 Sep 2014 10:48:02 +0300
Message-ID: <CABBYNZK7i7ohoR_KbqW+u52rf3V-M6YX8BCE5PO82r3r5QOJ_w@mail.gmail.com>
Subject: Re: connecting to a Motion 2in1 wiimote clone
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Kameron Larsen <kroylar@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kameron,

On Sat, Aug 30, 2014 at 6:14 AM, Kameron Larsen <kroylar@gmail.com> wrote:
> On Fri, Aug 29, 2014 at 6:23 PM, Kameron Larsen <kroylar@gmail.com> wrote:
>> On Fri, Aug 29, 2014 at 3:51 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Kameron,
>>>
>>> On Fri, Aug 29, 2014 at 1:47 AM, Kameron Larsen <kroylar@gmail.com> wrote:
>>>> Hello all,
>>>>
>>>> I'm having some difficulty in scanning and connecting to a device
>>>> using bluetoothctl. The device in question is a Motion 2in1 Wiimote.
>>>> Its basically a cheap chinese wiimote clone.
>>>>
>>>> When I try to scan using bluetoothctl the device never shows up. When
>>>> I try to scan using "hcitool scan --iac=liac", the device shows up as:
>>>>
>>>> 2A:04:84:80:13:41 Nintendo RVL-CNT-01
>>>
>>> That is strange bluetoothctl should see the device as well.
>>>
>>>> The device cannot be connected to in bluetoothctl but I can connect
>>>> using "hcitool cc 2A:04:84:80:13:41". If I connect using hctitool and
>>>> then immediately use "pair 2A:04:84:80:13:41" in bluetoothctl. It
>>>> looks like the device pairs but the wiimote disconnects before
>>>> finishing the process. If I then run "trust 2A:04:84:80:13:41",
>>>> bluetoothctl will show that the device connects anytime I press any
>>>> button, and then shortly disconnects.
>>>>
>>>> hcidump reveals that the something is wating for additional data but
>>>> it is not receiving what it expects.  Because this data was never
>>>> received the pairing process is left incomplete. However I can
>>>> reconnect by pressing any button on the remote. Whenever I do, it will
>>>> automatically disconnect after several seconds.
>>>
>>> Have to register an agent to do the pairing? You should be able to do
>>> that with bluetoothctl:
>>>
>>> agent on
>>> default-agent
>>>
>>>> Scouring the code, I've come to realize that this remote is not
>>>> responding to sdp queries and therefore bluez does not know what
>>>> services it supports. My logs show this error:
>>>>
>>>> 2A:04:84:80:13:41: error updating services: Input/output error (5)
>>>>
>>>> Without knowing the services (ie, HID) it fails in connect_event_cb
>>>> with the following error:
>>>>
>>>> Refusing input device connect: No such file or directory (2)
>>>
>>> It seems some, or perhaps most, gaming controllers do not have SDP
>>> working properly but first check if you are really able to pair
>>> properly because if you don't we wont be able to discover what service
>>> the remote device support.
>>
>> I believe it has paired properly. At least bluetoothctl lists it as paired.
>>
>> [bluetooth]# power on
>> Changing power on succeeded
>> [bluetooth]# agent
>> Missing on/off/capability argument
>> [bluetooth]# default-agent
>> No agent is registered
>
> So I didn't actually turn the agent on in that test. Oops! But without
> an agent why did it seem to work? Or maybe its not actually working
> either with or without the agent. It just appears to be.
>
> I repeated the test with actually turning the agent on and registering
> the default agent but it does exactly the same thing.

Try capturing the HCI traces and paste the relevant parts here it
should tell us if pairing is really succeeding and where it fails to
resolve the services.


-- 
Luiz Augusto von Dentz
