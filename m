Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 18:45:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Create flags for bt_sk()
Message-ID: <20120516154515.GA16250@x220>
References: <1337181432-979-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337181432-979-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 16, 2012, Gustavo Padovan wrote:
> defer_setup and suspended are now flags into bt_sk().
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  include/net/bluetooth/bluetooth.h |    8 ++++++--
>  net/bluetooth/af_bluetooth.c      |    8 ++++----
>  net/bluetooth/l2cap_core.c        |   14 ++++++++------
>  net/bluetooth/l2cap_sock.c        |   21 +++++++++++++--------
>  net/bluetooth/rfcomm/sock.c       |   14 ++++++++++----
>  5 files changed, 41 insertions(+), 24 deletions(-)

Patches 1 and 3 have been applied to bluetooth-next. I left 2/3 out as
we agreed since it doesn't compile.

Johan
