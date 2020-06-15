Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE322078A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aXE6YXVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgFOM4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgFOM4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 08:56:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B9C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:56:42 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b27so15512680qka.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=is7gHbrLOQTvEbnq2otXTKp4TjezeVuh0Hz5YAtbsjs=;
        b=aXE6YXVrIddlkJtGCuK/69+GAxGGF0m5rf+LNKMoqk2W0T5WamtfKGfG7/Ix/OI2Ju
         z1i3rYDKxLTLK5eyzvZ12ZHuLdADWFGkIAOhve0bcWe+orVIH8nCyhUQmCwBYBvY5f52
         sjPDcWZLJAbi/Y5LwdOVpF1f53olOL2M66X3oY0Hf4jj330qDbB3S5qem8CKMxfqW7Fm
         1WVAiFgyqu+n7eUpn49dyFR0xn8b7UnkY31o4Xh2JCMCqphJqQ/gL/gek579GEoeqnxX
         AYyk72YZ3f3Uv3vSiPRdDwb8SXIP1VEvZA/QUfgSbj6TSBIwUaQOd2iu0sMx7pDrUGI1
         VT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=is7gHbrLOQTvEbnq2otXTKp4TjezeVuh0Hz5YAtbsjs=;
        b=FdnUXmHbTwNAHMSCPwcVdJ8ggVoTenPr/08TFLGyEky7IUtJCJicNgwXANMPZuewYf
         nRS6Zq1gkgulLe1fP1LX2vIto1brbb+nX2PtWvEgkkyh9EdEuI8/LFslKstl+7PfuTXY
         2v7sYzq+1G+I9sHzjOpwkF7PHabtyty2T8bhaJBh08IMMQ5EvWuarJBKHOJHH/US0yZp
         r8cYjKkufEKnBiZqyLe5L4eaMqHCjF+YrcqscgSn6NgnR6ov3e2MDWXlG/XEQRdYv0kC
         JYRnzJkyJ4NfHugePRPZ61sVXLgNrA9pYwPXOA7uhJPlPj5chMe22RJ0jhzPQGDuYbWu
         dI0A==
X-Gm-Message-State: AOAM533Hp5KKob8uIMqGfG/iTvQYt1cRMzaBGmcl4n817RQbYAWCE/Xr
        dy7GQ3pZa2rXWRPnRiht97vA+swghuMK1tJ6H8KoVDluo2Q=
X-Google-Smtp-Source: ABdhPJwLlfjMt17MOkaEj1jZPZegR2tB2Rb/FKojOFwy+pNdFHeBYJ9f3xj0lnUOJMtVgozhb5wq0ZLNKqDEwYdQi8w=
X-Received: by 2002:ae9:e118:: with SMTP id g24mr14265314qkm.116.1592225801561;
 Mon, 15 Jun 2020 05:56:41 -0700 (PDT)
MIME-Version: 1.0
From:   Azizah Ibrahim <atlantis353@googlemail.com>
Date:   Mon, 15 Jun 2020 13:56:25 +0100
Message-ID: <CAD3XXH7Yfnz6OCE9a=Yseh-nSVvSFsaG-ACfN39n4k2o8r0-pA@mail.gmail.com>
Subject: LE Audio
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

Would it be possible to let me know when BlueZ host will support LE
Audio (Core 5.2)?

Thank you
Azizah
