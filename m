Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A838DC6A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054726; cv=pass; b=K0JQQDvsHfQk3IWwYDlqNBM0OOHPExUnocsz43AHejTxNq+5HQbghTVQ4MDPq5L57U3GwBRBel/rGUKKaLBY72amYs2XhcTByIFaAPb8hc+2G0Ue0h4nBf2WDlB9frwAj7nDYOM8I7SJaUPZRwISJAN3iloNxLbLGGwTSq+oP+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054726; c=relaxed/simple;
	bh=URmlO+EoAEJicOWMjquP6tOAtrvwmlKFbsXG+rYPkI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZFAPPDWyKc2gqFxRxUV6SKqrgUwrPOULZiadrw3iqd7iytAiFjM25MQCM5dad8uZiFSEV4H8hn7axoVLSMWVc6wSDvujVBO8i4W8MaWRNL/jB+gqNJgQbQkA4S1FjhIph4KYEdG83AYJlr26qcWMxwW4aoJ9LX6PayM4d8Dovk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBVPHkwd; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBVPHkwd"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-871c8a36fe3so84646177b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054723; cv=none;
        d=google.com; s=arc-20260327;
        b=LjnOM7XPlXu6rOgpoCTRi4Mwe38O3xd3wWMX2Tzd/IAibWcf/Vh6JcpuQNgo9tLZk7
         Ei0z/OByQmGUkpaEoH3Int2AkgFsBhE/rnC7AISO46WYo6ZNQCDNLNYVn58B9/mrxKRo
         qdI+RfY4R9I1vbx6s1ksLP8zAh6IcoWB/JQwK2Mt++1iDmVtWBZFLRE8Wn44X+EKJ3rU
         45e6bCclFWbGQ6fDOa5rC9kGOjHz9xK/aDalpGrNiLcRQgUeJ5hTXIRBXReT9QQ6lItV
         vUpGMAtKFn3XcKdPQtPhV17qPJ34frepGTF6EspbbGUarhgvv5AYkoNMPNRLu/MOi1/7
         kPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBAKmcjb5ocMGP/6wzLbwk9f9eHsHJ1cNNNXholeTXY=;
        fh=JSznKSo6Fxp5mxQrwCrkeNJvF72t4/PklVU/mvwYy8o=;
        b=XPxg+ArPMo34uC1ogWpk9GItvcR+oJMrbzYu/d/fOcA1N9mza53U/9BNSlVY/AQBJo
         Y+gIHWbSeSFHtGkhr/NMby4jiNXQlSadCNzpkBtiYEGmvteHKuAx+S3T8lKC1KchAoIy
         Vj/3TwEoKrpW38mbgMDGpe37fHQwYD3sTNrk1zmRW0U9Qg1EsKNvGy/wih1tZJyjVYwi
         7AC42DJRILD+BdNuPsKRFFFTaHUr36su3QAIrxJFpJfxU++8rWVt0JFlEaNK2rME9xJ9
         WtdBiu5LMZaohF/IOz2HjIXb6onGbcQcAGMVOEr5qaCDguqBkx2ToPxmpDupoWDMYscc
         Edgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789054723; x=1789659523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iBAKmcjb5ocMGP/6wzLbwk9f9eHsHJ1cNNNXholeTXY=;
        b=bBVPHkwdcJmAuMPq2m1Y8uY5840rcsB6gaKvpAeHcAsrbz9UtgKGdQ6S+sB2Ua8Nlq
         S/VgTHZLwqrfzMsBUDgS3ZWk3GsJQJk2HAX6SDUJ28XyNxVztOqvOBjLGjxFeeKEH1CM
         inB4jHqLPceF8WdsNXslOelbzQZTQOU7Bbzp/6S+7iMpXgEG34zeDvrKLv9/eLmSslc5
         4wavyHId8nNRA1vBZiHIyKFUji+WFl5MSyTpkQkbgaA5pBg5wr7pTNCpwKF2lg52hBOH
         99jmt6loMbuoWS2MtLifvYMWC/xGJQ93RLhb2+A2RE6yZ6rjuRwio7UzAferi+m8ugZ3
         ZtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054723; x=1789659523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBAKmcjb5ocMGP/6wzLbwk9f9eHsHJ1cNNNXholeTXY=;
        b=oEd+T/3FuA29Ba3ogwoeuEUB/A78dDgw6lmCXa85jF7abqZcauweRBGI0Rjlpq6k/t
         Doe0vvovdGdPpQbVCXi1ATr2PGJOhksh0ZfU+m8y5LcH32lP9UWd/dDcPGRxoyxLNSWr
         LE8LrZsT0DrsNXOYFixB0KInN+CMEIPqrChGZPzCg0lpKqJ4u00Mkhz6NlULo9fUznSB
         CKif/Cok6PgNLxav1kiKXQ7k2dmoYK7eVAr5GBzzG2BfOdrgChFpAeP4CjEm+9AmfG6l
         UtmVSFp3M7VBtLQjOoEFC7sM7BRbc1MJiBw7r18ZK+c8FHyU6PEiQk4tzXHLrTZ283sK
         yvww==
X-Forwarded-Encrypted: i=1; AKwUvBxJg5wp95SUwJcMDvLnBvQ75nvlYbT5Ia6viEzG7aVXhno4bWoMZbJi+NmE6js4SB0ONcAAfz1RAAVQay9l3xI=@vger.kernel.org
X-Gm-Message-State: AFuF++mjKy/Xmj738slA8eniHP/S0KvEp1XVA9MRg2qq5oSvqevLWx+C
	resIPZeXPhdCu17hV/QMpk7zn+EB5kfiMXllOftx0G1GS8U6tUQbURA7kxlH7B99KGJ3188l5sM
	C2i85X3D2FPnjRwop6Le4hxquxFiDzTc=
X-Gm-Gg: AYBFou0glh74f9Z3gOqhaQBzdGERlsErI9LvkJ5Z3NYzKpNpxizlrES4vaCX/6d58Ay
	IQNDEm7Ike2Efp3lpavSsEdI6gaC6kNszteQUZfdqrB2wL37hQWiz7cLe6608viH/TwF9RdK1rf
	AWnMNVosiC9cSgqYwWFFcynyULoZ1TDokllGFicJB64grdZ4Rq09Y7LbNGeRrjSid4y1xr6P3+Q
	c9lrGvHQnV/uuuW2T/daS4iKeQpaFoyX54n6tiTIeD1yU1YUupGG1TRBaVePFk8RZtNKl9QmGzN
	h6dqSC5T9uw01EMgV/jqdxlCN/2rHnitwkO99ZcVstnG6/4SYQXnYS8OFGlqjnXKm1FVTaBdWP7
	hV3GtqjOjUKVrBa6lASJkwMbWWxz4mRshJnMfo/zKAQ==
X-Received: by 2002:a05:690c:e0c5:10b0:81e:6a10:f90f with SMTP id
 00721157ae682-8712a228f92mr127550027b3.17.1789054723044; Thu, 10 Sep 2026
 08:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
In-Reply-To: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Sep 2026 11:38:31 -0400
X-Gm-Features: AcwNN1VPh33tL3sVlU_J_-VwtCGjA8358iRNI9Zj9P6chsWF1NydzrXIvNalAg8
Message-ID: <CABBYNZ+Xn2+9R7F_+9S9+SHeYm9pgtaSoS0=O2JA2bdtzfoang@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Sep 10, 2026 at 10:35=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> Hi Luiz,
>
> This revision addresses issues reported by Sashiko [1]. Fixes are listed
> in the changelog below; false positives are addressed as Q&A further down=
.
>
> [1] https://sashiko.dev/#/patchset/20260907-btusb_qcc2072-v3-0-1f65350b03=
b8%40oss.qualcomm.com
>
> Could you take a look at this new revision when you get a chance, and let
> me know if you have any further comments?
>
> False positives (no code change):
>
> Q: Can an empty vendor packet cause a NULL pointer dereference in
> btusb_qcom_send_frame()?
>
> A: No =E2=80=94 vendor packet's skb->len can't be 0 here. Both producers =
of
> a HCI_VENDOR_PKT skb already reject zero length before reaching
> hdev->send(): hci_sock_sendmsg's "len < 4" check for userspace writes,
> and hci_send_vendor_frame's own "!len" check for kernel-internal senders.
>
> This patch series supports Qualcomm multi-subsystem QCC2072. The first
> 3 commits are simple dependencies of the last one.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Changes in v4:
> - Fix memdump timeout blocking btusb_qcom_reset()
> - Fix missing build information on driver rebind or resume
> - Link to v3: https://patch.msgid.link/20260907-btusb_qcc2072-v3-0-1f6535=
0b03b8@oss.qualcomm.com
>
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
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} |  127 +-
>  drivers/bluetooth/btusb_qcom.c              | 4542 +++++++++++++++++++++=
++++++
>  drivers/bluetooth/btusb_qcom.h              |   99 +
>  include/net/bluetooth/hci_core.h            |    5 +
>  include/net/bluetooth/hci_mon.h             |    2 +
>  net/bluetooth/hci_core.c                    |   45 +
>  net/bluetooth/hci_sock.c                    |    8 +
>  9 files changed, 4843 insertions(+), 2 deletions(-)
> ---
> base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
> change-id: 20260824-btusb_qcc2072-abb918ab4220
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>
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
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} |  127 +-
>  drivers/bluetooth/btusb_qcom.c              | 4542 +++++++++++++++++++++=
++++++
>  drivers/bluetooth/btusb_qcom.h              |   99 +
>  include/net/bluetooth/hci_core.h            |    5 +
>  include/net/bluetooth/hci_mon.h             |    2 +
>  net/bluetooth/hci_core.c                    |   45 +
>  net/bluetooth/hci_sock.c                    |    8 +
>  9 files changed, 4843 insertions(+), 2 deletions(-)
> ---
> base-commit: 1b737f2ef1686d0e5a7661eaeb097aad53ea7040
> change-id: 20260910-btusb_qcc2072-7ad665e4560a
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>

There seem to be some new problem being flagged by Sashiko:

https://sashiko.dev/#/patchset/20260910-btusb_qcc2072-v4-0-e78f04b7675e%40o=
ss.qualcomm.com

If they are false positives, please add comments so they are not flagged ag=
ain.

--=20
Luiz Augusto von Dentz
