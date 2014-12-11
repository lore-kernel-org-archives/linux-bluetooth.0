Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Dec 2014 21:44:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix check for support for page scan related
 commands
Message-ID: <20141211194408.GA15835@t440s.P-661HNU-F1>
References: <1418325714-15366-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418325714-15366-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 11, 2014, Marcel Holtmann wrote:
> The Read Page Scan Activity and Read Page Scan Type commands are not
> supported by all controllers. Move the execution of both commands
> into the 3rd phase of the init procedure. And then check the bit
> mask of supported commands before adding them to the init sequence.
> 
> With this re-ordering of the init sequence, the extra check for
> AVM BlueFritz! controllers is no longer needed. They will report
> that these two commands are not supported.
> 
> This fixes an issue with the Microsoft Corp. Wireless Transceiver
> for Bluetooth 2.0 (ID 045e:009c).
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
