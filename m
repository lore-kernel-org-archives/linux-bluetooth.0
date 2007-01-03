Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459BFEA0.4030809@xmission.com>
Date: Wed, 03 Jan 2007 12:06:08 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000301c72f65$be796e60$0300a8c0@2600xp>
In-Reply-To: <000301c72f65$be796e60$0300a8c0@2600xp>
Subject: Re: [Bluez-devel] Btsco power consumption
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

Tom

doh... I forgot to update that version string when I built 0.5.

> Well I think I have version 0.5 of btsco working paired and talking on skype
> to my friends while pottering around the house. The problem I am
> experiencing is that the headset does not seem to go into standby or power
> saving after the headset is not in use. I have a Logitech HS08 v1.2. Should
> this be reported as a bug and who to also might someone have any ideas on a

as long as your hcid.conf contains "lp hold,sniff,park;" then file it as 
a bug on the bluetooth-alsa sourceforge project.

we are not maintaining btsco any more so I'd be interested to hear if 
the sco plugin in "plugz" has the same problem.

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
