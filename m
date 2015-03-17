Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Mar 2015 21:29:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: re: Bluetooth: Create SMP device structure for local crypto context
Message-ID: <20150317182958.GC30354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel Holtmann,

The patch 88a479d9507e: "Bluetooth: Create SMP device structure for
local crypto context" from Mar 16, 2015, leads to the following
static checker warning:

	net/bluetooth/smp.c:3068 smp_add_cid()
	error: potential NULL dereference 'smp'.

net/bluetooth/smp.c
  3031  static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
  3032  {
  3033          struct l2cap_chan *chan;
  3034          struct smp_dev *smp;
  3035          struct crypto_blkcipher *tfm_aes;
  3036          struct crypto_hash *tfm_cmac;
  3037  
  3038          if (cid == L2CAP_CID_SMP_BREDR) {
  3039                  smp = NULL;
                        ^^^^^^^^^^
Sets "smp" to NULL.

  3040                  goto create_chan;
  3041          }
  3042  
  3043          smp = kzalloc(sizeof(*smp), GFP_KERNEL);
  3044          if (!smp)
  3045                  return ERR_PTR(-ENOMEM);
  3046  
  3047          tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
  3048          if (IS_ERR(tfm_aes)) {
  3049                  BT_ERR("Unable to create ECB crypto context");
  3050                  kzfree(smp);
  3051                  return ERR_CAST(tfm_aes);
  3052          }
  3053  
  3054          tfm_cmac = crypto_alloc_hash("cmac(aes)", 0, CRYPTO_ALG_ASYNC);
  3055          if (IS_ERR(tfm_cmac)) {
  3056                  BT_ERR("Unable to create CMAC crypto context");
  3057                  crypto_free_blkcipher(tfm_aes);
  3058                  kzfree(smp);
  3059                  return ERR_CAST(tfm_cmac);
  3060          }
  3061  
  3062          smp->tfm_aes = tfm_aes;
  3063          smp->tfm_cmac = tfm_cmac;
  3064  
  3065  create_chan:
  3066          chan = l2cap_chan_create();
  3067          if (!chan) {
  3068                  crypto_free_blkcipher(smp->tfm_aes);
                                              ^^^^^^^^^^^^
If the "chan" allocation fails then this will Oops.

  3069                  crypto_free_hash(smp->tfm_cmac);
                                         ^^^^^^^^^^^^^
  3070                  kzfree(smp);
  3071                  return ERR_PTR(-ENOMEM);
  3072          }

regards,
dan carpenter
