Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Benoit Panizzon <panizzon@woody.ch>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Piconet problems
Cc: "jers@inwind.it" <jers@inwind.it>
References: <IA5EZL$515602A938C639AD7C0D84FB93EBFF70@libero.it>
In-Reply-To: <IA5EZL$515602A938C639AD7C0D84FB93EBFF70@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501111152.08711.panizzon@woody.ch>
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
Date: Tue, 11 Jan 2005 11:52:08 +0100

Am Dienstag, 11. Januar 2005 11.40 schrieb jers@inwind.it:
> Hi Marcel,
>
> I'm still trying to create a simple piconet with a master and two slaves. I
> upgrated my bluez and, on your website, I red the firmware of my dongles
> (Digicom Palladio CSR) is fit for my aims. Now the situation is as follows:
>
> On the three sides I type
>
> # modprobe bnep
>
> On the master side:
>
> # brctl addbr pan0
> # ifconfig pan0 10.0.0.1
> # brctl setfd pan0 0
> # brctl stp pan0 off
> # pand  --listen --master --role GN
>
> On the slave1 side:
> # pand --connect <master bt_addr>
> # ifconfig bnep0 10.0.0.2
>
> In most cases I obtain the following error:
>
> SIOCSIFADDR: No such device
> bnep0: unknown interface: No such device

Are you sure the connection is established? The bnep devices only show up 
after the connection was established so you cannot ifconfig them as long as 
it is not up yet (during search etc...).

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
