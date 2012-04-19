Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 11:39:56 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Split error handling for SCO listen
 sockets
Message-ID: <20120419143956.GD4127@joana>
References: <1334835833-21828-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334835833-21828-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-04-19 13:43:52 +0200]:

> Split the checks for sk->sk_state and sk->sk_type for SCO listen
> sockets. This makes the code more readable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Applied to bluetooth-next, thanks.

	Gustavo
