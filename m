Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: George Hansel <ghansel@MIT.EDU>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f74cej$323$1@sea.gmane.org>
References: <1184178600.6062.27.camel@Epimenides>
	<d89ddf300707111302n15fa8e01u65697135b8ab03fc@mail.gmail.com>
	<f74cej$323$1@sea.gmane.org>
Date: Thu, 12 Jul 2007 04:01:27 -0400
Message-Id: <1184227287.5997.2.camel@Epimenides>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Handling simultaneous SCO connections:
	Does	BlueZhave multiple SCO buffers?
Reply-To: ghansel@MIT.EDU,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1178976256=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1178976256==
Content-Type: multipart/alternative; boundary="=-ovbyEWz7RVyPN1BLnh/e"


--=-ovbyEWz7RVyPN1BLnh/e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-07-12 at 06:58 +0200, Niels v/d Spek wrote:

> Brad Midgley wrote:
> > George
> >
> > bluetooth adapters that are connected by usb need to have a kernel mod
> > to allow the alternate setting to be changed dynamically. There's an
> > experimental patch out there:
> >
> > http://article.gmane.org/gmane.linux.bluez.devel/11999
> >
> > the patch also assumes you have the flowcontrol patch applied first:
> >
> > http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff?view=log
> >
> Brad,
> 
> I'm using Ubuntu 7.4 and like to know of this patches are there also needed?
> 
> thanks anyway
> 
> Niels
> > Brad
> >
> > -------------------------------------------------------------------------


Neils,

I am also using Ubuntu 7.04 (latest patches, etc). As it turned out, I
created a workaround for my problem, not using the patches. Depending on
your application, you will need them as well. The Bluetooth stack is
developed independently, but is incorporated into the Linux kernel, and
so should be quite uniform throughout different distributions.

George

--=-ovbyEWz7RVyPN1BLnh/e
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.14.1">
</HEAD>
<BODY>
On Thu, 2007-07-12 at 06:58 +0200, Niels v/d Spek wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Brad Midgley wrote:</FONT>
<FONT COLOR="#000000">&gt; George</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; bluetooth adapters that are connected by usb need to have a kernel mod</FONT>
<FONT COLOR="#000000">&gt; to allow the alternate setting to be changed dynamically. There's an</FONT>
<FONT COLOR="#000000">&gt; experimental patch out there:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; <A HREF="http://article.gmane.org/gmane.linux.bluez.devel/11999">http://article.gmane.org/gmane.linux.bluez.devel/11999</A></FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; the patch also assumes you have the flowcontrol patch applied first:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; <A HREF="http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff?view=log">http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff?view=log</A></FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">Brad,</FONT>

<FONT COLOR="#000000">I'm using Ubuntu 7.4 and like to know of this patches are there also needed?</FONT>

<FONT COLOR="#000000">thanks anyway</FONT>

<FONT COLOR="#000000">Niels</FONT>
<FONT COLOR="#000000">&gt; Brad</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; -------------------------------------------------------------------------</FONT>
</PRE>
</BLOCKQUOTE>
<BR>
Neils,<BR>
<BR>
I am also using Ubuntu 7.04 (latest patches, etc). As it turned out, I created a workaround for my problem, not using the patches. Depending on your application, you will need them as well. The Bluetooth stack is developed independently, but is incorporated into the Linux kernel, and so should be quite uniform throughout different distributions.<BR>
<BR>
George
</BODY>
</HTML>

--=-ovbyEWz7RVyPN1BLnh/e--



--===============1178976256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1178976256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1178976256==--
