Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <18a15270707050404y72f7d4e1i6473089816749123@mail.gmail.com>
References: <200707041719.20662.wundram@beenic.net>
	<200707051108.32230.wundram@beenic.net>
	<Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
	<200707051135.23459.wundram@beenic.net>
	<18a15270707050404y72f7d4e1i6473089816749123@mail.gmail.com>
Date: Fri, 06 Jul 2007 08:00:44 +0200
Message-Id: <1183701644.6351.111.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Using BlueZ in commercial applications -
	Once	again.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ranulf,

>         > the socket-API being one form of such glue code
>         > (but because that requires a GPL'd header to actually
>         function, think of 
>         > AF_BLUETOOTH defined only in bluetooth/bluetooth.h, it's out
>         of the
>         > question) 
> 
> The number itself isn't covered by the GPL however. The constant name,
> I'm less sure about, but I see no reason why you couldn't define your
> own constant FAMILY_BLUETOOTH which happens to have the same value as
> a publically known magic value. 

contact a lawyer before making such statements. How do you learned about
that number. You read GPL code and this would make it derived work. Be
really careful. The licenses are in place for a reason. You wanna use
software from the community so you have to play with our rules. If you
don't want that, then you can always buy a Bluetooth stack from someone
else.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
