Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4615D7F4.4040401@xmission.com>
Date: Thu, 05 Apr 2007 23:17:40 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>	<200703271139.42015.Tim.Chick@csr.com>	<46091D10.7070809@access-company.com>	<200703271501.49792.chick@computergeek.freeserve.co.uk>
	<4614BA5D.5010701@access-company.com>
In-Reply-To: <4614BA5D.5010701@access-company.com>
Subject: Re: [Bluez-devel] Question about poll() - was Re: a2dpd and mplayer
 - any chance to get it working?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Frederic

> If poll(x,y,1) is replaced by usleep(1); poll(x,y,0) then cpu usage fall 
> back to 0.

poll is returning immediately either with an error or with one of your
conditions met. what is in revents after the return? what conditions are
you interested in?

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
