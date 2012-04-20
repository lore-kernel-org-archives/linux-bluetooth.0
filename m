Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Apr 2012 14:20:06 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Don't check source address in SCO bind
 function
Message-ID: <20120420172006.GB3911@joana>
References: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-04-19 13:43:53 +0200]:

> Checking the source address in SCO bind function will prevent from
> having an incoming and outgoing SCO socket. However that might be
> needed in case of multiple SCO connections on a single device.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)

Patch has been applied. Thanks.

	Gustavo
