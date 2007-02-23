Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 22 Feb 2007 21:06:12 -0500
From: Walt Shekrota <penguinacity@yahoo.com>
To: bluez-users@lists.sourceforge.net
Message-id: <200702222106.12976.penguinacity@yahoo.com>
MIME-version: 1.0
Subject: Re: [Bluez-users] plantronics 320 working minor problems
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

I think I have an answer to having to invoke  btsco twice.
Per the Plantronics instructions my headset is in pairing mode with a long 
press.

However I find that if after I have done this I give it a short press 
Then call btsco it connects perfect on the first call.

So is their document lying about pairing mode or does bluez require another 
signal? Or maybe the headset is trying to connect in some master mode and the 
additional short press says disconnect leaving it waiting?

Is there a document somewhere on the web that describes the interaction of the 
daemons for bluez?

Thanks.
-Walt

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
