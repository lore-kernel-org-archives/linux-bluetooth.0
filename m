Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jan 2013 16:28:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] AVRCP: Fix crash when MediaPlayer1 is disabled
Message-ID: <20130111142840.GA27836@x220>
References: <1357913949-27785-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357913949-27785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jan 11, 2013, Luiz Augusto von Dentz wrote:
> When MediaPlayer1 is disabled we should not proceed with getting
> remote capabilities but switch back to 1.0 mode.
> ---
>  profiles/audio/avrcp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
