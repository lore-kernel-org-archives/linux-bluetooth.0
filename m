Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9997C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 16:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE0720899
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NFdwGnZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgE0QYn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 12:24:43 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41569 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgE0QYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 12:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=GebOUm3zhaHND3IwSMm5h5jc5Rf3MM6iD67/0/iW9Sw=;
        b=NFdwGnZsqAm8OGsFPQIHEvOZuCFTdfrDMl2/J+2FqNIAzizGnxzX/JXFbVphZs3YgZ6xzTLl1ciq++DOKyQvVGZSMc2CoiPyvPE5JihGgGZjiwj47oyKzyEcQQjgk53MO/zgPka3YokuuRG9MJcAGVj+OX2plMS7n68VyWPajyGvDb4l8m8tfJ1X0D79ZQG4f8q/wwuPdW0Y33AulCQO95YJRyeQ69EPOzdSIubXtzFl7Zu5YQ2rvz4ElfypHoMd9PY1sd1401/tHJKWtuJ7pWsGEyek5FMpSW53pkdo72tZFLwKJhozdLVOCd+kQLbMm2GFixf3VfjUxkESx5QyAw==;
Received: from [183.83.8.63] (helo=[192.168.0.104])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
        id 1jdyr5-0006FW-Ft; Wed, 27 May 2020 18:24:35 +0200
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, usharma@chromium.org
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz>
 <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
 <20200516075340.3z37ejs3fuhctunl@pali>
 <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
 <20200518165011.jfarrp5mtqoy3mqz@pali>
 <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
 <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
From:   Ujjwal Sharma <ryzokuken@igalia.com>
Autocrypt: addr=ryzokuken@igalia.com; keydata=
 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
Message-ID: <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
Date:   Wed, 27 May 2020 21:54:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz!

Thanks for your response.

On 5/27/20 9:18 PM, Luiz Augusto von Dentz wrote:
> Hi Ujjwal,
> ...
> Testing is one thing but for production we would need a qualifyable
> solution, that said I wouldn't oppose to have the socket option behind
> a module options (runtime) or Kconfig (build-time) so people willing
> to run this code can do on their own.

1. What do you think is lacking in this solution that would make it
qualifyable for production? I believe there are multiple people in this
thread including Pali who are willing to put in the extra effort.

2. I'd be happy with a runtime option which would allow me to test this
as well.

Cheers,
Ujjwal

-- 
Ujjwal "Ryzokuken" Sharma (he/him)

Compilers Hacker, Node.js Core Collaborator and Speaker
