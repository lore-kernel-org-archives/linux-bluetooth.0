Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18EC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 13:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjECNel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjECNek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 09:34:40 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E4931FDB
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=xpLjX6inzeUghgA2qWaUH5PtEMkGVwD0Hu
        BhMSfNXqQ=; b=a4UUJ5HBITbvK6NgQeoD2WvjslV7GLzsl4ZXIO08nO1WK1xMSI
        j3exC37t+G7QrpgbH97dB0x+gnfVx/X1Roo48h+KLI3R/TdFn3Ej0WnSfxKkDLEb
        5Zzk7F2JRsHkWk76y4p71v3iaMP8HVj3Cz12AvgscuTHROocX3T31GhHQ=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogBXXU3PYlJkFPtnEg--.9140S2;
        Wed, 03 May 2023 21:34:35 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v3 1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Wed,  3 May 2023 21:34:06 +0800
Message-Id: <20230503133406.167517-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogBXXU3PYlJkFPtnEg--.9140S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4rGw18WF47Jw1ruFWDCFg_yoW5Gw43pa
        y3uay3WrWktrn3ZF17t3W0gF4q9w1kCFW7Kryktry5Jws0vrW8Ar40kryjgrs8urZ5uF4r
        AF4Utrn8KF4DJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUo5rcUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AApsL
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue,  2 May 2023 14:25:24 -0700, Luiz Augusto von Dentz wrote:
> From: Ruihan Li <lrh2000@pku.edu.cn>
> 
> The hci_conn_unlink function is being called by hci_conn_del, which
> means it should not call hci_conn_del with the input parameter conn
> again. If it does, conn may have already been released when
> hci_conn_unlink returns, leading to potential UAF and double-free
> issues.
> 
> This patch resolves the problem by modifying hci_conn_unlink to release
> only conn's child links when necessary, but never release conn itself.
> 
> Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/
> Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
> Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com

I don't think these tags are properly inserted in commit messages, are they?

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 640b951bf40a..70e1655a9df6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1083,8 +1083,18 @@ static void hci_conn_unlink(struct hci_conn *conn)
>  	if (!conn->parent) {
>  		struct hci_link *link, *t;
>  
> -		list_for_each_entry_safe(link, t, &conn->link_list, list)
> -			hci_conn_unlink(link->conn);
> +		list_for_each_entry_safe(link, t, &conn->link_list, list) {
> +			struct hci_conn *child = link->conn;
> +
> +			hci_conn_unlink(child);
> +
> +			/* Due to race, SCO connection might be not established
> +			 * yet at this point. Delete it now, otherwise it is
> +			 * possible for it to be stuck and can't be deleted.
> +			 */
> +			if (child->handle == HCI_CONN_HANDLE_UNSET)
> +				hci_conn_del(child);
> +		}
>  
>  		return;
>  	}
> @@ -1100,13 +1110,6 @@ static void hci_conn_unlink(struct hci_conn *conn)
>  
>  	kfree(conn->link);
>  	conn->link = NULL;
> -
> -	/* Due to race, SCO connection might be not established
> -	 * yet at this point. Delete it now, otherwise it is
> -	 * possible for it to be stuck and can't be deleted.
> -	 */
> -	if (conn->handle == HCI_CONN_HANDLE_UNSET)
> -		hci_conn_del(conn);
>  }
>  
>  int hci_conn_del(struct hci_conn *conn)
> -- 
> 2.40.0

Thanks,
Ruihan Li

