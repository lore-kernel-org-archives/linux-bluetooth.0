Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925947C0F7
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394261; cv=pass; b=eBCT4XoNlIuG5d9/rYPcV1yUVcIgjFSAEfE0T426xlvCtGqYs5LGkQpeDjf6VtX/EGPu7Yx69wGaWSBFrUxFtDUxwrvH6v5zsvHsNid5K+Nk/0wEigisbLj10rNpemqMJRD2KkB8GCXfWgEPe8bt/4ylg7O+xZFTgFhNDtbi9DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394261; c=relaxed/simple;
	bh=lJVGF2MrIGJ6/Msnkutl7Ct5nsmA8aoi6v75pv+4DMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnq06ciYlcwuyLzvjPcAHIaA2FI5yQpZ14gtLdcgxyl/lZN/8c4hdv2WuBjUOt2wl2HN0EHtoahS2swKORWSPoLdCho4EoQFECXf22kKqRxkrXG+qgmFaXS4RShC9iy8RSBPRz8XBZJN3M8lxx1I0DIa7hwTkkWH6DJi2fKJE4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR5DFjcL; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR5DFjcL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so1512873d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789394259; cv=none;
        d=google.com; s=arc-20260327;
        b=j2OXcg2GfVSOwmXIFpB6mzr/+s2m6+CjqFhD/KvA5+SXwju/44fkPdHDCKLjT9od5c
         zPTSAWOoy8oxpS+51MpeXZ3eLpKjBHtBonADqak4kl/mJ4wtNSwFzeaucii40Is0Wus9
         O1Ek6y9GgdRC2KODU1L9iPX1trOKrC2m0c0wUSpHMoJaNd/Gj4Zw8BrDc+4gVjeYvkoX
         3EJMOMrN2oSnR7r9x8fSf2qejxX4/1E5vdzLjRZ8kjRCCfIn0G8eIj0doGxFbzASpl0j
         y4ryp4RATflri7TWdkkxIZqg0+6184ilA3q5ydupSO8kRfLGmPXGpYbVDSV0ZygMiOiW
         Di/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ngouuzk5nO0PMiFaSO3Ww6fwWjCxaG/P3WaLVlqRSMY=;
        fh=wwjAA4ZEyVEj8lfObod3tAyJEJGkh82OBneQOnQXRKQ=;
        b=dpal3HnyARWB6IKSCEUO5cmwGBNyQCCCJDhp074c91OuBI49P+Nd5YQYZ4STDPXXk7
         VeqQSLp6p3eie9t9+Dm+BeO2SK1lqRnuQraGXBAvWYz01Ny6LAur0M5tZiqhQgZxWWT0
         bA6NEeKvutnP/zIhWdXWTIbYwMeZokiYDm0BKwj/FvMh5Qrfrpgfd+DIa89yILVUEpgg
         gSNZMn1SUbd9jpmG404SQYS6KwLjvp2iHaXeVv0VRygUSufbDR5WzI9ts9AI+ZRMGsAk
         U24GQn6fniL3c9JzolhgVX1/DqsbHdd3gFCKSVgiYwqpAdNQ5cpqvisUj1mBEgGc0MoI
         ZPQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394259; x=1789999059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ngouuzk5nO0PMiFaSO3Ww6fwWjCxaG/P3WaLVlqRSMY=;
        b=GR5DFjcLwn+Z2Y3Yx4nSLtFkwK5akafc1wS5yfDLCq9YHk8Ze5AUVZGy34hMfoKrhy
         exjw0Fpu2LIkEDHEfcSQZVir79wjexW5HexNaJiHqDYyD8hcW+zO/0/9gwUr430v10zZ
         3i+G/8b3Zt8WF31PYUPrS4LLcg6u5uKVBkGQriB9FqIeRE9Lnp69YiqGMvOLgkXRzGwg
         sFxutF9ku2F1iHAA8aCowTI8ExVCYGGuVYulhvNBF4/Dg+mamia6vnPeVHwd89b5X3A3
         C/EiHdBBrq4FBpr3r9O82xY8XMDs5dGItC0fNPxWVbou9EBsuBHFcH6rv34FjUs+aKwT
         Tudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394259; x=1789999059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ngouuzk5nO0PMiFaSO3Ww6fwWjCxaG/P3WaLVlqRSMY=;
        b=SZTn2tKzdDp8o4dnfHmkIRDvtV67bUJo0/At8LSWTHtDqfeyo1vd35AkkSRDvNT9yV
         rju8siqu+O3s44t7EeTdsFRmXlg9E8W3OihJbj1Ld8Hhbn4gbSshg8db+ItQqNk45U8T
         YmyrmOtDKwmbATV9F8CP9333hbZghiuavzCU/f2RnbiUqdz2ZmavroivLdnGTcwld5pc
         HAwBngy9fEjfisrA7LKk/TPnZJ4GuNnkxRtUVt9htVLePuwAuqoCVFjLFluMqe91B1/i
         Q8CR/QYK+hwnJGbgSF23zOe0hP8NzMr8smVWJN/oZ9E9IPVihqYQc390lFbXeaMERW9t
         12dQ==
X-Forwarded-Encrypted: i=1; AKwUvByfL1xb4AYxEzKgZrD5GsCa3rKZfCtQZR9ZV4e9PlUxu4bIKfAPQ9CRZG1y/sXdy4NQhlbKQNveoRJZvspxNK4=@vger.kernel.org
X-Gm-Message-State: AFuF++lPd5wqjkkIPhFIH0+C5Kx6zhWPqFqSqAlDXuYz5G4S6McVZSM+
	/B08FAJivuZ9Lv+PnfspCF/+UJH7h5EK4vEOiZfpNFvtu7PD+dp17vUwtqzXPIHM52LDPAqQDM+
	5F+7L1wkETVE7X74mm07n2/yzsM8RUqvxKa4dK1A=
X-Gm-Gg: AYBFou2Y5WrqbiQoaBlUW0swu3zj1/saM+M3RJfVvXYiUPGLoFugcLOZKXQtYRXxnja
	DtbjSy3patKTDdV7GmtWUsVbqhuH3pH3ABlei/nzyQN++i4lW7fZFzfjwlrxw/JtA2cX/zTgfBD
	4MY3DORdArio63VkCr9YhXO0UxaW6CrXN8DjoPQhkJ21PeFiUFAtScGBqk64MduQ/LuyTdmbCrM
	82/ZOi2190UFW6aP4+GeFi2aaQsQjBa4lQz8LpdJ6KDRNPkyf766GwMlimyxEPcNF12RhUOvD0t
	baf4n9bonSu+iRTqI0dMXTxZU0SSn9pY39ZDdV12cAls27KLW1rWpxPSycLhn2iO/rEZ1XIGky9
	EQSNbLQek7Kfg+XcGi/j+xE76DBBvqpIB5DuJBhbUlAFGXzE0xr43
X-Received: by 2002:a05:690e:1183:b0:671:61a:eafc with SMTP id
 956f58d0204a3-6714dfc990amr984009d50.2.1789394259157; Mon, 14 Sep 2026
 06:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com> <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
In-Reply-To: <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2026 09:57:28 -0400
X-Gm-Features: AcwNN1UlvJrqDr-FHzd6LRUOZnDSIpfdPmPIufIaHT4FMUT4Dsw_TxMkpXL_CEM
Message-ID: <CABBYNZ+ZUXkSO6ybT03vRCE_1Mwzm1hkbHqrndm2qL0mTLh0dg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: coredump: Fix skb leak in
 hci_devcd_append() stub
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Manish Mandlik <mmandlik@google.com>, 
	Zijun Hu <zijun_hu@icloud.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Sun, Sep 13, 2026 at 11:43=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> For hci_devcd_append(hdev, skb):
> it consumes the skb when CONFIG_DEV_COREDUMP=3Dy, but its stub does not f=
ree
> the skb. this inconsistency causes skb leak when CONFIG_DEV_COREDUMP=3Dn.
>
> NXP btuart device driver encounters this leak:
>
> btnxpuart.c:
> nxp_process_fw_dump(hdev, skb)
> {
>         ...
>         // the skb_clone() is leaked.
>         err =3D hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
>         if (err < 0)
>                 goto free_skb;
>         ...
> free_skb:
>         kfree_skb(skb);         /* frees the original, not the clone */
>         return 0;
> }
>
> Fix by freeing the skb in the stub to keep consistent behavior.
>
> Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  include/net/bluetooth/coredump.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/cor=
edump.h
> index acc1849f66c0..07940a1d5dd4 100644
> --- a/include/net/bluetooth/coredump.h
> +++ b/include/net/bluetooth/coredump.h
> @@ -103,16 +103,17 @@ static inline int hci_devcd_register(struct hci_dev=
 *hdev, coredump_t coredump,
>
>  static inline int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
>  {
>         return -EOPNOTSUPP;
>  }
>
>  static inline int hci_devcd_append(struct hci_dev *hdev, struct sk_buff =
*skb)
>  {
> +       kfree_skb(skb);

I don't think freeing it here is a good idea; in fact I think the bug
must be fixed in the caller so it properly frees all clones, etc,
actually it may need to check if hci_devcd_init fails and stops
cloning and calling hci_devcd_append as a result.

>         return -EOPNOTSUPP;
>  }
>
>  static inline int hci_devcd_append_pattern(struct hci_dev *hdev,
>                                            u8 pattern, u32 len)
>  {
>         return -EOPNOTSUPP;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
