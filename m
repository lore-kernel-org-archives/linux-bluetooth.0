Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj0YyuTWMxc0xJZp=z-7smmtXNtiOMy-FS4d7ePH1s-C+hVCQ@mail.gmail.com>
References: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
 <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
 <CAMj0Yys1efPQoZPPHbPKs54c9DFWRfFjhkt4Pe3K-fYaZZiarw@mail.gmail.com>
 <CABBYNZLNzLx0+BGgLzubwOHUaMcyde6bL1hhxrHtfskt9OGbzg@mail.gmail.com>
 <CAMj0YytVTxHLY-Mkrjy9PEvNPVd-2GmX9vAK5PeLVo+kSCvAZw@mail.gmail.com>
 <CANBo3n9=-VeFh2EAwm5EcSHgBuZUzFyJDwMZDR29wwKrmgKvVg@mail.gmail.com>
 <CAMj0YytkTtekdgHnZSWbHW+zwdANvMNjgaKfym6a4n5mKWaM_Q@mail.gmail.com>
 <CAMj0Yyu1CKr934V0jcFeeY9QEYSMoS6XO+3hjQNshGE4pFe2cg@mail.gmail.com>
 <CANBo3n_NVJCha8qLAan_9yEmk_9HPuaXK96MDT8S4DTqp=_y-w@mail.gmail.com> <CAMj0YyuTWMxc0xJZp=z-7smmtXNtiOMy-FS4d7ePH1s-C+hVCQ@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Tue, 16 Aug 2016 18:07:34 +0530
Message-ID: <CAMj0Yyu_uh9s8rhSa36T73PRRzGNubs1f_kLYFngmFS6hH-swA@mail.gmail.com>
Subject: Re: BT PAN Connection - NAP with PANU ?
To: bharat panda <bharat22bhusan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Aug 13, 2016 at 9:41 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
> On Sat, Aug 13, 2016 at 4:19 PM, bharat panda <bharat22bhusan@gmail.com> wrote:
>> Hi Ajay,
>>
>> On 13 Aug 2016 15:43, "Ajay Parashar" <ajay.parasha@gmail.com> wrote:
>>>
>>> On Thu, Aug 11, 2016 at 3:24 PM, Ajay Parashar <ajay.parasha@gmail.com>
>>> wrote:
>>> > On Tue, Jul 26, 2016 at 2:18 PM, bharat panda <bharat22bhusan@gmail.com>
>>> > wrote:
>>> >> Hi Ajay,
>>> >>
>>> >> On Tue, Jul 26, 2016 at 11:11 AM, Ajay Parashar
>>> >> <ajay.parasha@gmail.com> wrote:
>>> >>> On Mon, Jul 25, 2016 at 5:06 PM, Luiz Augusto von Dentz
>>> >>> <luiz.dentz@gmail.com> wrote:
>>> >>>> Hi Ajay,
>>> >>>>
>>> >>>> On Mon, Jul 25, 2016 at 2:11 PM, Ajay Parashar
>>> >>>> <ajay.parasha@gmail.com> wrote:
>>> >>>>>> Hi,
>>> >>>>>>
>>> >>>>>> I am using bluez 5.35 and performing one POC with NAP and PANU
>>> >>>>>> communication.
>>> >>>>>> I want to connect PANU with NAP, for this i executed below tasks
>>> >>>>>>
>>> >>>>>> 1) Created a bridge successfully with Ubuntu 15.10.
>>> >>>>>> 2) Executed /test/test-nap script and i can see that NAP has
>>> >>>>>> established.
>>> >>>>>>
>>> >>>>>> 3) I am not getting how to start PANU (client) so that it can be
>>> >>>>>> connected with NAP (as defined in above step 2) and start
>>> >>>>>> communicating each other.
>>> >>>>>
>>> >>>>> How about doc/network-api.txt:
>>> >>>>>
>>> >>>>>
>>> >>>>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt
>>> >>>>>
>>> >>>>> e.g: org.bluez.Network1.Connect("panu")
>>> >>>>>
>>> >>>>>
>>> >>>>> ----------------------------------------------------------------------------------------------
>>> >>>>> My fault i did Top posting, so giving my reply again in right
>>> >>>>> format.
>>> >>>>>
>>> >>>>> ----------------------------------------------------------------------------------------------------
>>> >>>>> Hi,
>>> >>>>>
>>> >>>>> Thanks for reply, I will try this connect API.
>>> >>>>> In my case it need to be connected with NAP as PANU itself, so the
>>> >>>>> parameter of connect api  should states its own role or the role of
>>> >>>>> server with whom it needs to be connected?
>>> >>>>>
>>> >>>>> These APIs are used in python examples, is there similar API
>>> >>>>> available
>>> >>>>> for C programming application also?
>>> >>>>> Can i get similar C example ?
>>> >>>>
>>> >>>> It is actually a D-Bus method call so any D-Bus binding would do it,
>>> >>>> we just did in python because it is much more convenient.
>>> >>>>
>>> >>>> --
>>> >>>> Luiz Augusto von Dentz
>>> >>>
>>> >>> HI Luiz,
>>> >>>
>>> >>> I will try with C language D-Bus binding.
>>> >>>
>>> >>> Prior to this I tried to execute bluez-5.34/test/test-network example
>>> >>> and i m getting below error.
>>> >>>  1) It sounds me that it is unable to found Bluetooth device, but my
>>> >>> device is quite ready and working with other examples."
>>> >>> 2) other reason could me i did not pair this with /test-nap example,
>>> >>> should first i pair this test-network example device with test-nap
>>> >>> example device ?
>>> >>>
>>> >>> Can you please let me know why i am getting this error or let me know
>>> >>> some pointers from where i can debug this issue.
>>> >>>
>>> >>> Traceback (most recent call last):
>>> >>>   File "./test-network", line 41, in <module>
>>> >>>     device = bluezutils.find_device(args[0], options.dev_id)
>>> >>>   File "/mnt/hgfs/shared_With_VM_Ubuntu/test/bluezutils.py", line 30,
>>> >>> in find_device
>>> >>>     adapter_pattern)
>>> >>>   File "/mnt/hgfs/shared_With_VM_Ubuntu/test/bluezutils.py", line 47,
>>> >>> in find_device_in_objects
>>> >>>     raise Exception("Bluetooth device not found")
>>> >>> Exception: Bluetooth device not found
>>> >> The test-network script, tries to search for remote device in device
>>> >> databases. So for this you first need to add the device in devices
>>> >> list by successfully pairing to the device from bluetoothctl. If
>>> >> bluetoothctl lists the remote device name for "devices" command, then
>>> >> this will not show this error anymore.
>>> >> Then you will encounter another error i.e "No such method "Connect"
>>> >> with signature "s" exists on org.bluez.Network1 interface". I am not
>>> >> sure how to get rid of this now.
>>> >>
>>> >>> --
>>> >>> To unsubscribe from this list: send the line "unsubscribe
>>> >>> linux-bluetooth" in
>>> >>> the body of a message to majordomo@vger.kernel.org
>>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >> Regards
>>> >> Bharat
>>> >>
>>> >> --
>>> >> Thanks and Regards
>>> >> Bharat Bhusan Panda
>>> >
>>> >
>>> > Hi,
>>> >
>>> > I reached till here and yes after executing test-network it gives
>>> > error.
>>> > ".UnknownMethod: Method "Connect" with
>>> > signature "s" on interface "org.bluez.Network1" doesn't exist"
>>> >
>>> > Please let me know is there any way to resolve this
>>> > issue?
>>> > Pasting Error details as below:
>>> >
>>> > Traceback (most recent call last):
>>> >   File "./test-network", line 52, in <module>
>>> >     iface = network.Connect(service)
>>> >   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in
>>> > __call__
>>> >     return self._proxy_method(*args, **keywords)
>>> >   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in
>>> > __call__
>>> >     **keywords)
>>> >   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
>>> > 651, in call_blocking
>>> >     message, timeout)
>>> > dbus.exceptions.DBusException:
>>> > org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
>>> > signature "s" on interface "org.bluez.Network1" doesn't exist
>>> >
>>> > Regards
>>>
>>> Hi,
>>>
>>> I nail down the issue why it always says (UnknownMethod: Method
>>> "Connect" with signature "s" on interface "org.bluez.Network1" doesn't
>>> exist).
>>>
>>> While debugging more,  it sounds that /org/bluez/hci1 provides only 8
>>> interfaces.(org.bluez.Adapter1, CyclingSpeedManager1,
>>> HeartRateManager1, Media1, NetworkServer1, ThermometerManager1,
>>> DBus.Introspectable, DBus.properties).
>>>
>>> org.bluez.Network1 interface entry is missing from /org/bluez/hci1 ?
>>>
>>> For your reference i am attaching snapshot of my set up, please let me
>>> know how can i add org.bluez.Network1 interface with /org/bluez/hci ?
>>> Is there any configuration file that i need to change ? or any other
>>> way to achieve this goal?
>>
>> Basically you need to add Network1 interface in bluetooth.conf file residing
>> /etc/dbus/system.d/bluetooth.conf
>>
>> And restart bluetoothd.
>>
>> Regards
>> Bharat
>>>
>>> Regards
>>> Ajay
>
> Hi Bharat,
>
> I hope this issue has resolve at your end?
>
> i did the change as suggested by you but it did not resolve the issue.
> For your reference i am attaching bluetooth.conf with my change at
> line number 21,  can you please confirm is this the only change
> required ? or some more changes need to do ?
>
> I have 1 more question the interfaces name mentioned in
> bluetooth.conf does not match with my set up. Again i am attaching
> snapshot of my setup.
>
> Please let me know how this issue can be resolved at my end ?
>
> Regards
> Ajay

Hi,

Can you please provide update regarding this issue?
How can i solve this , i am very much locked here.

Regards
Ajay
