Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Jun 2013 13:29:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] audio/media: Fix notifying settings changed
 incorrectly
Message-ID: <20130618102936.GB15389@x220>
References: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371542994-24510-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 18, 2013, Luiz Augusto von Dentz wrote:
> We should notify only the setting that has changed not all of them.
> ---
>  profiles/audio/avrcp.c | 30 +++++++++++++-----------------
>  profiles/audio/avrcp.h |  3 ++-
>  profiles/audio/media.c |  7 +------
>  3 files changed, 16 insertions(+), 24 deletions(-)

All three patches have been applied. Thanks.

Johan
