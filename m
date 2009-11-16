Return-Path: <cyrus@holtmann.org>
From: "Peter Hurley" <phurley@charter.net>
To: "'Colin Beckingham'" <colbec@start.ca>,
	<linux-bluetooth@vger.kernel.org>
References: <4B0190D5.8090406@start.ca>
In-Reply-To: <4B0190D5.8090406@start.ca>
Subject: RE: Bluetooth headsets fail to trigger pulseaudio consistently (Long)
Date: Mon, 16 Nov 2009 13:35:15 -0500
Message-ID: <007001ca66eb$8c664220$a532c660$@net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> # hcidump -t -X -V

This dump looks truncated.  Is this all the output or did the trace
start generating tons of SCO packets that you snipped?  There might be
BT commands/replies in the mass of SCO packets that got snipped too.

Also, you need to set the already-running bluetooth daemon into debug
output mode.  You can do this with:

sudo kill -SIGUSR2 [pid of bluetoothd]

Then the daemon log will be way more useful - please repost that daemon
log. Also, there's no need to include pulseaudio output because I
virtually guarantee it's just "the messenger".

I noticed the time stamps in the trace and log aren't for the same
interval.  The hcidump trace and the daemon log should be for the same
events/time interval, ok?

Regards,
Peter Hurley

