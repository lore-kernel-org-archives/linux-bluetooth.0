Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Benoit Panizzon <panizzon@woody.ch>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Accept incomming serial connection (palm hotsync)
Cc: Jay Summet <summetj@cc.gatech.edu>
References: <20050110040324.3E5548852B@sc8-sf-spam1.sourceforge.net> <41E28999.9070005@cc.gatech.edu>
In-Reply-To: <41E28999.9070005@cc.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501111023.18859.panizzon@woody.ch>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 11 Jan 2005 10:23:18 +0100

Hi Jay

> I am able to sync my Palm T via bluetooth, but the way I do it is not by
> setting up a serial connection. Instead, I set up a PAN connection (giving
> my palm pilot a local ip address and my computer another) and then do a
> NETWORK hotsync (vs serial over bluetooth) using the IP address of my
> computer. I tell Jpilot (pilot-link) to listen to "net:all" (or is it
> "net:any"....)...

Yup, kpilot also is able to listen to net:any

But... I never managed to get a PAN Bluetooth Network Connection from my palm.

PAN with pand between two Linux Boxes work (one as NAP the other as PANU) 
works, so I assume by Linux Bluetooth Setup is correct.

What works is a dund connection via bluetooth an ppp.

But my Zire 72 does not offer to do a 'hotsync' via this ppp connection. Only 
'serial' aka 'local' or 'modem' connections are selectable from hotsync.

How did you manage to sync via IP?

Regards
-Benoit-
-- 
SPAM SPAM SPAM SPAM / Hormel's new miracle meat in a can
Tastes fine, saves time. / If you want something grand, / Ask for SPAM!
  - Hormel's 1937 jingle for SPAM


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
