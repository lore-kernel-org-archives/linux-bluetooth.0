Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69782078E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGqk9YLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgFXAsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgFXAr7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 20:47:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F36C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 17:47:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n6so347109otl.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUEIJjZhaJmPp9QD02Lmmp/Oph+hEEYsDXqu7fkLfOE=;
        b=iGqk9YLPccPLzCy71GS8mYtgRI+LLS0uNOAsofpPNRXFaKs0Tj1n58dMWHgWNvjNB7
         8UbRsrCoFXFNWB661RRdrXxC4eOf9EXNIR54LLB/wYa4JNg7oA5WNpeLYuy9FylcN8gy
         4YOIJRUcYpIQQgtnrwtUpyCk30UJQY7SxqoKRcwNfidoXTb9lvi/U7UeQaRD51fwR2ZJ
         DVTthuu3hrx9tz8TCsO1LjBOgrVvpFSxhD+yr3NzSqrGXCMv8V2GosYwJ/h6OOycizWn
         24vKO8dYI3tC8Pob23SH0HW7Ws5DgpYtKMbz90gDGlhhr7bOfiimHt1yaUSrTp6klXIL
         z4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUEIJjZhaJmPp9QD02Lmmp/Oph+hEEYsDXqu7fkLfOE=;
        b=oIVn0xx8kYwDNPveML15exi/9Hgrd/8IXDz0rtP7x+EnwVoIloj1FP5w3LKYrdW25z
         mT1i62QJBZw2fxVKxfWlFqHGaSgFhBkEt4jaoWIxauioYCKXpw0tsFvyYfEIslTwIzGZ
         s1yRmsS11WQRXSmrCPTQb6qSWwYXJOpZwOIGpDH7MdDbLj+vdcvfVx90aTvapFDYeaQ8
         u2U8ac6gGgTuDlY0geFllG8osaLCDkYYqWIHDLJVdNEJ93zQdV677odJUohU0J3ymlPe
         ysZBUqdU/pjUD6TbAd+wBSJCTbQ/hjoJQt6spUvTVjIvVK1oHPWbMACaI8FgLVLZxwkd
         cJKQ==
X-Gm-Message-State: AOAM5329+iDpyui8SsjpO0/u9GvXhjHlipw7Mzi+I4BErknSDCRrYm9x
        /ZPGgeJACQTDmyu22oCoVdnU7XQRAhpl59zGIoUrvw==
X-Google-Smtp-Source: ABdhPJwdDdUaIzXGvVWzRGfmTYpxkIDOcK63VBR+L1ez+g30VDedS4n54BRVN0N2LgUqYaBIDsqSfJPShFt7PDfG0dU=
X-Received: by 2002:a9d:3da5:: with SMTP id l34mr2158592otc.88.1592959678247;
 Tue, 23 Jun 2020 17:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200621185618.214415-1-2538614+noahp@users.noreply.github.com> <5eefb011.1c69fb81.9a90d.c39a@mx.google.com>
In-Reply-To: <5eefb011.1c69fb81.9a90d.c39a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:46 -0700
Message-ID: <CABBYNZL+nih60qwNrXx1tQTj4M6NgJA4r5PugArEHe4twgA6KQ@mail.gmail.com>
Subject: Re: [BlueZ] src/shared: update uuid16_table to latest
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     noah.pendleton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sun, Jun 21, 2020 at 12:09 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
> Test Result:
> checkgitlint Failed
>
> Outputs:
> 6: B1 Line exceeds max length (83>80): "https://www.bluetooth.com/specifications/assigned-numbers/16-bit-uuids-for-members/"
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
