Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE345EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGTSEs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGTSEr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 14:04:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3E2709
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:04:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b961822512so16837321fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689876284; x=1690481084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqyIb3y7DhmqxAzRbbTnaV+7kD6kbOtFxlcaLtBtVl0=;
        b=oLzvKpcyD/mOaUm3o5Afu4B5fAkFaQzV8eJMRkXOJOXmlZwGGb25GLhttYIqRysSsP
         17YQ5P/FEGmPnq2L+nVdphfEeC0qpfkCsHi2GmO23cjv9HkPGgHp87vyxrnk1otDUnje
         gAsikL+LUzzhoDPpPDb+P6fozE/47LA0ie8Kh6SMtIgR+fLo0gDzSJpT9W3pSawtijW1
         Jzk08Pz+YIsMOYtkL8AZLIkc0F9cxvprqY/DFATsmlzumlXL+j5iVf5K/zDnLJm7Ufoh
         Zl78r3UwIWgRm88otiZMIlcL74dzkfloSsP6Ei3i984ZKGacvSJHeOb/2hlaBRhOm230
         z/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689876284; x=1690481084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqyIb3y7DhmqxAzRbbTnaV+7kD6kbOtFxlcaLtBtVl0=;
        b=dsJzhQQDs8Pw6z8KWGV2AHJp7Tzzv/zjP6QmeGLR+PzXP7Hfah8facoeLRMzYiHW0R
         FK2G3q8UZrJqUQHQuHCFywGare5gJyr4hvfdQdxVk2iMCZNmXMXm2cXDi/9UDApEjdo7
         CWtX3Ejtehve57dEe9elgTltKcngItxsuyqTUbXkkb3oT8Hcbq1bQomzJi+NjvEBRRWM
         N1ZZnbE/KoVdTvj6sLHFHGFbrrJJHYhqbAdnKG1HKJCtJGUfFoLPB6FawQWt9PyDyu43
         rsw6BAESLNLazTCGsUiI2Fu9AUSs6hYVss0Kcf5qwu3VKo6naYKEAOv5g020K9NrVr1Z
         Jv3A==
X-Gm-Message-State: ABy/qLYMmMaBqu2FFNsUo5oyfGN507ftjcwetGco+TdzpqVFMwymMM6M
        QwhzX5AQALpkUnKN/8rQRfQhKjdSD4eMRKOVAHrK7U30
X-Google-Smtp-Source: APBJJlE4+/gVVFRD/a2LbwP1GL7hv6XKuiZpnu8oFwJ9xVnNEdF8t+lNebmbvzIrx512WaY+meyOeU/RnZeWWrgMALA=
X-Received: by 2002:a2e:9d88:0:b0:2b6:a22b:42dc with SMTP id
 c8-20020a2e9d88000000b002b6a22b42dcmr2604383ljj.16.1689876284078; Thu, 20 Jul
 2023 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
In-Reply-To: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Jul 2023 11:04:31 -0700
Message-ID: <CABBYNZ+c1CfDDQ7GbO5wdQvF-ef=jaVKDcGGnVxHhJN84Edm5Q@mail.gmail.com>
Subject: Re: Daemonizing bluetoothd
To:     Dynastic Space <dynasticspace@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jul 20, 2023 at 10:42=E2=80=AFAM Dynastic Space <dynasticspace@gmai=
l.com> wrote:
>
> I am reading through the bluetoothd code for version 5.56, but I
> cannot find the call that makes it into a daemon. I don't see a fork
> or a daemon call. How is it turned to one?
> I am compiling the code on an OpenWRT system.

We don't call fork anymore, since most likely bluetoothd would be run
as a systemd service I don't think it matters though.

--=20
Luiz Augusto von Dentz
