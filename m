Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B447C7618E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 23:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjDUXo6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjDUXo5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 19:44:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6B11BD4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 16:44:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so20238671fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120693; x=1684712693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hixhMP6FNA3IBI/+W0OiYDt1RzdLUYjvt+1hvJF06Ls=;
        b=BnNZR146Xyd3osyCJz6ZtkJ6VgCpsuCLd2Dih8y2uwtXxxtDkuzw0ukKlu/YKVKCAA
         e5v5/dsZoprrwR+Um26urO4LUFedYXFhl9KdHFSCgTozVR2s72Y363d08cQEiSLP/Pbq
         5GpdL4D+/5WJvWrETCzB9eqzUWaVQdxGzOYSqGGi4/Ws99PVsBvvZU8e+rYhZsTcvm06
         Ix7strsuoPugj4rYrWmGXsk0R3Ujyiv+uQqlgVf67BPi30oPSR9dF/1f2u9bM00AyS+7
         w0p9FRgN2qhuI4xOZD1VRxpQZ9r83k6JWm9ZQ/F/kYA6s9qrJcjyweM0+mfVg1OOKL0b
         J7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120693; x=1684712693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hixhMP6FNA3IBI/+W0OiYDt1RzdLUYjvt+1hvJF06Ls=;
        b=e8xPcjYC0KqG1fuBfwD8/rJdvXBoCw6d3t/4jG6AJ/+XCCEAgkl9S/q8b06zi2+bBb
         QB2te4oKDkyqtimoZ4o5UTebaPYBLzf4hMN+TK5zZux3TH/xbssKuWiNiD5Uk2vJTI8s
         X/dwfMBtvmYexHVg0hCuKnhvN06N1sSRrmDUYFmkqXBoHpiS2/ks4CJkd5h+Yc6dC9i6
         D5tgqWoaxgatYtBLUm/C9aZ90fHBvrWygYYUgYRrw/FIKs46/ytiE9OgZhG1OWVq7z6q
         SYZB/WX87LLtxXgvlS0Y00YpJYWJ5RaggF1P405W9VSJ24EuOSQU61sYcaAML2y5cUBB
         Lecg==
X-Gm-Message-State: AAQBX9fXRGJGg1CvXi10sWCXGH0EnIVAWjvUykDqpJ/xa3lpQH40C/cY
        gvozODGvwA7/p6lShuIBHkZUtsFQ14aTP7c9rcqyqnqJ684=
X-Google-Smtp-Source: AKy350bMp8rJUlgO0DgQHe4wrDavKBqPVCfirhiEoI+zuVOjszY2+4zZdS05MPs1tx7Fo/VpxgUfDWvZDl0NHD0F/ik=
X-Received: by 2002:a2e:a0d4:0:b0:2a8:ba49:a811 with SMTP id
 f20-20020a2ea0d4000000b002a8ba49a811mr1157538ljm.25.1682120692905; Fri, 21
 Apr 2023 16:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <733a8933-008a-8394-4564-71e49c3a4059@braneaudio.com>
In-Reply-To: <733a8933-008a-8394-4564-71e49c3a4059@braneaudio.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Apr 2023 16:44:40 -0700
Message-ID: <CABBYNZKHE8soV+5tOhMGQay7iSCJoOz6Eo4Cy5QEEmXAqXmw3w@mail.gmail.com>
Subject: Re: Is AVCTP Version Really 1.3?
To:     Richard Greer <rg@braneaudio.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Richard,

It is still marked as 1.3:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/avrc=
p.c#n409

That said I don't think there is much difference, well we better check
what was incorporated with these erratas:

1.4 Bluetooth AVCTP Protocol Change History
1.4.1 Changes from 1.3 to 1.4
1.4.1.1 General Changes
=EF=82=B7 Incorporation of adopted changes to correct various errata. Relev=
ant
errata are
733, 2689.

If Tizen qualified it for 1.4 it is most likely just a version change
that needs to be made, from 0x0103 to 0x0104.

On Fri, Apr 21, 2023 at 4:26=E2=80=AFPM Richard Greer <rg@braneaudio.com> w=
rote:
>
> Hi,
>
> I will start by saying that I am not a Bluetooth expert, but just getting=
 started on Bluetooth development.
>
> In looking at BlueZ 5.66, it seems that the version of AVCTP being report=
ed is 1.3 (in avrcp_ct_record() in profiles/audio/avrcp.c) which correspond=
ed with what is in doc/supported-features.txt (which looks like it was last=
 updated several years ago).
>
> On the BlueZ website there is an entry from 21 Aug, 2014 titled "Bluetoot=
h 4.1 qualification for Tizen BlueZ" that says it was using AVCTP 1.4.
>
> AVCTP version 1.3 was deprecated in July, 2013 and officially withdrawn o=
n 1 Feb, 2023.
>
> If I were to start working on a product that was going to have Bluetooth =
in it, I could not get it certified with AVCTP 1.3.  So, I was just sort of=
 hoping that it was a version reporting issue (due to the Tizen BlueZ state=
ment above about it using 1.4 8+ years ago) and not something that still ne=
eds to be developed.
>
> Anyhow, if someone more familiar with Bluetooth on Linux can explain what=
 is up with the AVCTP version, that would be greatly appreciated.
>
>
> Thanks in advance,
>
> Richard Greer



--=20
Luiz Augusto von Dentz
