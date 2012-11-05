Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Nov 2012 08:49:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] Change maximum pkt size for High Speed max pkt
Message-ID: <20121105064921.GA17622@x220.P-661HNU-F1>
References: <1351689401-3650-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351689401-3650-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 31, 2012, Andrei Emeltchenko wrote:
> For AMP, L2CAP packets might be of bigger size, up to 1492 bytes.
> Without the change hcidump cuts AMP data packets.
> ---
>  lib/hci.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluez-hcidump.git and bluez.git. Thanks.

Johan
