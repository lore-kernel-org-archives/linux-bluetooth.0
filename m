Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 10:36:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anton Weber <ant@antweb.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix optstring to parse -b parameter
Message-ID: <20120628073642.GA32563@x220>
References: <1339760580-8219-1-git-send-email-ant@antweb.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339760580-8219-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

On Fri, Jun 15, 2012, Anton Weber wrote:
> Without the colon getopt ignores the parameter and optarg is always NULL.
> ---
>  monitor/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
