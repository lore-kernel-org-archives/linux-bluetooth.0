Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D9B610A7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbhELWmi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:42:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53571 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443879AbhELWhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 18:37:05 -0400
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 44A9C60005;
        Wed, 12 May 2021 22:35:55 +0000 (UTC)
Message-ID: <6af830fc74d50c722ecb9855038a00bf6673d4e5.camel@hadess.net>
Subject: Re: [PATCH 1/1] Fix various memory leaks
From:   Bastien Nocera <hadess@hadess.net>
To:     Steve Grubb <sgrubb@redhat.com>, linux-bluetooth@vger.kernel.org
Date:   Thu, 13 May 2021 00:35:54 +0200
In-Reply-To: <20210512133932.4e2b4bd0@ivy-bridge>
References: <20210512133932.4e2b4bd0@ivy-bridge>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2021-05-12 at 13:39 -0400, Steve Grubb wrote:
> diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> index 09bff8ad0..44e3cf3d2 100644
> --- a/obexd/plugins/filesystem.c
> +++ b/obexd/plugins/filesystem.c
> @@ -415,7 +415,7 @@ static void *capability_open(const char *name,
> int oflag, mode_t mode,
>                         goto fail;
>                 }
>  
> -               object->buffer = g_string_new(buf);
> +               object->buffer = buf;
>  
>                 if (size)
>                         *size = object->buffer->len;

Pretty certain this is wrong. It might be best to split the patch up
into its individual parts so it's easier to merge the non-broken ones.

