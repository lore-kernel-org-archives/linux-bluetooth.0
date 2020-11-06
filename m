Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F714C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD0A206D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="urrVHUUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgKFWxJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:53:09 -0500
Received: from hoster906.com ([192.252.156.27]:38650 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgKFWxH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 17:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=subject
        :from:to:references:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=dkim; bh=Vh2kFVTD94If
        LC7ksKz3ILzaMfiSlwrtB6Y2WEJ57Uk=; b=urrVHUUoJrfsXGrWCV2F1ANSLSbk
        XTBP8rBYMmM/JqaC+ZuVsqoqNZf6Dh0lj5pwCYBAhmn0m52Edpy9lRKyfP2isQoA
        IHP/AwJAo+ceGSTJXi4LgGDENI75A66HrGEYaRfpig3Evx1z7SnvCnF5Xz0zhREO
        mHzLNZ2+SjP4B9A=
Received: (qmail 38253 invoked by uid 503); 6 Nov 2020 22:53:04 -0000
Received: from unknown (HELO ?192.168.254.79?) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 6 Nov 2020 22:53:04 -0000
Subject: Re: bluetooth-meshd: Leave borks bluetooth-meshd
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <12e1bb50-64da-7e72-c13d-f7486fbd3283@mnmoran.org>
Message-ID: <d7942a2c-9198-f312-c4e3-86d3ec2dea58@mnmoran.org>
Date:   Fri, 6 Nov 2020 17:53:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <12e1bb50-64da-7e72-c13d-f7486fbd3283@mnmoran.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I submitted a patch that fixes this issue.

On 11/5/20 3:23 PM, Michael N. Moran wrote:
> Hi Meshers,
> 
> My provisioning/configuration application supports multiple networks.
> 
> In general, everything works great [1] for adding, provisioning and configuring the networks.
> 
> I recently added the org.bluez.mesh.Network1 Leave(token) to delete a network. The Leave() operation succeeds. However, when I subsequently try to use DevKeySend() on a different network,
> the DevKeySend() succeeds but I never receive any responses from the addressed node.
> 
> If I restart my application, nothing changes.
> 
> If I restart the bluetooth-meshd, then it all starts working again
> until I use Leave() again.
> 
> The mesh-cfgclient does not seem to support Leave(), which is not
> too surprising since it only supports a single network.
> 
> This leads me to believe that the Leave() function in the bluetoot-meshd
> is not very well tested. Please correct me if I'm wrong.
> 
> I'm willing to poke around in the bluetooth-meshd code if I can get some
> pointers from the bluetooth-meshd experts. :-)
> 
> Answers:
> * I am using the bluez git tip. Rebased today.
> 
> [1] Occasionaly, bluetooth-meshd seems to get into a similar state "overnight".
> 


-- 
Michael N. Moran           (h) 770 704 9751
218 Wilshire Terrace       (c) 678 521 5460
White, GA, USA 30184       http://mnmoran.org

