Return-Path: <SRS0=5peh=MK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B1C43382
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32E920676
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 17:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32E920676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeI1XuO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:50:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43370 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1XuO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Sep 2018 19:50:14 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id F2FACCF2A1;
        Fri, 28 Sep 2018 19:32:43 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] Bluetooth: Fix debugfs NULL pointer dereference
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180928145121.GA74892@Matias-MacBook-Air.local>
Date:   Fri, 28 Sep 2018 19:25:27 +0200
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C974C534-B18D-4AB7-AE3E-81D5AF4CA5E4@holtmann.org>
References: <20180928145121.GA74892@Matias-MacBook-Air.local>
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

> Fix crash caused by NULL pointer dereference when debugfs functions
> le_max_key_read, le_max_key_size_write, le_min_key_size_read or
> le_min_key_size_write and Bluetooth adapter was powered off.
> 
> Fix is to move max_key_size and min_key_size from smp_dev to hci_dev.
> At the same time they were renamed to le_smp_max_key_size and
> le_smp_min_key_size.
> 
> BUG: unable to handle kernel NULL pointer dereference at 00000000000002e8
> PGD 0 P4D 0
> Oops: 0000 [#24] SMP PTI
> CPU: 2 PID: 6255 Comm: cat Tainted: G      D    OE     4.18.9-200.fc28.x86_64 #1
> Hardware name: LENOVO 4286CTO/4286CTO, BIOS 8DET76WW (1.46 ) 06/21/2018
> RIP: 0010:le_max_key_size_read+0x45/0xb0 [bluetooth]
> Code: 00 00 00 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8b 87 c8 00 00 00 48 8d 7c 24 04 48 8b 80 48 0a 00 00 <48> 8b 80 e8 02 00 00 0f b6 48 52 e8 fb b6 b3 ed be 04 00 00 00 48
> RSP: 0018:ffffab23c3ff3df0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00007f0b4ca2e000 RCX: ffffab23c3ff3f08
> RDX: ffffffffc0ddb033 RSI: 0000000000000004 RDI: ffffab23c3ff3df4
> RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffab23c3ff3ed8 R11: 0000000000000000 R12: ffffab23c3ff3f08
> R13: 00007f0b4ca2e000 R14: 0000000000020000 R15: ffffab23c3ff3f08
> FS:  00007f0b4ca0f540(0000) GS:ffff91bd5e280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002e8 CR3: 00000000629fa006 CR4: 00000000000606e0
> Call Trace:
> full_proxy_read+0x53/0x80
> __vfs_read+0x36/0x180
> vfs_read+0x8a/0x140
> ksys_read+0x4f/0xb0
> do_syscall_64+0x5b/0x160
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/smp.c              | 25 +++++++++++--------------
> 2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0db1b9b428b7..334a65f720ca 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -259,6 +259,8 @@ struct hci_dev {
> 	__u16		le_max_tx_time;
> 	__u16		le_max_rx_len;
> 	__u16		le_max_rx_time;
> +	__u8		le_smp_max_key_size;
> +	__u8		le_smp_min_key_size;

I would just use le_{min,max}_key_size since the SMP doesn’t really give any benefit. It is always SMP when it comes to LE.

> 	__u16		discov_interleaved_timeout;
> 	__u16		conn_info_min_age;
> 	__u16		conn_info_max_age;
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 3a7b0773536b..e41178408f64 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -88,9 +88,6 @@ struct smp_dev {
> 	u8			local_rand[16];
> 	bool			debug_key;
> 
> -	u8			min_key_size;
> -	u8			max_key_size;
> -
> 	struct crypto_cipher	*tfm_aes;
> 	struct crypto_shash	*tfm_cmac;
> 	struct crypto_kpp	*tfm_ecdh;
> @@ -720,7 +717,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
> 	if (rsp == NULL) {
> 		req->io_capability = conn->hcon->io_capability;
> 		req->oob_flag = oob_flag;
> -		req->max_key_size = SMP_DEV(hdev)->max_key_size;
> +		req->max_key_size = hdev->le_smp_max_key_size;
> 		req->init_key_dist = local_dist;
> 		req->resp_key_dist = remote_dist;
> 		req->auth_req = (authreq & AUTH_REQ_MASK(hdev));
> @@ -731,7 +728,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
> 
> 	rsp->io_capability = conn->hcon->io_capability;
> 	rsp->oob_flag = oob_flag;
> -	rsp->max_key_size = SMP_DEV(hdev)->max_key_size;
> +	rsp->max_key_size = hdev->le_smp_max_key_size;
> 	rsp->init_key_dist = req->init_key_dist & remote_dist;
> 	rsp->resp_key_dist = req->resp_key_dist & local_dist;
> 	rsp->auth_req = (authreq & AUTH_REQ_MASK(hdev));
> @@ -745,7 +742,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
> 	struct hci_dev *hdev = conn->hcon->hdev;
> 	struct smp_chan *smp = chan->data;
> 
> -	if (max_key_size > SMP_DEV(hdev)->max_key_size ||
> +	if (max_key_size > hdev->le_smp_max_key_size ||
> 	    max_key_size < SMP_MIN_ENC_KEY_SIZE)
> 		return SMP_ENC_KEY_SIZE;
> 
> @@ -3243,8 +3240,6 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
> 	smp->tfm_aes = tfm_aes;
> 	smp->tfm_cmac = tfm_cmac;
> 	smp->tfm_ecdh = tfm_ecdh;
> -	smp->min_key_size = SMP_MIN_ENC_KEY_SIZE;
> -	smp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> 
> create_chan:
> 	chan = l2cap_chan_create();
> @@ -3370,7 +3365,7 @@ static ssize_t le_min_key_size_read(struct file *file,
> 	struct hci_dev *hdev = file->private_data;
> 	char buf[4];
> 
> -	snprintf(buf, sizeof(buf), "%2u\n", SMP_DEV(hdev)->min_key_size);
> +	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_smp_min_key_size);
> 
> 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
> }
> @@ -3391,11 +3386,11 @@ static ssize_t le_min_key_size_write(struct file *file,
> 
> 	sscanf(buf, "%hhu", &key_size);
> 
> -	if (key_size > SMP_DEV(hdev)->max_key_size ||
> +	if (key_size > hdev->le_smp_max_key_size ||
> 	    key_size < SMP_MIN_ENC_KEY_SIZE)
> 		return -EINVAL;
> 
> -	SMP_DEV(hdev)->min_key_size = key_size;
> +	hdev->le_smp_min_key_size = key_size;
> 
> 	return count;
> }
> @@ -3414,7 +3409,7 @@ static ssize_t le_max_key_size_read(struct file *file,
> 	struct hci_dev *hdev = file->private_data;
> 	char buf[4];
> 
> -	snprintf(buf, sizeof(buf), "%2u\n", SMP_DEV(hdev)->max_key_size);
> +	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_smp_max_key_size);
> 
> 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
> }
> @@ -3436,10 +3431,10 @@ static ssize_t le_max_key_size_write(struct file *file,
> 	sscanf(buf, "%hhu", &key_size);
> 
> 	if (key_size > SMP_MAX_ENC_KEY_SIZE ||
> -	    key_size < SMP_DEV(hdev)->min_key_size)
> +	    key_size < hdev->le_smp_min_key_size)
> 		return -EINVAL;
> 
> -	SMP_DEV(hdev)->max_key_size = key_size;
> +	hdev->le_smp_max_key_size = key_size;
> 
> 	return count;
> }
> @@ -3474,6 +3469,8 @@ int smp_register(struct hci_dev *hdev)
> 		return PTR_ERR(chan);
> 
> 	hdev->smp_data = chan;
> +	hdev->le_smp_max_key_size = SMP_MAX_ENC_KEY_SIZE;
> +	hdev->le_smp_min_key_size = SMP_MIN_ENC_KEY_SIZE;

I am not sure this should be done here. This should be done in the HCI init so that it has guaranteed default values even early on.

Regards

Marcel

