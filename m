Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simone Gotti <simone.gotti@email.it>
To: Detlef Grittner <detlef.grittner@t-online.de>
Subject: Re: [Bluez-users] Pocket PC 2003 and Linux
Cc: bluez-users@lists.sourceforge.net
References: <412C5482.3010909@t-online.de> <200408251202.48482.simone.gotti@email.it> <412C9332.7010002@t-online.de>
In-Reply-To: <412C9332.7010002@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408251612.44110.simone.gotti@email.it>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 25 Aug 2004 16:12:43 +0000

On Wednesday 25 August 2004 13:25, Detlef Grittner wrote:
> Yes, I have kbtobexsrv registered and the sdptool command output is as
> expected.
>
> The problem is I can send data from the Linux client to the Pocket PC
> via Obex Push using the KDE tools.
> But I can't send data from the Pocket PC to the Linux client.

So the Obex Push service is right registered but the Pocket PC can't find it?
you said that it can find only the kbtserialchat, can you confirm this?
I can only think that probably there are registered more than one obexservice. 
Can you post the full output of "sdptool browse local"?

P.S. I don't know if this is the right place to talk about kdebluetooth. 
Probably we should move our thread to the kdebluetooth mailing list (avoiding 
any crossposting).

Bye!
-- 
Simone Gotti
<simone.gotti@email.it>
http://kde-bluetooth.sf.net


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
