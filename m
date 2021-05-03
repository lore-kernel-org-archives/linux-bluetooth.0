Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8BAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56F16120E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 May 2021 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhECIiV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 May 2021 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECIiT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 May 2021 04:38:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C9C06174A;
        Mon,  3 May 2021 01:37:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j10so6902644lfb.12;
        Mon, 03 May 2021 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODlNgytFWNi0h4hvZVNT737gxT+3xG+wTptlougqpcA=;
        b=okB+e/O3UjYrPgIcuj/20UnDlGpXaUdikvGS2pR+iUunc/FWb9AfK1LRjG9qj9Gez5
         STBDj2nZbYx1csy1sah7TDZerO/EhuNCIq7YW1b+eqFqg8n9uc7bVNEzzaIkVv5KKlIN
         RpSVdSQI7eCvYijQrGlm/ZJIlfYb+TpjahIk2A2gxGhalxwy28VpQVSEHBzkyfJfj8Ca
         G6+J/M8O1v5Vks2dp/At2deq39uHNHmYexIIcVR4ag0+k4WUhkPYL6W1RdpG4jC6dyom
         hA+zVgdVZbLastxt8M0rjgEZwWuepwtfHGx7ofZWaphvoBRw9rmsDmh/ukI08tu/4ZUI
         3IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODlNgytFWNi0h4hvZVNT737gxT+3xG+wTptlougqpcA=;
        b=sROJQ3AnpBDBcpFoKIcgHFHaoKfCInvF0h2xa/2fuKbThafux1w5bNyDsfHqKo+FVT
         j2LqzXom8XuRlFC79TxTziCTYEwH+uz4XGKfcOwe9do8BxbSouXOIGlNCYDrbj5FbLvA
         JKj8QncE3+k+4EdGYyCHhm9J9642BYafMrokLtJnnPoDiUqD1LF4K5bdLQXnhZiLI8IS
         hyjgggNvRRWwFwgFXK6cuh4RL3JCoQ0JOWndrhxPq6LMZX/yE+FPTwYsAjTD9W/jKCQO
         0ycH31RqEBLk8mD6qJv9a8SReud5Ujy7wa1bBJo9K0ANRZBd1z0EYWHg5YYpMHeSeQYl
         B1tw==
X-Gm-Message-State: AOAM532T13tK3TfwvrxJUoryxEWayBgsxBwRM4NLCAiC8X0VKwnxIK6M
        NyY+thAmdlyDt3hukbKyrjkHJyjFbGGKrcle
X-Google-Smtp-Source: ABdhPJyADC3XLpmVukANV72ECJLB3BCLOZPwbPh6CWkliR3rPURcWarY1x3dcHeO730VCPEMx3+aYw==
X-Received: by 2002:a05:6512:108c:: with SMTP id j12mr12293845lfg.403.1620031040943;
        Mon, 03 May 2021 01:37:20 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id r19sm1005182lfi.246.2021.05.03.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:37:20 -0700 (PDT)
Date:   Mon, 3 May 2021 11:37:18 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] bluetooth: fix potential gfp
Message-ID: <20210503113718.2ec9668f@gmail.com>
In-Reply-To: <YI+s2Hms/56Pvatu@hovoldconsulting.com>
References: <20210501150445.4055-1-paskripkin@gmail.com>
        <YI+s2Hms/56Pvatu@hovoldconsulting.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

On Mon, 3 May 2021 09:57:12 +0200
Johan Hovold <johan@kernel.org> wrote:
> On Sat, May 01, 2021 at 06:04:45PM +0300, Pavel Skripkin wrote:
> > In qca_power_shutdown() qcadev local variable is
> > initialized by hu->serdev.dev private data, but
> > hu->serdev can be NULL and there is a check for it.
> > 
> > Since, qcadev is not used before
> > 
> > 	if (!hu->serdev)
> > 		return;
> > 
> > we can move its initialization after this "if" to
> > prevent gfp.
> 
> Good catch. The commit message needs to be improved however.
> 
> First, what's a "gfp"? Did you mean GPF?

Yes, it's typo :(

> 
> Second, I'd expect you to try to point to the commit that introduced
> this issue (e.g. using a Fixes tag) and CC the person responsible.
> This appears to be commit 5559904ccc08 ("Bluetooth: hci_qca: Add QCA
> Rome power off support to the qca_power_shutdown()") but you should
> verify that.
> 
> Third, this looks like it could be triggered by user space so you
> should CC stable too so that the fix is backported.
> 
> Fourth, your commit summary (Subject) is missing the driver component
> (i.e. "hci_qca").
>

Ok, I'll fix it all and send v2 soon.

Thanks for your feedback!

> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c
> > b/drivers/bluetooth/hci_qca.c index de36af63e182..9589ef6c0c26
> > 100644 --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1820,8 +1820,6 @@ static void qca_power_shutdown(struct
> > hci_uart *hu) unsigned long flags;
> >  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> >  
> > -	qcadev = serdev_device_get_drvdata(hu->serdev);
> > -
> >  	/* From this point we go into power off state. But serial
> > port is
> >  	 * still open, stop queueing the IBS data and flush all
> > the buffered
> >  	 * data in skb's.
> > @@ -1837,6 +1835,8 @@ static void qca_power_shutdown(struct
> > hci_uart *hu) if (!hu->serdev)
> >  		return;
> >  
> > +	qcadev = serdev_device_get_drvdata(hu->serdev);
> > +
> >  	if (qca_is_wcn399x(soc_type)) {
> >  		host_set_baudrate(hu, 2400);
> >  		qca_send_power_pulse(hu, false);
> 
> Johan


With regards,
Pavel Skripkin
