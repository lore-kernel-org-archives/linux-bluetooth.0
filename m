Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-id: <1080560568.1688.24.camel@gryffindor>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_jHNZMp6EVQSZcQbg7Hf3eA)"
Subject: [Bluez-devel] DUND features
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Mar 2004 13:42:48 +0200


--Boundary_(ID_jHNZMp6EVQSZcQbg7Hf3eA)
Content-type: text/plain
Content-transfer-encoding: 7BIT

   I have read the Bluetooth DUN specifications, and it appears that
devices supporting DUN are supposed to implement a set of AT-compatible
commands in order to fully support this profile: so far it does not seem
that DUND is supporting anything in particular.

   When using Palm-compatible devices as clients, this is not a problem
because it is possible to configure them to start PPP link negotiation
independently from link establishment. But in the case of Windows
clients, it creates problems because the Windows computer sends AT
commands and tries to dial a number to connect to the Linux server
offering DUN...

   Are there plans to correct this at the moment? Alternatively, are
there known workarounds to enable windows-based clients to connect to
Linux servers running dund ? Apparently the option called "msdun" is not
enough...

Regards,

Edouard

--Boundary_(ID_jHNZMp6EVQSZcQbg7Hf3eA)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
&nbsp;&nbsp; I have read the Bluetooth DUN specifications, and it appears that devices supporting DUN are supposed to implement a set of AT-compatible commands in order to fully support this profile: so far it does not seem that DUND is supporting anything in particular.<BR>
<BR>
&nbsp;&nbsp; When using Palm-compatible devices as clients, this is not a problem because it is possible to configure them to start PPP link negotiation independently from link establishment. But in the case of Windows clients, it creates problems because the Windows computer sends AT commands and tries to dial a number to connect to the Linux server offering DUN...<BR>
<BR>
&nbsp;&nbsp; Are there plans to correct this at the moment? Alternatively, are there known workarounds to enable windows-based clients to connect to Linux servers running dund ? Apparently the option called &quot;msdun&quot; is not enough...<BR>
<BR>
Regards,<BR>
<BR>
Edouard
</BODY>
</HTML>

--Boundary_(ID_jHNZMp6EVQSZcQbg7Hf3eA)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
