Return-Path: <cyrus@holtmann.org>
Message-ID: <48D95F28.4000708@stephan.co.uk>
Date: Tue, 23 Sep 2008 22:27:04 +0100
From: Stephan de Georgio <sd@stephan.co.uk>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48C43D87.2040705@stephan.co.uk>
	<d89ddf300809071430jb7d0303yea3173504c0894aa@mail.gmail.com>
In-Reply-To: <d89ddf300809071430jb7d0303yea3173504c0894aa@mail.gmail.com>
Subject: Re: [Bluez-devel] Motorola DC800
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

 >afaik, this is still only possible using "a2recv" in the old btsco 
project.

Is a2recv not for streaming audio from the DC800 to the PC?  I'm trying 
to stream audio from the PC to the DC800.  I can't seem to find any 
documentation on a2recv except the small snippet below from the 
bluetooth-alsa build page.

 >The A2DP sink code receives a stream from another device. Run it with:
 > hciconfig hci0 class 0x200404
 > sdptool add A2SNK
 > ./a2recv

 >It will try to bind to the bluetooth adapter and send audio out to 
/dev/dsp.

I have installed the btsco package and tried running this and a2recv 
just hangs with no output.  Is there something else I need to do before 
running a2recv?

I've also tried the command

mpg123 --au - file.mp3 | ./a2play bdaddr

where bdaddr is the address of the DC800, but this give no audio output 
either.

Any help would be very much appreciated.

Regards,
Stephan


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
