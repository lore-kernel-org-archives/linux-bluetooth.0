Return-Path: <SRS0=kgXe=64=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F22C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 19:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CFA206A5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 19:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieMVzjLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgENTt4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 May 2020 15:49:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbgENTtz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 May 2020 15:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589485793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ym1YlDfqrUxOWzwk7CvpaP2ZKgAbThmLIHlqQvfMk5Y=;
        b=ieMVzjLJmVf+6biq9aC43OrbcQNQH+qk7BIF93BsIw0FnhXuQsiAOKv7yHOYWGh36wn+5v
        HEo3IVS34o66iQmGHEF6NcnE1hUsr2wfajFP55PDC5OTmacMlFxNumruC3iBTMEJjjQVJ/
        nuxkmlAIIVzT1+Thul4PJ+Y/mWsUe8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-HBw73N-mMbWsTNNsm8YEUQ-1; Thu, 14 May 2020 15:49:48 -0400
X-MC-Unique: HBw73N-mMbWsTNNsm8YEUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E1E3107ACCA;
        Thu, 14 May 2020 19:49:47 +0000 (UTC)
Received: from [10.40.195.24] (unknown [10.40.195.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A37C379B6;
        Thu, 14 May 2020 19:49:44 +0000 (UTC)
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        David Heidelberg <david@ixit.cz>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com, pavel@ucw.cz
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz>
 <20200419234937.4zozkqgpt557m3o6@pali>
From:   Aleksandar Kostadinov <akostadi@redhat.com>
Autocrypt: addr=akostadi@redhat.com; prefer-encrypt=mutual; keydata=
 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
 i7qb30Fmhn6zUp82N7PZMQ==
Organization: Red Hat
Message-ID: <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
Date:   Thu, 14 May 2020 22:49:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200419234937.4zozkqgpt557m3o6@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pali Rohár wrote on 20.04.20 г. 2:49 ч.:
<...>
> Please let me know what do you think about it. Thanks

Hello,

Is anybody from bluetooth maintainers able to review and move this
forward? Seems like recent bt headsets are unusable under Linux for
audio conferences at the moment. I have a few that only work as playback
devices.

Pali is doing a huge job trying to tackle the issues in all various
places. This patch appears necessary to get reasonable quality out of
the headsets as the default codec sounds horrible (I mean for HSP/HFP mode).

Thus I and I assume all headphones users will appreciate very much any
support to get things moving forward.

I hope my message finds everybody in a good situation.

