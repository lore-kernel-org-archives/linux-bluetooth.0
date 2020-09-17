Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65963C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C4A2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 09:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIQJrV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 05:47:21 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52592 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIQJrU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 05:47:20 -0400
X-Greylist: delayed 2229 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:47:20 EDT
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 96A3C3A3028
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 08:56:29 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8C0F620010;
        Thu, 17 Sep 2020 08:56:06 +0000 (UTC)
Message-ID: <f1be58f4af1465d4790990b9b310ca394e63f2a9.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] sixaxis: Fix crash caused by return of
 udev_device_get_property_value
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Date:   Thu, 17 Sep 2020 10:56:05 +0200
In-Reply-To: <20200916223453.22537-1-sonnysasaka@chromium.org>
References: <20200916223453.22537-1-sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.37.90 (3.37.90-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-09-16 at 15:34 -0700, Sonny Sasaka wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
> 
> This adds a NULL check before calling sscanf().
> 
> Reviewed-by: Yoni Shavit <yshavit@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>

Looks good.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

