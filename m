Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4146FD1E.9090100@uni-paderborn.de>
Date: Tue, 14 Sep 2004 16:15:58 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp_search and l2cap concurrently
References: <41430846.4010006@uni-paderborn.de> <1094997749.5695.13.camel@pegasus>
In-Reply-To: <1094997749.5695.13.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Please forget this one. My fault. Sorry!<br>
<br>
Marcel Holtmann schrieb:<br>
<blockquote cite="mid1094997749.5695.13.camel@pegasus" type="cite">
  <pre wrap="">Hi Stefan,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I've written a small library which uses the JNI to bring BlueZ to
Java. Upon that, I'm writing a small "Location Aware
Web-Service"-Demo. So my ClientApp has a DiscoveryThread which does
non-cached inquiry and sdp_search() all the time, and an UpdateThread
which uses the DiscoveryInfo to connect to the servers, measure RSSI
and LQ and transmit the websites via L2CAP. Everything works fine
while all devices are good in range, but if one device is at the edge
of the range, sdp_search() blocks the DiscoveryThread and also seems
to cripple/block the UpdateThread. I don't know why. I have seen that
there is a hard coded 20s timeout in sdp_read_resp(). Is there a way
to decrease this timeout or to make it a settable parameter in future
versions? Anyway, sdp should not cripple l2cap, shold it? Any
suggestions? Thanks in advance!
    </pre>
  </blockquote>
  <pre wrap=""><!---->
what do you mean by cripple L2CAP and use it concurrently. Explain in
more detail what your program is really doing and check how many low
level HCI connections are opened at the same time.

Regards

Marcel


  </pre>
</blockquote>
</body>
</html>
