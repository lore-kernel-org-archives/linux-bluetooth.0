Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 13:03:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v2] Adapter: Fix Discovering state while Powering Off
Message-ID: <20120404100333.GC11856@x220>
References: <1333454039-6961-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333454039-6961-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Tue, Apr 03, 2012, Hemant Gupta wrote:
> This patch fixes the adater discovering state while powering off.
> Without this fix, BlueZ sends incorrect discovering state to upper
> layers while switching off.
> ---
>  src/adapter.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Applied (with a few modifications). Thanks.

Johan
