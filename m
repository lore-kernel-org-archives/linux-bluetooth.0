Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 22:00:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] gobex: Fix unit test for PUT request followed by
 ABORT
Message-ID: <20120412190005.GA29311@x220.P-661HNU-F1>
References: <1334148186-10675-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334148186-10675-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Apr 11, 2012, Luiz Augusto von Dentz wrote:
> gobex was actually used to respond not to request so the test is
> renamed to test_stream_put_rsp_abort and a new test is created using
> g_obex_put_req to initiate the request and g_obex_cancel_transfer to
> abort it.
> ---
>  unit/test-gobex-transfer.c |   69 ++++++++++++++++++++++++++++++++++++++++---
>  unit/util.h                |    2 +
>  2 files changed, 66 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
