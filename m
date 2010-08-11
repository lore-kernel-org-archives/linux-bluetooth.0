Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Aug 2010 09:26:17 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix not deleting stored keys when a new one is
 created
Message-ID: <20100811132617.GB13302@jh-x301>
References: <1281530667-25379-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281530667-25379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Aug 11, 2010, Luiz Augusto von Dentz wrote:
> When a new link key is created but it doesn't match any criteria to be
> stored any previouly one should be removed from filesystem.
> ---
>  src/dbus-hci.c |   12 +++++++-----
>  src/device.c   |    2 +-
>  src/device.h   |    2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)

The patch is now upstream. Thanks.

Johan
