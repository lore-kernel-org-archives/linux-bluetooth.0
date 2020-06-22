Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E4C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AA62073E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfJ+8W3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFVT3m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgFVT3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 15:29:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1818C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:29:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g5so14084521otg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HFs4X3K3vRuZflPTKMtfIaROiHEvkB5uzd9uWDqU3Io=;
        b=nfJ+8W3KqQOFWk7Vtg1knN0lmcbhecjC2C/Bv6deMmCcDc8RAVccmYwcRZ05HI5bPi
         j4YPanG0WxU6IKwVvaM8UDqGqWnGqe0kUSlCKLJF88Hleb/cDmxyIdLaBXN6cOto7teZ
         vkbl4CZbPG8hNU99ch0LN8hQKiPBnG2GOJfWOYhBjXr5LT7BxT/XiyIMZftJoslU8Pzp
         H2+wIhd9+4msai9b8UGZHa1YLIjjIlT9fjh06ORHWlGrUSxdeOeoSQ2a5SuFdeuz7iqp
         TEBukYUb/sI3YTV09zxL0OE6OckCG+VKZ/FNodsu6a6zlVBwRXtMlFfsYD/qOQ1/Tf0M
         p3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HFs4X3K3vRuZflPTKMtfIaROiHEvkB5uzd9uWDqU3Io=;
        b=Nc62qWz3cSLelw5nW9hHPxxetNTenifvR3p1VAuryczEvoItmdItgXvDxb0aFDKUEk
         G20LoKW8qbaocenkq78+Enggh7SjfVUP3PWRkKwrOSs3aDbdIPfsqdmYX17I6cjpUVjf
         9U+Ns0PC40BLpy/G87hOcpFPbhDZqnuzsxa3KuE9a0iljbxaz9IzTrAURnj607f+FfDl
         xAVZGy4AfcyKowgzGxrwTp24qG8schu4gAFMW/rPBl6keV5go7ijbnxIxxohfmHf8GSe
         /irgntcdc0yDbxWfVeb6ek620iAxWoBKFPBxRFHF7MWuQkGwuDNNBu3Yr0dhrS5qqNs4
         IWQw==
X-Gm-Message-State: AOAM5336UhTQrV872UoWNToZGm8ACYncEb13DJtGdL4QY0gwUI+V03xX
        6clZRIgxl2zIIHBFXEJowsDyDOLOP/mEK/RSagk=
X-Google-Smtp-Source: ABdhPJw9QiztMch7ZmRJ1ZgZyu5rmbU7zc7H5tXq2t00FaO4TLNK5IfHTIen8zT3ocEbaYBCU2gPKFVJRdVwfM5XNBA=
X-Received: by 2002:a9d:4691:: with SMTP id z17mr14916483ote.88.1592854180221;
 Mon, 22 Jun 2020 12:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200619225623.10200-1-michaelfsun@google.com>
In-Reply-To: <20200619225623.10200-1-michaelfsun@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Jun 2020 12:29:29 -0700
Message-ID: <CABBYNZ+a_PteA5zpUx_qWL-QFST9hLQnXY7HLCzu82fx_PFORw@mail.gmail.com>
Subject: Re: [bluez PATCH v4 0/3] Add new commands in btmgmt to support adv monitor
To:     Michael Sun <michaelfsun@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

On Fri, Jun 19, 2020 at 9:55 PM Michael Sun <michaelfsun@google.com> wrote:
>
> Hi linux-bluetooth,
>
> This series of patches add support for new advertisement monitor mgmt
> opcodes by introducing new btmgmt commands into a new submenu
> 'monitor'. The new commands are =E2=80=98features=E2=80=99, =E2=80=98add=
=E2=80=99, and =E2=80=98remove=E2=80=99. They
> provide the ability for users to query supported advertisement
> monitoring features and add/remove monitor filters through btmgmt
> console.
>
> Changes in v4:
> - Fix endianness
> - Use regular options instead of optget options per feedback, and fix
> endianness
>
> Changes in v3:
> - Fix build errors
>
> Changes in v2:
> - Move features command into submenu and fix build warnings
> - Move remove command into submenu and fix build warnings
> - Move add command into submenu and fix build warnings
>
> Michael Sun (3):
>   btmgmt: Add "monitor" btmgmt submenu and command "features"
>   btmgmt: Add command "remove" into "monitor" btmgmt submenu
>   btmgmt: Add command "add" into "monitor" btmgmt submenu
>
>  tools/btmgmt.c | 268 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 268 insertions(+)
>
> --
> 2.27.0.111.gc72c7da667-goog
>

Applied, thanks.

--=20
Luiz Augusto von Dentz
