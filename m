Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 May 2010 17:06:57 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] MCAP implementation for BlueZ
Message-ID: <20100504200657.GC26732@vigoh>
References: <1272962595-4108-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272962595-4108-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

* Santiago Carot-Nemesio <sancane@gmail.com> [2010-05-04 10:43:15 +0200]:

> This patch enables MCAP in BlueZ.
> Current implementation provides support for standard op. codes. Clock
> Synchronization protocol is not yet supported.
> ---
>  Makefile.am     |   11 +-
>  acinclude.m4    |    6 +
>  mcap/mcap.c     | 2146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mcap/mcap.h     |  176 +++++
>  mcap/mcap_lib.h |  162 +++++
>  5 files changed, 2500 insertions(+), 1 deletions(-)
>  create mode 100644 mcap/mcap.c
>  create mode 100644 mcap/mcap.h
>  create mode 100644 mcap/mcap_lib.h

2500+ lines is too big for review. MCAP is way complicated to
understand completely. I suggest you to split this patch and send
smaller ones for each feature of MCAP you implement, then we can review
each piece and not at once.

Also a MCAP test tool would be interesting to help on the
review/merge/qualification process. Do you guys have one? Or are you
planning to do one?


-- 
Gustavo F. Padovan
http://padovan.org
