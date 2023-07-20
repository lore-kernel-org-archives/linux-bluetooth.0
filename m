Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F8EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTSPl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTSPk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 14:15:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ACD92
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:15:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-563643b20baso733318a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689876939; x=1690481739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDFrknzpf+dQCFatv7YuQwveK4aoP4IrvkuaEmESepo=;
        b=OjXpvibwmXbN7dr536h1f3laD8OUN1y8kdvpn+taorwmzrztHrK21Tt2BTE9qOtHRg
         Wq0bSpMcVM7+KSDf2vyDxEnWe1c2Ib9rV6sJn6eeOcs3pFTfs/JW+LZK2dPoJXudMwmz
         XaFcARQFvdqXhz1ThpdqscbpKuNAYMKTfl9xXY4UpkgQzFrU0kAlMMNazcqWs4Bp2H29
         DQedLhJz9T1YDoGVbTp+P+1dOoo4nyNcsQ6Mx1xIJkRgT3eD1tlb44QwanOOqn/ETK7a
         nY57gNgf/Dj2uSucStUcFCOg4p7wTMIcz4WHKAlr5HOI2wuY4J7QugUsiN3cAyf4pbO4
         ok+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689876939; x=1690481739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDFrknzpf+dQCFatv7YuQwveK4aoP4IrvkuaEmESepo=;
        b=C49a/BmYg0ZEz3mCD2GvBY2j0drSmOo2RVlKuGIlkBv5fJz9PSpawgFPW0DFf/9cya
         yWzBjDl69DofHQTjylM8bHVxQKMfIM/hq9Fg7+qozO4fojo5CjDXALOVicSfn5wTV500
         r8IjIhjq7kr10qmeYkWSxov2B+x6rzUM5449PKlCK2db1fjySlfdg+fZk0f8jbU0RJza
         Nv6QtxyaDG9hblAmalljf9gjJrfxTnb1shegAs1jMw5LUgDetzdwTJul7j8Nui+hTe2p
         AtHlR+ByKat3kqhoKVUkKauEb+rvH2mHX7QHAjCBCFOUmvJxkbIm/RrtMvE1ZB5Sd4nv
         g2QQ==
X-Gm-Message-State: ABy/qLbMGDtD/LTyfCWVqPg50oJPEfjmQGm9qonzPIbmhxjEIC6c8Ubt
        EBox0eJuog4EPb8RjqqLt22zjfXUkCT0Z1Rd3+k=
X-Google-Smtp-Source: APBJJlE9NsL03e5QxeXi6/qs587Wwr0qCLtFOJJ7y3+gE8SAXNHIPY3Af/9viCi51B5C/BHmfdKcCMo6Muuo4P6khfU=
X-Received: by 2002:a17:90a:6949:b0:25e:a8ab:9157 with SMTP id
 j9-20020a17090a694900b0025ea8ab9157mr19205pjm.22.1689876939048; Thu, 20 Jul
 2023 11:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
 <CABBYNZ+c1CfDDQ7GbO5wdQvF-ef=jaVKDcGGnVxHhJN84Edm5Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+c1CfDDQ7GbO5wdQvF-ef=jaVKDcGGnVxHhJN84Edm5Q@mail.gmail.com>
From:   Dynastic Space <dynasticspace@gmail.com>
Date:   Thu, 20 Jul 2023 21:15:27 +0300
Message-ID: <CAEU5HDZVY7hYAK=1FhzSabg9n5Oogq81GqvsuHHJYU7Mr2TXUA@mail.gmail.com>
Subject: Re: Daemonizing bluetoothd
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you for your reply.
So you are saying that you are relying on whatever service manager to
daemonize the process? I am compiling for OpenWRT which uses procd,
not systemd.

On Thu, Jul 20, 2023 at 9:04=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Jul 20, 2023 at 10:42=E2=80=AFAM Dynastic Space <dynasticspace@gm=
ail.com> wrote:
> >
> > I am reading through the bluetoothd code for version 5.56, but I
> > cannot find the call that makes it into a daemon. I don't see a fork
> > or a daemon call. How is it turned to one?
> > I am compiling the code on an OpenWRT system.
>
> We don't call fork anymore, since most likely bluetoothd would be run
> as a systemd service I don't think it matters though.
>
> --
> Luiz Augusto von Dentz
