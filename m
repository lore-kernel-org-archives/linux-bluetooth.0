Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 16:36:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump v2] hcidump: parse extended control field in l2cap
Message-ID: <20110927133657.GA9071@dell>
References: <1317127529-15094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317127529-15094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Sep 27, 2011, Emeltchenko Andrei wrote:
> Adds support for parsing extended control field. Extended control
> field may be used for ERTM and streaming mode (if EWS specified).
> ext_ctrl flag resides in cid table, added fixes for P-bit decode.
> ---
>  parser/l2cap.c |  140 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 112 insertions(+), 28 deletions(-)

Both patches have been applied. Thanks.

Johan
