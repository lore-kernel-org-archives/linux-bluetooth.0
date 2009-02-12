Return-Path: <cyrus@holtmann.org>
From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
To: linux-bluetooth@vger.kernel.org
Subject: extended passkey in hcid.conf
Date: Fri, 13 Feb 2009 00:59:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902130059.29542.bernhard@schiffner-limbach.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hallo,

my simple question to the bluetooth-code was to find out, how to make use of 
an "extended" passkey.
(But I didn't succeed: I'am not a real good C-programmer...)

IMHO a passkey is defined by the spec to be 16 byte (16*[0..255]). 

In /etc/bletooth/hcid.conf you can enter something like >passkey 
"0123456789ABCDEF"<

But is it possible to enter non-numeric values here too?
Perhaps as in:

echo -n -e "\xFF\xAA\x00" | od -t x1

TIA

Bernhard

PS:
CC me if you answer please. I'am not subscribed here and have limited internet 
access only.
