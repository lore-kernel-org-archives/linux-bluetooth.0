Return-Path: <cyrus@holtmann.org>
Message-ID: <4FBB868C.5070401@tu-ilmenau.de>
Date: Tue, 22 May 2012 14:29:00 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Grant Access to Advanced Audio Distribution Service
References: <4FBB5CCF.7080003@tu-ilmenau.de> <20120522094725.GA12593@x220>
In-Reply-To: <20120522094725.GA12593@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Am 22.05.2012 11:47, schrieb Johan Hedberg:
> Hi Steffen,
>
> On Tue, May 22, 2012, Steffen Becker wrote:
>> maybe you remember me, I wrote some mails regarding a problem with
>> the connection of two Bluetooth-Dongles.
>> Now I tested a little bit with a Ubuntu Live CD and there I also
>> couldn't create a connection between my devices *but* when I clicked
>> on a pop-up-window at the remote device named "Grant Access to the
>> service 0000110D-0000-1000-8000-00805F9B34FB", the connection
>> worked!
>> I googled and found out that:
>>
>> 0000110D-0000-1000-8000-00805F9B34FB = AdvancedAudioDistributionService.
>> So I think I have to grant access to this service in my
>> gentoo-settings to get my connection work.
>> But I have no idea where/how I can configure this.
> The "Trusted" property for each device determines whether authorization
> is needed for incoming connections. IIRC gnome-bluetooth sets this
> automatically for all configured devices and from the command line you
> can do it with the test-device python script (that's part of the BlueZ
> source tree): test-device trusted<address>  yes
>
> Johan

Thanks for your answer, but I already tried
# bluez-test-device trusted <remot-address> yes
and in my "# bluez-test-discovery" I can see "Trusted = 1", so I think 
that isn't the problem.
What I just noticed is that there are different Classes at both devices:
Device 1: "Class = 0x000000"
Device 2: "Class = 0x420100"
Does it mean something? And how can I change my classes?

Neither my connection via
# bluez-test-network <remote-address> NAP
nor via
# bluez-test-serial <remote-address>
works.

I will be thankful for any helpful idea.

Here is what I get:
# bluez-test-network 00:02:72:AE:58:73 nap
Traceback (most recent call last):
   File "/usr/bin/bluez-test-network", line 40, in <module>
     device = adapter.FindDevice(address)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 68, 
in __call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 143, 
in __call__
     **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 
630, in call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Does Not Exist

----------------------------------------------------

# bluez-test-serial 00:02:72:AE:58:73
Traceback (most recent call last):
   File "/usr/bin/bluez-test-serial", line 39, in <module>
     path = adapter.FindDevice(address)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 68, 
in __call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 143, 
in __call__
     **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 
630, in call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Does Not Exist



Regards,
Steffen
