Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Jul 2013 09:24:52 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/player: Fix not setting playlist items as
 playable
Message-ID: <20130726162452.GB6805@x220.p-661hnu-f1>
References: <1374845040-17563-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374845040-17563-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jul 26, 2013, Luiz Augusto von Dentz wrote:
> All items in the playlist should have playable flag set otherwise they
> cannot be part of the playlist.
> ---
>  profiles/audio/player.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
