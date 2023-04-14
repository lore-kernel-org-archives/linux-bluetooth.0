Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11471C77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 19:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNTxn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNTxl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 15:53:41 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A755A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 12:53:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1BC7E240290
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 21:53:37 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PynFF38Cmz6txQ;
        Fri, 14 Apr 2023 21:53:37 +0200 (CEST)
Message-ID: <1ae133312ec9d702ebf18cbf3a2b106e8c27acd4.camel@iki.fi>
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Fri, 14 Apr 2023 19:53:36 +0000
In-Reply-To: <20230413183113.896669-2-luiz.dentz@gmail.com>
References: <20230413183113.896669-1-luiz.dentz@gmail.com>
         <20230413183113.896669-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-04-13 kello 11:31 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes only matching CIS by address which prevents creating new hcon
> if upper layer is requesting a specific CIS ID.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 7 ++++++-
>  net/bluetooth/hci_conn.c         | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4fe1e71cb9d8..6f5e8594ff2d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1180,7 +1180,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
>  
>  static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
>  							bdaddr_t *ba,
> -							__u8 ba_type)
> +							__u8 ba_type,
> +							__u8 id)
>  {
>  	struct hci_conn_hash *h = &hdev->conn_hash;
>  	struct hci_conn  *c;
> @@ -1191,6 +1192,10 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
>  		if (c->type != ISO_LINK)
>  			continue;
>  
> +		/* Match CIS ID if set */
> +		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
> +			continue;
> +

Should this also check the CIG ID?

Core v5.3 4.E Sec. 5.3: "The CIS_ID has a separate number space for
each CIG_ID.", and I didn't manage to find restriction that you
couldn't have the same peripheral in multiple CIG.

>  		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
>  			rcu_read_unlock();
>  			return c;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 204164ee5f9a..b9ecfc782be9 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1842,7 +1842,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
>  {
>  	struct hci_conn *cis;
>  
> -	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
> +	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cis);
>  	if (!cis) {
>  		cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
>  		if (!cis)

-- 
Pauli Virtanen
