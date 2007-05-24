Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300705240624u15df9655gb9624e0955d6d195@mail.gmail.com>
Date: Thu, 24 May 2007 07:24:17 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200705171521.38889.bluez-devel@huitl.de>
MIME-Version: 1.0
References: <200705170207.52710.bluez-devel@huitl.de>
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
	<200705171521.38889.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1365215350=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1365215350==
Content-Type: multipart/alternative;
	boundary="----=_Part_93247_5624564.1180013057078"

------=_Part_93247_5624564.1180013057078
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Robert

> Could it be that some of the ALSA plugins only work with hardware
> devices?!


that is a real possibility. libalsa plugins are definitely second-class.

i am searching around in headsetd to see if it restricts the mic and speaker
sockets to be sent to the same application. it should be easy enough to keep
track of these two independently.

Brad

------=_Part_93247_5624564.1180013057078
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<b class="gmail_sendername">Robert </b><div><div><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Could it be that some of the ALSA plugins only work with hardware devices?!
</blockquote><div><br>that is a real possibility. libalsa plugins are definitely second-class.<br><br>i am searching around in headsetd to see if it restricts the mic and speaker sockets to be sent to the same application. it should be easy enough to keep track of these two independently.
<br><br>Brad<br></div><br></div><br>

------=_Part_93247_5624564.1180013057078--


--===============1365215350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1365215350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1365215350==--
