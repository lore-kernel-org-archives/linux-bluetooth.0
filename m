Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 15 May 2008 07:43:23 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D20016883BD@sc-exch03.marvell.com>
References: <F60A3CE9E807BE49B5F56BD80B894D20016883B3@sc-exch03.marvell.com>
	<1210844689.7025.40.camel@violet.holtmann.net>
From: "Angus Ainslie" <aainslie@marvell.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Alsa and asoundrc
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

> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net 
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf 
> Of Marcel Holtmann
> Sent: Thursday, May 15, 2008 3:45 AM
> To: BlueZ users
> Subject: Re: [Bluez-users] Alsa and asoundrc
> 
> Hi Angus,
>
> not that I remember. Show your .asoundrc and post the output 
> from calling hcid -n -d. It might indicate what is going wrong.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

I don't think it was the .asoundrc but I included it at the end anyway.

The 2 problems I found were 

1) it wasn't finding libasound_module_pcm_bluetooth.so until I added
/usr/lib/alsa-lib to my LD_LIBRARY_PATH

2) Because the library wasn't found at boot the sound service needed to
be restarted.

Angus


asoundrc:

pcm.!default {
    type bluetooth
    device 00:07:A4:F1:AE:13
    profile "hifi"
}
pcm.headphones {
    type bluetooth
    device 00:07:A4:F1:AE:13
    profile "hifi"
}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
