Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9568EC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303F20651
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0Rl3Kla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfDASEK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:04:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44163 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDASEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 14:04:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so4942064pfm.11;
        Mon, 01 Apr 2019 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=um3yLmjOxNHiqWh0I10IfRUzK5l/lVvG1pFRCnHnutE=;
        b=u0Rl3KlablJXeoskoOQrXp9eA56REHERxZJJqZp31dKEcq7DuMlK67/6tBGELPAABO
         mD7uQt9BeW55vkfyo9jjzH6YLkzzai863OLCaWbu7iIJNT2v9aO84bIwQ8HJ7dMNCVdD
         ZUX+In5xmGwMfCyzFXgMO+iv2o6IqkLAEuYTUMQ17RL7amz10VpYtxe12kF2svbgESbX
         Q0qmZA/nG6YGgvyOGbP/QVnyWdKYgRld5yVf9iULe8cMn7aBXHgehZqg5mjy9mXylafY
         QvqM8OFT61KuZLLwLgcJMCdKGxi3jHJqGxgy7gysNq+NC/ml/NpROkAbfFWM0QBJUwHN
         3IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=um3yLmjOxNHiqWh0I10IfRUzK5l/lVvG1pFRCnHnutE=;
        b=oCKywKrC1cvkOog3g67iKFU+LL7eMvHepMb1tCvr1XaLe9LVp+HWz/0NzcHautlHBI
         RwlSLyIzmDGi5QM2tle2T/TM3Gfgjuv0vfqbTlkUyu6ngrNCb64NHXG7LucqRxYH6wSb
         E3dKE5qybPdZDGxyTfgOMbFiZMz68ijYs1xOMNl8NuX9j8d8rCY+XUTHJtuewBWWKbXR
         DeG9MmVDeZ4DDikHmxB1ROi3N9W/QB8cOcI435iMHmQTCy7ajgEuz2mNe2dTn+bRC33V
         ge5ZGSl42bKqqwdTZHwBTXkec1fEfXqtFfkbRy14ZLheuaUhyr7ZG/qFQsU+ko8Og1Ku
         5O1w==
X-Gm-Message-State: APjAAAXBzaFfUaa2AeIByafCDJaYzuQPNsz1//ZNeuaINUJOtKPiOQ/Z
        +HTJbepb6vz7LQTiVMFMc3jR5tZztqf3sFDevWw=
X-Google-Smtp-Source: APXvYqziXHUL5uBFQ+dU9WSjyqSAr/sYO5VrKh94HW4og0GpER8eKh/DBII/OmVlB4lPHnpNqeDPbb40xpTpJciu/tw=
X-Received: by 2002:a63:c10b:: with SMTP id w11mr62417471pgf.39.1554141845036;
 Mon, 01 Apr 2019 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
In-Reply-To: <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 1 Apr 2019 11:03:53 -0700
Message-ID: <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Mar 30, 2019 at 2:23 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
>
> Hi Dan,
>
> On 3/30/19 8:25 AM, Dan Carpenter wrote:
> > There is a potential out of bounds if "ev->length" is too high or if the
> > number of reports are too many.
> >
> > Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>

I sent a patchset to fix all of this kind of OOB:
https://marc.info/?l=linux-netdev&m=155314874622831&w=2

Unfortunately I get no response...

Does any of you mind to look at them?

Thanks.
