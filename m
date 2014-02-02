Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 17:57:21 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove one level of indentation from
 hci_encrypt_change_evt
Message-ID: <20140202015721.GC5133@x220.p-661hnu-f1>
References: <1391214268-13443-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391214268-13443-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 31, 2014, Marcel Holtmann wrote:
> The function already has an unlock label which means the one extra level
> on indentation is not useful and just makes the code more complex. So
> remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 49 ++++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
