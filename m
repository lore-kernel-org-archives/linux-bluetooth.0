Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jan 2012 21:41:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Send the Extended Error result code, if requested
 in the failure cases
Message-ID: <20120112194122.GA7453@fusion.localdomain>
References: <1326381301-25862-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326381301-25862-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Jan 12, 2012, Syam Sidhardhan wrote:
> If HF has already requested for the Extended Error result code reporting,
> then send the same in certain failure cases. Earlier in this case we were
> sending normal error.
> ---
>  audio/headset.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
