Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <6.1.2.0.2.20050125092855.057821a0@pop.gmx.net>
To: bluez-users@lists.sourceforge.net
From: George <george.news@gmx.net>
Subject: Re: [Bluez-users] Bluez BNEP connection close
In-Reply-To: <1106589847.8058.90.camel@pegasus>
References: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es>
 <1106581771.8058.49.camel@pegasus>
 <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net>
 <1106583831.8058.52.camel@pegasus>
 <6.1.2.0.2.20050124180402.041c1eb0@pop.gmx.net>
 <1106585260.8058.56.camel@pegasus>
 <6.1.2.0.2.20050124182813.04216860@pop.gmx.net>
 <6.1.2.0.2.20050124192058.04bee240@pop.gmx.net>
 <1106589847.8058.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
Date: Tue, 25 Jan 2005 09:33:24 +0100

Hi again.

In my code I have a reconnection capability once the bnep connection 
disappears.
However doing some more tests I found that sometimes the interface bnep0 is 
still there (in the laptop) although there is no connectivity.
I mean, the interface exists but the channel or path is not more up. 
Therefore my reconnection capability doesn't work on this case.

So... don't know what could happen. I have recompiled the kernel serveral 
times changing the UCHI, OHCI and EHCI supports but still happens the same..

I'm thinking on buying a PCMCIA Bluetooth card to have a try as Marcel 
thinks the problem is with the usb.

Any new Idea?

Sorry for being so insistant but it's a matter of dead or life ;)

Regards

At 19:04 24/01/2005, Marcel Holtmann wrote:
 >Hi George,
 >
 >> OOpssss ... It wasn't the solution
 >>
 >> I have remove the SCO totally removed and still facing the same problem.
 >> Thanks for your help and sorry for bothering all of you, but I have to 
show
 >> my application in a short while and I want it to be as stable as possible.
 >
 >try to swap your UHCI host controller with an OHCI one or move to a 2.6
 >kernel. If the USB subsystem is the problem I can't help you.
 >
 >Regards
 >
 >Marcel
 >
 >
 >
 >
 >-------------------------------------------------------
 >This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
 >Tool for open source databases. Create drag-&-drop reports. Save time
 >by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
 >Download a FREE copy at http://www.intelliview.com/go/osdn_nl
 >_______________________________________________
 >Bluez-users mailing list
 >Bluez-users@lists.sourceforge.net
 >https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
