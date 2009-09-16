Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2009 18:19:02 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: BNEP problem, hardware dependent?
Message-ID: <20090916181902.52bf7e99@strolchi.home.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

recently I was changing my work machine. When I wanted to do my usual
setup (hacked up test-network script) to connect to the internet via my
mobile phone, I got "bnep error".

It is this piese of code in network/connection.c:

270         if (rsp->ctrl != BNEP_SETUP_CONN_RSP)
271                 return TRUE;
272
273         r = ntohs(rsp->resp);
274
275         if (r != BNEP_SUCCESS) {
276                 error("bnep failed");
277                 goto failed;
278         }

I then found out that it did work with some dongles, and it did not
work with others. Apparently there was no connection to the "quality"
of the dongles (but I have to admit, that AFAIR all were broadcom or
worse), there was a very cheap one that did work and more expensive
ones that didn't.

I always thought that the "supported profiles" list on the packaging
was just a "what we licensed in the driver" list and that all hardware
could do everything.

Am I wrong?

Thanks,

	Stefan
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
