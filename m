Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Mar 2015 09:01:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove two else branches that are not needed
Message-ID: <20150312070128.GA22131@t440s.P-661HNU-F1>
References: <1426121260-32743-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426121260-32743-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 11, 2015, Marcel Holtmann wrote:
> The SMP code contains two else branches that are not needed since the
> successful test will actually leave the function.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
