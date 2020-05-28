Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B272071A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 16:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAcTvPSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404818AbgE1QDY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404688AbgE1QDW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 12:03:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8EC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 09:03:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f18so2731958otq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTq/2dCd+ML3kavQj4ipivKXoHS0xVwDAkG8RJcrJ+M=;
        b=iAcTvPSZsIwzCFayGN29q+BGW305o6z5Oi/Tki2X6KZwmbs4NQ4Ks1q1eGrbxKxfPA
         wLCsoRoPNwqPbcuX4WsjDb9ZqBm3hBs6i9w9Uky8eaH1TeiEE+qI2NciLQp+9fwJ7J2N
         9PJ139Ba6lz041Cg3XVMfL7yRZidlRz9Ljg6yg69bbrmIUVRZsC9XatePAHOr/oPnrd/
         ZXpBqeNzBglCRtYO3ulM7rN/yMyzHXE63+nRpsnbDDnO4WiqRz24azwDPpTA/4WU+389
         Bl8braDcE+7LoEH0+hHi5H2eToCwhX0V5U/bY6ZtHJjeCcxhEgRNvDLFGurLmgds05kZ
         pKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTq/2dCd+ML3kavQj4ipivKXoHS0xVwDAkG8RJcrJ+M=;
        b=mvb9khdHrWh/+b8gN4ZrH53ao+xOM92W0en6kaFc8K0n6pBKj0SdBV1jIX4B5QvXoi
         JHYYSnT+G0gGXDJInxJs0QEr8iSFLadJN7jQzI53YY5t7C+94HQSMu+26Qcn27gKPPns
         Nupal3fvASs3BkV39K9Vzj1wz5oD7WNsyrJpoDM5jSwUcAWs3vL8E13lB5Rq+o21w5xQ
         hFwS3mgceNDz7SvCfnxXUS+ELHqjKCIIR0n5ZknDlj28CoCfMVhRqKHwXl6iD8eXQmhc
         94iuWEUxqbE9LjUuEt2mxjMpc1nXlVLHqry8l1H6vDJqnAWCGfkO3KNbEId6v4rxtf2l
         hW/g==
X-Gm-Message-State: AOAM532orQSwLlcjdUEa4W0F1mwJj+2Jiv5WGiZ0+iCOSqrzSCPZIvwP
        T/FL9d6gypE7K8DFuq9HZpRMcPSMxJELi2Qp4DI=
X-Google-Smtp-Source: ABdhPJxjfEGsJFzPejiFdByT6h2QNRAcTJ1cxTcmYIkI+5PIBJEnauYyuoyvUJOhLTtIVcweGzVsz5azAPuRsVwZYQQ=
X-Received: by 2002:a9d:2049:: with SMTP id n67mr2520675ota.177.1590681800357;
 Thu, 28 May 2020 09:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200528144605.Bluez.v2.1.Idd38f20f6ff4fc0b295a0a4a8655079373216933@changeid>
In-Reply-To: <20200528144605.Bluez.v2.1.Idd38f20f6ff4fc0b295a0a4a8655079373216933@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 28 May 2020 09:03:08 -0700
Message-ID: <CABBYNZ+ei4hTCu8EMbvjF7CdsBsUj+qjwQo6ZDiF8_JMgbc=Kw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] audio/avrcp: Fix media player passthrough bitmask
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, May 27, 2020 at 11:46 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Adjust the values of the passthrough bitmask with the declared
> keys in avctp.c:key_map, according to section 6.10.2.1 of the
> AVRCP specification.
> ---
>
> Changes in v2:
> - Fix the mix-up between the first 4 and the last 4 bits of each
> octet
>
>  profiles/audio/avrcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 773ccdb60..6c529bf0c 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -298,8 +298,8 @@ static unsigned int avctp_id = 0;
>
>  /* Default feature bit mask for media player as per avctp.c:key_map */
>  static const uint8_t features[16] = {
> -                               0xF8, 0xBF, 0xFF, 0xBF, 0x1F,
> -                               0xFB, 0x3F, 0x60, 0x00, 0x00,
> +                               0x1F, 0xFA, 0xFF, 0xBB, 0xF3,
> +                               0xBF, 0xF9, 0x06, 0x00, 0x00,
>                                 0x00, 0x00, 0x00, 0x00, 0x00,
>                                 0x00 };
>
> --
> 2.27.0.rc2.251.g90737beb825-goog

Perhaps we should add a translation table so when we update the
key_map we automatically update the features as well otherwise we
always risk having these out of sync.

-- 
Luiz Augusto von Dentz
