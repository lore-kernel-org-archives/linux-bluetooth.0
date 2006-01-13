Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Dietmar Segbert <trebges@web.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <9lorhdjeSyB@trebges.web.de>
In-Reply-To: <43C809DA.1050302@xmission.com>
References: <43C809DA.1050302@xmission.com>
Subject: Re: [Bluez-users] a2play question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: 13 Jan 2006 21:49:00 +0100

Hello Brad,

> bmidgley@xmission.com schrieb am 13.01.06:
> does it drop out for a second or so and come back? i was noticing
> that a lot on a machine using nvidia drivers. i suspect they turn
> off interrupts in their driver.
Difficult to explain, it sounds as you can hear the frames and betwenn the
frames is a litte dropout or beep.
I have no videodriver running, i only use linux on the console, becuase i
am blind. Only in the kernel is speakup integrated, so that i can use my
dolphin apollo hardwaresynthesizer, also i use brltty with a tieman voyger
braille display.


>> Wiht the 2.4.32 kernel the dropouts are also to hear.

> 2.6.x may behave better
Can i compile a 2.6.x kernel, when a 2.4.x kernel works?


>> Can or must i configure the headphone-profile with
>> hcitool/sdptool, the bt-120ar has an integrated microphon.

> hcitool/sdptool is not how you make the mic work and it won't help
> with dropouts.

> your headset runs in two modes: 2-way mono and 1-way stereo. the
> btsco app is for 2-way mono and a2play is for 1-way stereo. you
> can't run both the mic and stereo simultaneously on any of the
> headsets out there.

> brad


Dietmar

> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through
> log files for problems?  Stop!  Download the new AJAX search engine
> that makes searching your log files as easy as surfing the  web.
> DOWNLOAD SPLUNK! http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=
> click _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
