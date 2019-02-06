Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A15C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7347020B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWh9mvnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfBFLuA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:50:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41006 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBFLuA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 06:50:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so11309483otk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Feb 2019 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xGlQp1l4+DO+cKstVINtg1I0Sv98thEIDwZsjJZEhB8=;
        b=QWh9mvnWLz8Y55eKRw0fXjJXqUDzdhKdYo6bIo6g/X7HMewPIyC4+38AAJylJLHj/v
         URnX+R1RwlAUyptZhsaXgZhoE7DXETu4fJidMRo+9WfLZX8I4UA6Sfac0fkZT0vpLLL1
         meJgfyQ0Xj5e3491GKxbws0m/R7ug6YbUa09utI0QRfB16eEihNXuFAmpr8idwXxWNuP
         CQaGRql+PU3/ZBCb7Uw0Z8p4U+NbqlmJZ7X/qgrCrSWbzo/aCYIwXa2UmDN9WNhSsNQs
         UHXwoEBr3TEyZm5mX8nLRtcLqlE6aih182O+sm2ZF3ppODRsvgOI8BTcoF5pzkRxs43w
         2LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xGlQp1l4+DO+cKstVINtg1I0Sv98thEIDwZsjJZEhB8=;
        b=MRE9iQCxsNYDuKiTpcYR8XAbOHISGZ4oa0ilZLP1O2ksIjJGUfsBbSeevIL2MA0LZj
         Vt/xyCZRED3F/uM7YS03BlirPiiu/lGgIWofHn8H7wYt3D4Tvqc0aZefjRs3npoubRCz
         gMVxBnK9rQ3CNgNH3uVTeZ1eHQaRuVot4AOxn5VEXhLw31x2wccgwiXzDbw2V5epVp4t
         esmVMkvf+3JLqTKrDWyJR9Jftv/2pnKnk/XhcTLtDv5sK3VYbB/NT04I9rSInSUjIczs
         RCKrk0+vOrhaA5o++HUabbgpecpGI6agaA1/ZMDWvruWW2jKtAkr4u+exRUPFPop9NQb
         4ZRA==
X-Gm-Message-State: AHQUAuapOH2fCzL/8HpoUHg1EX89hXYEyZvPRpfqkMFvM4ey7E5xzODR
        TBZ2Yaz6qw/M0TNxV54Rb2WTuk6Z3YzgvqiJFhP1Nw==
X-Google-Smtp-Source: AHgI3Ibj8Xnl/eEFgiHn7e8iwtY9v34tQoHF6nu1o53d2CGi9HOtSW6rnqFV+fEfBTldc3WXXKM75LefbIMsZJXk8is=
X-Received: by 2002:a9d:63c5:: with SMTP id e5mr2884785otl.291.1549453799129;
 Wed, 06 Feb 2019 03:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Feb 2019 13:49:46 +0200
Message-ID: <CABBYNZJv=r2rxdDjb392F=cBDtmn+=vfY4tL7dgDAse95Sw1Rg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/15] shared/crypto: Add bt_crypto_gatt_hash
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Tue, Jan 29, 2019 at 3:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The bt_crypto_gatt_hash uses AES-CCM to create a hash with the contents
> stored in the iovec.
>
> Note: The spec disregards the byte order so both the key, msg and res
> are not swapped.
> ---
>  src/shared/crypto.c | 31 +++++++++++++++++++++++++++++++
>  src/shared/crypto.h |  3 +++
>  2 files changed, 34 insertions(+)
>
> diff --git a/src/shared/crypto.c b/src/shared/crypto.c
> index ce0dcd638..5c5e1217d 100644
> --- a/src/shared/crypto.c
> +++ b/src/shared/crypto.c
> @@ -688,3 +688,34 @@ bool bt_crypto_h6(struct bt_crypto *crypto, const uint8_t w[16],
>
>         return true;
>  }
> +
> +bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
> +                               size_t iov_len, uint8_t res[16])
> +{
> +       const uint8_t key[16] = {};
> +       ssize_t len;
> +       int fd;
> +
> +       if (!crypto)
> +               return false;
> +
> +       fd = alg_new(crypto->cmac_aes, key, 16);
> +       if (fd < 0)
> +               return false;
> +
> +       len = writev(fd, iov, iov_len);
> +       if (len < 0) {
> +               close(fd);
> +               return false;
> +       }
> +
> +       len = read(fd, res, 16);
> +       if (len < 0) {
> +               close(fd);
> +               return false;
> +       }
> +
> +       close(fd);
> +
> +       return true;
> +}
> diff --git a/src/shared/crypto.h b/src/shared/crypto.h
> index 1e1b4836d..c58d2e104 100644
> --- a/src/shared/crypto.h
> +++ b/src/shared/crypto.h
> @@ -23,6 +23,7 @@
>
>  #include <stdbool.h>
>  #include <stdint.h>
> +#include <sys/uio.h>
>
>  struct bt_crypto;
>
> @@ -61,3 +62,5 @@ bool bt_crypto_h6(struct bt_crypto *crypto, const uint8_t w[16],
>  bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
>                                 const uint8_t *m, uint16_t m_len,
>                                 uint32_t sign_cnt, uint8_t signature[12]);
> +bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
> +                               size_t iov_len, uint8_t res[16]);
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
