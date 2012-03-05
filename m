Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Mar 2012 11:35:45 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove not needed total variable in get_ltk_info
Message-ID: <20120305193545.GA16481@x220.ice.intel.com>
References: <1330973919-3704-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330973919-3704-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 05, 2012, Szymon Janc wrote:
> This variable is not really needed and was mostly dead assigned.
> ---
>  src/adapter.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
