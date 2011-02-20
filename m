Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Feb 2011 15:29:14 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix Crash where MTU allowed to be set too large
Message-ID: <20110220182914.GA29936@jh-x301>
References: <1298148343-10535-1-git-send-email-bgix@codeaurora.org>
 <1298148343-10535-3-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298148343-10535-3-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Sat, Feb 19, 2011, Brian Gix wrote:
> As previously written, a remote device could request, and we would
> accept an MTU larger than what we could support.
> ---
>  src/attrib-server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
