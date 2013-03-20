Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Mar 2013 11:10:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4 v2] AVRCP: Add support for available player
 changed event for CT role
Message-ID: <20130320091014.GA3799@x220.ger.corp.intel.com>
References: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 18, 2013, Luiz Augusto von Dentz wrote:
> This adds support for registering to available player changed event if
> supported by TG.
> ---
> v2: Fix not checking return of create_ct_player which can fail if experimental
> is not enabled.
> 
>  profiles/audio/avrcp.c  | 402 ++++++++++++++++++++++++++++--------------------
>  profiles/audio/avrcp.h  |   1 +
>  profiles/audio/player.c |   5 +-
>  profiles/audio/player.h |   3 +-
>  4 files changed, 240 insertions(+), 171 deletions(-)

All patches in this set have been applied. Thanks.

Johan
