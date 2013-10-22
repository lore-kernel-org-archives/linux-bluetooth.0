Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2013 18:01:30 -0700
Message-ID: <CAHZ1yC=vh0PUS7ZgZ_zUff_gPzLwjYx8EABxbT71uU5zQAChTQ@mail.gmail.com>
Subject: GATT - How to mark an attribute as requiring encryption
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While there is a way to mark an attribute as needing authentication
and/or authorization, there does not seem to be a way to mark an
attribute as requiring encryption (or a particular key size), and I
couldn't find any code that would return the ATT_ECODE_INSUFF_ENC or
ATT_ECODE_INSUFF_ENCR_KEY_SIZE responses.

There is an explicit test case in the GATT TS for this:

  TP/GAR/SR/BI-05-C [Read Characteristic Value - Insufficient
Encryption Key Size]

The TRCL maps this:

  (GATT:3/8 AND ATT:5/2)
  OR
  (ATT:3/1 AND ATT:3/10 AND ATT:5/2)

GATT:3/8 [Read Characteristic Value] is Mandatory
ATT:5/2 - [LE Security Mode 1] is Optional, but without it none of the
authentication or authorization stuff makes sense either

Reference:
 GATT 4.8.1
 ATT 3.4.11, 3.4.4.3

Thoughts?

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
