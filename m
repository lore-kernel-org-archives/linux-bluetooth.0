Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733CC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC5D2243E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6HaFvJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC5D2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeKLWvf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:51:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43531 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeKLWvf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 17:51:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so4328718plb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 04:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WwzdVvlB3G6DIYMuvImRTKDB8GPFM8NhTNECvf8r6gw=;
        b=S6HaFvJgcW6vFMqDMxyfv47fRkVHuUveWDRIsMXFHUurDWcQRFi2WIodSSRUjLJoxf
         wNA97MVwDaMO6MzMbFITyFi6bHiRyaMs0sBGINZqUyKmq62ZopA5LF1VroOU+oVYDQnE
         xT2rO0d/tCKXRASlmERXF3mz2cghBuZXURaqD0xvOjvMfeC1l0Tl9tuLaxOfnDNzfaew
         Q0S1hqj8RzaZVrcc0FDuc11pRQ3bHnithcMgvxnDoTd4pItwNRb1U5GNiG/0OQ5M7W9I
         h5BQcnuZ6BUPxN5jIgpGfc1QlHQ3By4ZT/Hq7PbJhovfM64YNRCqa7BOl60UvPUEG+bL
         jMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WwzdVvlB3G6DIYMuvImRTKDB8GPFM8NhTNECvf8r6gw=;
        b=PswPrGLnPLgsEn/jlBoO3k4f6PFBneWaUQnKCq6QrW0hn4cDwi92cyk216ATENibGm
         w8WRfqVzGeN1OZ3sqmEPTMOs7eAd9wuS+rqRv0oZzYJqJ9IPlGxlS7R5+tJhMEPkDYrs
         jvYjkUxCr5cM6tLnWdiOLQYm+DSdzExAnX47/hoJk/UGtDISlQA2cQ7emUzmuqS80lKa
         nbBMrzhSKEb6rX1cmRh12wkR6+L1pNq7u/UHAJAJ++bNc5mCHlKw9NpAi+BMLaAzGimk
         zd9qabvUl6Nxz9/DVNMoH+/AP/AuzOL8I+NHb0Qo8Prwgizqx7bmGBSeLg2XToLgfKFB
         TQiQ==
X-Gm-Message-State: AGRZ1gIzmq7XO09sqtTuBYm7VDvwur7bFUWJ9rNBH1CHaiHToPSsmJdw
        NDL2VrH0LZXPPzxp7BDcw6tLPYRTfwY=
X-Google-Smtp-Source: AJdET5fgw6RKppY/DLVCMa9+cWUQqBReM/DJVTnxbDzdRXN/MVhLrAM2RyeAsUJdMTKaRxm/eIxAaw==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr889644plt.106.1542027503999;
        Mon, 12 Nov 2018 04:58:23 -0800 (PST)
Received: from ibflynnx-mobl.ger.corp.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id 64-v6sm40550305pfa.120.2018.11.12.04.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 04:58:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ v2] doc: Initial Bluetooth Mesh API
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <CABBYNZJLLxNC3BQvyDxzTFLppe25ke=VK_9QtvJsNbCFjnUW2A@mail.gmail.com>
Date:   Mon, 12 Nov 2018 13:58:07 +0100
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C0377DF-430B-4A2C-BA6E-CC4B9C6ED9F6@gmail.com>
References: <20181112013317.5714-1-inga.stotland@intel.com>
 <CABBYNZJLLxNC3BQvyDxzTFLppe25ke=VK_9QtvJsNbCFjnUW2A@mail.gmail.com>
To:     Luiz Von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

> On 12 Nov 2018, at 13.24, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
> It seems wrong  to me to have to send your own object as method
> argument, usually this sort of communication goes as a Signal but it
> seems the Element interface has no signal to be able to do something
> like that.

The problem with signals is that they cannot return an error, and I do =
think we=E2=80=99d want to have the daemon return an error if it cannot =
send the given message. Also, by default signals are broadcast, and it =
feels a bit hawkish to do unicast destinations for them.

Johan=
