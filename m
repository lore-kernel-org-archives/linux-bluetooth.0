Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C1A0E4.1050102@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] a2play question
References: <9lVn5TEuSyB@trebges.web.de>
In-Reply-To: <9lVn5TEuSyB@trebges.web.de>
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
Date: Sun, 08 Jan 2006 16:31:48 -0700

Dietmar

> I have downloaded the btsco-0.4 package.

I released a 0.41 package today so we have a more modern baseline.

> If i do a make in the /kernel directory, it appears a errormessage /lib/ 
> modules/2.4.26/source cannot find such file. I can not find a kernelmodule
> btsco.

The kernel module isn't required for stereo/a2dp audio.

> 
> The command
> 
> mpg123 --au - musik.mp3 | a2play 00:4F:62:05:53:8A -
> 
> produces no sound output only  error message.

you should show us the error message

> 
> The command
> 
> mpg123 --au - musik.mp3 | sbcenc - | a2play 00:4F:62:05:53:8A -
> 
> produces sound, but it plays to fast.

we may need to put your headset in the a2play list of noncompliant
devices. Marcel coded that stuff.

> another question ist: Can i send output of mplayer to the stereo-receiver?

there is a hack to create an alsa plugin that simply writes to standard
out. then the client can be run with its output piped to a2play. it's a
rather gross workaround for our nonworking alsa plugin.

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
