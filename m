Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Nick Pelly <npelly@google.com>
Date: Thu, 12 Nov 2009 16:39:12 -0800
Message-ID: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
Subject: What is the motivation for conn->power_save
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If I understand correctly, conn->power_save prevents the host stack
from requesting active mode if it was not the host stack that
requested sniff mode.

I don't understand the motivation for this. If we have ACL data to
send, then it seems like a good idea for the host stack to explicitly
request active mode, regardless of the reason that we entered sniff
mode.

We want to enter active mode more aggressively when setting up SCO
connections, to avoid a 5 second delay with certain sniff modes. But
the conn->power_save code is getting in the way and doesn't appear to
be useful in the first place.

Sending patches in another email...

Nick
