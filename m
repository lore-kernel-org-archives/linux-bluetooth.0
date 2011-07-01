Return-Path: <cyrus@holtmann.org>
Message-ID: <4E0D9996.8050807@wp.pl>
Date: Fri, 01 Jul 2011 11:55:34 +0200
From: "W.P." <laurentp@wp.pl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: pairing device in text mode
References: <4E0D82DA.7090501@wp.pl> <20110701084439.GA6461@dell.ger.corp.intel.com>
In-Reply-To: <20110701084439.GA6461@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Użytkownik Johan Hedberg napisał:
> On Fri, Jul 01, 2011, W.P. wrote:
>   
>> How can I do this in text mode?
>>     
>
> You can pair with "simple-agent hci0 <remote address>". To simply create
> a new device object without pairing you can use "test-device create
> <remote address>". Once you've created the object you can connect HID to
> the device with "test-input connect <remote address". To make it
> possible for the remote device to connect back to you later without user
> interaction do "test-device trusted <remote address> yes". simple-agent,
> test-input and test-device can be found under the test subdirectory in
> the source tree.
>
>   
[root@laurent-home test]# simple-agent hci0 00:1A:40:01:AE:09
Creating device failed: org.bluez.Error.AuthenticationFailed:
Authentication Failed

[root@laurent-home test]# test-device create 00:1A:40:01:AE:09
New device (/org/bluez/2269/hci0/dev_00_1A_40_01_AE_09)

But:
[root@laurent-home test]# test-input connect 00:1A:40:01:AE:09
Traceback (most recent call last):
  File "/usr/bin/test-input", line 40, in <module>
    input.Connect()
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630,
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.Failed: Connection
refused (111)

linkkeys not added.

What should I do / check?
> That doesn't make any sense. A PIN is a mandatory input parameter to the
> pairing process with any Bluetooth 2.0 or older device. Or do you mean
> to say that the mouse doesn't require pairing at all?
>
>   
It does require pairing. But in Win$ I simply choose option "without
security code", as said in manual.

W.P.
--
To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
