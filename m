Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB66C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4017520707
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp+Cm0qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgFPR2A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgFPR1v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:27:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F0C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:27:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b8so20001303oic.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcSi4XIiZu8mWAdlSdh3dMFVQnsF6c8lJxJLbFTpxRc=;
        b=gp+Cm0qWTvP+1CEFcVel+jXGo3pkWb8YRgDpDF1o4x8gLNU/naZ9gHsf8tPfO7cQSq
         TC8tBFc5YvqJht4oPd1eIN229rMZuFKqzXU7Q9FTYvp+7aQQfUhm5LkUXzxl6qv29SYg
         MpsZhj1rZLqrRn0UmybAzYWx9+yGCDtAVur2oGev5y0Vos2VYjQdUjaMycS/cpApwDl2
         JrM48/CIDOuZO3TO3IUdpW8GMGRO5QmwzUKDqRP3CikUmRYvq0Qqlpy1/qkMrLmvUqHg
         aUO1NRHGNFWPPaY+JulfcE+gCPx7WYyELnC50vsE0E7FjinUCmZ7j5Zm2KvkXz/ES5hu
         TY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcSi4XIiZu8mWAdlSdh3dMFVQnsF6c8lJxJLbFTpxRc=;
        b=TvE8T7InZiOPthE+VXabY79zomc6phXfM7CJ8Hxy2VO6fFZ+3r7jI8gf+GQZ6jfIww
         RFHsnKiwcuLHTL1o4db9bDsI8NqVk3JivK0/+/5ZJw5/p6cT0WAGZSVMGhHUkDAzAmMO
         jjHF1k5EKFOWErpfKKdTXcZS1fEYrD3IYWRkv5sJgw2xgSMCiZ9xyJArnRGrXZA54c59
         9ejMGMoUj5ZBNWDJTV/ks9yY9zmK6SCXlfPPjwcGLPw3hdsDx2ELlh/boXQLOvK0Adcn
         bbQlhgvRmysc4/HwVNk7vgHwXdeoI1k2vl4Iqkc40hiV+v1VDoiWMayHaZiiHm5WhXQw
         tn2g==
X-Gm-Message-State: AOAM533iZxCjTlLrwWil6S3x/zklmiBTjTB2ym0jkj2tqW/Wxl6cUdsb
        SyudtCA+Cl2HMdON/uP0CR8n3U1eg5jvGJGQV98=
X-Google-Smtp-Source: ABdhPJzmXoCQCYDGWrpLxTJ6rG7gENovDinJv0mCq1+jjMIrX5vbiV3VfN49Qn6A6ngIkEro5WzcQ2vWeQoMIAV64oA=
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr4184366oii.82.1592328470560;
 Tue, 16 Jun 2020 10:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200610092045.BlueZ.1.I27c2620cfdc8ec07adf16dad54579cefcde65aea@changeid>
 <CAGPPCLAofU3_6ZfVk5Yi4L=64ZNgPkvqun1UShpCw=rFAnWDng@mail.gmail.com>
In-Reply-To: <CAGPPCLAofU3_6ZfVk5Yi4L=64ZNgPkvqun1UShpCw=rFAnWDng@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Jun 2020 10:27:38 -0700
Message-ID: <CABBYNZK9PspvCtzqs=bH9FdoKQuht8r3LkZp5=sA5Ng7HbpwFg@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Move HOG UUID definition to lib/uuid.h
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Jun 15, 2020 at 11:40 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Friendly reminder to review this patch.
>
> Thanks,
> Manish.
>
>
> On Wed, Jun 10, 2020 at 9:22 AM Manish Mandlik <mmandlik@google.com> wrote:
>>
>> HOG UUID is defined at multiple places in the code. Move that
>> definition to lib/uuid.h where all other UUIDs are defined.
>>
>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>> Reviewed-by: Alain Michaud <alainm@chromium.org>
>> ---
>>
>>  android/hidhost.c        | 2 --
>>  lib/uuid.h               | 1 +
>>  profiles/input/hog-lib.c | 1 -
>>  profiles/input/hog.c     | 2 --
>>  4 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/android/hidhost.c b/android/hidhost.c
>> index fe0ea2f61..7bc484f11 100644
>> --- a/android/hidhost.c
>> +++ b/android/hidhost.c
>> @@ -87,8 +87,6 @@
>>  /* HID Virtual Cable Unplug */
>>  #define HID_VIRTUAL_CABLE_UNPLUG       0x05
>>
>> -#define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
>> -
>>  static bdaddr_t adapter_addr;
>>
>>  static GIOChannel *ctrl_io = NULL;
>> diff --git a/lib/uuid.h b/lib/uuid.h
>> index ebdcf729c..c7e6269f1 100644
>> --- a/lib/uuid.h
>> +++ b/lib/uuid.h
>> @@ -88,6 +88,7 @@ extern "C" {
>>  #define HDP_SINK_UUID          "00001402-0000-1000-8000-00805f9b34fb"
>>
>>  #define HID_UUID               "00001124-0000-1000-8000-00805f9b34fb"
>> +#define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
>>
>>  #define DUN_GW_UUID            "00001103-0000-1000-8000-00805f9b34fb"
>>
>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>> index a544e062c..e96c969b7 100644
>> --- a/profiles/input/hog-lib.c
>> +++ b/profiles/input/hog-lib.c
>> @@ -61,7 +61,6 @@
>>  #include "profiles/battery/bas.h"
>>  #include "profiles/input/hog-lib.h"
>>
>> -#define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
>>  #define HOG_UUID16             0x1812
>>
>>  #define HOG_INFO_UUID          0x2A4A
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index 327a1d1c3..9335b7e8b 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -60,8 +60,6 @@
>>  #include "attrib/gatt.h"
>>  #include "hog-lib.h"
>>
>> -#define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
>> -
>>  struct hog_device {
>>         struct btd_device       *device;
>>         struct bt_hog           *hog;
>> --
>> 2.27.0.278.ge193c7cf3a9-goog
>>

Applied, thanks.

-- 
Luiz Augusto von Dentz
