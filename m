Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 09:47:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, Ido Yariv <ido@wizery.com>,
	Arik Nemtsov <arik@wizery.com>
Subject: Re: [PATCH 1/2] Bluetooth: Search global l2cap channels by src/dst
 addresses
Message-ID: <20120423124720.GA18564@joana>
References: <1334947568-3437-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1334947568-3437-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

* João Paulo Rechi Vita <jprvita@openbossa.org> [2012-04-20 15:46:07 -0300]:

> From: Ido Yariv <ido@wizery.com>
> 
> The cid or psm and the source address might not be enough to uniquely
> identify a global channel, especially when the source address is our
> own.
> 
> For instance, when trying to communicate with two LE devices in master
> mode, data received from the both devices is sent to the same socket.
> 
> Fix this by taking the destination address into account when choosing
> the socket.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> Tested-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |   43 +++++++++++++++++++++++++++++++------------
>  1 files changed, 31 insertions(+), 12 deletions(-)

Patch has been applied, thanks.

	Gustavo
