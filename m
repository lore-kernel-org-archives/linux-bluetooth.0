Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 10:49:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Add more functions for new UUID handling
Message-ID: <20110315084935.GA16296@jh-x301>
References: <1300128839-6293-1-git-send-email-epx@signove.com>
 <1300128839-6293-3-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300128839-6293-3-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Mon, Mar 14, 2011, Elvis Pf??tzenreuter wrote:
> This patch adds more functions that are necessary to handle
> the new bt_uuid_t type, and moves basic things like
> byte-swapping functions and uint128_t type to bluetooth.h.
> ---
>  health/mcap_sync.c |   15 -----
>  lib/bluetooth.h    |   54 +++++++++++++++++++
>  lib/sdp.c          |   43 ---------------
>  lib/sdp.h          |    4 +-
>  lib/uuid.c         |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/uuid.h         |   11 +++--
>  test/hciemu.c      |   16 ------
>  7 files changed, 207 insertions(+), 81 deletions(-)

Patches 1 (v3.1 of it) and 2 have been pushed. 3 has some issues which
I'll send another email about.

Johan
