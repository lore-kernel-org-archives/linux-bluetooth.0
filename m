Return-Path: <SRS0=KupO=3Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B03C35247
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Feb 2020 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D767420674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Feb 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWI5B2v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBESaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:30:18 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44652 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBESaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Feb 2020 13:30:18 -0500
Received: by mail-oi1-f175.google.com with SMTP id d62so1717676oia.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Feb 2020 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAzQeMLR6gNoBDV3AQz8qRzJUhdHOYUBPeR/uOcJaGk=;
        b=KWI5B2v6olihrnBoN0pTjPPX+l4wVSyQU/TU0rbmtQA+lod5/vDeoXKqncDsECR7h6
         vEZ090aaMYGUoLHtwwTbaNivaFhQiyN4BIZswLk54zNi18kIaiMeOtAaA0H3PLyvOqeQ
         8dlf/H7NPrBpQh0lsF6qKouVG7mQs6Wd8X991eLhKHDO/BbsXZEpb/d6pVBpSgWibD3r
         MvfMV47XYSlkk1BAF4/5wb25CoMm3ou9ssiEeozJE69RWzRDuYLLzCHWIt/dwRPWebqX
         LrG7857eI1kSWZ6SpB95KRgO4q2g124GNDhiaXgAQrcKgGBLLACOHXn3yzozv8Z5RsJJ
         ewAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAzQeMLR6gNoBDV3AQz8qRzJUhdHOYUBPeR/uOcJaGk=;
        b=jf/bYXQJBP6B5UjEr/JTQG/nyyU6C9sc7MAXMAL/BwTUfdsSRjMZWkyASn0N93YK/u
         wHb+pV6Bj2hk7MEDsEq2HNYVYcixwj6AfpPeZCuuxQbS7BkdUelu1boqzXk0wy+YoFlF
         9gRUnBzD8+YFjDvBTedSglwBBuTmSiyXugb2SeQdykQcl1xfqRUd7CHGNBhxY/ubYH29
         Diw/xL9vDtSiaF6kWcCUkjr879PzfpFK6iwZkKGo0CQXXnq7hGqQNYg6XYILutCCZTah
         WLPFetzzrIkNSdYIQgOMP0/8gdWC1/1cwO5A032K1D5uG4mqKIAcZK0gucyuMn/rDt2i
         ifOA==
X-Gm-Message-State: APjAAAXmrMg9iddgZlr8vN3kVZx4K562IWb9kVMgA2lNlsXnaErRHrgS
        13IyZEfLRkMaA0zo9Fb+NwJ+4lsaaZ1D2UNG94TYlw==
X-Google-Smtp-Source: APXvYqz31mXrKVjSQc2T6jzpSs824e1YAGYyJk+z/wvdcFILNfZh0dWp2T0TsKos9R5PIsAnsre/JG70JDJYCCNgFRQ=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr4115812oie.110.1580927415864;
 Wed, 05 Feb 2020 10:30:15 -0800 (PST)
MIME-Version: 1.0
References: <CAOVXEJKBm8VhAC4meAUe+e0ZMED5eJKQ90xLpqxoEp-kFiOwyQ@mail.gmail.com>
In-Reply-To: <CAOVXEJKBm8VhAC4meAUe+e0ZMED5eJKQ90xLpqxoEp-kFiOwyQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Feb 2020 10:30:03 -0800
Message-ID: <CABBYNZ+g08zmKN2_Cgkj__Qt+Yoy8crY=702Jw4M14VJ8wWaDA@mail.gmail.com>
Subject: Re: How populate GATT database with bluez
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Mon, Feb 3, 2020 at 10:49 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi
>
> I would like to know is there any tools already available to populate
> GATT database using bluez.
> Please advise me to the right direction where I can look

bluetoothctl can register services if that what you meant when saying
populate, there is also the test/example-gatt-server which registered
a few services as well.

-- 
Luiz Augusto von Dentz
