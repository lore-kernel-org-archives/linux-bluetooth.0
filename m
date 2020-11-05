Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D2C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 20:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A945520867
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="cVqbPPrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKEU3v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:29:51 -0500
Received: from hoster906.com ([192.252.156.27]:34578 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKEU3v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 15:29:51 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 15:29:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=4s17xiYZrwRWevqiJPDEEr0pL
        wsfLsJ8XgukAltaHS8=; b=cVqbPPrNyotx1mSK019uyBNtXBvjmro2lka8bfma3
        xbfRo84CZTQJnJpF9rS7nwgu1uMDaErKQpa2LM3DSb3JUSLSHDPmJzIUh278gG+y
        Irvj5ShXB0hQnlmK8/NGDDRcsRfDun+NRXuECiIDzcpixIXJIUGby+KRp0GxcCLv
        50=
Received: (qmail 9554 invoked by uid 503); 5 Nov 2020 20:23:10 -0000
Received: from unknown (HELO ?192.168.254.79?) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 5 Nov 2020 20:23:10 -0000
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: bluetooth-meshd: Leave borks bluetooth-meshd
Message-ID: <12e1bb50-64da-7e72-c13d-f7486fbd3283@mnmoran.org>
Date:   Thu, 5 Nov 2020 15:23:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meshers,

My provisioning/configuration application supports multiple networks.

In general, everything works great [1] for adding, provisioning and configuring the networks.

I recently added the org.bluez.mesh.Network1 Leave(token) to delete a network. The Leave() operation succeeds. However, when I subsequently try to use DevKeySend() on a different network,
the DevKeySend() succeeds but I never receive any responses from the addressed node.

If I restart my application, nothing changes.

If I restart the bluetooth-meshd, then it all starts working again
until I use Leave() again.

The mesh-cfgclient does not seem to support Leave(), which is not
too surprising since it only supports a single network.

This leads me to believe that the Leave() function in the bluetoot-meshd
is not very well tested. Please correct me if I'm wrong.

I'm willing to poke around in the bluetooth-meshd code if I can get some
pointers from the bluetooth-meshd experts. :-)

Answers:
* I am using the bluez git tip. Rebased today.

[1] Occasionaly, bluetooth-meshd seems to get into a similar state "overnight".

-- 
Michael N. Moran           (h) 770 704 9751
218 Wilshire Terrace       (c) 678 521 5460
White, GA, USA 30184       http://mnmoran.org

