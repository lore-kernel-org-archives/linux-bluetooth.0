Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY107-F11C9029CAA2F0071A01144D8650@phx.gbl>
From: "Adolfo Bulfoni" <iaquintovski@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 05 Apr 2007 17:07:21 +0200
Mime-Version: 1.0
Subject: Re: [Bluez-devel] intercept new authentication events
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

Hi Marcel
thanks for your quick reply.

I've checked the passkey-agent util program  in /bluez-utils/daemon/ and if =

I try running it, an error message comes up saying there is already a =

passkey agent running on my PC.
How can I intercept the events sent by this agent? What are the functions =

that need to be called to get the output events from it?
A "dirty" workaround for my app might be to tail the /var/log/syslog file, =

where the pin_code_request event is logged, together with the remote device =

address. But I'd prefer a cleaner solution.
Thanks in advance,
regards

Adolfo

_________________________________________________________________
Ami i Quiz? Mettiti alla prova con Duell Live=85Gratis su Messenger! =

http://specials.it.msn.com/DuelLive.aspx


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
