Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Jan 2015 10:45:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow remote OOB data to only provide P-192
 or P-256 values
Message-ID: <20150131084508.GA21990@t440s.P-661HNU-F1>
References: <1422693422-12944-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422693422-12944-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> In case the remote only provided P-192 or P-256 data for OOB pairing,
> then make sure that the data value pointers are correctly set. That way
> the core can provide correct information when remote OOB data present
> information have to be communicated.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
