Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:52:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix sending X-IRMC-CALL-DATETIME in PullvCardEntry
Message-ID: <20110710075216.GC1808@dell.ger.corp.intel.com>
References: <1310045839-14474-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310045839-14474-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Jul 07, 2011, Bartosz Szatkowski wrote:
> Previously when pulling single vCard there was no difference between
> pulling contact or call, now there are separate queries and additional
> previously missing data are being sent.
> ---
>  plugins/phonebook-tracker.c |   30 +++++++++++++++++++++++-------
>  1 files changed, 23 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
