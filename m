Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070227122248.z4cs4s8ocsg0ow0w@www.webmail4.com>
Date: Tue, 27 Feb 2007 12:22:48 -0700
From: "robert@infotility.com" <robert@infotility.com>
To: mmajchrowicz@gmail.com
References: <3d3168e50702270853u31b66304w5e95b23386a88a54@mail.gmail.com>
In-Reply-To: <3d3168e50702270853u31b66304w5e95b23386a88a54@mail.gmail.com>
MIME-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with PAN. Bnep doesn't work ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Quoting Micha=B3 Majchrowicz <mmajchrowicz@gmail.com>:

> Hi I have a problem with PAN.
> I have succesfully configured pand connection
> on sever:
>  pand -l
> bnep0 11:22:33:44:55:66 NAP
> on client:
> pand -l
> bnep0 66:55:44:33:22:11 NAP
> where 66:55.... is MAC of server and 11:22.... is MAC of client.

Michael, the problem could be any one of a number of things...
To help with tracking down the source of the error, try these programs:
sdptool browse
l2ping xx.xx.xx.xx
hcitool scan

should all show something.
Also try tail -f /var/log/messages
to see if the kernel writes something there.

Sorry I can't be more helpful. Let us know how it goes.

Robert Dodier

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
