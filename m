Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812301246.25781.siarhei.siamashka@nokia.com> <200901051522.25993.siarhei.siamashka@nokia.com> <002701c96f43$dc833c90$9589b5b0$@de> <200901051718.44559.siarhei.siamashka@nokia.com>
In-Reply-To: <200901051718.44559.siarhei.siamashka@nokia.com>
Subject: RE: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 16:33:10 +0100
Message-ID: <004501c96f4a$ea4f0500$beed0f00$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I mean that 'return pos > len ? pos : len' and 'return pos' expressions are
> completely interexchangeable in this context.

They are slightly different but really, I do not care. Both fixes will work. At least one must be applied.
BTW: Why not use fread instead? ;-)

Greetings

 Christian


