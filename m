Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Mar 2015 10:38:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/8] Bluetooth: Use kzfree instead of kfree in
 security manager
Message-ID: <20150316083845.GA10169@t440s.lan>
References: <1426493425-7427-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426493425-7427-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 16, 2015, Marcel Holtmann wrote:
> Within the security manager, it makes sense to use kzfree instead of
> kfree for all data structures. This ensures that no key material leaks
> by accident.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

All 8 patches in this set have been applied to bluetooth-next. Thanks.

Johan
