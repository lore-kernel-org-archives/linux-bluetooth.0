Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Nov 2013 09:44:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] build: Force GLib version check while building in
 maintainer mode
Message-ID: <20131128074437.GA4191@x220.p-661hnu-f1>
References: <1385567096-27261-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385567096-27261-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 27, 2013, Szymon Janc wrote:
> This will allow to catch up build errors introduced by using GLib API
> introduced in newer GLib than minimal required even if building with
> newer version.
> ---
>  acinclude.m4 | 2 ++
>  1 file changed, 2 insertions(+)

Seems like a good idea. Applied. Thanks.

Johan
