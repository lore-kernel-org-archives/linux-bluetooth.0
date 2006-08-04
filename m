Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44D35444.8000304@xmission.com>
References: <44D35444.8000304@xmission.com>
Date: Fri, 04 Aug 2006 18:39:50 +0200
Message-Id: <1154709590.3905.97.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] channel-surfing cellphone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Brad,

> I have a Treo 700p that I use for dialup networking. I have to reset the
> thing every once in a while and it seems to invariably alternate between
> channel 1 and 4 for dialup networking.
> 
> I'm all set up with the rfcomm mapping, ppp settings, and diald to fire
> up the network using this phone but sometimes things break down because
> the channel has changed! Has anyone worked out a good way to see this
> coming and adapt automatically? I'd like to avoid parsing sdptool output.

so far the only way is to write a wrapper that queries the SDP database
of the phone and creates RFCOMM TTY devices dynamically. The nice static
mapping will no longer work. We don't have SDP support in the Linux
kernel and we will _never_ move this protocol into the kernel.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
