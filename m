Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Mar 2015 10:09:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Move eir_append_data function to a
 different location
Message-ID: <20150315080910.GB27545@t440s.P-661HNU-F1>
References: <1426398199-11977-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426398199-11977-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 14, 2015, Marcel Holtmann wrote:
> The eir_append_data helper function is needed for generating the
> extended local OOB data fields. So move it up into the right location.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
