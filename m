Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 10 Nov 2015 20:47:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/gatt-client: Don't reset database on
 service changed
Message-ID: <20151110184729.GB17113@t440s.P-661HNU-F1>
References: <1447161195-8830-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447161195-8830-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 10, 2015, Luiz Augusto von Dentz wrote:
> If the remote send a full reset, 0x0001 - 0xffff, just discovery the
> attributes again as device may send this even though nothing has
> changed.
> ---
>  src/shared/gatt-client.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied. Thanks.

Johan
