Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72CC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 23:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjE1XXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1XXm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 19:23:42 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF04B9
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 16:23:40 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 45B53240101
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:23:38 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTvqF3tvfz9rxF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:23:37 +0200 (CEST)
Message-ID: <8eacbb0919470938a9ea10fc507d684b6a6d169f.camel@iki.fi>
Subject: Re: [PATCH 1/6] Bluetooth: ISO: fix maximum number of CIS in Set
 CIG Parameters
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Date:   Sun, 28 May 2023 23:23:36 +0000
In-Reply-To: <46eefccceb45556120a0d1fa95cf27c576e9649a.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
         <46eefccceb45556120a0d1fa95cf27c576e9649a.1685294131.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

su, 2023-05-28 kello 17:44 +0000, Pauli Virtanen kirjoitti:
> The maximum CIS_Count is 0x1f (Core v5.3 Vol 4 Part E Sec 7.8.97).
> 
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/hci_conn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1f906f8508bc..7b1a83ec50ae 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -788,7 +788,7 @@ struct iso_list_data {
>  	int count;
>  	struct {
>  		struct hci_cp_le_set_cig_params cp;
> -		struct hci_cis_params cis[0x11];
> +		struct hci_cis_params cis[0x1f];
>  	} pdu;
>  };
>  
> @@ -1815,7 +1815,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
>  	}
>  
>  	/* Reprogram all CIS(s) with the same CIG */
> -	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0x11;
> +	for (data.cig = qos->ucast.cig, data.cis = 0x00;
> +	     data.cis < ARRAY_SIZE(data.pdu.cis);
>  	     data.cis++) {
>  		data.count = 0;
>  

Probably should also have cleaned up this loop while at it, the command
takes 0x1f configurations at most, but CIS IDs are <= 0xef. For v2...

-- 
Pauli Virtanen
