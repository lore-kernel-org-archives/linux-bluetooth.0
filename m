Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <18a15270707050404y72f7d4e1i6473089816749123@mail.gmail.com>
Date: Thu, 5 Jul 2007 12:04:38 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200707051135.23459.wundram@beenic.net>
MIME-Version: 1.0
References: <200707041719.20662.wundram@beenic.net>
	<200707051108.32230.wundram@beenic.net>
	<Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
	<200707051135.23459.wundram@beenic.net>
Subject: Re: [Bluez-devel] Using BlueZ in commercial applications - Once
	again.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0539350188=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0539350188==
Content-Type: multipart/alternative;
	boundary="----=_Part_3112_3809902.1183633478411"

------=_Part_3112_3809902.1183633478411
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > the socket-API being one form of such glue code
> > (but because that requires a GPL'd header to actually function, think of
> > AF_BLUETOOTH defined only in bluetooth/bluetooth.h, it's out of the
> > question)
>

The number itself isn't covered by the GPL however. The constant name, I'm
less sure about, but I see no reason why you couldn't define your own
constant FAMILY_BLUETOOTH which happens to have the same value as a
publically known magic value.

You'd only be using standard POSIX interfaces at that point.

Ralf.

------=_Part_3112_3809902.1183633478411
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; the socket-API being one form of such glue code<br>&gt; (but because that requires a GPL&#39;d header to actually function, think of
<br>&gt; AF_BLUETOOTH defined only in bluetooth/bluetooth.h, it&#39;s out of the<br>&gt; question) <br></blockquote></div><br>The number itself isn&#39;t covered by the GPL however. The constant name, I&#39;m less sure about, but I see no reason why you couldn&#39;t define your own constant FAMILY_BLUETOOTH which happens to have the same value as a publically known magic value.
<br><br>You&#39;d only be using standard POSIX interfaces at that point.<br><br>Ralf.<br><br><br>

------=_Part_3112_3809902.1183633478411--


--===============0539350188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0539350188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0539350188==--
