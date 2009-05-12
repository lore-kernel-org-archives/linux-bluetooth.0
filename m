Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <671907.21026.qm@web95401.mail.in2.yahoo.com>
References: <671907.21026.qm@web95401.mail.in2.yahoo.com>
Date: Tue, 12 May 2009 11:24:32 -0300
Message-ID: <2a9506370905120724u61747a6foce33fafbba2ceb52@mail.gmail.com>
Subject: Re: Help me to test top of tree bluetooth subsystem
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: balaji palaniswami <balaji_palaniswami@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balaji,

On Tue, May 12, 2009 at 9:14 AM, balaji palaniswami
<balaji_palaniswami@yahoo.com> wrote:
> Hi All ,
>
> I have upgraded the ubuntu 8.04 kernel to 2.6.30-rc5 and bluez 4.39. I did pairing with Jabra headset using below pyhton script. I got below error message. This issue is related with ubuntu application dbus. so please advise me which distribution , setup procedure  would be suitable to test top tree of bluetooth subsystem.
>

There is an audio devices howto at the wiki[1], which has been updated
recently (thanks Zygo!),
it covers pretty much everything.

Taking a look at the traceback and the script you have provided it
seems that you still are running
a daemon from the old 3.x series. The dbus interface has changed,
please take a look at the *-api.txt
files in the doc directory in a more recent version.

> Thanks,
> Balaji.P
>
>
> Traceback (most recent call last):
>  File "./bthstereoheadset.py", line 25, in <module>
>    path = audio.CreateDevice(headsetAddress)
>  File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in __call__
>    return self._proxy_method(*args, **keywords)
>  File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140, in __call__
>    **keywords)
>  File "/var/lib/python-support/python2.5/dbus/connection.py", line 607, in call_blocking
>    message, timeout)
> dbus.exceptions.DBusException: org.bluez.Error.ConnectionAttemptFailed: Host is down
>
>
>      Now surf faster and smarter ! Check out the new Firefox 3 - Yahoo! Edition http://downloads.yahoo.com/in/firefox/?fr=om_email_firefox


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

[1] http://wiki.bluez.org/wiki/HOWTO/AudioDevices
