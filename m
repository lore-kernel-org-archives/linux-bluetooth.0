Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC4C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 18:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjHOSSi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbjHOSSW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 14:18:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62676C6;
        Tue, 15 Aug 2023 11:18:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso995471fa.0;
        Tue, 15 Aug 2023 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692123499; x=1692728299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2mO/J1d7DrBY/NdIMdsnnPNhtFJpeppdqDUW01BnP8=;
        b=JXm5LGs8ur0EZ6X7M3XCNyhkbVte6gAm48EkwWRvt23OLtGCd8/EPC0mI3kLzEHgoP
         kk6q2STfobletEHX1zo5/EQOS7zx+IqUlq8PF4K0LLvyqes/qG6Z/clXghl9uPILgfz4
         swFsoHSTFpLt52awmAE+hp42PSjwq3HilOhRXuiu6MarqeJRhcEzKgk/dRXv5VEI+F1s
         281ghjxOlAm1MJ3usLFdcHSqzdKm7YQAthIepAEsAr9fTBbzShRkWydr5QoEhXQknpS2
         A0V8T7srBOs0fuAvOjfLaIbEMbRN1L3VBjgRm/Kk3ngXqteqdBoaQJ75WpDGtEO0qxFv
         MNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692123499; x=1692728299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2mO/J1d7DrBY/NdIMdsnnPNhtFJpeppdqDUW01BnP8=;
        b=B3814fQNnXmJDwjbr9+wlX1MgmmTVlB5ga+0vMq/vwWGYBgCMGxsOI7xQhOk4cOppJ
         ZOwacLVpMlLY3gw7vK90vsEsW2H0RAaujAhXQPMeZ6ODM8vh9kKOrdk1VKoaO2Zb08Lu
         K9sXi5n6WLHOwrrFcWhwvwUNf+ruuCHIZw46GSxULDeXpsUNZes2tUa1quct9vmGSC7u
         QnBPpUE7wPfUVo3QTuwxgRgi0CCDAF8rqBt1Qxwyik1upKWS/i7JBoFRvenSXeu39/4n
         SdpJmkLTJImMyZP8dnEwrjPSNGvw2s0tmfAdmx/7vTi6jZTq/mV0hD+3FkQIfRpcuhGn
         R2Uw==
X-Gm-Message-State: AOJu0YyZ1pnKHKYRKne1b4/6/KpVlH3/QGG36e51aL28oGkVCW80Jg9w
        hdWbU1ez88tir6qhgfxiNtyW0iIN2saXnyEt6dCrE/ta
X-Google-Smtp-Source: AGHT+IGHMYWYnNV88mLhWgCgeaNMvN7CJwF68vczpVS6ail83z4icAJgjdltqouixBlQvMJiIwSoeN2ubDGOpO4+jOM=
X-Received: by 2002:a2e:7d15:0:b0:2b9:ed84:b2bf with SMTP id
 y21-20020a2e7d15000000b002b9ed84b2bfmr9742338ljc.33.1692123499360; Tue, 15
 Aug 2023 11:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
 <20230814164546.71dbc695@kernel.org> <CABBYNZJmkOpPgF6oox-JAyGAZRxzX7Kn9JQpLPXi_FR=Cf-FOA@mail.gmail.com>
 <20230815111554.7ff6205e@kernel.org>
In-Reply-To: <20230815111554.7ff6205e@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 11:18:07 -0700
Message-ID: <CABBYNZ+mnQ2gKOoezeKfM=CF4ANVGtjM0Zb4a-tnZKYvrw_F5A@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2023-08-11
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

On Tue, Aug 15, 2023 at 11:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 15 Aug 2023 10:59:35 -0700 Luiz Augusto von Dentz wrote:
> > > As indicated by Stephen's complaint about lack of an SoB tag,
> > > it appears that DaveM merged this PR over the weekend :)
> >
> > Ok, since it has been applied what shall we do?
>
> Not much we can do now. Make sure you run:
>
> https://github.com/kuba-moo/nipa/blob/master/tests/patch/verify_signedoff=
/verify_signedoff.sh
>
> on the next PR.

Will try to incorporate this into our CI checks, btw any reason why
this is not done by the likes of checkpatch?

--=20
Luiz Augusto von Dentz
