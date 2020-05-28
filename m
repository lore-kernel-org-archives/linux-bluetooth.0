Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A5DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341A9207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7A4bd5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbgE1N2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 09:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390389AbgE1N2F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 09:28:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD36C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:28:04 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so12924368lfc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scgdFkqrA9ipif8zfFAOgiEAeLrFRRq77UViCEgJYhQ=;
        b=h7A4bd5ICjLIQNoqkc2kTYRm0GGVAuLAjpjqR0mvwJ3pu3AHYLFf+OLYBQCZJZc93b
         WqKDDnxUlWCbcOw1OxmNILyLjqSsHmmDBF1nI9CUEQal823GmrNRcC77cS6YnJ5yxY7W
         ucGwQU0xTxhX/cuEuTFjVpEoXnITkU8MpYPKyDkN4SyXx4Tvg7pAnn8PbI95Xmv3CfW/
         qYmCJ+Vu2Alo/2Hjrq79Lx0UMUscEEWQpkSzReiG+7xSP3Dbi2LKc7B0kREN/Wxtzjcy
         +LphpvXzLMor2fbWSTZ7TLI9sDveY01GZQPpLXYbpD1OrGs4LNIWXMP5bmn/u+6IazZt
         eR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scgdFkqrA9ipif8zfFAOgiEAeLrFRRq77UViCEgJYhQ=;
        b=OaLVGMO8DKullsjAd95bIkzwIPnMLG7wCudfLc3QIUWtL8Rr0SCcc2L312L0gKehZL
         sGsewmdaTAtMVLjKWYFKVgrFAUIkqQTHCyVD68STkkagAmnL+wAYINB8M23lphEHY9ra
         CoAIRlrZgPZR/4f6v5SlOii8czLJP6CvlJVQgTCM7DH9bAUvkQOvoBMpXHgB+wF6OMMk
         d4j3JgoT1ybLSKqBUahjE6pqZEl/ygNSZE0SLEZMk/yo+cNLynFjVQRku6VrGkuhQiWh
         vZOpgZ3IJ0wIkYW0PINYxZKuVkD+qo0xCGC/szgSscpXLyfHKDSb9Fv04I4zKYCx+Qvc
         9Gsw==
X-Gm-Message-State: AOAM53390n8o6CjJjh3WbuYM3yUfnvGVMsl5VYQmDF1zivt/Q3wjJVLw
        lwXkwXH3BTnKOkI7IYh6WNhW5XQ3B4R2oJshfGFKaA==
X-Google-Smtp-Source: ABdhPJys7EDgDENTfzCOQMRtRYtNjk6p1D8wTCQERoxgVB1oJbh8QdBDRmFNDGGzXAr+njwICWTaIbEciwjwQ9sFvDg=
X-Received: by 2002:a19:c016:: with SMTP id q22mr1687959lff.191.1590672482850;
 Thu, 28 May 2020 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200525184343.8532-1-alainm@chromium.org> <31E0FE7F-34A6-4819-AE06-C9F0B49D7C11@holtmann.org>
In-Reply-To: <31E0FE7F-34A6-4819-AE06-C9F0B49D7C11@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 28 May 2020 09:27:51 -0400
Message-ID: <CALWDO_XZLjFR1WheNogehz-STe+8wRpi2SSPb3Bscb2eKsPDmw@mail.gmail.com>
Subject: Re: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, May 28, 2020 at 4:26 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds support for reporting the BT_PKT_STATUS to the socket
> > CMSG data to allow the implementation of a packet loss correction on
> > erronous data received on the SCO socket.
> >
> > The patch was partially developed by Marcel Holtmann and validated by
> > Hsin-yu Chao
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> >
> > ---
> >
> > include/net/bluetooth/bluetooth.h |  8 ++++++++
> > include/net/bluetooth/sco.h       |  3 +++
> > net/bluetooth/af_bluetooth.c      |  3 +++
> > net/bluetooth/hci_core.c          |  1 +
> > net/bluetooth/sco.c               | 28 ++++++++++++++++++++++++++++
> > 5 files changed, 43 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 3fa7b1e3c5d9..85e6c5754448 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -147,6 +147,8 @@ struct bt_voice {
> > #define BT_MODE_LE_FLOWCTL    0x03
> > #define BT_MODE_EXT_FLOWCTL   0x04
> >
> > +#define BT_PKT_STATUS          16
> > +
>
> we need to agree on if this is an int or u8 value. Otherwise this looks good.
Since doing anything beyond a u8 value would require a core spec
change and likely a new definition for what the packet flags are, I
think it is likely safe to keep as u8.  Do you have a different
perspective?
>
> Regards
>
> Marcel
>
