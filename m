Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 0/1] On demand LE link encryption/authentication
Date: Fri, 27 Apr 2012 12:05:24 -0400
Message-Id: <1335542725-8806-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch adds support in BlueZ for only increasing security level of the LE
link when the ATT request fails with "Insufficient Encryption" or "Insufficient
Authentication". This mechanism is described on Core Specification page 1837
("3.2.5 Attribute Permissions") and 1876 ("4 Security Considerations"). This
allows for very low latency connections when encryption is not required.

On a related topic, we would like to propose changing how LE Security
Modes/Levels are mapped to BlueZ/kernel security levels. Currently, for LE the
kernel does the following mapping:

* seclevel SDP (0): not used by LE. Effectively should work like LOW.
* seclevel LOW (1): no authentication and no encryption (LE Security Mode 1
  Level 1)
* seclevel MEDIUM (2): Unauthenticated pairing with encryption (LE Security
  Mode 1 Level 2), uses Just Works pairing algorithm
* seclevel HIGH (3): Authenticated pairing with encryption (LE Security Mode 1
  Level 3), uses Passkey Entry pairing algorithm

There is no support for LE Security Mode 2. Our proposal is to:

1) Rename SDP level to NONE. It will mean "no authentication and no encryption"
   for LE, for BR/EDR it will be unchanged.
2) use LOW for "Unauthenticated pairing with encryption"
3) use MEDIUM for "Authenticated pairing with encryption"
4) HIGH becomes unused for LE (maybe mapping to MEDIUM?)

We believe this would align better with BR/EDR and with the definition of LE
Security Mode 2. Thoughts?

Note: there is currently a bug which makes the socket unavailable for writing
after switching from MEDIUM to HIGH security level. We are currently
investigating the issue. Until it is not fixed, this patch cannot be applied.

Comments/suggestions are welcome.


Bruna Moreira (1):
  attrib: Retry ATT request when link is unencrypted

 attrib/gattrib.c |   32 ++++++++++++++++++++++++++++++++
 src/device.c     |    2 +-
 2 files changed, 33 insertions(+), 1 deletions(-)

-- 
1.7.5.4

