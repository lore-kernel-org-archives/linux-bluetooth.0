Return-Path: <SRS0=i2N+=PB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA51C64E75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01BB217D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLXVJo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:09:44 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53339 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 16:09:44 -0500
Received: from [192.168.0.117] (188.146.78.210.nat.umts.dynamic.t-mobile.pl [188.146.78.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id CBFDACF2A8;
        Mon, 24 Dec 2018 22:17:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v5 27/30] mesh: Sample Provisioning Agent
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219042016.25538-28-brian.gix@intel.com>
Date:   Mon, 24 Dec 2018 22:09:41 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <3DB952F2-C235-4921-A4E9-4FADF5C10F31@holtmann.org>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-28-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> mesh/agent.py | 40 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
> create mode 100755 mesh/agent.py

no, these all belong in the test directory. And we never used the .py suffix either.

Regards

Marcel

