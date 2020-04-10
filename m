Return-Path: <SRS0=WCAs=52=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB2C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Apr 2020 06:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4689D20732
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Apr 2020 06:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgDJGvN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:51:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54369 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgDJGvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Apr 2020 02:51:13 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1AE3CCED05;
        Fri, 10 Apr 2020 09:00:47 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] device: Add device type property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
Date:   Fri, 10 Apr 2020 08:51:10 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org>
References: <20200401221320.12105-1-sonnysasaka@chromium.org>
 <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org>
 <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Thanks for the feedback, Marcel. Will come back with the modified
> patches based on your suggestions.

I also meant to write that the name “Bearer” might not be the best either. I am open for suggestions. Also if it is an array, it needs to be plural of course. If we start exposing BR/EDR vs LE or its combination (and we might also consider HS even while not used these days), then we need to be consistent with our terminology across the APIs.

Regards

Marcel

