Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Aug 2011 22:25:23 +0100
From: Dave Higton <davehigton@dsl.pipex.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <7b86640552.davehigton@dsl.pipex.com>
Subject: Arguments to PIN Code Request Response
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the Core Spec versions 4.0, 3.0, 2.1 and 2.0, the
arguments to PIN Code Request Reply are BD_ADDR, PIN length, and
PIN code.  However, this doesn't work with the devices I've tried
(an Android phone and a mini keyboard); there are several more
bytes of argument in a capture that I have.  If I only send the
args as per the spec, I get an args not understood error; if I
add these other arg bytes, copied from the capture, the PIN code
is accepted and the pairing process continues.

Are these extra arguments documented in one of the earlier core
specifications, now deprecated?

The bytes I have are:

0D 04 17 3F 1B AC 26 2C DC 04 30 30 30 30 17 00 0C 11 0A 11 0B 11 16 11 02 0A

Unless I've badly misunderstood something, the PIN code length
above is 4, and the PIN code is ASCII "0000".  I don't expect to
see any bytes following "30 30 30 30".

Dave
