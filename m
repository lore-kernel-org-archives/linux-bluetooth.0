Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D702C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350187AbiEDWMN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiEDWMK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 18:12:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0B11A30
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 15:08:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so2676848plg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=044pzmwxAR3y+/KzOPhRhKK0eTluR8LsFQbWCyRY/Ko=;
        b=Oy0aOUxnvACHXJsLHyFx4FDU+tBqzOu/QhnEgZhQVQeScaUs9AAQtq8Qq+M3rwPQ4c
         EVE1HSorDCwxNsE8QtlsXTV+48qw+3O6IXLBJGeHdYCdrNENiFcu9EhKj/++lgJpH8hA
         e//8FGTZWMs4BCPu7nJmvUviS1i+9Bt0kUp9rXZX4DZks8tFzWHUKYCpjbwtTxw3p3B0
         XVdoJw0fFCr3NzSfRIL3T4k16+VdF9MUzwbbxYS4dB8W8hsgyfrwnWhal1CwdSHthpuB
         uFQqMTMhKoq71gavqwUvy6VFHoSjOJiEBuUUgKa/uJN+8XLR+wNPm/R6l0xWio9oOXRU
         kChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=044pzmwxAR3y+/KzOPhRhKK0eTluR8LsFQbWCyRY/Ko=;
        b=esbmnFAGyraqyGoKnZrquN2TU5CC7mGya+K+eOFdboBmwH+lvONxYvoymSjTZ2NbcY
         3M12/N2qZs90trjfcUnPj3h768PnBEy0HqQDKlHgkIP/JiIgnvwxCv3Cz97QLmKRBnFO
         gf2kNn+ChogtVxIdG/YGPCQrUpJv4uM2ewO+FNL2DnjkqpctUKjMp5dFHhvOC7/iMbCE
         T6feoZ09uvdqbfOEbrwhGAMvxpRlbB/mdzIlWCqr78M66v/wjqE+YIkT5ceQlvZpuchb
         R82xXhddGQsaS5csjoHohhb7bwY2GHPZovtOikfwrGhCHMD7fGQqO9z9XIIt0GkI4fLr
         EY2Q==
X-Gm-Message-State: AOAM531553Xen3dUlANOKCnYQ7jSF3Gmp7knZGop1n3hyDQOjV1r1Onj
        ad9Gi2TDKLotKBxjA884PXcZvqou9saT8cA5Vmo=
X-Google-Smtp-Source: ABdhPJzjade8SAwuBOT1J4jf+/BzGgIZCMsD0lobbDIeqyZ6hNfUWW4O9L9CPCyQEEJQjc8UfRRDWqKWHmOysvXWXIU=
X-Received: by 2002:a17:902:ecc7:b0:15e:8685:77d with SMTP id
 a7-20020a170902ecc700b0015e8685077dmr24545265plh.20.1651702111442; Wed, 04
 May 2022 15:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com> <20220504140940.Bluez.v3.2.I52f3efc7576fd0048437f1419dd2e1e687f7ac65@changeid>
 <6792e558daf326716ac0ac87867367cd91da3b45.camel@hadess.net>
 <CAB4PzUq0FKEE2JbwO6nss3s42M6rbNSt6BGGoGVhuzzR2+1mNw@mail.gmail.com> <CAB4PzUoPyD2KyN4mRbUKGw5BbbyysaZdi7+0hmWrGDJdmk7Www@mail.gmail.com>
In-Reply-To: <CAB4PzUoPyD2KyN4mRbUKGw5BbbyysaZdi7+0hmWrGDJdmk7Www@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 May 2022 15:08:19 -0700
Message-ID: <CABBYNZ+J40t0trsCy8jmehNQs3+6KwXCPm-JW1P49P5BzHGoqg@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/3] doc: add "Bonded" flag to dbus property
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Wed, May 4, 2022 at 3:04 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Hi Bastien,
>
> To avoid confusion, I would propose to update the description to "key information".
>
>                         Indicates if the remote device is bonded. Bonded means
>                         the key information created from the pairing process
>                         has been stored.
>
> Thanks,
> Zhengping
>

Ive changed it a little bit:

https://gist.github.com/Vudentz/ca59d846b4ff840e2ee4c01f6965def6

> On Wed, May 4, 2022 at 2:47 PM Zhengping Jiang <jiangzp@google.com> wrote:
>>
>> Hi Bastien,
>>
>> Thanks for the comment. They are not the same for Classic. "Bonded" means the key information is persistent for both LE and classic.
>> For classic the stored information is "Link key" for LE it will be "LTK". But I think if a device has both classic and LE, the two types of keys can be converted.
>>
>> Thanks,
>> Zhengping
>>
>>
>> On Wed, May 4, 2022 at 2:37 PM Bastien Nocera <hadess@hadess.net> wrote:
>>>
>>> On Wed, 2022-05-04 at 14:09 -0700, Zhengping Jiang wrote:
>>> > Bonded flag is used to indicate the link key or ltk of the remote
>>> > device has been stored.
>>> >
>>> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>>> > Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
>>> >
>>> > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
>>> > ---
>>> >
>>> > Changes in v3:
>>> > - Move documentation update to a separate patch
>>> > - Add description to bonded and paired
>>> >
>>> >  doc/device-api.txt | 12 +++++++++++-
>>> >  1 file changed, 11 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/doc/device-api.txt b/doc/device-api.txt
>>> > index 1e8590b27d58..c7e217c07526 100644
>>> > --- a/doc/device-api.txt
>>> > +++ b/doc/device-api.txt
>>> > @@ -246,7 +246,17 @@ Properties string Address [readonly]
>>> >
>>> >                 boolean Paired [readonly]
>>> >
>>> > -                       Indicates if the remote device is paired.
>>> > +                       Indicates if the remote device is paired. Pairing is
>>> > +                       the process where devices exchange the information to
>>> > +                       establish an encrypted connection.
>>> > +
>>> > +               boolean Bonded [readonly]
>>> > +
>>> > +                       Indicates if the remote device is bonded. Bonded means
>>> > +                       the link key or the ltk from the pairing process has
>>> > +                       been stored.
>>>
>>> "long-term key (LTK)"
>>>
>>> Is Paired effectively the same as Bonded for Classic devices? If so,
>>> would be great to mention.
>>>
>>> > +                       A PropertiesChanged signal indicate changes to this
>>> > +                       status.
>>> >
>>> >                 boolean Connected [readonly]
>>> >
>>>


-- 
Luiz Augusto von Dentz
