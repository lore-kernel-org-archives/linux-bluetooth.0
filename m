Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EECDC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEBOK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBOK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:10:28 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D13F1FC9
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=GKEK9nZmFrvza3v8rX1r2f1MWrDA
        lzupLrBYtzw+w3M=; b=egmuNgsiehM0wU1Dz/7euBDMcoIvwUl1W1rc7BG2dsdL
        PDmrPebe+RweciMRl1F6aJtLizQt1WWYlCeIp+xBoV63tkTWohF6VEg3RYf8rzH9
        gVnDICYM1ZlF7Tqafdwy1ZRfN1vQ/QkuOYXQxpTXiqFtFXimJjvQibf/kWA09ag=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogDHwrm_GVFk_y01Eg--.23272S2;
        Tue, 02 May 2023 22:10:22 +0800 (CST)
Date:   Tue, 2 May 2023 22:10:06 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: Fix potential double free caused by
 hci_conn_unlink
Message-ID: <e3lpbuwudub45ymqoubloli7smktxhsgrrhz52ppmywei6dnbc@54tpwahrnrk6>
References: <20230430180535.168270-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430180535.168270-1-lrh2000@pku.edu.cn>
X-CM-TRANSID: 54FpogDHwrm_GVFk_y01Eg--.23272S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury8uw4UXw1DJFW8Jw4ruFg_yoW5Xr1fpa
        yYga9avF4ktrn3uF42yw10grs0vw1kuFW7Kr1FqryYyws0vr1kAw4F9ry8Krs8urWkuF45
        AF4jqr15KF4DZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbZmitUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAUs2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, May 01, 2023 at 02:05:35AM +0800, Ruihan Li wrote:
> The hci_conn_unlink function is being called by hci_conn_del, which means
> it should not call hci_conn_del with the input parameter conn again. If it
> does, conn may have already been released when hci_conn_unlink returns,
> leading to potential UAF and double-free issues.
> 
> This patch resolves the problem by modifying hci_conn_unlink to release
> only conn's child links when necessary, but never release conn itself.

Syzbot also found this bug several days ago (but it does not email
linux-bluetooth until today).

Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=690b90b14f14f43f4688

> Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
> Changes since v1:
>  * CI complains that there are some merge conflicts. This is because
> 	void hci_conn_del(struct hci_conn *conn)
>    this completely unrelated line makes the patch dependent on another fix:
> 	https://lore.kernel.org/linux-bluetooth/20230430171847.156825-1-lrh2000@pku.edu.cn/
>    But actually, deleting that line makes the two patches independent of
>    each other, and everything still works.
> 
>  net/bluetooth/hci_conn.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 85c34c837..5f388202f 100644
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
> @@ -1100,12 +1110,5 @@ static void hci_conn_unlink(struct hci_conn *conn)
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
> -- 
> 2.40.0

Thanks,
Ruihan Li

