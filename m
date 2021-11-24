Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7755AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhKXUtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:49:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57369 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhKXUth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 15:49:37 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6CC71CED2B;
        Wed, 24 Nov 2021 21:46:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] Bluetooth: refactor malicious adv data check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211124201628.405647-1-brian.gix@intel.com>
Date:   Wed, 24 Nov 2021 21:46:25 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        paskripkin@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <0D2E978A-4EEE-4EE7-B7F4-8EEA18857D51@holtmann.org>
References: <20211124201628.405647-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> Check for out-of-bound read was being performed at the end of while
> num_reports loop, and would fill journal with false positives. Added
> check to beginning of loop processing so that it doesn't get checked
> after ptr has been advanced.
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
> net/bluetooth/hci_event.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

