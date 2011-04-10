Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 11 Apr 2011 01:56:11 +0300
Message-ID: <BANLkTikULKr_9PjxdxFDRoHQF04xLDdzBg@mail.gmail.com>
Subject: Bug report in Obex code
From: Claudiu Coman <claud.coman@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

While doing some documentation for my GSOC application, I found a small
bug in the Obex code, in src/obex.c, function "obex_write_stream".
There's the declaration:
"uint8_t hi;"
If the "if" statement body between lines 640-648 is executed, after the jump
to the "add_header" tag, the switch statement will test an
uninitialized variable.
At first I thought about sending a patch myself, but I don't know what value
the header index variable should be initialized with.

Cheers,
Claudiu
