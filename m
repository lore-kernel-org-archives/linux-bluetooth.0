Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EBEC5DF62
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C365204EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572992914;
	bh=I9UIaPC+F6pMaRWtxmM2p9WCZ3F8CbiIzFcH59kpZGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R9y8ARpAWi6qBEpw97zoHGeOUNUWKwk5ugOidRaNGaW8kVgAd2rvcPMfCwE6fiL6P
	 xrwUVNNN39tWaIlm5DEJ1K1atbKqWGwJtDtmwDCpFFAH9YAs5102oG4S7gPVa+mNVw
	 yJtwAzi+I0t7qB+zR/iK1MXcl1BPdXPMKRQzW7xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfKEW2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:28:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40570 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEW2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 17:28:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id 22so1007147oip.7;
        Tue, 05 Nov 2019 14:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KjC2KAma0LvKn8lumDMjxYlVIodGsZnVFEKifxdYSnk=;
        b=d3ueRprQvnW67UsHL1myk6iFa3saZxOgLa0qZeJKM/5P8dxTa03BsPGih9jWr9BPXx
         q5mjpUxychbm+QiSQ7HS7RQIs9ig20H+ZCNrsUK0qsHq5SyEUOYOd978PXDLEJzh/2RX
         i0T3oiQPHsyYg7Et1vY70cnsbcvLRY8sZXqTWyvTZJcbAAEEPfuGd0pCOuE+grw4MvC3
         fLDz7G4L94nNwpx1SCabg+mG25RbZJzuTkCM7a84UX6bCf9pjdiNhVgAIwWRoblDuUsk
         uqGt0uilMI7BO/lpPJjdOWYbDh13+z+KnxyOWdhfgBSV8hAC/l6h+wAgtdei22o/eBul
         In/Q==
X-Gm-Message-State: APjAAAUr6CUXItQUhx0hrpC1QR1xkHmFQU4cvss967B1D+rDN3pdN98a
        t9lCxLhIW+dX5/z7xIc2Ww==
X-Google-Smtp-Source: APXvYqy5wstR+27k4YDuFjIs+QGvk3acSSr3Nj8fQl3hz0coclqz40Lwa3CnvVJ6yzu4SV/xIyQc6A==
X-Received: by 2002:a05:6808:18f:: with SMTP id w15mr836024oic.136.1572992912226;
        Tue, 05 Nov 2019 14:28:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h79sm6168228oib.3.2019.11.05.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:28:31 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:28:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: add DT binding for
 Realtek controllers
Message-ID: <20191105222831.GB15425@bogus>
References: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
 <20191030224333.70241-2-bonstra@bonstra.fr.eu.org>
 <20191101080256.gjc4tacltehro3iw@hendrix>
 <6C5CE71F-37F2-4C8A-9D94-1BC75937B478@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C5CE71F-37F2-4C8A-9D94-1BC75937B478@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 04, 2019 at 03:20:59PM +0100, Marcel Holtmann wrote:
> Hi Hugo,
> 
> >> The rtl_bt driver already supports some Realtek controllers on ACPI
> >> platforms.
> >> This commit adds bindings for DT-only platforms.
> >> 
> >> Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
> >> ---
> >> .../bindings/net/realtek-bluetooth.txt        | 25 +++++++++++++++++++
> >> 1 file changed, 25 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt
> > 
> > You should write that binding using a YAML description. Free-form
> > device tree bindings are more or less deprecated now.
> 
> unless we change all the Bluetooth descriptions, I prefer we keep it the “old” way.

Who's going to do that? Me? You? Randomly select some poor soul to do 
them all to get their device added? I only have 3500 to do. An all at 
once approach doesn't really work nor is it necessary.

I'd suggest new ones in schema and if you want to encourage conversions 
require any changes on existing ones to first be converted. Still up to 
you because it goes thru your tree.


> > IIRC, that has been discussed before and the standard "model" property
> > was to be preferred.
> 
> This one should really get an ACK from Rob.

Humm, maybe, but I don't see 'model' used in this context.

Rob
