Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 14:37:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix bad epoch time stamp generation
Message-ID: <20111208123740.GA12014@x220>
References: <1322235448-9638-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322235448-9638-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Nov 25, 2011, Santiago Carot-Nemesio wrote:
> The number of months is in the range 0 to 11, we have to decrease
> month number by 1 before getting the epoch.
> ---
>  thermometer/thermometer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
