Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C1C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C591D2073B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Zfnok1UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgC3P1d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:27:33 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38707 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3P1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 11:27:33 -0400
Received: by mail-lj1-f173.google.com with SMTP id w1so18509125ljh.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Fgyu8ufq07oSeLrKaaKhlZAT6jOHp+NEXbUV1i5WIIo=;
        b=Zfnok1UHFEXMbco4kme33sAGI7MAEf+XExWeLeBtVmlzzRfARI1veGcxNc41FYkliv
         U5q1ZFVmYfqUFWdD/XOsY6FOtF9UmGGsIbz8jCM2P+Hr2ggPRh3piZ45nftMGGuMHbZ4
         75EKoVCpDcvcuAwSeWXgGS+7K/bMTt1YCK4gbpQmtd2HkWmNU7sY5atMno4lLYGXIpaA
         wbI9M3GVyFy13upjUcP1QOzFO11sBw7aaZGPe84ZgFMQDughICyyPsS6pXZMsbXsKYWq
         G7ehLnv8voao7ghvBZHnQspypfDdbHEJB1ZLGjspuOki6RyHT2k6JOOhJJ0nJkDbQRWp
         aj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Fgyu8ufq07oSeLrKaaKhlZAT6jOHp+NEXbUV1i5WIIo=;
        b=DidYS02GIv75cxqqe77+wA50znsqlRHDZqy/jeofs+jmysWSUr6lFhWuAMV6ur2K8k
         T+xjM9jqHnLWWFlrAOKhfnX7r25NRmpP+sIbkWpqq3Jo8qytWM1hVOu3J6YxYQ4fluQd
         9KtFtHApi0uVFQem5zqbC15pRfbOCGkAkTbLtjEtDdFqZoGpyq06R8Z5ktsOW193YHBq
         cOmvkTqcreNTcZvcWSyXJ9tRD0Oaufq8HoMvdjEO4hHBU3q8KsDB8tTftOS4Eu6DGo3o
         tH635BJ7N+PbLK7bXvUXyH3TAOLmtFht00zgQtbXFVsDFOmxBsoF+CDX5EKknh4n6SvQ
         hNWQ==
X-Gm-Message-State: AGi0Puanz7sudMK0vTTw25D/8M/DaGcrQyfCqcdwNMgJw3HXMhdlHr1R
        2Bd/AGDit18psju4q6wdYh7zlRA9kb8=
X-Google-Smtp-Source: APiQypJI+hJY2GzU+2vfUElK0Uwm7JuQC8eOb5TDOKb7ghxbRA95FGfzQ+4vmM/gLlwj1T0cuth9pQ==
X-Received: by 2002:a2e:9247:: with SMTP id v7mr4933880ljg.215.1585582049415;
        Mon, 30 Mar 2020 08:27:29 -0700 (PDT)
Received: from kynes (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l132sm2740916lfd.13.2020.03.30.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:27:28 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Mon, 30 Mar 2020 17:27:26 +0200
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>,
        =?utf-8?Q?Przemys=C5=82aw?= Fierek 
        <przemyslaw.fierek@silvair.com>
Subject: Application vs Network nonce in segmented messages
Message-ID: <20200330152130.gf5jkgalya34mj2e@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>,
        =?utf-8?Q?Przemys=C5=82aw?= Fierek <przemyslaw.fierek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

A question: when poking around the code looking for places where I
should fix the net key index, I've noticed a peculiar thing in
mesh/net.c:

	if (msg->segmented) {
		/* Send each segment on unique seq_num */
		seq_num = mesh_net_next_seq_num(net);
		...

This means that for segmented messages, if sequence number used on the
transport layer is, say, N, then the first segment is encrypted with
sequence number N + 1 on *network* layer.

While I think it's legal from the spec point of view, I can't think of a
reason to do so. Can you please shed some light on that line?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
