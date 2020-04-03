Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEF1C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0982F20737
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urSXbc83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDCVnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:43:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37486 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 17:43:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so8923299otq.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiW9J2LymjJhE0Kaf/UJ37O2+Pxs0/DGHfGu24vgrjQ=;
        b=urSXbc83kDnQyZUJ6pfs3CYdljXhHrswf8p6IX1b8EHOyXdxfj11bFinqEkVbOOKMc
         Yf7KsGscw2acsNUbhYc7Sfly6Oa+jRRopOHzlvF/0LECl/KAvaPPlz+uvfT2M8uawb1O
         pkHS3x4cftBsDFfM/QF4MOLYo2vdm4rW8VIp+7/gWAqpf9ozTt57OV8xVEMqrS99oczS
         Po5cLYR+fAtE6a4c+07Uav7x79rv08XjFbaJAhgPUIL2sounqweTdWTK14fOuIRoWZCU
         voqMmgg55ZAXpEXY0/1lIsmCIllHvGj6jCeluBMaUiYebATHcZq2lVvVXndrZDa371pZ
         xm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiW9J2LymjJhE0Kaf/UJ37O2+Pxs0/DGHfGu24vgrjQ=;
        b=ssZHpNRTBZgZNHcFAvM1FiOy4SjpzzhcnqFBXwA4FlmRmOUX8acc5mef3/zBGL5f0Y
         7YHa3DawGZlvCUfeeYLerjp5+m7RtmogYt/SHCT3hggmDu54s/zmRYHqK5zJ/Dc70Sa+
         zqwH5yxVoRuJYXdzD1jnmN1ZmkGth8DS2Pc2bLzBS1m19fSgKz9UDxQzm5pxgsRisVye
         XbK7fc2xze1Y/nwvS9hDfoXI0QAyN+xB8aAr6txYbk4T2f49UFJjQADTmF0jRD7JjclQ
         xPX6kFYNc13ELVvsocpZnrs5uFPJlSZRmBgaOOSrRt/ICoDOotFtVHNT8XnRj82++bkg
         sJmg==
X-Gm-Message-State: AGi0PuaPKR/YgTs9R0Q5UsZxWx0Zg1uGb8xTeLm73oUeItUHsNEqjKDr
        0wcFv2sWp/U0MNoPI4tb7rJeNOQVs+lX2alEnPk=
X-Google-Smtp-Source: APiQypIafwzA55Mw8PCEzZDxkMifN5GRtuBwpdxvmNx1+D4VjTteIZdcE3+9fpq4R1GABlXBV+zbQcFpgo0lR9hvT34=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr8699872otp.79.1585950184091;
 Fri, 03 Apr 2020 14:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
In-Reply-To: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Apr 2020 14:42:52 -0700
Message-ID: <CABBYNZL25S=U3kF=oLygOc9ktvtFK94+BWzzqFujDDgF22HBwg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix error code in case of invalid offset
To:     "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thorsten,

On Fri, Apr 3, 2020 at 12:43 AM Klein, Thorsten (BSH)
<kleinkastel@googlemail.com> wrote:
>
> Fix dbus error code in case of invalid offset (org.bluez.Error.InvalidOffset).
>
> Ryll, Jan (BSH) (1):
>   fix dbus error code in case of invalid offset
>     (org.bluez.Error.InvalidOffset)
>
>  client/gatt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> --
> 2.7.4

Something is missing here.


-- 
Luiz Augusto von Dentz
