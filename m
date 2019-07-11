Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D9C74A4B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7B1208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd8IDQAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGKIll (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:41:41 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44693 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfGKIll (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 04:41:41 -0400
Received: by mail-ot1-f45.google.com with SMTP id b7so5011454otl.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2019 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bypyXXsZe6rgH+t/ppDegqOh62tsGYUe4NCLx4pPEfU=;
        b=Yd8IDQAStCeyZpT7CAMVYwWKE0SMqPHGJNEQiMz2TFX8ZCS3spu/nzGP48gx9XArWx
         IcfLuub3QGFl+VDxoigNAol5iOaUqw9WOYMPVSizf6d/XlpQI5d802V7nV84Oaju9bHr
         EXCN2ELXVyi80pEy4/M+4SLyQz5VgNLLYwJhleCZ1U013UOViV8x5jzgk0UyIu7uXbiN
         Z+/91dvKya/wc32aKeJ/DwMW9vS6dHBLdcvq0Gf4Qw3M1UCuzZoTHrQpJB4D4SN76nvK
         Tzwy+cLQIuDs/2ZrGBP1UDBUyVh3dBn55gqEXfwfeNcC51xQMybVKuJX/eDaFBv9TgUn
         wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bypyXXsZe6rgH+t/ppDegqOh62tsGYUe4NCLx4pPEfU=;
        b=p/4U+4A+xIeZureA+0lWQ4uK5rDoKH8jum2ssmFm8lEH2u9cozRPNKe2JejYs3JYjI
         uTpTUdy06k7qnbDhTLF5NQnezDk+3uuN4DlkqjzJ/e3UfkDaie290J95l2CkD8DY7yvO
         xQ68tjE/zG09Kzc2vu0RL8tAC8c6dCY5RHeOyt4r+QPndJv9zr0DqAOe3/G3oSnOV/ut
         hKH8jgx0Ee6vBiXDUzxbulyRaAA6s+eLiovkOeCHSf+Kxkok0hslKWyIuF722kccXLUU
         BGIHtTSUmG18bJBjz3dMQBoSDDzL8a4cs4uwf+rmy+UCJVd1zc/6oQBg8gjLyn5t6Mk8
         xrJA==
X-Gm-Message-State: APjAAAUoCgdo4O2Cm9LW4l5xW1YLrgJX+LzXe+zfK4PNXUXHRY3hWAty
        xAxcP54KfOz3uwrHrLyRXGEPuTlVZSenTi0ao2o9/z5j
X-Google-Smtp-Source: APXvYqwtls4AyBEqvzLslO34CMcbxw09d+LF5E0kiFrlfarM56U0hnX1K8KBJX4txUTovRSRDj3jdEOIuBLTyWRef6Y=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr2547470ota.79.1562834499974;
 Thu, 11 Jul 2019 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAK_dC=N1qN-OqM=fCTWmX=jmjntiGoTAchwJAbGWeC6nx9kk9g@mail.gmail.com>
In-Reply-To: <CAK_dC=N1qN-OqM=fCTWmX=jmjntiGoTAchwJAbGWeC6nx9kk9g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Jul 2019 11:41:28 +0300
Message-ID: <CABBYNZKH1ufS+-xptzsXDO8Q3JQEk=kAQiG6OA8-xyy8eWO-ow@mail.gmail.com>
Subject: Re: Setting up GATT server using bluetoothctl tool
To:     Edward Fung <jjsheepman@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Edward,

On Tue, Jul 9, 2019 at 2:15 AM Edward Fung <jjsheepman@gmail.com> wrote:
>
> Hello team,
>
> I'm able to set up a few service/characteristic combinations with the
> latest bluetoothctl tool using the following commands:
>
> register-service
> register-characteristic
> register-application
>
> I was just wondering if there is a way to define GATT-based service
> for use only over the BR/EDR transport or LE transport using the
> bluetoothctl tool or any Bluez utility tool? Can anyone shed some
> light on this? Thanks.

There is a single instance of the database, therefore we can't really
have service declared on a per bearer basis, what you should be able
to do is detect what bearer is in use and then return accordingly, we
can however introduce permission to restrict access on a per bearer
basis but this further complicates the usage of these APIs.

-- 
Luiz Augusto von Dentz
