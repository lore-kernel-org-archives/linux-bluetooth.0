Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2FDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 22:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F9B20786
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="Oru7qi/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgG0Wrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:47:51 -0400
Received: from hoster906.com ([192.252.156.27]:57740 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgG0Wru (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 18:47:50 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 18:47:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=aIGtX9zi9W5zjNuLkOa3D3TfS
        XfE3Ezgda+99Ph+dbA=; b=Oru7qi/6pyDtuCs8GkpFgKrW2v5viAKQGh+lstEEa
        1Gm1FkhIx8av2EtdRuQr3OtVb3Ch8R90JEtqffx6NZYierdkYCOeqgYyOhveObq9
        wJIKc7RH944zG0hoMw+cSOWTWULzmm7NxjF1sewAr+fj8QP6eZKP/wgWSd1IZp1Q
        uY=
Received: (qmail 13785 invoked by uid 503); 27 Jul 2020 22:41:08 -0000
Received: from unknown (HELO ?192.168.254.79?) (pop-before-smtp@162.39.210.203)
  by hoster906.com with ESMTPA; 27 Jul 2020 22:41:08 -0000
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: Mesh: Continuous Transaction Acknowledgment
Message-ID: <20d1abee-8400-19a9-6f15-d3011a8a3d0a@mnmoran.org>
Date:   Mon, 27 Jul 2020 18:41:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm using a clone of bluez master on a Fedora 32 system.

I was using the Fedora 32 bluez-5.54 and bluez-mesh-5.54-1 
packages, but there are some issues when using mesh-test 
where opcodes are using the wrong byte-order that has been 
fixed in master.

Otherwise, mesh was working OK and I was able to provision 
and configure my device using mesh-cfgclient.

However, running the master branch code I am having a 
problem where provisioning does not complete and in the end, 
a Transaction Acknowledgment for my Random PDU is sent 
endlessly. The bluetooth-meshd does not seem to be sending a 
LE Set Advertise Enable to DISABLE advertising.

I assume that bluetooth-meshd has a timer that that fires 
that should disable the advertisement after some period of 
time (150ms), but the code is a bit opaque to my eyes.

I have a btmon trace the shows the problem if needed.

Also, the btmon trace shows that there are two LE Set 
Advertise Enable (DISABLE) HCI commands in a row just before 
the LE Set Advertising Data is issued for the offending 
Transaction Acknowledgment.

Thoughts?

-- 
Michael N. Moran           (h) 770 704 9751
218 Wilshire Terrace       (c) 678 521 5460
White, GA, USA 30184       http://mnmoran.org

