Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BEC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 09:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA1223C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGVL3wZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDA1223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeKLTnl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:43:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40305 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLTnl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 14:43:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so7401593oth.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 01:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKDsHj8tIYaNjxBtwxyhOmhrgREZRNJyam0NGL2/994=;
        b=FGVL3wZtCN+s2OvNfVH6mHrHnhMLcOKL5SNjm1kNuA3wuj65QWQDYIWuoBDGPbf2Za
         SAbCnjMk52uutOxs2p3S0CAKZxdB6njDoEZoi+xotQ1UKlLxOFh8gFxhDgtBvjfqnejX
         yYijaNRShRo62i+SKqxMl+hYzo4gLa6TtMqBZXjEZmiXoj39zeHsN0HanEe6Dagpeoue
         e4iCZzbLP7KH+1ESL1XMt4huvsbuMXowDnMWhUgE8EP88wDQNwkzGo9DcCZkpPadB7RS
         de0b4NLrA2zZskTRFdnmWqt4HNMBc1PfIVe1pb7kW1ow2CAd6rBb5YDlIGzY6F4m1K7b
         W57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKDsHj8tIYaNjxBtwxyhOmhrgREZRNJyam0NGL2/994=;
        b=JMjUdjNKmLV+/Wt6VVbAidmy3cJXRlnfaydzGiRSLWdXxh3ppbvuDUB9LhuCIoCYQ+
         VDCeEtgJ/iQLS4GUGxHawcoE+fPietfDAonuIH64FjmlcEwwxIYjpVC87AcqrHTEZRuE
         tCE8Recb3OMnu3VEVrWMEOzZQhNIHTMw0S//ZcFH+mrYuqSU5hBgnm2Nz0QffPwbd0Oz
         dqGXMcEpCt88ICgeBg+RvL/hASsg5OwymxzII8e60FXgaB7vmJgAnuKDmEaPiWi12ya+
         7etfiKC4Nf0n1wygjQEM1LjjS/o8cJ832q6gtYX587J/o0YcIDkUqjnEE8x81TxLo+d4
         h/Kg==
X-Gm-Message-State: AGRZ1gIltZ7TtX+/+HtHgV4lpjBNsMbP3PvAQxtWKrRxUegCUn/CeCN5
        spxtm+Fm5Qk4rmGjlkNqeORqD9zGm0FbvUmMmdcKWHBD
X-Google-Smtp-Source: AJdET5cscHdOvaPEFEWdHSJMHQK8BG37Nze+habThvKPqnR/SyCkokfXS27IzZIYqO9aHIWtCqplRct7/lNNYTSDy4I=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr155661otf.242.1542016274220;
 Mon, 12 Nov 2018 01:51:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKz1w-==yXd4EL39ULE6bcYU3fTpZB9D0EqdgRhq4L38kVzYEg@mail.gmail.com>
 <CAKz1w-kFDGH-zfYu1GjoJqfs+9uvHvxnG=qwgj8EscAidDNd1w@mail.gmail.com> <CAKz1w-nQRUOKU3WaTLBOY7nExfG6Lv59PpFddbvintyLRmduAg@mail.gmail.com>
In-Reply-To: <CAKz1w-nQRUOKU3WaTLBOY7nExfG6Lv59PpFddbvintyLRmduAg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Nov 2018 11:51:02 +0200
Message-ID: <CABBYNZLRrpSB4-RJLQ0SJODC2yJYioFCoWFRhm_G4WTv0iOg1g@mail.gmail.com>
Subject: Re: Odd l2cap_sock.c Code?
To:     dylanetaft@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dylan,
On Mon, Nov 12, 2018 at 7:28 AM Dylan Taft <dylanetaft@gmail.com> wrote:
>
> I think I was able to figure my own confusion out after browsing the
> bluez userspace tools.  The kernel does not handle anything above the
> L2CAP layer.  This is ATT and that negotiation is in user space,
> nothing to do with sockopts!

Yep, there a procedure to set the ATT MTU called Exchange MTU, note
that when ATT is used over BR/EDR it does use the so L2CAP basic mode
so the MTU will be negotiated over L2CAP, Exchange MTU is not allowed
over BR/EDR.

-- 
Luiz Augusto von Dentz
