Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Feb 2014 18:24:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 01/10] Bluetooth: Remove SMP data specific crypto context
Message-ID: <20140218162438.GA13953@x220.p-661hnu-f1>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
 <1392736479-8808-2-git-send-email-johan.hedberg@gmail.com>
 <596B741F-5844-4C49-BE66-5413510692C4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <596B741F-5844-4C49-BE66-5413510692C4@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> > Now that each HCI device has its own AES crypto context we don't need
> > the one stored in the SMP data any more. This patch removes the variable
> > from struct smp_chan and updates the SMP code to use the per-hdev crypto
> > context.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/smp.c | 15 ++-------------
> > net/bluetooth/smp.h |  1 -
> > 2 files changed, 2 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 5867c1c3f436..6dcb35640b6f 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -413,21 +413,13 @@ static void confirm_work(struct work_struct *work)
> > {
> > 	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
> > 	struct l2cap_conn *conn = smp->conn;
> > -	struct crypto_blkcipher *tfm;
> > +	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm_aes;
> > 	struct smp_cmd_pairing_confirm cp;
> > 	int ret;
> > 	u8 res[16], reason;
> > 
> > 	BT_DBG("conn %p", conn);
> > 
> > -	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
> > -	if (IS_ERR(tfm)) {
> > -		reason = SMP_UNSPECIFIED;
> > -		goto error;
> > -	}
> > -
> > -	smp->tfm = tfm;
> > -
> 
> so I am curious now to what happens if we are running SMP and at the
> same time are doing RPA resolving. Can the same crypto context be used
> that way?

That's a fair point, and after a quick look through the crypto API it
seems like this might not be safe. A simple fix would be to ensure that
any access is between hci_dev_lock & hci_dev_unlock.

Johan
