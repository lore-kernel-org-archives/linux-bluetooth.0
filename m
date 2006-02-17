Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <bd72c4b0602161927o48736a32haf0749102896e04b@mail.gmail.com>
From: "Gareth Bradley" <gareth.bradley.nz@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060217012201.74E3A13EE3@sc8-sf-spam2.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_481_10818879.1140146872630"
References: <20060217012201.74E3A13EE3@sc8-sf-spam2.sourceforge.net>
Subject: [Bluez-devel] Re: Bluez-devel digest, Vol 1 #1908 - 6 msgs
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
Date: Thu, 16 Feb 2006 15:27:52 -1200

------=_Part_481_10818879.1140146872630
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> this looks like a hardware limitation. What kind of dongles/chips are
> you using?
>
> Regards
>
> Marcel
>

I am using a rebranded dongle from DSE (our equivilent of Radio Shack). I
have also tried it with an ePox DG-03. The former is described at
http://www.dse.co.nz/cgi-bin/dse.storefront/43f536790af241f0273fc0a87f99074=
2/Product/View/XH6881,
on the off chance you are able to recognise its original manufacturer.

I am beginning to have concerns about the 2.4.19 kernel we are using. Havin=
g
looked it up, it is the last release that Intrinsyc /Familiar released for
our CerfCube255 board. There is also a 2.6.7, though it doesn't have USB
support.

Anyway, if someone can shed some light on the BT messages that are poassed
through hci_conn.c that are unique to the handshake, I'm hoping I can clear
up this problem of mine.

gjb.

------=_Part_481_10818879.1140146872630
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">this looks l=
ike a hardware limitation. What kind of dongles/chips are<br>
you using?<br><br>Regards<br><br>Marcel<br></blockquote></div><br>
I am using a rebranded dongle from DSE (our equivilent of Radio Shack).
I have also tried it with an ePox DG-03. The former is described at
<a href=3D"http://www.dse.co.nz/cgi-bin/dse.storefront/43f536790af241f0273f=
c0a87f990742/Product/View/XH6881">http://www.dse.co.nz/cgi-bin/dse.storefro=
nt/43f536790af241f0273fc0a87f990742/Product/View/XH6881</a>
, on the off chance you are able to recognise its original manufacturer.<br=
>
<br>
I am beginning to have concerns about the 2.4.19 kernel we are using.
Having looked it up, it is the last release that Intrinsyc /Familiar
released for our CerfCube255 board. There is also a 2.6.7, though it
doesn't have USB support.<br>
<br>
Anyway, if someone can shed some light on the BT messages that are
poassed through hci_conn.c that are unique to the handshake, I'm hoping
I can clear up this problem of mine.<br>
<br>
gjb.<br>

------=_Part_481_10818879.1140146872630--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
