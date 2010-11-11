Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:17:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix interleave discovery regression
Message-ID: <20101111211719.GF24514@jh-x301>
References: <1289508326-18143-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289508326-18143-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Nov 11, 2010, Claudio Takahasi wrote:
> Command complete event for LE commands are not being handled properly
> due blocking calls of LE Set Scan Parameters and LE Set Scan Enable
> Commands. Fix wrong Discovering signal emission in the interleaved
> discovery mode.
> ---
>  plugins/hciops.c |   34 ++++++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 8 deletions(-)

Pushed upstream. Thanks.

Johan
