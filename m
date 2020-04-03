Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5557C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E02206F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UedtGkEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbgDCQll (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:41:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44310 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgDCQlk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 12:41:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id a49so7857878otc.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXq6eAsioQAHzuUMLgfWLgX11AMwnh5dZTSt1roKCvM=;
        b=UedtGkExr3krIQuo11dA4DNSihmW16zNt6wZWIWBYhnaiwmV/zKCIn2S/qts4WV9VF
         wNHky82DbYRUCdtm+ZpwoIiJS/382es1t5uir+VKSjfHHqufn3ilg0+tIBjrddlokW8B
         CHvoFhx7ENQJX9JAxHiowKLAHRPn72e30HIgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXq6eAsioQAHzuUMLgfWLgX11AMwnh5dZTSt1roKCvM=;
        b=kXbDlvS5ybp1SN6p0S1hBaG7xsNdWUapArYScmCtKgAtTnwX+KgyiB0GG/0q8Fw8dE
         Xp4VHBAi9D5BBrLQnfPgY/h2uUvVxP7ixYJqW+cQ0mvQB3nxJEzi78KLl2nM/OUywS2h
         WUZBsDrWQ5k3NHoQsUW0Ng1oxO6Qyf6sH0pmWVAJ602EeondGxTRcC/eDUiMwe+J8hTw
         2PfarcHI6DVlBJuNcwYwlkSdzlDYt574GoxyG42mymtzNgpa7mk5NMDfd+mVSN9ApSd3
         5S/oSRVwxSQJF1KPW4roeKbrPWmYfv0oPWkrWsuf9cK2gbeItfLiUz23sHeYlRzPebWy
         5ASA==
X-Gm-Message-State: AGi0PubSxTZcTdJkmm3LqaNlcYwIkt6EGU3JD77MKsJQgdAk63eGqpzv
        CHeniWnNPQtJvDN9IRtyCjqf173dCjS5tzqeOn/24A==
X-Google-Smtp-Source: APiQypJ6itRFv13VJoGxqM5tYdvWWfKa7KDCqBEyvrvTLoNJxuBp1Q1lnStt2NbySRDupiUnChkruTb57a7PTnpcf0w=
X-Received: by 2002:a4a:9813:: with SMTP id y19mr7416223ooi.56.1585932099548;
 Fri, 03 Apr 2020 09:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200331003355.14614-1-sonnysasaka@chromium.org> <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org>
In-Reply-To: <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 3 Apr 2020 09:41:28 -0700
Message-ID: <CAOxioNm27+wmWeCp+hoWCF-5W1=xm_gdvn3xWbDJVeYE=wmyiQ@mail.gmail.com>
Subject: Re: [PATCH] tools/hciattach_ath3k: Load BT board data based on
 country code
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, yixiang@google.com,
        Zhifeng Cai <caiz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for your feedback. I will take note of this deprecation plan.
For now, Chromium OS can have a local patch to accomplish this and in
the future we will migrate to serdev instead of hciattach.

On Fri, Apr 3, 2020 at 6:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > BT board data file PS_ASIC-<country-code>.pst is loaded based
> > on country code. If not exist, default BT board data file
> > PS_ASIC.pst would be loaded.
> >
> > This patch doesn't define how to get the country code at the moment, but
> > future patches can supply the country code in the region parameter of
> > get_ps_file_name.
> > ---
> > tools/hciattach_ath3k.c | 32 +++++++++++++++++++++++---------
> > 1 file changed, 23 insertions(+), 9 deletions(-)
>
> while we can fix parts of hciattach, but I rather remove that tool at some point.
>
> Do you still require it with serdev kernel support? I mean all UART based Bluetooth controllers should be handled via serdev.
>
> Regards
>
> Marcel
>
