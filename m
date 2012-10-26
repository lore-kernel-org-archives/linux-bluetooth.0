Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 10:44:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 07/11] AVRCP: Add initial support for controller
 player
Message-ID: <20121026074436.GA16896@x220>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
 <1351173554-28039-7-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351173554-28039-7-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 25, 2012, Luiz Augusto von Dentz wrote:
> This also bump controller record to 1.3.
> ---
>  Makefile.am    |   1 +
>  audio/avrcp.c  | 686 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>  audio/player.c | 404 +++++++++++++++++++++++++++++++++
>  audio/player.h |  46 ++++
>  4 files changed, 1047 insertions(+), 90 deletions(-)
>  create mode 100644 audio/player.c
>  create mode 100644 audio/player.h

I've applied patches 1-6 but this one is just huge. Isn't there some
easy way you could split it up a bit? Also, the necessary D-Bus API
documentation changes seem to be missing.

Johan
