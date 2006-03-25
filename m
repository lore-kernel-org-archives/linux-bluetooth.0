Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000901c65064$040843c0$6280a8c0@clytemnestra>
From: "Alec Myers" <alec@fridge-news.co.uk>
To: <bluez-users@lists.sourceforge.net>
References: <E1FNH0j-0003Bs-QK@mail.sourceforge.net>
Subject: Re: [Bluez-users] Question about licensing!
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 25 Mar 2006 23:29:46 -0000

Just to be quite clear: is your customer planning on selling the complete 
solution to the public? Or is it just an in-house project?

----- Original Message ----- 
From: "Patrick Laplante" <plaplante@vanteon.com>
To: <bluez-users@lists.sourceforge.net>
Sent: Saturday, March 25, 2006 10:13 PM
Subject: [Bluez-users] Question about licensing!


Hi all,



I am currently working on a Linux based project that need Bluetooth support.
I need to basically receive images from Bluetooth devices and print them.



The code printing the images is proprietary and can't be GPL'd.



Since bluez is GPL, I can't just link against it without being forced to
make my code GPL which I can't, my customer won't allow me to release their
IP to the public.



I was thinking of doing this:



A small daemon that uses the bluez library that would, on image reception
from a device, push the image to another print daemon over a name pipe or
socket.  Does this break the GPL in any way?  If I understand the license
correctly, I would have to make my Bluetooth daemon GPL but my print daemon
wouldn't have to be GPL.



Can you please confirm?  Do you guys have any issue with that?



The last thing I want to do is upset anybody or put my customer in a
position where he could be sued.  Worst case, I'll have to buy a stack from
a company like StoneStreet or implement a custom stack for my customer
(which will bump the price by a lot :-)).



Regards,



Pat Laplante
Principal Engineer

Vanteon Corporation
2851 Clover Street
Pittsford, NY 14534-1711
Office: (585) 248-0510 x298
Fax: (585) 248-0537
www.vanteon.com  <http://www.vanteon.com> - Embedded for Your Future







-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
