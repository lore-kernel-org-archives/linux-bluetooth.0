Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Nov 2009 08:51:48 -0500
From: Celejar <celejar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: ppp over bluetooth trouble
Message-Id: <20091124085148.a82fed54.celejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm having trouble connecting my Palm Centro (basically a Treo) to my
Debian system via bluetooth, following these directions:

http://wiki.debian.org/BluetoothPalmOSConnection

Here's what I get:

~# dund --nodetach --listen --persist --msdun call centro
dund[4423]: Bluetooth DUN daemon version 4.57
using channel 12
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
dund[4424]: New connection from 00:07:E0:E7:25:6E
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x2 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x2 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x3 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x3 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x4 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x4 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x5 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x5 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x6 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x6 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x7 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x7 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xa399cef2> <pcomp> <accomp>]
rcvd [LCP ConfReq id=0x8 <asyncmap 0x0> <pcomp> <accomp>]
sent [LCP ConfAck id=0x8 <asyncmap 0x0> <pcomp> <accomp>]
LCP: timeout sending Config-Requests
Connection terminated.
Modem hangup

I don't know exactly what all the LCP messages mean, but I do note that
the rcvd lines are all ConfReq's, and IIUC, I should be getting a
ConfAck in response to the sent ConfReq.  Can anyone figure out
what's going on here?

Celejar
-- 
foffl.sourceforge.net - Feeds OFFLine, an offline RSS/Atom aggregator
mailmin.sourceforge.net - remote access via secure (OpenPGP) email
ssuds.sourceforge.net - A Simple Sudoku Solver and Generator

