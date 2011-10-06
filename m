Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 11:16:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object
Message-ID: <20111006081647.GA23687@fusion.localdomain>
References: <1317844938-21950-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317844938-21950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 05, 2011, Luiz Augusto von Dentz wrote:
> This move the MediaPlayer registration to adapter object on Media
> interface so we can track players properly.
> ---
>  audio/avrcp.c     |  840 +++++++++++------------------------------------------
>  audio/avrcp.h     |   67 ++++-
>  audio/device.c    |    3 -
>  audio/device.h    |    2 -
>  audio/manager.c   |    7 -
>  audio/media.c     |  784 +++++++++++++++++++++++++++++++++++++++++++++++++
>  doc/media-api.txt |  163 +++++++++++
>  7 files changed, 1179 insertions(+), 687 deletions(-)

All four patches have been applied. Thanks.

Johan
