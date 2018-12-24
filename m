Return-Path: <SRS0=i2N+=PB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7290C64E75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB80D217D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Dec 2018 21:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLXVKw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:10:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33023 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVKw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 16:10:52 -0500
Received: from [192.168.0.117] (188.146.78.210.nat.umts.dynamic.t-mobile.pl [188.146.78.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 79F20CF2A8;
        Mon, 24 Dec 2018 22:18:31 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v5 29/30] mesh: Sample Mesh Joiner (provision
 acceptor)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219042016.25538-30-brian.gix@intel.com>
Date:   Mon, 24 Dec 2018 22:10:50 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <90DD36EA-CFFE-4F6E-92E5-394039F5FDBF@holtmann.org>
References: <20181219042016.25538-1-brian.gix@intel.com>
 <20181219042016.25538-30-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> mesh/test-join | 408 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 408 insertions(+)
> create mode 100644 mesh/test-join

same here, use clean names and put it into test directory.

Regards

Marcel

