Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Apr 2012 14:27:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Restrict to one SCO listening socket
Message-ID: <20120420172420.GC3911@joana>
References: <1334839078-14958-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334839078-14958-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-04-19 14:37:58 +0200]:

> The SCO sockets are only identified by its address. So only allow one
> SCO socket in listening state per address or BDADDR_ANY.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c |   29 ++++++++++++++++++++++-------
>  1 files changed, 22 insertions(+), 7 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
