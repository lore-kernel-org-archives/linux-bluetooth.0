Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188EC2BB85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C8920771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586894026;
	bh=1Tfa7F6G/eHZuULvkVNU9okQUoW6vF7kPfZUtg/VEZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZiqNM+rjMNdcOUdwL6ykZ/79mCGmbGG9NFch1cxE3F8ngn/sYvp0mQUZRlEiK02hW
	 vb89wHDnX9J8lUTiPpz2NQRxtoF5eIWvxUXiBToSvBQKnplro0ZbxY4EBFcL3r5DE7
	 lpcGkfbygLNHSV6ELHpde7ROsB+IclT94xkveJs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505255AbgDNTxn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505216AbgDNTxh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 15:53:37 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FE620767;
        Tue, 14 Apr 2020 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586894017;
        bh=1Tfa7F6G/eHZuULvkVNU9okQUoW6vF7kPfZUtg/VEZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzHa6E+EvWP+WxqXjhDcXL74Lo+64rWtuvB0IKavlw7DbBmFN8pqmS1sbnrW6kbWK
         QMM6m4g43bKN47R2sn01rl71ZZjb3xrddug7yxMplodLLlsbxcv5ELMnwlZN/H3HiO
         BB7CrvuNmbeGRtKg7jmp89iIQhvKZqMqB2F21zys=
Received: by pali.im (Postfix)
        id 07CF1770; Tue, 14 Apr 2020 21:53:34 +0200 (CEST)
Date:   Tue, 14 Apr 2020 21:53:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 0/3] bluez: Export SDP "Remote audio volume control" item
 for HSP profile
Message-ID: <20200414195334.cucssmdt3xj7lf2y@pali>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
 <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz!

I have there another simple change for updating documentation:

diff --git a/doc/profile-api.txt b/doc/profile-api.txt
index ec18034a6..183c6c11a 100644
--- a/doc/profile-api.txt
+++ b/doc/profile-api.txt
@@ -16,10 +16,33 @@ Object path	/org/bluez
 			If an application disconnects from the bus all
 			its registered profiles will be removed.
 
+			Some predefined services:
+
+			HFP AG UUID: 0000111f-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.7, profile Features
+				is 0b001001 and RFCOMM channel is 13.
+				Authentication is required.
+
 			HFP HS UUID: 0000111e-0000-1000-8000-00805f9b34fb
 
-				Default RFCOMM channel is 6. And this requires
-				authentication.
+				Default profile Version is 1.7, profile Features
+				is 0b000000 and RFCOMM channel is 7.
+				Authentication is required.
+
+			HSP AG UUID: 00001112-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.2, RFCOMM channel
+				is 12 and Authentication is required. Does not
+				support any Features, option is ignored.
+
+			HSP HS UUID: 00001108-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.2, profile Features
+				is 0b0 and RFCOMM channel is 6. Authentication
+				is required. Features is one bit value, specify
+				capability of Remote Audio Volume Control
+				(by default turned off).
 
 			Available options:
 


There is a mistake in documentation that default rfcomm channel for HFP
HS profile is 6. But in reality default rfcomm channel for HFP is 7.
Channel 6 is default for HSP HS profile as can be seen in src/profile.c.
