Return-Path: <cyrus@holtmann.org>
From: "=?utf-8?Q?G=C3=B6ran?= Uddeborg" <goeran@uddeborg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19504.50180.287560.834476@gargle.gargle.HOWL>
Date: Sun, 4 Jul 2010 19:25:24 +0200
To: linux-bluetooth@vger.kernel.org
Subject: hciconfig manual page bug
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is this the right place to report a bug in the manual page for
hciconfig?  If so, the synopsis on the page says

       hciconfig [-a] [command [command parameters]]

but the correct syntax seems to be

       hciconfig [-a] hciX [command [command parameters]]

for some X.  That is also what "hciconfig -h" says.
