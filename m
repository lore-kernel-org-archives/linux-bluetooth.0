Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:24:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] gatttool: Use GError to propage error messages
 to caller
Message-ID: <20130417082453.GA4310@x220>
References: <1364945490-17059-5-git-send-email-alvaro.silva@openbossa.org>
 <1366127394-4451-1-git-send-email-eder.ruiz@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366127394-4451-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eder,

On Tue, Apr 16, 2013, Eder Ruiz Maria wrote:
> Handle runtime errors outside gatt_connect(), using GError to propagate
> error messages to caller.
> ---
>  attrib/gatttool.c    |    6 ++++--
>  attrib/gatttool.h    |    3 ++-
>  attrib/interactive.c |   10 +++++++---
>  attrib/utils.c       |   14 +++++++-------
>  4 files changed, 20 insertions(+), 13 deletions(-)

Thanks. This as well as the rest of the patches in the set have now been
applied.

Johan
