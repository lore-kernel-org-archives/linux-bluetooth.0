Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300705091650w787619eap2ecd667b3c4ace33@mail.gmail.com>
Date: Wed, 9 May 2007 17:50:08 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4642007E.5030803@idlum.be>
MIME-Version: 1.0
References: <4642007E.5030803@idlum.be>
Subject: Re: [Bluez-devel] How to completely reset a dongle from software?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1380452877=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1380452877==
Content-Type: multipart/alternative;
	boundary="----=_Part_91771_5544678.1178754608502"

------=_Part_91771_5544678.1178754608502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Pierre-Yves


>
> Is there a way to perform a full reset of a USB dongle without
> unplugging it, but having the very same effects than if it was
> physically unplugged and plugged back again?


if it is a csr chip, you can enable bccmd in bluez-utils and use it to reset
the chip. It might take two attempts to actually reset.

Brad

------=_Part_91771_5544678.1178754608502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<b class="gmail_sendername">Pierre-Yves<br><br></b><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><br>Is there a way to perform a full reset of a USB dongle without
<br>unplugging it, but having the very same effects than if it was<br>physically unplugged and plugged back again?</blockquote><div><br>if it is a csr chip, you can enable bccmd in bluez-utils and use it to reset the chip. It might take two attempts to actually reset.
<br><br>Brad <br></div><br></div><br>

------=_Part_91771_5544678.1178754608502--


--===============1380452877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1380452877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1380452877==--
