Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <F60A3CE9E807BE49B5F56BD80B894D20016883B3@sc-exch03.marvell.com>
References: <F60A3CE9E807BE49B5F56BD80B894D20016883B3@sc-exch03.marvell.com>
Date: Thu, 15 May 2008 11:44:49 +0200
Message-Id: <1210844689.7025.40.camel@violet.holtmann.net>
Mime-Version: 1.0
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

Hi Angus,

> I had alsa and .asoundrc working under 3.24 . Now under bluez 3.31 the
> device can't be found. 
> 
> Is there a configuration change for alsa ? A new audio.conf option ?

not that I remember. Show your .asoundrc and post the output from
calling hcid -n -d. It might indicate what is going wrong.

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
