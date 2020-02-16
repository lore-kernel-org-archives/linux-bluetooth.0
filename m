Return-Path: <SRS0=yJGP=4E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3703C3B1BF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EC02084E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 22:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="Ezhbz+BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgBPWcR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Feb 2020 17:32:17 -0500
Received: from hoster906.com ([192.252.156.27]:52456 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPWcR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Feb 2020 17:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=dkim; bh=aE9QjJHHifti
        OuJO9LY5hofzk6eyQHE0Yn18ovBAasQ=; b=Ezhbz+BW3rQH4Dwv/jKmiPrpZlM0
        TtcupjUBCXZFfSEcc4KvkeJcsbeb1PghvRZndWdkpTzYu+91NHAhSNjP0Nk8hD8A
        3LiUYLMJ7x4rsDCPBtb9uetWt53LPeYRJAJjG1WJW2jJUQdaPSt8NeHApkczQGKv
        RD8DJ9/dSwKyCvM=
Received: (qmail 16021 invoked by uid 503); 16 Feb 2020 22:32:16 -0000
Received: from unknown (HELO ?192.168.254.100?) (pop-before-smtp@162.39.210.60)
  by hoster906.com with ESMTPA; 16 Feb 2020 22:32:16 -0000
Subject: Re: mesh: Send mesh model message to group address
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
 <e2f322b4ba3abb81b59a51d8bb5c3611b968cd4f.camel@intel.com>
 <410faf08-70e6-ebb2-df7d-79ea1ee0b9f4@mnmoran.org>
 <23EFD76B-C427-4AE1-96C7-D4103C243D9A@intel.com>
From:   "Michael N. Moran" <mike@mnmoran.org>
Message-ID: <8c86e780-2f05-ef45-a743-3bb2c66eb64e@mnmoran.org>
Date:   Sun, 16 Feb 2020 17:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <23EFD76B-C427-4AE1-96C7-D4103C243D9A@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 2/16/20 10:17 AM, Gix, Brian wrote:
>> I'm probably missing something.
>> How is this supported in mesh-cfgclient?
> 
> mesh-cfgclient only has a Config Client model. It can be used as a starting point to write an On/Off client or server, or you can also look in test/test-mesh to find an example of a python implementation of on/off client and server.

Ah... the test-mesh python code is interesting.

It appears that test-mesh application is used to add a new 
device/node to the mesh daemon via dbus, with its own cli 
interface.

That new device/node can subsequently be provisioned and 
configured using mesh-cfgclient.

Once provisioning is completed the test-mesh On/Off Client 
menu commands can be used to send messages to any 
destination address.

Thank you,
mike
