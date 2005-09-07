Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] PAN question
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050907111226.010371EC5B3@mrelay1.st2.lyceu.net>
References: <20050907111226.010371EC5B3@mrelay1.st2.lyceu.net>
Content-Type: text/plain
Message-Id: <1126095186.10631.33.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Sep 2005 14:13:06 +0200

Hi Esther,

> One more question. I can have one Bluetooth device on two different piconet,
> acting as a master in one of them, and as a slave in the other, and
> therefore forming a scatternet. But can this Bluetooth device form one PAN
> on each piconet, and be GN on one of them and PANU on the other?

you can and talking about GN and PANU is crap. The specification of PAN
has been written by someone without network knowledge at all. Every BNEP
connection has its own network interface in Linux and after that you can
use Bridging, Routing, NAT etc. to form the needed TCP/IP networks.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
