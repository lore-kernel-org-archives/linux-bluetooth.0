Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47B063B6.6060900@wurmsdobler.org>
References: <47B063B6.6060900@wurmsdobler.org>
Date: Mon, 11 Feb 2008 16:08:48 +0100
Message-Id: <1202742528.7664.166.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] ALSA version for blueZ 3.26
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Peter,

> What version of ALSA is required to make BlueZ-utils 2.26 compile?
> 
> The latest audio/pcm_ioplug.h requires the struct 
> snd_pcm_ioplug_callback to contain a "delay" function which is not yet 
> present in the ALSA version 1.0.6 of my cross development environment 
> comes with.

I don't know, but the Debian stable kernel has 1.0.13 and that should be
a good start. My Ubuntu Gutsy box has 1.0.14 and I actually have 1.0.15
on Fedora8.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
