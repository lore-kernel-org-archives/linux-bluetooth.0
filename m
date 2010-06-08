Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 14:27:19 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] sdptool: Fix 2 possible NULL dereference
Message-ID: <20100608062719.GA21167@jh-x301>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
 <1275732870-15889-3-git-send-email-gustavo@padovan.org>
 <1275732870-15889-4-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275732870-15889-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Jun 05, 2010, Gustavo F. Padovan wrote:
> Issues found by smatch static check:
> http://smatch.sourceforge.net/
> ---
>  tools/sdptool.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)

This patch is now also upstream. Thanks.

Johan
