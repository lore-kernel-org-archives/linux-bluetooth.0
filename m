Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC0BC4360F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E39218A2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ss8gH+Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfBYX4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:56:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36207 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfBYX4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 18:56:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so5267948pfa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 15:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GyDDqMb+PADkLlsZfFC/yNsSsDZWmZ/JbaeXSY7K8IE=;
        b=Ss8gH+Fc6QWjevlMltPlqgZYLZkrCmMYEnRcV80g7TNFQ92295nk/Iec5cPviJugxf
         yDIAyDbIG9OA68JMFk83EVm7C3Kqp3jOO41JxWFFxr0t1Wz1tzFnlIx80qh8RTjG1j9G
         fvqcWtBuUq12bnqpCTL1U79GMnK1+D3dM79mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GyDDqMb+PADkLlsZfFC/yNsSsDZWmZ/JbaeXSY7K8IE=;
        b=VrWZjPs6T9uj4vTZKz4k2ejmkAuE3CkupR1fI2JGkrc/2KAIsqUWk6cwfyzIwi/GMG
         +Or6tNT9psHizpdCaagVfR71knMppKZcDiY7iZsAPv5uPMb0Sa6Tz9Ycx6aIFPLrjqnT
         A98eMKFxdEbDQjLfxcDtli/0YfPXPwkqKXDFyeGsnKkUC3n+TrSHtB1Xsq8SnRdWKv7+
         6AmNa9Rz2mA9VZQi8FglVF3LlF1y9/sTdrTdarjjjTXMjHbNVAUzynx+mjnALZw+NnQr
         QdiX1KCSHH9lacxbhbdu6Ueso2s+DG/h+T1th1snouKHx+q/Va0p4U5eJhKSdd8nYz/D
         XEEw==
X-Gm-Message-State: AHQUAuaELX/AXxOUY8MkOzCqPPy5MlsLFw+7dfUGsQFHEBgdK+jvnP2i
        qvohw4RVbgpiB5UDxkqh8K3qtQ==
X-Google-Smtp-Source: AHgI3IaT2dTIPw5zKr53kzWw49NtyNET5EQPDWg7yjwAubxwn1X4/bxnDUdGnD4WRzKnuPKkAIg6Ag==
X-Received: by 2002:a62:b618:: with SMTP id j24mr22718863pff.120.1551138981907;
        Mon, 25 Feb 2019 15:56:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y14sm18785736pgc.17.2019.02.25.15.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:56:21 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:56:20 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Update baudrate change wait time
 for wcn3990
Message-ID: <20190225235620.GA67723@google.com>
References: <20190220112516.19179-1-bgodavar@codeaurora.org>
 <20190220234302.GB116191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220234302.GB116191@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 20, 2019 at 03:43:02PM -0800, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Wed, Feb 20, 2019 at 04:55:16PM +0530, Balakrishna Godavarthi wrote:
> > This patch will update the baudrate change request wait time from
> > 300 ms to 100 ms. When host sends the change baudrate request to
> > the controller, controller sets its clock and wait until the
> > clocks settle down. Here the Wait time is required for both
> > host and controller to be on sync.
> > 
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> >  drivers/bluetooth/hci_qca.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 5e03504c4e0c..22f3c983f868 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -59,7 +59,8 @@
> >  
> >  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
> >  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> > -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
> > +#define ROME_BD_SETTLE_TIMEOUT_MS	300
> > +#define WCN3990_BD_SETTLE_TIMEOUT_MS	100
> 
> nit: _BR_ instead of _BD_?
> 
> >  #define POWER_PULSE_TRANS_TIMEOUT_MS	100
> >  
> >  /* susclk rate */
> > @@ -965,8 +966,11 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> >  	struct hci_uart *hu = hci_get_drvdata(hdev);
> >  	struct qca_data *qca = hu->priv;
> >  	struct sk_buff *skb;
> > +	struct qca_serdev *qcadev;
> > +	unsigned int bd_settling_timeout;
> 
> nit: from the context the purpose of the variable is fairly clear,
> calling it just 'timeout' (or 'settling_time', it's not really a
> timeout) should be fine.
> 
> That said, I have a similar change in my pipeline, which further
> reduces the time to the 'strictly necessary'. It's slightly more code
> though. I guess I'll send it and we can discuss/let Marcel decide
> what to adopt.

I haven't sent my patches yet since I encountered initialization
errors when testing, however it turns out these errors are not
related with my changes.

This series fixes the problem:

https://lore.kernel.org/patchwork/project/lkml/list/?series=384571

I'm now retesting my changes and will send them soon unless I
encounter other issues.

Thanks

Matthias
