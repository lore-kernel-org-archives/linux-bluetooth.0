Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:42:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6 v2] tools: Make mpris-player to export players
 using MPRIS interface
Message-ID: <20130125074218.GA27699@x220>
References: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jan 24, 2013, Luiz Augusto von Dentz wrote:
> Players found are exported in private connections using
> org.mpris.MediaPlayer2.<device name> on the session bus.
> ---
> v2: Fix generating invalid player bus name if device name contains invalid
> chars.
> 
>  tools/mpris-player.c | 644 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 623 insertions(+), 21 deletions(-)

All patches in this set have been applied. Thanks.

Johan
