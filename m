Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 17:24:32 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <002701c96f43$dc833c90$9589b5b0$@de> <200901051718.44559.siarhei.siamashka@nokia.com>
In-Reply-To: <200901051718.44559.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901051724.32451.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 17:18:44 ext Siarhei Siamashka wrote:
> On Monday 05 January 2009 16:42:39 ext Christian Hoene wrote:
[...]
> But the bug in 'sbc_get_codesize' is the unquestionable one for sure. Good
> job finding and fixing it.

Sorry, I meant the need to promote 'codesize' to uint16_t is unquestionable,
not changing the 'sbc_get_codesize' function itself :)

-- 
Best regards,
Siarhei Siamashka
