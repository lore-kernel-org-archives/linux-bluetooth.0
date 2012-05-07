Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 10:56:19 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v2 1/2] Bluetooth: notify userspace of security level
 change
Message-ID: <20120507175619.GA5679@x220.hpllc.com>
References: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, May 07, 2012, Gustavo Padovan wrote:
> When the userspace request a security level change it needs to be notified
> of when the change is complete.
> This patch make the socket non writable while the security request is
> ongoing. If it succeeds POLL_OUT is emitted, otherwise the channel is
> disconnected.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  include/net/bluetooth/bluetooth.h |    1 +
>  net/bluetooth/af_bluetooth.c      |    2 +-
>  net/bluetooth/hci_event.c         |    7 +++++++
>  net/bluetooth/l2cap_core.c        |    5 +++++
>  net/bluetooth/l2cap_sock.c        |   15 ++++++++++-----
>  5 files changed, 24 insertions(+), 6 deletions(-)

Both patches have been applied to bluetooth.git.

Johan
