Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02BE7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 22:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0WBJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 18:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0WBI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 18:01:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7780FB;
        Wed, 27 Sep 2023 15:01:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so191972011fa.3;
        Wed, 27 Sep 2023 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695852064; x=1696456864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ITScod0vDIBUawt6Tv12trYCl8zUPCwWwUD13fHVI=;
        b=Gz1zhHoFCVzWqyZnYnjJjddyEKHcF7lxk4YcdZeSCmTFtGrOSJsTSwLYaDS8zVwFgs
         B1OnLVG/b7/tcFQgIYE9VweykSoVqtrDSD+cccFVQ9TWGsBbee7/Ull4UmCfp8AKuI+y
         Joj2zWZZCs2UITHgyL6hMbeR0e4xJxtTWl1FOY317rhfQeivY1sizLO0id0BTJVTwHHa
         nkvCsft6UiZCm0gCrj7Qu3f972igGEvr+76Qxw5GMYwUNnST6ET42saFGPIGoW75qf6R
         fKHA2ddmL2VkjzEG268uSsnNMYyb+n/N2AQ5YwFNHsGCHFyN8fjuR1iQtFDx2+8hFwGe
         43Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695852064; x=1696456864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8ITScod0vDIBUawt6Tv12trYCl8zUPCwWwUD13fHVI=;
        b=ppcLtQ5u1kAFHgaupTxHMK/ZSJA60pekJ2zRz/8frJGkdL6uLcvCt+/3XSvaKSHOlc
         oRp88U5QpD6+lavRZ825bl7ZDvqObtJZcliTWErcvX/d2TNd1zcqnYZk/MP4ijBARwKs
         F+ECSDWNaHEcCTlAQfaS3K9s2kaleaFE/jTs5YuhL+mdvH4YKTTZ/mWiTrKuPDL5Y8lm
         PABSNXpmDB10po07eYteN4ciiXQQa9TTgcPRotW2aL1arW1nrSqlMWcWEwGeAUGKbG14
         lplue7fijisC4eQe9CRIcmCFIcZ3UK95UR8We0a1ZUZjudYx4lsKeL6wiijXtlxdTl8p
         ye9A==
X-Gm-Message-State: AOJu0YygTaC6mMy/8KYsDq/ugXRR176jFoRkpiLPc6mSIsHaFKhIJ45k
        0YDNkShNfKHKJC2h2f8qcnxbkbe50Gk2CNoIMO//V2PlWndz4w==
X-Google-Smtp-Source: AGHT+IGz+lwkUhRRZ4suBaYVlSkCf5qNKc3ngIEPXOqsxXN1SzlUlMYfq3pGi/EgkJrLllGFPiz1JP0uBXCJh7MTJrs=
X-Received: by 2002:a2e:96c9:0:b0:2bf:fde1:2586 with SMTP id
 d9-20020a2e96c9000000b002bffde12586mr3194217ljj.1.1695852063721; Wed, 27 Sep
 2023 15:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230920181344.571274-1-luiz.dentz@gmail.com>
In-Reply-To: <20230920181344.571274-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Sep 2023 15:00:50 -0700
Message-ID: <CABBYNZLxyLzJ2yNyOFvOoGvMPqMtEr5+6q5PYinO7aFvBe6SPA@mail.gmail.com>
Subject: Re: pull-request: bluetooth 2023-09-20
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Sep 20, 2023 at 11:13=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c2=
14:
>
>   net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()=
 (2023-09-20 11:54:49 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git t=
ags/for-net-2023-09-20
>
> for you to fetch changes up to b938790e70540bf4f2e653dcd74b232494d06c8f:
>
>   Bluetooth: hci_codec: Fix leaking content of local_codecs (2023-09-20 1=
1:03:11 -0700)
>
> ----------------------------------------------------------------
> bluetooth pull request for net:
>
>  - Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
>  - Fix handling of listen for ISO unicast
>  - Fix build warnings
>  - Fix leaking content of local_codecs
>  - Add shutdown function for QCA6174
>  - Delete unused hci_req_prepare_suspend() declaration
>  - Fix hci_link_tx_to RCU lock usage
>  - Avoid redundant authentication
>
> ----------------------------------------------------------------
> Luiz Augusto von Dentz (4):
>       Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FIL=
TER
>       Bluetooth: ISO: Fix handling of listen for unicast
>       Bluetooth: hci_core: Fix build warnings
>       Bluetooth: hci_codec: Fix leaking content of local_codecs
>
> Rocky Liao (1):
>       Bluetooth: btusb: add shutdown function for QCA6174
>
> Yao Xiao (1):
>       Bluetooth: Delete unused hci_req_prepare_suspend() declaration
>
> Ying Hsu (2):
>       Bluetooth: Fix hci_link_tx_to RCU lock usage
>       Bluetooth: Avoid redundant authentication
>
>  drivers/bluetooth/btusb.c        |  1 +
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_conn.c         | 63 ++++++++++++++++++++++------------=
------
>  net/bluetooth/hci_core.c         | 14 +++++++--
>  net/bluetooth/hci_event.c        |  1 +
>  net/bluetooth/hci_request.h      |  2 --
>  net/bluetooth/hci_sync.c         | 14 ++++-----
>  net/bluetooth/iso.c              |  9 ++++--
>  8 files changed, 60 insertions(+), 46 deletions(-)

Looks like this still hasn't been pulled, any problems with the pull-reques=
t?

--=20
Luiz Augusto von Dentz
