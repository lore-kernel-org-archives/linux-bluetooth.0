Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B59E61042
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 19:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhHMT1Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:27:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58419 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHMT1Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 15:27:25 -0400
Received: from smtpclient.apple (tmo-080-146.customers.d1-online.com [80.187.80.146])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0FDE7CED04;
        Fri, 13 Aug 2021 21:26:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [Bluez PATCH 01/62] lib: Inclusive language in HCI commands and
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210813201256.Bluez.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
Date:   Fri, 13 Aug 2021 21:26:50 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FB2904D7-96FA-4A26-83A3-2F1729DC2D73@holtmann.org>
References: <20210813121848.3686029-1-apusaka@google.com>
 <20210813201256.Bluez.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> "central" and "peripheral" are preferred, as reflected in the BT
> core spec 5.3.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> lib/hci.h          | 14 +++++++-------

until we deprecate libbluetooth and no longer give an option to install it, you can not do this. It is part of libbluetooth and this would break API.

Regards

Marcel

