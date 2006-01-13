Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C809DA.1050302@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] a2play question
References: <43C1A15F.3040001@xmission.com> <9lorfQU9SyB@trebges.web.de>
In-Reply-To: <9lorfQU9SyB@trebges.web.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Jan 2006 13:13:14 -0700

Dietmar

> i have downloaded and installed btsco-0.41. I also have installed the rtc
> module of the 2.4.26 kernel.
> 
> mpg123 --au - musik.mp3 | ./a2play -p 00:4F:62:05:53:8A
> 
> works, but after some seconds i can hear a dropout.

does it drop out for a second or so and come back? i was noticing that a
lot on a machine using nvidia drivers. i suspect they turn off
interrupts in their driver.

> Wiht the 2.4.32 kernel the dropouts are also to hear.

2.6.x may behave better

> Can or must i configure the headphone-profile with hcitool/sdptool, the
> bt-120ar has an integrated microphon.

hcitool/sdptool is not how you make the mic work and it won't help with
dropouts.

your headset runs in two modes: 2-way mono and 1-way stereo. the btsco
app is for 2-way mono and a2play is for 1-way stereo. you can't run both
the mic and stereo simultaneously on any of the headsets out there.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
