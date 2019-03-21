Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E0C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1588218D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 13:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGILjlFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCUNxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:53:49 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38111 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUNxs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 09:53:48 -0400
Received: by mail-oi1-f172.google.com with SMTP id w137so4681307oiw.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2019 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OqXlgaMcUNnhbj+a/8pU1Old+HZvDEvSvTsFe3+gASs=;
        b=sGILjlFNWsgMLCWaDZwY3WddGiw8swlw/sdQImDsUj5IpWDQU40WRBw1o73cn7g4L+
         NpO0QWFT1nsuRwDnQdPPWDFoGfZY3Hae0gxbFy4Jt90+NojWNxYPeeIVP48/zsN2Cd3i
         bR2up2sVkHPIkVAob0ayLR332fs0X+0xMXEMJpiDUZGJuEPzKzsmeslgsFPFzOVDiBRN
         Se1rSHrmPmuOQRs2Az/UUJlm626ixhaO/cMHzxJ716cAYWfCiDY62kc8X5y5UlVjm90w
         tvLLxcST/FtsU1P/xjpvtPDXxcu49L5yNTmtfma6NEKuGNZ9lhUSzbO3ZQfY++yE4YcV
         T+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OqXlgaMcUNnhbj+a/8pU1Old+HZvDEvSvTsFe3+gASs=;
        b=CzJPej7Wtk3GLrTWrhMeuWaZConrgp22AwvYIq+C9qGF9RGlT66ZGAFHi8F2/4mLVY
         VzcN7Pc2P31/CBkibVP7QILjnkrk1LhYT+HMff2WTe4MmMMT5xUhATNmJaRVLYA1MEM8
         Xr4zzhH+Rd6EgCN14VUYDUZYlRRfwMrgXMZxqoAOCz8jDFxjrADDSa9CB++DXX45pIe0
         pKEgZ3EpG/PUuhT5iQlmj6n3Vq2QDstnafkTu6wE+TvrokdtuOwJEr5RuiEZDVUu7OWw
         XCT6iX1hfurTg270W9rQ5lCOFN9Dey98vchEzB+iH728WkUpOVh7xHYK6ofFJLnj5oyy
         BV3Q==
X-Gm-Message-State: APjAAAUzb70ZGVJUH0DLzzzvP+NGLwgjt413UGsYlxcrrufcmyWoleJW
        1XiOpKfAutSwrYRJ8EgzqVxhk6+O2HbINcVLdnMZ/JxwmAU=
X-Google-Smtp-Source: APXvYqyZ6IZ6BYWn+gTejTQawLQvqYvHR5rfofuZ3JFuQ2ep8q5xGFAaSHyxCIKrJShKElq9nMqntXUHcNpvsvHfWOo=
X-Received: by 2002:aca:4344:: with SMTP id q65mr2063663oia.156.1553176428147;
 Thu, 21 Mar 2019 06:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
 <CABBYNZKOisJtGZV6fq7h58yhHvw=B_9BqiNLnwgMAP8rdM2jQA@mail.gmail.com>
 <CAGuyqoFbadJA_2U_s15ZeNUS-Rb12XL76eCmAh=9GFXbdjaZog@mail.gmail.com> <CAGuyqoHhtZv9ixyn40kotbK+cMbKgp6KZt1EYVPcRS+_rTv4=g@mail.gmail.com>
In-Reply-To: <CAGuyqoHhtZv9ixyn40kotbK+cMbKgp6KZt1EYVPcRS+_rTv4=g@mail.gmail.com>
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Thu, 21 Mar 2019 14:53:36 +0100
Message-ID: <CAGuyqoHhh-pDgsz-ZTMYhb-FY71JiFaMVHvNCHSf5iTo2NG6eg@mail.gmail.com>
Subject: Re: BlueZ 5.50: Avoid service discovery in every connection
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sorry, I meant I do NOT find information in the cache about the GATT
Characteristics of the remote device.
