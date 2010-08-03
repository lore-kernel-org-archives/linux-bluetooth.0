Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 12:54:29 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix NULL checking for pbap_get
Message-ID: <20100803095429.GA14178@jh-x301>
References: <1280828987-15562-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280828987-15562-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Aug 03, 2010, Radoslaw Jablonski wrote:
> Fixed NULL checking for name parameter - it shouldn't be there because
> handling for NULL name for some cases is already below. Also passing path
> which is NULL further makes no sense for PBAP so leaving with -EBADR if
> that kind of situation occurs after generating path.
> ---
>  plugins/pbap.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Thanks. The patch is now upstream.

Johan
