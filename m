Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 8/8] sdp: Decouple Device ID profile implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379599910-8666-1-git-send-email-szymon.janc@tieto.com>
Date: Sat, 21 Sep 2013 12:23:50 -0500
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <27E4FDA5-DF83-43E3-989A-711B745E8204@holtmann.org>
References: <1379599248-7923-9-git-send-email-szymon.janc@tieto.com> <1379599910-8666-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Make DeviceID profile similar to other profiles implementations. Use
> btd_profile for handling DeviceID profile while adding/removing
> adapters. The nice drawback is that SDP code no longer depends on
> main_opts.
> ---
> 
> Fixed missing g_slist_remove.
> 
> Makefile.plugins             |   3 +
> profiles/deviceid/deviceid.c | 189 +++++++++++++++++++++++++++++++++++++++++++
> src/adapter.c                |  26 +++---
> src/adapter.h                |   3 +
> src/sdpd-server.c            |   4 -
> src/sdpd-service.c           |  58 -------------
> src/sdpd.h                   |   2 -
> 7 files changed, 206 insertions(+), 79 deletions(-)
> create mode 100644 profiles/deviceid/deviceid.c

please do not intermix profiles/ code with src/ code in the same commit.

Regards

Marcel

