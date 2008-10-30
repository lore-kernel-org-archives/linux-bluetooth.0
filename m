Return-Path: <cyrus@holtmann.org>
From: Christian Hoene <hoene@uni-tuebingen.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001d01c93a9f$6f2c8710$4d859530$@de>
References: <001d01c93a9f$6f2c8710$4d859530$@de>
Date: Thu, 30 Oct 2008 16:20:52 +0100
Message-Id: <1225380052.4626.8.camel@hoene-desktop>
Mime-Version: 1.0
Cc: 'Frans de Bont' <frans.de.bont@philips.com>
Subject: Re: [Bluez-devel] FW: REALLY Bad encoding performance of Linux
	SBC	audio codec
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

Hello, 

the sound quality got better. Still, both encoder and decoder are not as
good as the reference.


For example, not the audio quality measured with ODB(BV) is

Algorithm
ODG(BV)
In0Filename
In1Filename
PEAQBasic
             -1.99
ref.wav
tmp.bluez.wav
PEAQBasic
              -1.5
ref.wav
tmp.bluezref.wav
PEAQBasic
             -0.82
ref.wav
tmp.refbluez.wav
PEAQBasic
             -0.44
ref.wav
tmp.ref.wav


If I use the simple perceptual model of the reference implementation
(option -p), the encoding quality get even better.

Algorithm
ODG(BV)
In0Filename
In1Filename
PEAQBasic
             -1.99
ref.wav
tmp.bluez.wav
PEAQBasic
              -1.5
ref.wav
tmp.bluezref.wav
PEAQBasic
             -0.55
ref.wav
tmp.refbluez.wav
PEAQBasic
             -0.17
ref.wav
tmp.ref.wav

Here the old values before Frans's patch

Algorithm
ODG(BV)
In0Filename
In1Filename
PEAQBasic
              -1.5
ref.wav
tmp.bluezref.sw.wav
PEAQBasic
             -3.89
ref.wav
tmp.bluez.sw.wav
PEAQBasic
             -3.88
ref.wav
tmp.refbluez.sw.wav
PEAQBasic
             -0.44
ref.wav
tmp.ref.sw.wav

Greetings

 Christian



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
