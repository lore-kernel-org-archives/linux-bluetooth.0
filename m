Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANBo3n9=-VeFh2EAwm5EcSHgBuZUzFyJDwMZDR29wwKrmgKvVg@mail.gmail.com>
References: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
 <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
 <CAMj0Yys1efPQoZPPHbPKs54c9DFWRfFjhkt4Pe3K-fYaZZiarw@mail.gmail.com>
 <CABBYNZLNzLx0+BGgLzubwOHUaMcyde6bL1hhxrHtfskt9OGbzg@mail.gmail.com>
 <CAMj0YytVTxHLY-Mkrjy9PEvNPVd-2GmX9vAK5PeLVo+kSCvAZw@mail.gmail.com> <CANBo3n9=-VeFh2EAwm5EcSHgBuZUzFyJDwMZDR29wwKrmgKvVg@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Thu, 11 Aug 2016 15:24:02 +0530
Message-ID: <CAMj0YytkTtekdgHnZSWbHW+zwdANvMNjgaKfym6a4n5mKWaM_Q@mail.gmail.com>
Subject: Re: BT PAN Connection - NAP with PANU ?
To: bharat panda <bharat22bhusan@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 26, 2016 at 2:18 PM, bharat panda <bharat22bhusan@gmail.com> wrote:
> Hi Ajay,
>
> On Tue, Jul 26, 2016 at 11:11 AM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
>> On Mon, Jul 25, 2016 at 5:06 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Ajay,
>>>
>>> On Mon, Jul 25, 2016 at 2:11 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> I am using bluez 5.35 and performing one POC with NAP and PANU communication.
>>>>> I want to connect PANU with NAP, for this i executed below tasks
>>>>>
>>>>> 1) Created a bridge successfully with Ubuntu 15.10.
>>>>> 2) Executed /test/test-nap script and i can see that NAP has established.
>>>>>
>>>>> 3) I am not getting how to start PANU (client) so that it can be
>>>>> connected with NAP (as defined in above step 2) and start
>>>>> communicating each other.
>>>>
>>>> How about doc/network-api.txt:
>>>>
>>>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt
>>>>
>>>> e.g: org.bluez.Network1.Connect("panu")
>>>>
>>>> ----------------------------------------------------------------------------------------------
>>>> My fault i did Top posting, so giving my reply again in right format.
>>>> ----------------------------------------------------------------------------------------------------
>>>> Hi,
>>>>
>>>> Thanks for reply, I will try this connect API.
>>>> In my case it need to be connected with NAP as PANU itself, so the
>>>> parameter of connect api  should states its own role or the role of
>>>> server with whom it needs to be connected?
>>>>
>>>> These APIs are used in python examples, is there similar API available
>>>> for C programming application also?
>>>> Can i get similar C example ?
>>>
>>> It is actually a D-Bus method call so any D-Bus binding would do it,
>>> we just did in python because it is much more convenient.
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>> HI Luiz,
>>
>> I will try with C language D-Bus binding.
>>
>> Prior to this I tried to execute bluez-5.34/test/test-network example
>> and i m getting below error.
>>  1) It sounds me that it is unable to found Bluetooth device, but my
>> device is quite ready and working with other examples."
>> 2) other reason could me i did not pair this with /test-nap example,
>> should first i pair this test-network example device with test-nap
>> example device ?
>>
>> Can you please let me know why i am getting this error or let me know
>> some pointers from where i can debug this issue.
>>
>> Traceback (most recent call last):
>>   File "./test-network", line 41, in <module>
>>     device = bluezutils.find_device(args[0], options.dev_id)
>>   File "/mnt/hgfs/shared_With_VM_Ubuntu/test/bluezutils.py", line 30,
>> in find_device
>>     adapter_pattern)
>>   File "/mnt/hgfs/shared_With_VM_Ubuntu/test/bluezutils.py", line 47,
>> in find_device_in_objects
>>     raise Exception("Bluetooth device not found")
>> Exception: Bluetooth device not found
> The test-network script, tries to search for remote device in device
> databases. So for this you first need to add the device in devices
> list by successfully pairing to the device from bluetoothctl. If
> bluetoothctl lists the remote device name for "devices" command, then
> this will not show this error anymore.
> Then you will encounter another error i.e "No such method "Connect"
> with signature "s" exists on org.bluez.Network1 interface". I am not
> sure how to get rid of this now.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Regards
> Bharat
>
> --
> Thanks and Regards
> Bharat Bhusan Panda


Hi,

I reached till here and yes after executing test-network it gives
error.
".UnknownMethod: Method "Connect" with
signature "s" on interface "org.bluez.Network1" doesn't exist"

Please let me know is there any way to resolve this
issue?
Pasting Error details as below:

Traceback (most recent call last):
  File "./test-network", line 52, in <module>
    iface = network.Connect(service)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with
signature "s" on interface "org.bluez.Network1" doesn't exist

Regards
