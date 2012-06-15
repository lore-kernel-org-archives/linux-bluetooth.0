Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 17:52:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/9 v3] audio: Add handling of AVDTP command
 collision
Message-ID: <20120615145235.GA12490@x220>
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 15, 2012, Luiz Augusto von Dentz wrote:
> Check collision for AVDTP OPEN, CLOSE, START, SUSPEND and ABORT
> commands and if they collided remove the pending request if sep
> has accepted the indication.
> ---
> v2: Fix capitalizing some acronyms
> v3: Rebase and fix not using avdtp_start return in case of error
> 
>  audio/avdtp.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

All patches in this set have been applied. Thanks.

Johan
