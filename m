Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5097DC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6808221FC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgKQSBs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:01:48 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54035 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgKQSBs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 13:01:48 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B7C2C60003;
        Tue, 17 Nov 2020 18:01:45 +0000 (UTC)
Message-ID: <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 17 Nov 2020 19:01:45 +0100
In-Reply-To: <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
         <20201111011745.2016-7-sonnysasaka@chromium.org>
         <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-11-17 at 11:51 +0100, Bastien Nocera wrote:
> <
> <snip> didn't review the code in depth, but, having written this
> mechanism
> for Bluetooth battery reporting, I think that this is the right way
> to
> go to allow daemons like pulseaudio to report battery status.

It would also be useful to know what external components, or internal
plugins you expect to feed this API.

Apparently HSP/HFP, for example, provide more information that what can
be expressed with the Battery1 API, whether it is charging or not, or
whether a battery level is unknown, etc.

So I would say that, even if the current battery API is extended, we
need to make sure that the D-Bus API to feed new data is extensible
enough to allow new properties, and they don't need to be added
separately to org.bluez.BatteryProvider1 or org.bluez.Battery1.

