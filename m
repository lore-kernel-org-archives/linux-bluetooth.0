Return-Path: <cyrus@holtmann.org>
Message-ID: <1350578979.2026.6.camel@aeonflux>
Subject: Re: [PATCH 02/11] Add encoder_state parameter to analysis functions
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 09:49:39 -0700
In-Reply-To: <1350576911-14678-3-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1350576911-14678-3-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
>  sbc/sbc.c                   |    4 ++--
>  sbc/sbc_primitives.c        |    8 ++++----
>  sbc/sbc_primitives.h        |    6 ++++--
>  sbc/sbc_primitives_armv6.c  |    6 ++++--
>  sbc/sbc_primitives_iwmmxt.c |    8 ++++----
>  sbc/sbc_primitives_mmx.c    |    8 ++++----
>  sbc/sbc_primitives_neon.c   |    8 ++++----
>  7 files changed, 26 insertions(+), 22 deletions(-)

you need to explain why we need that. Please use commit messages that
explain the reasoning behind the change.

Regards

Marcel


