Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464194a50705141007p3d81a78dlbd2e364d47a51d21@mail.gmail.com>
Date: Mon, 14 May 2007 20:07:42 +0300
From: "Zmej Gorianin" <mortagon.iyi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179152578.13351.47.camel@violet>
MIME-Version: 1.0
References: <464194a50705140636m31a90100gbd8111982012d7de@mail.gmail.com>
	<1179152578.13351.47.camel@violet>
Subject: Re: [Bluez-devel] Combination Keys?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1741152961=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1741152961==
Content-Type: multipart/alternative;
	boundary="----=_Part_65366_3577041.1179162462065"

------=_Part_65366_3577041.1179162462065
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/5/14, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > I'm doing my bachelors dissertation project about alternative Bluetooth
> authentication and key exchange and I would like to know whether it is
> possible to pass the combination key my app has constructed to BlueZ in some
> way, so that BlueZ will write the key in
> /var/lib/bluetooth/<BD_ADDR>linkkeys or my application should tamper with
> the file directly.
>
> you might wanna modify the file directly or better use the textfile.c
> library to do so.
>
> Regards
>
> Marcel


Thank you.

Regards

------=_Part_65366_3577041.1179162462065
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">2007/5/14, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt; I&#39;m doing my bachelors dissertation project about alternative Bluetooth authentication and key exchange and I would like to know whether it is possible to pass the combination key my app has constructed to BlueZ in some way, so that BlueZ will write the key in /var/lib/bluetooth/&lt;BD_ADDR&gt;linkkeys or my application should tamper with the file directly.
<br><br>you might wanna modify the file directly or better use the textfile.c<br>library to do so.<br><br>Regards<br><br>Marcel</blockquote>
<div>&nbsp;</div>
<div>Thank you.</div>
<div>&nbsp;</div>
<div>Regards</div><br>&nbsp;</div>

------=_Part_65366_3577041.1179162462065--


--===============1741152961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1741152961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1741152961==--
