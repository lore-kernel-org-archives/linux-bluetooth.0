Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiDSSni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiDSSnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 14:43:37 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989F31928
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:40:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d39f741ba0so18425873fac.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+lLvyZwJjd5rXuwUvD7SQ0qoSUOSg7cCIUnYISsHV4=;
        b=ENnFmWUQQ8y1gWiUYCHZMKbdz50JaG9rnFbdQpu6aGra7qEW0zZCtb0NCaV3hHgHo4
         CyUQji9pwf+mjo4cWqZRUszOwK25hfx65qe2MbhMohd5HwfMZRGz2iGZk2wxEgoohQXs
         nZlcS54TgmQf/RCM1ckb0V/Q9gSVrjEUftiZn+iPCSD8Gcd017MXxV7A7q/i6gKqqp89
         Bzdb8ik7gyLVWQ+eZnbX84ya1sZXmUBW1rHbwE5sFQl0I0775MaT5YJlXz8jispuQHf9
         JE5p4x+sEZzm0drpVLkT653RyoPvjQ8cmimZ4h/+xcUOdSLxpAyfDeQndYyq2KBv69VA
         51Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+lLvyZwJjd5rXuwUvD7SQ0qoSUOSg7cCIUnYISsHV4=;
        b=ehMDVHZqjUgAyP3MGbClntWe0ATeESiUV23pwkktC0/mU+CgxStQmjTmLUl+IxEbzx
         FlHMygexlhseV/y8RlJEhOxV9S+kpCTijfbQMXQhSnvjw/Y8KQZ/68bFPf3bXYRINOPA
         HC3opQks9jVhfk0Hai5MpDJFwcbyuwrManMX2mBnsUuf7wSBVJDtRFUImpU7w0+uSXUn
         7QisZuyb04oMB5XAP26Dlq4lQYHm6UmBQAnKC3zDFQ0crQgOFtB+YZJiADJ7+ZX29bO8
         B0byzHzjbrn5b0wgyMHX+wuUJUpZAg8ZaLRA1XaHLIi+3fzPhJyqG9byJFJKouer8bz+
         IFCA==
X-Gm-Message-State: AOAM531hKMUaNk1vE2+ZRpqGr3s81N13RSCFmbnRzPr7ualmsSV3xD3j
        69Nh67DbWnn2id+2iRxEwyAyw0uaZ7WmtXyEamU=
X-Google-Smtp-Source: ABdhPJzzwqHy2IwbSn2VMNJgBiGW9uENlyzn1vRNt6+XOe/RtVsWmYSjdaiSBAIpy1f1ica1pnrri3G0NR2Nttvg1C0=
X-Received: by 2002:a05:6870:4598:b0:e5:bffa:56fb with SMTP id
 y24-20020a056870459800b000e5bffa56fbmr6497505oao.85.1650393653310; Tue, 19
 Apr 2022 11:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
 <20220415223049.1155838-3-luiz.dentz@gmail.com> <7222b71167dd3ec90d7b4ad1b12b6179cc95f94d.camel@hadess.net>
In-Reply-To: <7222b71167dd3ec90d7b4ad1b12b6179cc95f94d.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Apr 2022 11:40:41 -0700
Message-ID: <CABBYNZJmGGSZbWZ1=aYkAt6yFo=uP_760mHt_-nq8TeYEbRiBg@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 3/3] build: Make use of StateDirectory and ConfigurationDirectory
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Tue, Apr 19, 2022 at 3:33 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2022-04-15 at 15:30 -0700, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes use of StateDirectory[1] and ConfigurationDirectory[1] to
> > inform systemd what those paths are used for instead of using
> > ReadWritePaths and ReadOnlyPaths which can lead to issues.
> >
> > Fixes: https://github.com/bluez/bluez/issues/329
>
> FYI, my reviews on those patches are at:
> https://github.com/bluez/bluez/issues/329#issuecomment-1102459104
>
> Cheers

Ive sent a couple of patches addressing them, please have a look.

-- 
Luiz Augusto von Dentz
