Return-Path: <cyrus@holtmann.org>
Message-ID: <1336412121.5970.104.camel@aeonflux>
Subject: Re: [PATCH -v2 1/2] Bluetooth: notify userspace of security level
 change
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 May 2012 10:35:21 -0700
In-Reply-To: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
References: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

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

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


