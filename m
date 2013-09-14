Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 4/8] sdp: Decouple Device ID profile implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379071852-10094-4-git-send-email-szymon.janc@tieto.com>
Date: Fri, 13 Sep 2013 18:49:22 -0700
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <B531A8F3-8ABA-4CD1-A013-AB0AFF40302C@holtmann.org>
References: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com> <1379071852-10094-4-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Make DeviceID profile similar to other profiles implementations. Use
> btd_profile for handling DeviceID profile while adding/removing
> adapters. The nice drawback is that SDP code no longer depends on
> main_opts.
> ---
> Makefile.plugins             |   3 +
> profiles/deviceid/deviceid.c | 181 +++++++++++++++++++++++++++++++++++++++++++
> src/sdpd-server.c            |   4 -
> src/sdpd-service.c           |  58 --------------
> src/sdpd.h                   |   2 -
> 5 files changed, 184 insertions(+), 64 deletions(-)
> create mode 100644 profiles/deviceid/deviceid.c
> 
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 7c5f71d..df5d2a1 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -82,6 +82,9 @@ builtin_sources += profiles/scanparam/scan.c
> builtin_modules += deviceinfo
> builtin_sources += profiles/deviceinfo/deviceinfo.c
> 
> +builtin_modules += deviceid
> +builtin_sources += profiles/deviceid/deviceid.c
> +

this is changing the semantics a little bit. Device Id record is guaranteed to have 0x10000 handle. I would prefer if we can keep it that way. Also we need to find a way to make this work with the extended inquiry response that can also included device id information.

Regards

Marcel

