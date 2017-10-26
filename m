Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1509021568.28409.34.camel@hadess.net>
Subject: Re: [PATCH BlueZ] obexd: Fix compile error due to lack of header
From: Bastien Nocera <hadess@hadess.net>
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 26 Oct 2017 14:39:28 +0200
In-Reply-To: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
References: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-10-26 at 15:05 +0900, ERAMOTO Masaya wrote:
> When compiling with gcc 7.2.0, gcc outputs the following messages.
> This patch adds the header stdlib.h to each obex-related header
> including
> functions with the type ssize_t, so the same problem does not also
> happen
> in case using there headers individually.

I already sent a patch for this about 2 months ago, look for "obexd:
Fix compilation error on F27"

Cheers
