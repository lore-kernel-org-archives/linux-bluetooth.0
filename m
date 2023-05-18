Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79BC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjERRNp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjERRNo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 13:13:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5E1B7
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 10:13:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso23738951fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684430018; x=1687022018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T98EvybwX9kbmbfmGVNhvKLmPdw734LnNmS5r+OsSTU=;
        b=qod0zTB/SSjMhqS4yf1cgq1sOqsjjPI6VcbIem9jStxcp/pFWIxw3qm9g6emFRFzC7
         QIfknhjhjcaIhxr4wJnq2Xg3Kj/rPYZhtpwXUeVpPLlKRDlJhYfH9kO51hh0MXW6+4T/
         9rNTIpKdl90GTET8CHBMO3+2YjOxhD50gRGK2QDgQoBzV7qd0FkYqHHWBlfwgZJCR0vD
         MCTNB4U+WXljPoy2rABuY/iLNjNCgH8BoDwg25+YJK9X4wodL4X+p8KrUROYizskEEwZ
         A1Wp45q1s3jYovXgMGvWcxmXOpgr8TuieImHDuo7N5mFSb3tbWIbZVZTUkjRKoXYYSDo
         ZMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430018; x=1687022018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T98EvybwX9kbmbfmGVNhvKLmPdw734LnNmS5r+OsSTU=;
        b=EPRRlwTltBux3whRwozl2/eEyZS+BnPwe9gQCuDVIt0kRD6WzhqPCgWTiMvmORDMjO
         7HYe6yfz/fFCeH3yQBPMDISdinqAhseMtATWKcwqa3qL1N0CPQgsiZx2321YQUIfWIyx
         OeN6OtwRdOM++CKZSV269lDRq5WBsaIv47LhRWs3HfnOORNn3wpi8PKDpzw9+S2On5OI
         zwaNpS2JBcOIP4T6+SoATcsdDUhACk7cFzLFE2RZFvMN5cvlZJgDNQI0JQ+SxpDDIyyX
         Y+A/lTh98yLstwi/ahktjXnEcBrMQeUtf27KffvEe+LppwS+7e3DzeRGlJmtOqgqNM8z
         /5Zw==
X-Gm-Message-State: AC+VfDzkLKE2q/kodcPT6XuvSPG/XfpTRbwtgTyBcU0yqS46BpcvD4EO
        XRwnReXmZxVUoqvjA8NJyBuaRA0c+zd6VQy01t5NLbH8
X-Google-Smtp-Source: ACHHUZ7HAEsRG3PwRmYmcQV8Y07ImIoW3XfOn5NnPyCdGbwuve0Q2XunKOUI4ChuYLHuOSV5DhZ6m4eEygsmQoXMUBE=
X-Received: by 2002:a2e:9b97:0:b0:2ad:98a6:4af0 with SMTP id
 z23-20020a2e9b97000000b002ad98a64af0mr11181301lji.23.1684430017909; Thu, 18
 May 2023 10:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZ+mRgkn_PiL5=4NuQQudrQZQvdYqVuab3m_S7pRvj9YeQ@mail.gmail.com>
 <20230518071507.4640-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230518071507.4640-1-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 May 2023 10:13:25 -0700
Message-ID: <CABBYNZ+M7yS0tEcuoyUBoPnfqa3SiJ3z_nvTU+vLwHpCmSU_Aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Thu, May 18, 2023 at 12:15=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> Hi Luiz,
>
> Thank you for the review, let me better explain the flow that I proposed,
> because I think I should have added a more detailed description to this
> patch.
>
> I added the num_bis field to the QoS structure so that the user can
> specify from the start the total number of connections that will be
> opened for the BIG, but one socket will always be connected to an
> unique BIS.
>
> So the user will first open a socket, set the QoS options with the
> num_bis parameter set to the number of BISes, and then the user will
> call connect on that socket. The BIG will be created with the specified
> number of BISes, but the socket will only be connected to one of them.
> The rest of the connection handles will be stored in the "bigs" queue
> that I added.
>
> Later on, the user might decide to open new sockets, for the rest of
> the BISes that are created and stored in the queue. In this case,
> the connect API on the socket will not issue the LE Create BIG command
> again, but it will extract a connection handle from the queue and the
> socket will be connected instantly.

Ok, that makes more sense now.

> As for the HCI_CONN_PER_ADV flag, I noticed that it was only checked
> in the "bis_cleanup" function, to decide whether the advertising set
> and the BIG should be terminated. I removed it because now I am only
> terminating the advertising set and the BIG if all of the BIS handles
> have been assigned and no other BISes are in the BT_CONNECTED state
> for that BIG, so I thought I might not need the flag anymore.

Hmm, I think Ive added it in case the BIG was not created yet but the
socket is terminated then we need to clean up the periodic advertising
set since we don't have a hci_conn yet.

> I think it's a better idea to use DEFER_SETUP for binding multiple
> BISes to a BIG, instead of using the num_bis QoS parameter, so that
> I can keep each socket completely separated from information about
> other connections, so I will update the implementation.

Yeah, I think adding BIS on-demand based on the number of sockets open
is more consistent to how we handle that in case of unicast.

> Regards,
> Iulia



--=20
Luiz Augusto von Dentz
