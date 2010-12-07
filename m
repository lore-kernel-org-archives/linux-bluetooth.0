Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 16:23:17 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 5/9] Bluetooth: Add support for using the crypto
 subsystem
Message-ID: <20101207192317.GC4797@eris>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
 <1291671832-13435-6-git-send-email-vinicius.gomes@openbossa.org>
 <003101cb963d$8dcd6210$a9682630$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003101cb963d$8dcd6210$a9682630$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 10:35 Tue 07 Dec, Brian Gix wrote:
> 
> Hi Vinicius,
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> > Sent: 06 December, 2010 1:44 PM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: Vinicius Costa Gomes
> > Subject: [RFC v2 5/9] Bluetooth: Add support for using the crypto
> > subsystem
> > 
> > This will allow using the crypto subsystem for encrypting data. As SMP
> > (Security Manager Protocol) is implemented almost entirely on the host
> > side and the crypto module already implements the needed methods
> > (AES-128), it makes sense to use it.
> 
> I do understand the desire to reuse the crypto module, but I would like
> to point out that every baseband that supports any level of LE-SM, is
> required to have implemented the HCI commands for LE-SM centric encryption
> and random number generation.

Yes, we are aware of that.

> 
> Also, since these are processor intensive calculations, which must take
> place in real-time on the baseband for encrypted links, I would argue
> that it makes more sense to use the likely optimized functionality
> present in the basebands.

I am sure that the baseband is optimized for those operations, but one 
thing that needs to be considered is the time that the information takes to get
to and from the baseband. For example, in the case of a USB controller, we need 
to build an HCI command, insert the command in the queue, and wait for it to be
delivered (and received) via the USB bus to the baseband. Using the crypto
subsystem we may even be able to use functionality built inside the processor.

> 
> That is not to say that it cannot be done on the host, just that it
> is likely less efficient, for no gain in portability or functionality.

There is a gain in simplicity ;-) 

> 
>  
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/hci_core.h |    2 ++
> >  net/bluetooth/hci_core.c         |   10 ++++++++++
> >  2 files changed, 12 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 0687e2f..d0a9f5d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -135,6 +135,8 @@ struct hci_dev {
> >  	__u32			req_status;
> >  	__u32			req_result;
> > 
> > +	struct crypto_blkcipher	*tfm;
> > +
> >  	struct inquiry_cache	inq_cache;
> >  	struct hci_conn_hash	conn_hash;
> >  	struct list_head	blacklist;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 12c6735..b96c3dd 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/notifier.h>
> >  #include <linux/rfkill.h>
> > +#include <linux/crypto.h>
> >  #include <net/sock.h>
> > 
> >  #include <asm/system.h>
> > @@ -961,6 +962,13 @@ int hci_register_dev(struct hci_dev *hdev)
> >  	if (!hdev->workqueue)
> >  		goto nomem;
> > 
> > +	hdev->tfm = crypto_alloc_blkcipher("ecb(aes)", 0,
> > CRYPTO_ALG_ASYNC);
> > +	if (IS_ERR(hdev->tfm)) {
> > +		BT_ERR("Failed to load transform for ecb(aes): %ld",
> > +							PTR_ERR(hdev->tfm));
> > +		goto nomem;
> > +	}
> > +
> >  	hci_register_sysfs(hdev);
> > 
> >  	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
> > @@ -1001,6 +1009,8 @@ int hci_unregister_dev(struct hci_dev *hdev)
> >  	for (i = 0; i < NUM_REASSEMBLY; i++)
> >  		kfree_skb(hdev->reassembly[i]);
> > 
> > +	crypto_free_blkcipher(hdev->tfm);
> > +
> >  	hci_notify(hdev, HCI_DEV_UNREG);
> > 
> >  	if (hdev->rfkill) {
> > --
> > 1.7.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Cheers,
-- 
Vinicius
