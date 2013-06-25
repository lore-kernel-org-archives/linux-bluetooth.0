Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jun 2013 19:54:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix not adding UUID found during pairing
Message-ID: <20130625165445.GA24596@x220.P-661HNU-F1>
References: <1372178160-22870-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372178160-22870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 25, 2013, Luiz Augusto von Dentz wrote:
> This is a regression introduce by de63199f0c89fce76180edd40359fde4b13c54c1
> where the list of UUID found is always empty thus causing no driver to be
> probed.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
