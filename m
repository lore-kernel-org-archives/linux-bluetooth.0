Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D7560AD1
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886340; cv=pass; b=jbCTSypXr8TDZOqAUBMz8ENS46JtCg5iRKGBg3ESwqaQrIlFWxKuD+Wafb51v1gBvZmEyoNoAu259apZfApfZer9s2QJRl4YyAPkDaa9pLSHMe4wup9h1/PmRsHMeRSaS5XWWAVu1RSTkv8u5d0lIktGi+H1YYEonqYZ3Q5ttv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886340; c=relaxed/simple;
	bh=RFLo/c30RnwMfBUuWCBomvpXL9tpZs91lqk0qum8yAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME5N9BCQ5Zzqy7e6iplEjKonAlAX+wB1Uf4vDbI/kJvd6wH9EEE/V49tfQvIJdUfDbvHThxRxyAe5AXzWwJOCxg5oVgsMvs8iGdYZbsGsFXvK4i+5wLPF/oa0A5N3UHaHbFsgRBnFTMLdyGeSiu3RqFaTPffNOP49gCfGjzYPfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr0dRsjo; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr0dRsjo"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-87c938111a7so8127237b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 09:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886338; cv=none;
        d=google.com; s=arc-20260327;
        b=YF68MTXBYUeAegydbKFzYO+vVsj7z/CosiY5it8QzjI6e3BcNdIjGPcOoC0pAuB9MX
         /3OcY+uK8zGdwWbwNimEitDR/jeid3iELlBCOQjVNVFzU2RX+eBrHbSJ7E6LFdOtfBhJ
         VaZZNd8LQurZphD5xldmziJSwFeCiGI4VKV8pppwHrk9SYOA5/15dodUOdzML2HkDPTK
         kM0/8nMlyaakqchOixFJ4ukyJnDf3Y/yWV0q9DjU5dfLAJW82jlzNm1rbQ+j4CLEtMV3
         Cgm+J6e6PayUN+GopG2Xez3AFI6mlr/+/A8ShjlEmuk9Y9WpI1BUxC7OWkb7S+j2v7SO
         Rnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STWPWl7tcjtucuQHNVQpu/hRSscdkOJCyxMFTbnlkQs=;
        fh=tMRFq+0XHqfCc7LZ0O4PK3M09oWc6O0sVUiT/dKXZcg=;
        b=LL9X3y8UqPVPSs7EK+nB6XYkXYfuYM1wUBK8jlla+R31WsvgdrTAYnJdvzBYVmiudK
         UJFyBNP5DlvPncxp3rtLhc0SCLVmTy6SgSUQw/G47mxjkpzNOG/YqlhB0XJbB6OK6trS
         dVazFsN4Bdvtvcyoy7zLzYkS7OtKh4n88PwAeULixB6kDacCoOqGvbbLfx8UKLxBVgXt
         Hq97OAQ5QCOQW8nTGC8vckBdW6f8LFak3+x4AzVaJqgA18I/Yllrh9evDa69/t+W8FVe
         nx8PfDJbBpjv6ahUNmIFa8FBVDK38iXyrn90gyGt7Cr7nxds423RPregUPXg07zEOiqG
         NRpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886338; x=1789491138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STWPWl7tcjtucuQHNVQpu/hRSscdkOJCyxMFTbnlkQs=;
        b=lr0dRsjok4EVXmHAbHapvgP9Lu20Ndp4QMk5nHdIdJmJEUQOqZImnrp2lAC9iL6y5h
         NON+VytyJR59tqi+iVpQdofdwpC7Fye/nl2aTBJOIpBW5miRyHwW745Ts78a1GRMFyjY
         ShnTnJOZBFB9MKPumi7S11Ysb7EUbiWxszbtkwL+NfWoOdcHID/Dw3gadVNpoJrDiMuF
         bQ4HscJU4KBYJ3FReNkxn9vaHkOzn4X6c3FQ/9iOMKOsqTNgHb/a3KhUJblKHYKdQCCS
         J1swVHjf/Din3MptBTwytTRNhR74zeZeM78g14YxX5UvYhYGESrvhKo41G6hCetusUsl
         jTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886338; x=1789491138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STWPWl7tcjtucuQHNVQpu/hRSscdkOJCyxMFTbnlkQs=;
        b=gjDoFhRvh2tIBcn4a5xGahnOpMF+KQsx9QLTvOmuIvfXX3AcEjHcLlPP8wjmMjl4E1
         mAvxCruNiGamsXshbpeM/fAEJjJfidapwvrrdGztlwacVG7G4uCOGVytFdsgCBHcNHj5
         IhBPhKl+BOH4DVFClZ8Mdq32I08S5UuyzEUnBwD/hVYfM1DrqmCl+w9B/R7wS8eWAMxU
         Q63YJG97UON5IAHEoSEF4/adAt8LY6IWrfyMEIiduJi7T5o3deYE5EHqHInd6f8Bm+jq
         G7xSzWruIjv+75RShWWPPaDApGlhjH8uvcjxfvzTgtxIW8LvjCJHrT6ZakUjLBI5bTss
         PYeg==
X-Forwarded-Encrypted: i=1; AKwUvBxfSo3UTMIFnCM1lLUuX1JuhG7HlN2rAwyDtns0afiFhpSWge3Ia76rpByA+savRoUv1Wuw3USY7B9TzpnNFtU=@vger.kernel.org
X-Gm-Message-State: AFuF++lx62MHg9lJeNQ8CAQ9Jky+mzLeGy9kGCo0VvJ/TVVWXLCkRiMM
	Cyl8/3L770Zm1q8OWLz84V1XrnGfOcaZwlsKFx8bY2NTr3RVlpT1VAqAr5liE+rT4YBclF3pdl5
	S++ijXPRwgvHVO85GJE9rKIJ4iONKdQk=
X-Gm-Gg: AYBFou2COgH7gjMvC169ruTYlIe62xarHedCQ54kR+mKx4Rdap1egLcOqQGq1GyegA8
	CRhTjjMiqB1VQQj1j4plVaEkxq2124IUjAgS/wcsgveVmnraVf+rbO0NolTE5IRhnNSBugi9q26
	rJyEQnicyy2fgQgnz3dfQaxBNQ5jd2LkL/U5PYyRcvQmuhNEXy7qg8jAG50r/UzQ7LSy9vRkFkH
	F6JErV74llBf88cU1koq2s8DNZi2zMn92iThDXAPVu+cGPzsGsyq98ms5oIRCDGRsUt9EHVqf6Y
	ykWi7qx1MpzADSc4qWisWy/7xcWopA66ZkFW6ZiEE30WnVwmuBrtAeUyUdEFBaQDGAN60a2wZoL
	W0eiLgmyGTFPvoT4AS4eFCiRu6s1d3yk=
X-Received: by 2002:a05:690c:e297:20b0:870:ed34:2880 with SMTP id
 00721157ae682-870ed3429e6mr76477807b3.13.1788886338275; Tue, 08 Sep 2026
 09:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
In-Reply-To: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 12:52:06 -0400
X-Gm-Features: AcwNN1VOCIt3sE0BX0rlzhyvMWwTxZtmr-A9s8oAuCxpg6Qw_iufvQTIhDARuvU
Message-ID: <CABBYNZJdJ9Tcv0Yvi2WRvOgKXc5ghLubMArHuPFdArd6UweskQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Sep 7, 2026 at 4:45=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com>=
 wrote:
>
> Hi Luiz,
>
> This revision addresses issues reported by Sashiko. Fixes are listed in
> the changelog below; false positives are addressed as Q&A further down.
>
> Could you take a look at this new revision when you get a chance, and let
> me know if you have any further comments?
>
> False positives (no code change):
>
> Q: Does this explicit padding with null bytes break userspace crash dump
> analysis for btqcom_submit_memdump()?
>
> A: No =E2=80=94 this header is internal and appended as dump data. Its fi=
xed
> 512-byte size is enough to delimit it from the dump data, so it doesn't
> need the text end marking like the external file header.
>
> Q: Does mixing goto statements with guard() declarations in
> qperi_try_wakeup() violate the scope-based cleanup guidelines?
>
> A: No =E2=80=94 all the gotos happen after guard(spinlock)() is taken, at
> function scope. Since every goto stays inside that same scope, it
> doesn't violate cleanup.h's guidance.
>
> Q: Could this cause a kernel panic if a zero-length packet is received
> for btqcom_recv_vendor_pkt()?
>
> A: No =E2=80=94 not reachable from a socket write, recv_vendor_pkt() only=
 runs
> on the RX side. And skb->len can't be 0 anyway: btusb_upward_frame()
> pushes 1 byte onto the skb right before tagging it HCI_VENDOR_PKT.
>
> Q: Can this lead to a null pointer dereference on the transmit path
> for btusb_qcom_send_frame()?
>
> A: No =E2=80=94 skb->len can't be 0 here. Both producers of a HCI_VENDOR_=
PKT
> skb already reject zero length before reaching hdev->send():
> hci_sock_sendmsg's "len < 4" check for userspace writes, and
> hci_send_vendor_frame's own "!len" check for kernel-internal senders.
>
> This patch series supports Qualcomm multi-subsystem QCC2072. The first
> 3 commits are simple dependencies of the last one.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Changes in v3:
> - Remove socket option BT_RECV_VENDOR_PKT
> - Fix heap overflow in hci_send_vendor_frame()
> - Fix a stray NUL byte in the memdump file header
> - Fix PM reference leak in btusb_do_reset_work()
> - Don't mix goto with scoped_guard() in __qperi_tx_sync_evt()
> - Don't mix goto with scoped_guard() in qperi_handle_evt()
> - Prepare btusb_qcom for bulk serialization mode support.
> - Link to v2: https://patch.msgid.link/20260830-btusb_qcc2072-v2-0-5c0e0c=
9dd98b@oss.qualcomm.com
>
> ---
> Zijun Hu (4):
>       Bluetooth: btusb: Add recv_intr() hook to btusb_data
>       Bluetooth: Add generic support for vendor packets
>       Bluetooth: btusb: Build the driver from multiple source files
>       Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
>
>  drivers/bluetooth/Kconfig                   |   14 +
>  drivers/bluetooth/Makefile                  |    3 +
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} |  126 +-
>  drivers/bluetooth/btusb_qcom.c              | 4514 +++++++++++++++++++++=
++++++
>  drivers/bluetooth/btusb_qcom.h              |   99 +
>  include/net/bluetooth/hci_core.h            |    5 +
>  include/net/bluetooth/hci_mon.h             |    2 +
>  net/bluetooth/hci_core.c                    |   45 +
>  net/bluetooth/hci_sock.c                    |    8 +
>  9 files changed, 4814 insertions(+), 2 deletions(-)
> ---
> base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
> change-id: 20260824-btusb_qcc2072-abb918ab4220
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>

Sashiko flagged a few more issues:

https://sashiko.dev/#/patchset/20260907-btusb_qcc2072-v3-0-1f65350b03b8%40o=
ss.qualcomm.com

--=20
Luiz Augusto von Dentz
