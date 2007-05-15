Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 15 May 2007 22:20:57 +0100
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
	<200705150200.43977.bluez-devel@huitl.de>
	<200705152222.11641.bluez-devel@huitl.de>
In-Reply-To: <200705152222.11641.bluez-devel@huitl.de>
MIME-Version: 1.0
Message-Id: <200705152220.58038.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] skype and bluetooth
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tuesday 15 May 2007 21:22, Robert Huitl wrote:
> Okay after some debugging I know what the problem is.
> 2.) Offering more sampling rates than 8 kHz would be nice to have, but I'm
> not familiar with the design philosophies around ALSA. It's probably not a
> good idea to implement resampling in each and every sound plugin like
> pcm_sco. Does ALSA have some resampling facilities that can be plugged in
> between an application and a plugin? Maybe some magic lines in .asoundrc?
>
I do this with a2dp, I'm sure the same could apply to sco.
I use an .asoundrc file which looks like this:

pcm.a2dpd {
=A0=A0=A0=A0=A0=A0=A0=A0type a2dpd
}

pcm.rs0 {
=A0=A0=A0=A0=A0=A0=A0=A0type plug
=A0=A0=A0=A0=A0=A0=A0=A0slave {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pcm "a2dpd"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rate 44100
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0format S16_LE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0channels 2
=A0=A0=A0=A0=A0=A0=A0=A0}
}

pcm.!default {
=A0=A0=A0=A0=A0=A0=A0=A0type plug
=A0=A0=A0=A0=A0=A0=A0=A0slave.pcm "rs0"
}

----

It will resample the audio given to the a2dp plugin so it is always 44.1kHz.

Cheers,
Tim


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
