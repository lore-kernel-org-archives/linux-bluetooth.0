Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706122144q1ebed24fx9368c8d6d836cfd9@mail.gmail.com>
Date: Tue, 12 Jun 2007 22:44:10 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <39D0ED4A56B05A409DB3C01F8DCEFB54F3281C@CORPAPPL021.corp.saab.se>
MIME-Version: 1.0
References: <39D0ED4A56B05A409DB3C01F8DCEFB54F3281C@CORPAPPL021.corp.saab.se>
Subject: Re: [Bluez-devel] SCO with BlueZ 2.15?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1344440020=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1344440020==
Content-Type: multipart/alternative;
	boundary="----=_Part_1718_13118551.1181709850263"

------=_Part_1718_13118551.1181709850263
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Bengtsson

> connections starts up fine, but the SCO connections doesn't start at all.
> When inspecting the loaded modules with lsmod, SCO is not loaded.
>

why not modprobe sco? was it not built as a module for your kernel?

The question is, is SCO working with version 2.15?
>

i can't really speak to this. i think an old kernel version is likely to be
more trouble than old bluez.

I have compiled the same application on an ordinary PC with version 3.9 and
> 3.11. ACL and SCO works fine. lsmod shows that SCO is loaded.
>
> I'm using a USB dongle for the moment, but shall use UART instead, because
> more than one SCO channel is not working on USB. However, it is possible to
> open two SCO connections on the PC with USB dongle, but not communicating it
> seems.
>
there was a dynamic alternate setting patch posted on bluez-devel a few
weeks ago that would allow multiple sco through usb. it requires the latest
flowcontrol patch to be applied first.

brad

------=_Part_1718_13118551.1181709850263
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<b class="gmail_sendername">Bengtsson <br></b><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><p><span lang="sv"><font face="Arial" size="2">
 connections starts up fine, but the SCO connections doesn&#39;t start at all. When inspecting the loaded modules with lsmod, SCO is not loaded.</font></span></p></div></blockquote><div><br>why not modprobe sco? was it not built as a module for your kernel?
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><p><span lang="sv"><font face="Arial" size="2">The question is, is SCO working with version 
2.15?</font></span></p></div></blockquote><div><br>i can&#39;t really speak to this. i think an old kernel version is likely to be more trouble than old bluez.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><p><span lang="sv"><font face="Arial" size="2">I have compiled the same application on an ordinary PC with version 3.9 and 3.11. ACL and SCO works fine. lsmod shows that SCO is loaded.</font></span></p>

<p><span lang="sv"><font face="Arial" size="2">I&#39;m using a USB dongle for the moment, but shall use UART instead, because more than one SCO channel is not working on USB. However, it is possible to open two SCO connections on the PC with USB dongle, but not communicating it seems.
</font></span></p></div></blockquote><div>there was a dynamic alternate setting patch posted on bluez-devel a few weeks ago that would allow multiple sco through usb. it requires the latest flowcontrol patch to be applied first.
<br><br>brad<br>&nbsp;</div><br></div><br>

------=_Part_1718_13118551.1181709850263--


--===============1344440020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1344440020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1344440020==--
