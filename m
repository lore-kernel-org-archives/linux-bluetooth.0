Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F89CC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFC62063A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoHndWgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgFJQIU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgFJQIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 12:08:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E00C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:08:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p5so2446154ile.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsnxLwxfIxCIhVShv/X8/0KZLs/qUxnJjoV3prV2H/k=;
        b=CoHndWgOLO2mGuYd/8nBd9iD47Z2fbJh2wqlLPJrT5Y7qIQNgPT4J/4tpB1c+onh76
         fcrFuDyKh648rk8H7668zA5KBumlwSFpDjLp6vOgPu9u3W15/X8JNsk9XVV02Y5BQsTC
         yWLRKia/8bDRm3uTogadvB13BzDHEqJAhkJzzrWbOZmUU4LmVtkVdn8BBkhYqzq9K4Mk
         FLj8cL12yOPldqWc/M5M7//SqsFuMK9jH3nMYxmsBsA48GGb284wnt64s+cXL3DnQHMh
         6NFZLMVrol1ort+SKNDRItB30/CzGfU+QcF+/vewVXS0zgrk3gBwj0cHmiLQRIaTBW4F
         M4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsnxLwxfIxCIhVShv/X8/0KZLs/qUxnJjoV3prV2H/k=;
        b=GZpMnRPQ3dtJVgkAq9s1DbwYtwhYoi6dFICebavgqGiLyYhkwjAQ3tnrlyJOZ0DZgy
         Q89gxe/Ek9SykHvEQFNhCuE8iAnscL/2TbA0qYx5W4h9ppLobI89t9t+8aEDoBvrEdVa
         ZZ3AwdxhRseGhwvAsdsPIOSHzbNp3tCs8d4beYWhrCnY0JetvLLDCpS7AyRdyazgfQIn
         DPfInhQGQpeJajUl229zDRfgFbwq7D6TqGH8TSYTfAlJRzbFfEd4w3RDa9PAI5U2yUvi
         kTLSWV1wkJEKRPW5PE8fQQgDLm7NjOvVZY6xYkkiE+pmU9FyqiRpP8Pu+KI9673KEuJg
         unTw==
X-Gm-Message-State: AOAM531DZpWCOSXXDqOGBwvYJkcuevFSlftylTv1/DonHM5qEEs+E3uV
        O/2wEI5f5c6cLQwJiB4WDpSi/GMycKnM0C/BKuqGd92E6cQx7w==
X-Google-Smtp-Source: ABdhPJymlfbYtYLU2jrkk4l7GuH1WAgRBV7dNpKIaK3CsoDj2E13JC9kp1xUfHw+++YFGvUUR3KXVQcK9GapsF4FPug=
X-Received: by 2002:a92:c6c5:: with SMTP id v5mr2029041ilm.1.1591805298210;
 Wed, 10 Jun 2020 09:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200609140351.153833-1-alainm@chromium.org> <20200609140351.153833-2-alainm@chromium.org>
 <F728221B-1F3D-421C-9164-BF6D3C9F6A41@holtmann.org> <CALWDO_W4vnn-X-YYJ1AjvYMgoK+aDqY3gxKZOWqMw5x0C0y1Cg@mail.gmail.com>
 <950EAD0D-EFF1-45EC-8F4C-BEDFAF43C4B2@holtmann.org>
In-Reply-To: <950EAD0D-EFF1-45EC-8F4C-BEDFAF43C4B2@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 10 Jun 2020 12:08:07 -0400
Message-ID: <CALWDO_VfEPgO1ys-m=3m9DPRbo4LQ9zVj2GODKX4hPFZYoE2qw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mgmt: read/set system parameter definitions
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I'll be happy to review :)

Thanks,
Alain

On Wed, Jun 10, 2020 at 12:02 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Since this has already been committed in user space, could we agree to
> > keep it as is?  The alternative is that we'd need to re-patch all the
> > userspace implementation through a seperate patch.  Up to you.
>
> we can fix this up easily. And I can do that if needed.
>
> > I won't have time to implement the runtime config ones in the next few
> > weeks, feel free to post it separately, or I can get to it in July.
>
> That is fine, then I will add it for you. It would be just great if you can review it though.
>
> Regards
>
> Marcel
>
