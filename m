Return-Path: <cyrus@holtmann.org>
Message-ID: <1350579036.2026.7.camel@aeonflux>
Subject: Re: [PATCH 01/11] Pass encoder_state to process input functions
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 09:50:36 -0700
In-Reply-To: <1350576911-14678-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1350576911-14678-2-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
>  sbc/sbc.c                 |    4 ++--
>  sbc/sbc_primitives.c      |   30 ++++++++++++++++--------------
>  sbc/sbc_primitives.h      |    8 ++++----
>  sbc/sbc_primitives_neon.c |   32 ++++++++++++++++----------------
>  4 files changed, 38 insertions(+), 36 deletions(-)

I am failing to see why we do this. Please add a commit explaining the
reason for this change.

Regards

Marcel


