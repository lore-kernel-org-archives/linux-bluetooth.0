Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3161C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD126101D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhJLVws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhJLVwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:52:46 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712BC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:50:44 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e2so1331096uax.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ry9QMHEVk/sXfg8uMxj9k1/d+XtBwm86T/aMlZSaboQ=;
        b=KvRgBncwRaylPrYInyZTOVhkyvM9VhNC2nyBCmx7xALH5eow1rvrPVfAtQWqA56+JN
         qgiLpUbJH9Sp+k7ab9JoFEjKpWvNiIfN1T0ukQroVgnpJST0t9c+4gtDU7nXwyiuaOWb
         5oV7gHvrl7TtoOf2zInmOr6mxf/oMFS/czsfEpwZxbNGtrzMSjUob6mlWcyY4eeVHjpl
         XHZJPyqY1ynj3RcFOOsXjca8PkKSdnKHVaPNlstOjcTtxd+G+gy2boPNwYDeidcNP0js
         PvtnOVdTjUgfwkGM/2uymZ+u17C8lPLrcd4j21AJBiqvDr9Wq8HK3K0K7J/mIUaEziy2
         ZBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ry9QMHEVk/sXfg8uMxj9k1/d+XtBwm86T/aMlZSaboQ=;
        b=zn4kdv4pyxVEP98I+PMfdEN6AAvC2rUPd8Fw641TCkoMK2gvkaJwOBsRpfIPhJs1Jt
         3ErA0vQOh/z5g2vD8wOHxW2Cd2CrKyHaNQN2FbBUGKyqhzCYiFnJ9AYeWWc8LzMkyqef
         iVNaMhh51KX4RvBalqDNWOkIAOHq5UiZ07bJGg8tbxNuoztS9FktxWWQZac/LPdaq65S
         aIIYjvYQ1uZbFvD5YMhtaCH3qqvk7nKv7Zwvgk0nMmdh9WVhD88kYRsnqbvs2RLdtz/k
         +7AM361MeNrj0F8HD/nvIhObbehM5VLnBuguLBBOUDqB6Co8fPAp+dGRQJFZu4MX74Bq
         M5uQ==
X-Gm-Message-State: AOAM53365Lr8jf0tt4fsSfFgfRNQBjUXtgKZLBaacinJ8fTHQ2lOf3WC
        85nXa5+r66w0XFeBsVFb3j9huSZ5xRNMB2cVue/oaMrb
X-Google-Smtp-Source: ABdhPJwE4aEwmcfKjQb029ps6InNxWGxqoijylZjOoyrk9Hsk6NQHco0hjMMYAG7K80G7bU4HFnFEzxVhxsKHGuPI8s=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr25072969uar.3.1634075443657;
 Tue, 12 Oct 2021 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211003101834.45448-1-thomas@t-8ch.de> <61598804.1c69fb81.d279a.fe3f@mx.google.com>
 <CABBYNZ+-7QASvCoA9XJQ_Jmi8=e2-dZQSnL4Xft4Ci_WGb=nPA@mail.gmail.com> <008c2b28-f830-46fe-bc51-9f1714695f37@t-8ch.de>
In-Reply-To: <008c2b28-f830-46fe-bc51-9f1714695f37@t-8ch.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Oct 2021 14:50:32 -0700
Message-ID: <CABBYNZKQbceBLrATpb9GmfrdAOm_tzz3GGFMZWtE+EcOFDn_3Q@mail.gmail.com>
Subject: Re: [BlueZ] Use accurate icons for headphones and headsets
To:     thomas@t-8ch.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Tue, Oct 5, 2021 at 12:07 AM <thomas@t-8ch.de> wrote:
>
> Hi Luiz,
>
> On 2021-10-04T21:15-0700, Luiz Augusto von Dentz wrote:
> > Shouldn't they be proposed to be added to the standard before we do
> > these changes? I mean it is better to have an icon then not have
> > anything or is there a fallback mechanism e.g. audio prefix fallback
> > to audio-card?
>
> The naming standard has not been updated since 2006, I'm not sure it is still
> maintained.
> Each theme can specify other themes it inherits from where missing icons
> are looked up from. The themes I checked either contain these icons or they
> inherit from some that do.
> A standard fallback mechanism by name is not specified.
>
> If you want I can try to submit the names to the standard but they seem already
> be part of the de-facto standard.
>
> Thomas

Applied, thanks.

-- 
Luiz Augusto von Dentz
