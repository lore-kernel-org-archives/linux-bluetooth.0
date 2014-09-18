Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Sep 2014 08:08:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] emulator/btdev: Add iovec support
Message-ID: <20140918050815.GA19490@t440s.P-661HNU-F1>
References: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Sep 17, 2014, Luiz Augusto von Dentz wrote:
> This convert btdev_set_send_handler to take struct iovec for doing
> scatter io.
> ---
>  emulator/btdev.c    | 135 ++++++++++++++++++++++++++--------------------------
>  emulator/btdev.h    |   2 +-
>  emulator/serial.c   |   5 +-
>  emulator/server.c   |  10 +++-
>  emulator/vhci.c     |   5 +-
>  src/shared/hciemu.c |  16 ++++++-
>  6 files changed, 98 insertions(+), 75 deletions(-)

Both of these patches have been applied. Thanks.

Johan
