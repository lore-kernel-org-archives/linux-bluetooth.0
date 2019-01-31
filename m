Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C5BC169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6F218AC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhYlEwWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfAaKty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:49:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38686 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKty (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 05:49:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so2408145otl.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h8YkwEL8ui8ZwNo6oetV5MSn6VXaMzzOrvAnEMbyTcQ=;
        b=bhYlEwWugrj6/09Ltqgr6g3suAjzAP35XWDAdJ6Ac3luw3UBfatsFNBOj2UPz3ZbC5
         AsGrNfAbeIroPslYVK0b4VqM9Iijn3r8Jf0UDSLYty1AInpqpWxzzMXrW1CoynI6MTa8
         Y/TVUz8NYl4ZSdYoVQb/4Ow1Kb4qlst/X4+rZJPYYKhXLrvMpKREuH4VwmldjuZgPxWZ
         k34bwBywBh+p8qIR1Fotq7YuL+wvdT2adtXD51u0EAPqXB+5+MpkKCJDdxVhI+hjRFLW
         1v2lVDXMrO8jbtHWem4vU/C6owBJlndTEmNVqsFT6OHRN9izeupEcL/2UibzBLVgTYIz
         MWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h8YkwEL8ui8ZwNo6oetV5MSn6VXaMzzOrvAnEMbyTcQ=;
        b=SI/Mcor9eJPVpPEXHFLDDAs5nXPKNMZYo0agwk8O7YCtHSQM35+9nmJZbuWDW9AX+K
         wLc23fCxg1FZxKIE+OlbCC4jAoCgU0vIqWRid7Tz7Yq3jzGBUmiVCDJ/dgRiRkLbXGt4
         A66rYbPY/6y4YYQdGgGNXPgvgMnE5FH4o5+isjS/wEC8kqFtiQht4vAdhFaiRpi04eVz
         6/zAvsQHpRvL9nLONjvIXdl7WT79SWkDtFaLk/EJQHMptvZ6NgvlwylvyZgonzCLbLiA
         2afm2qSH8xDH8TTFhvqFMgThQ2Mb2pMlLb4UYTGuxnUa8xNZBzi3uVplvMfSYtoDY9LD
         suMg==
X-Gm-Message-State: AJcUukf/0khLc8C2whcqC2Pm+HPEFyARnf6OCuPhq8yU/NeeY6AYC9rF
        NAGUzb+6coLYSx0yxy8BJqDxNWU5ld7LpfgRHds=
X-Google-Smtp-Source: ALg8bN66rlvBAZ2fCXGt980HM2dMNvVKKj9b0WVbxj2cS0eOHcZkDscbyVTAPzYt1n9JyT1JWEFoZVSXk8/AEwOqgJs=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr26367044ote.84.1548931793216;
 Thu, 31 Jan 2019 02:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20190126102415.23786-1-pali.rohar@gmail.com>
In-Reply-To: <20190126102415.23786-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 12:49:40 +0200
Message-ID: <CABBYNZK2WzHXvmBZXyLqB_xHR13XRxUCnT38ZPY3sDOs=utdFg@mail.gmail.com>
Subject: Re: [PATCH] avinfo: Fix parsing capabilities
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Sat, Jan 26, 2019 at 12:25 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> Function print_caps() expects capabilities buffer without AVDTP header.
> Previously avinfo somehow worked, because AVDTP header looks like
> capability header with unknown category which was skipped.
> ---
>  tools/avinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/avinfo.c b/tools/avinfo.c
> index 02fc1f233..a3298e8c8 100644
> --- a/tools/avinfo.c
> +++ b/tools/avinfo.c
> @@ -809,7 +809,7 @@ static ssize_t avdtp_get_caps(int sk, int seid)
>                 return -1;
>         }
>
> -       print_caps(caps, ret);
> +       print_caps(caps->caps, ret - sizeof(struct getcap_resp));
>
>         return 0;
>  }
> --
> 2.11.0

Applied, thanks.

--=20
Luiz Augusto von Dentz
