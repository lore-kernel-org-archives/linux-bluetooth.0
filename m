Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <Tim.Chick@csr.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 27 Mar 2007 11:39:41 +0100
References: <200701150326.46855.bluez-devel@huitl.de>
	<45BD6370.4050005@xmission.com> <45C36CE5.90205@access-company.com>
In-Reply-To: <45C36CE5.90205@access-company.com>
MIME-Version: 1.0
Message-Id: <200703271139.42015.Tim.Chick@csr.com>
Subject: Re: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Friday 02 February 2007 16:55, Fr=E9d=E9ric DALLEAU wrote:
> Hi,
>
> I've been trying some things and just uploaded an *a2dpd2* plugin.
> Tested the plugin with
> aplay,xmms,amarok,vlc,mocp,kaffeine,mplayer,beep-media-player.
> This gave good sound on all except mplayer :( but at least the movie
> speed is now correct. This may be worth a try on another computer.
> Not had time to try any gst based player.
>
> reports appreciated.
>

It looks like this stuff is in flux at the moment?

I am using CVS from last night, and I see basically 100% CPU usage from =

a2dpd, with mpg321 and mplayer whilst it is streaming.

On an old version, from a few months ago, I did not see this problem.

This is running on a 400MHz ARM based system, so there should be plenty =

of CPU available.

Thanks,
Tim

-- =

Tim Chick, Applications Engineer - Convergence SBU
CSR, Cambridge, UK - http://www.csr.com



To access the latest news from CSR copy this link into a web browser:  http=
://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relatio=
ns page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
