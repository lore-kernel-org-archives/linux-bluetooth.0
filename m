Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41430846.4010006@uni-paderborn.de>
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/html; charset=us-ascii
Subject: [Bluez-devel] sdp_search and l2cap concurrently
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
Date: Sat, 11 Sep 2004 16:14:30 +0200

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi!<br>
<br>
I've written a small library which uses the JNI to bring BlueZ to Java.
Upon that, I'm writing a small "Location Aware Web-Service"-Demo. So my
ClientApp has a DiscoveryThread which does non-cached inquiry and
sdp_search() all the time, and an UpdateThread which uses the
DiscoveryInfo to connect to the servers, measure RSSI and LQ and
transmit the websites via L2CAP. Everything works fine while all
devices are good in range, but if one device is at the edge of the
range, sdp_search() blocks the DiscoveryThread and also seems to
cripple/block the UpdateThread. I don't know why. I have seen that
there is a hard coded 20s timeout in sdp_read_resp(). Is there a way to
decrease this timeout or to make it a settable parameter in future
versions? Anyway, sdp should not cripple l2cap, shold it? Any
suggestions? Thanks in advance!<br>
<br>
Kind regards<br>
Stefan Mischke<br>
<br>
</body>
</html>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
