Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457D793F.6080504@xmission.com>
Date: Mon, 11 Dec 2006 08:29:03 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457C2D1F.1050605@free.fr>
In-Reply-To: <457C2D1F.1050605@free.fr>
Subject: Re: [Bluez-devel] [RFC] : Bluez audio routing: introducing switch
 alsa	plugin
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

Fabien

> The idea is to bring in the picture a new plugin that i would call
> conveniently the 'switch' plugin.
> As its name suggests, its role would be to route to either one PCM
> stream or another PCM.

This approach would be ok I think. It's an implementation detail.

One motivation for this approach would be keeping a2dp and sco daemons 
separate. Are you still interested in doing it that way?

We have been running with the assumption that we will have a single 
daemon for sco and a2dp. So Connect(addr) would attempt to make control 
connections for both protocols. Does this become too difficult?

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
