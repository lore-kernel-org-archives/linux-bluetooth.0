Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <C67AA1DF-D588-4FA1-884F-526189E99EDA@gmail.com>
References: <042F6BC7-A46A-4D9D-8810-1C66347B60C7@gmail.com>
	<45A5105B.7050705@xmission.com>
	<6D8DB734-3C02-4CED-80CE-F770D73FD6BA@gmail.com>
	<45A51999.3010108@xmission.com>
	<ABCE48BD-8B79-4C00-9ADE-B7DDB0940DE2@gmail.com>
	<45A51EC4.4030803@glidos.net>
	<076A94F3-C853-4A56-A4E1-5B5259353D5F@gmail.com>
	<1168450887.5241.2.camel@violet>
	<C67AA1DF-D588-4FA1-884F-526189E99EDA@gmail.com>
Date: Wed, 10 Jan 2007 19:00:16 +0100
Message-Id: <1168452016.5241.5.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] What happened with pin_helper (hcid.conf)?
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

Hi Bas,

> > this has been discussed to death. Starting with bluez-utils-3.x the  
> > PIN
> > helper concept has been deprecated and you have to provide a passkey
> > agent. Nobody said that this agent has to use a display. Check the
> > example passkey-agent.c in the source code.
> 
> The word "over-engineering" is about to leave my mouth.... *oops*,  
> nope, won't say it.

once you realize the full picture behind it, you might think otherwise.
The change to a passkey agent concept and cleanly separating the
handling of a pairing from the PIN input was a wise decision. Especially
when the new Simple Pairing of Bluetooth 2.1 comes along.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
