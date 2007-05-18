Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>
Date: Fri, 18 May 2007 07:13:16 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: feig@nnytech.net, "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <464C7616.9070900@nnytech.net>
MIME-Version: 1.0
References: <200705170207.52710.bluez-devel@huitl.de>
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
	<200705171521.38889.bluez-devel@huitl.de>
	<464C7616.9070900@nnytech.net>
Subject: Re: [Bluez-devel] Frequent headset disconnects
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0590433703=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0590433703==
Content-Type: multipart/alternative;
	boundary="----=_Part_33482_2652486.1179493996681"

------=_Part_33482_2652486.1179493996681
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

John


> I've been using the a2dpd app for a couple of weeks now, and really like
> it. I have a few issues though, with the main one being that after a
> couple of minutes of playback, my headphones (HT820) turn off
>

it looks like alsa_transfer_raw returns -1 once and then a2dpd closes the
connection. Maybe we should be checking for an error state that indicates we
can retry or maybe we should retry a few times regardless.

it could be the set turns off because of the way we terminate the
connection. This is mostly Frederic's playground but I remember locking up
headsets with a2play by accidentally sending data on the stream fd after we
had signaled a stream close on the control fd.

brad

------=_Part_33482_2652486.1179493996681
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote"><b class="gmail_sendername">John<br><br></b></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>I&#39;ve been using the a2dpd app for a couple of weeks now, and really like
<br>it. I have a few issues though, with the main one being that after a<br>couple of minutes of playback, my headphones (HT820) turn off<br></blockquote></div><br>it looks like alsa_transfer_raw returns -1 once and then a2dpd closes the connection. Maybe we should be checking for an error state that indicates we can retry or maybe we should retry a few times regardless.
<br><br>it could be the set turns off because of the way we terminate the connection. This is mostly Frederic&#39;s playground but I remember locking up headsets with a2play by accidentally sending data on the stream fd after we had signaled a stream close on the control fd.
<br><br>brad<br>

------=_Part_33482_2652486.1179493996681--


--===============0590433703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0590433703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0590433703==--
