Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Mar 2014 23:36:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enforce strict Secure Connections Only mode
 security
Message-ID: <20140319213609.GA22186@t440s.P-661HNU-F1>
References: <1395263425-5744-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395263425-5744-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 19, 2014, Marcel Holtmann wrote:
> In Secure Connections Only mode, it is required that Secure Connections
> is used for pairing and that the link key is encrypted with AES-CCM using
> a P-256 authenticated combination key. If this is not the case, then new
> connection shall be refused or existing connections shall be dropped.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c  | 11 +++++++++++
>  net/bluetooth/hci_event.c | 12 ++++++++++++
>  2 files changed, 23 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
