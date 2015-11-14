Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56431E41.6030404@felipetonello.com>
References: <CABOZqnh3p4NXcGMyeT3UjYH+OdU4phV0bGPtoUJa2KzEZjp5iw@mail.gmail.com>
	<56431E41.6030404@felipetonello.com>
Date: Fri, 13 Nov 2015 16:39:26 -0800
Message-ID: <CABOZqniMLZ3Hy_WXMKObtoCXjTAuts+3iz3HuYB8wSLhAZLupw@mail.gmail.com>
Subject: Re: Connection failures on Ubuntu
From: Mark Spruiell <mes@zeroc.com>
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Wed, Nov 11, 2015 at 2:53 AM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Mark,
>
> On 10/11/15 17:20, Mark Spruiell wrote:
>> I'm not able to connect to a service running on Ubuntu 15.10. The
>> system-provided BlueZ version is 5.35.
>>
>> I can reproduce it using the test scripts. On Ubuntu:
>>
>> ./test-profile -s -u b85280dd-b78a-4a45-be4b-b6fec4abd86f -n "Test Server" -C 5
>>
>> sdptool shows the service:
>>
>> Service Name: Test Server
>> Service RecHandle: 0x10009
>> Service Class ID List:
>>   UUID 128: b85280dd-b78a-4a45-be4b-b6fec4abd86f
>> Protocol Descriptor List:
>>   "L2CAP" (0x0100)
>>   "RFCOMM" (0x0003)
>>     Channel: 5
>>
>> On a different host (this one running Fedora 22 with BlueZ 5.29), I
>> start a client:
>>
>> ./test-profile -u b85280dd-b78a-4a45-be4b-b6fec4abd86f -c
>>
>> and then
>>
>> ./test-device connect <ubuntu-addr> b85280dd-b78a-4a45-be4b-b6fec4abd86f
>> Traceback (most recent call last):
>>   File "./test-device", line 104, in <module>
>>     device.ConnectProfile(args[2])
>>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 70,
>> in __call__
>>     return self._proxy_method(*args, **keywords)
>>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 145,
>> in __call__
>>     **keywords)
>>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line
>> 651, in call_blocking
>>     message, timeout)
>> dbus.exceptions.DBusException: org.bluez.Error.Failed: Connection refused
>>
>> Other times I will get:
>>
>> dbus.exceptions.DBusException: org.bluez.Error.Failed: Resource
>> temporarily unavailable
>>
>> These hosts are already paired. Things work fine when both hosts are
>> using Fedora 22.
>>
>> Any suggestions on how I can diagnose this further?
>
> I had this type of problem on Ubuntu when trying to register master's
> build of bluetoothd to D-Bus on Ubuntu as well and not on Fedora.
>
> Try to tweak /etc/dbus-1/system.d/bluetooth.conf user permissions just
> for development.

I tried playing with some different settings in bluetooth.conf but
couldn't get it to work.

Thanks for the reply.

Mark
