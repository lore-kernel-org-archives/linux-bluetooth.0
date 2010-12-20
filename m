Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Dec 2010 17:41:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Fix tools UI to avoid program launch mistakes.
Message-ID: <20101220154125.GC14575@jh-x301>
References: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
 <1292840029-27770-3-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292840029-27770-3-git-send-email-michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Mon, Dec 20, 2010, Michal Labedzki wrote:
> hciconfig: warrning user on unknown commands
> hcitool: return error on unknown command in hcitool
> fix length size in comparision to avoid ambiguity commands
> check if command number of arguments is correct
> ---
>  tools/hciconfig.c |   10 ++-
>  tools/hcitool.c   |  201 ++++++++++++++++------------------------------------
>  2 files changed, 70 insertions(+), 141 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
