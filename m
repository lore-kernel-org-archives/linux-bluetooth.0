Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B2C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCDB20882
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVRpQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:45:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48188 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDVRpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:45:16 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 97DF3CECFD;
        Wed, 22 Apr 2020 19:54:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/8] Bluetooth: btbcm: Drop upper nibble version check
 from btbcm_initialize()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
Date:   Wed, 22 Apr 2020 19:44:44 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DB1A586C-0355-42AF-AA59-5BF1344B37B7@holtmann.org>
References: <20200417171532.448053-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> btbcm_initialize() must either return an error; or fill the passed in
> fw_name, otherwise we end up passing uninitialized stack memory to
> request_firmware().
> 
> Since we have a fallback hw_name of "BCM" not having a known version
> in the subver field does not matter, drop the check so that we always
> fill the passed in fw_name.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btbcm.c | 4 ----
> 1 file changed, 4 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

