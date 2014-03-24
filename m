Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 11:08:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] core: Move EIR flags definitions to eir.h
Message-ID: <20140324090824.GA30302@t440s.lan>
References: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
 <1395610854-30579-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395610854-30579-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Mar 23, 2014, Szymon Janc wrote:
> ---
>  src/adapter.c | 15 ++++-----------
>  src/eir.h     |  9 +++++++++
>  2 files changed, 13 insertions(+), 11 deletions(-)
> diff --git a/src/adapter.c b/src/adapter.c

This patch is otherwise fine, but please don't rename the defines. The
EIR prefix is good enough and keeps the usage of the readable enough.
Also, even if we did want to rename them, it's misleading to hide that
in a patch which you (in the commit message) claim to be only about
moving stuff around.

Johan
