Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Aug 2012 11:43:23 +0200
From: Ludek Finstrle <luf@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Subject: Obexd 0.46: PBAP and GetSize
Message-ID: <20120809094323.GB32525@pzkagis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

  I see strange behaviour with my obexd 0.46 on N900 (ARM) and pbap-client on notebook (x86_64):

--- Select Phonebook CCH ---


--- GetSize ---

Size = 12802


--- List vCard ---

...
562.vcf : Name
BEGIN:VCARD
VERSION:2.1
N:Name
Tel:Number
END:VCARD

--- PullAll ---
...

Binary representation of the numbers:
12802
0011001000000010
562
0000001000110010

(another numbers):
15360
0011110000000000
60
0000000000111100

As you can see there is swapped bytes. Can someone reproduce the problem?
Has anyone idea where should be the problem (it seems like little x big endians)?

Best regards,

Luf
