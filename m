Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: SBC big endian issues?
Date: Mon, 5 Jan 2009 10:15:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901051015.20512.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

SBC encoder contains the following fragment:

> #if __BYTE_ORDER == __LITTLE_ENDIAN
> 			if (sbc->endian == SBC_BE)
> #elif __BYTE_ORDER == __BIG_ENDIAN
> 			if (sbc->endian == SBC_LE)
> #else
> #error "Unknown byte order"
> #endif
> 				s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);
> 			else
> 				s = (ptr[0] & 0xff) | (ptr[1] & 0xff) << 8;

This does not look right. Because as far as I can see, it will work
differently on big and little endian systems (though I did not test it
on real hardware). Is anybody using SBC on big endian systems?
Does it actually work as expected?

Best regards,
Siarhei Siamashka
