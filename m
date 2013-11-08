Return-Path: <cyrus@holtmann.org>
Message-ID: <1383927109.3880.7.camel@nuvo>
Subject: How do you do OBEX testing?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Nov 2013 17:11:49 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I've been testing and fixing OBEX client and server side bugs for a
while, usually in GNOME, but I recently realised how outdated my testing
techniques were, relying on what would be described as "legacy"
phones[1].

I've asked this question on IRC, but I guess I might not be the only one
that needs to test things like this.

So, what do you use for testing ObexFTP, OBEX Push or related protocols
like PBAP?

- Adding an additional dongle on your computer and assigning it to a VM?
- Using software on a newer smartphone (seems Android has more of those
than the badly rated iOS ones)?
- Another computer? a dumb phone?

I'm looking for something that I could run on a laptop with minimal
additional hardware, so any hints would be welcome.

Cheers

[1]: a Sony Ericsson one that refuses to get out of demo mode because
the SIM slot is broken, and a 10-year candybar Nokia phone that can't
hold charge.

