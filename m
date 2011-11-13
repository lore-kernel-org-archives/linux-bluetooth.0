Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 13:50:49 +0900
In-Reply-To: <1321141730-20943-2-git-send-email-alon.barlev@gmail.com>
References: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
	 <1321141730-20943-2-git-send-email-alon.barlev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321159852.15441.449.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon,

> Reference: "Flag Variables Ordering"[1]
> 
> In automake, if you modify CFLAGS or LDFLAGS of a target you
> actually override the autoconf supplied flags. This is highly
> none standard and may lead to undesired results, as some
> targets will be compiled with the autoconf supplied flags and
> some won't.
> 
> This patch adds AM_LDFLAGS to any flags overridden.

care to redo this against latest GIT tree and please use a proper commit
message target for LDFLAGS and not just copy&paste.

Regards

Marcel


