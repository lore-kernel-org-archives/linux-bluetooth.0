Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF277C31E51
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 13:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A7D2084D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560863253;
	bh=B+Dth4coHSSUS9fJHC8P8NlLivPVB/bh0H17o1Jd+0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BmqhAZoH04cE3zlxOUuD/3P/b9B2kZ25FCnxS6uSU4UFBqPxXIWdxsTvRXqbt0XeB
	 AI/XSJaUAwTLA3F3vC7ZAdruNtHq56kxIkCuqSb1nOFkFElvVxTv9RtdZfg2F67LxM
	 YQ7Rx5M0MHwd1W0dGIpcLqxbdg/2NjagEM6RItxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFRNHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRNHd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 09:07:33 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28592084D
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863252;
        bh=B+Dth4coHSSUS9fJHC8P8NlLivPVB/bh0H17o1Jd+0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKZQi6ic1+IxUIN1kqlGnS5I4FcFli6EM2XaOc3f4aSZ/vNZYRjil3FNknCgh5PfD
         PehtdWZDAV3EJl698LowP7nLsxI++ZMBnI1hau1pHTxSJnpJIcyD8SkTiBUWMsA4mk
         5zyldgQGyq2kPWpAH0ZNtdFrveU+DObgjzjJqfLw=
Received: by mail-qt1-f181.google.com with SMTP id h21so15095457qtn.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 06:07:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXzSy/GnDzuv2bSlvEhCzDmMkAstrM6NrrclE3M4U3phfP7FUfH
        b2GcazNmmnqlEcpbG3Vnt71qrG0OWrHHUzh8aP0=
X-Google-Smtp-Source: APXvYqwwjrkdxLxmrZIl9L8Wl6Z9n7BT0X1XsBmiU3gq98jOppEMM+d2h+0Zfq4YEcP74ntZ+NsUsvn7zbf9jd0luCw=
X-Received: by 2002:a0c:d0f6:: with SMTP id b51mr5531653qvh.225.1560863251193;
 Tue, 18 Jun 2019 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <1560240038-29261-1-git-send-email-amit.k.bag@intel.com> <1560240038-29261-3-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1560240038-29261-3-git-send-email-amit.k.bag@intel.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 18 Jun 2019 09:07:20 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4tVCONcoazZ9Gcr-J4Y5cjtDjGURNRfGK4S1q5QX6oug@mail.gmail.com>
Message-ID: <CA+5PVA4tVCONcoazZ9Gcr-J4Y5cjtDjGURNRfGK4S1q5QX6oug@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-firmware: Update firmware file for Intel
 Bluetooth 22161
To:     Amit K Bag <amit.k.bag@intel.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jun 11, 2019 at 4:05 AM Amit K Bag <amit.k.bag@intel.com> wrote:
>
> This patch adds new firmware file for Intel Bluetooth 22161
> Also it is known as Intel CyclonePeak (CcP).
>
> FW Build: REL0282
>
> Release Version: 21.20.0.4
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE               |  12 ++++++++----
>  intel/ibt-20-0-3.sfi | Bin 716180 -> 715376 bytes
>  intel/ibt-20-1-3.sfi | Bin 716180 -> 715376 bytes
>  intel/ibt-20-1-4.ddc | Bin 0 -> 70 bytes
>  intel/ibt-20-1-4.sfi | Bin 0 -> 715376 bytes
>  5 files changed, 8 insertions(+), 4 deletions(-)
>  create mode 100644 intel/ibt-20-1-4.ddc
>  create mode 100644 intel/ibt-20-1-4.sfi

Applied all 3 patches and pushed out.

josh
