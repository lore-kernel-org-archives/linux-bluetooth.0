Return-Path: <SRS0=S2yS=R2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1363C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Mar 2019 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA332087F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Mar 2019 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkRH8i6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfCWKI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfCWKI6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Mar 2019 06:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so3200856pgk.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2019 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lWGyeabAz3muWJCAlWW4m1e5tlZUwc4hOWvxCco0a9I=;
        b=mkRH8i6JuwLZutasCNF/L2IexMAn4Ba4zx1hUR2wSlIVo5/0rgV6GtJNkilhYA9VqO
         yJfwFgLOPIjjSxLoI0uG9UKIrBz1znSk21lDGskNM+NxEM7PafApfeRjBnmIm3rqy230
         8wbv52/UlLNj1ZNcmVwx90RMUuUh7Nwu2VPzEOtT/ZGMpUdgliMtedOwmm2Vr2IGDnlR
         7FQQwR4o25UJtwspkyrXqds1JWFM3lnMrzYFA9AidH+5yEKYQk+Du4XeRCjD3aKQtQk3
         aUHHH5xeAcMmpRes7z1wiE1Kf42q4/gnZk9Uzv/Qu2AhOTw9Wrd3fFNL62QegboE5Oka
         2GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lWGyeabAz3muWJCAlWW4m1e5tlZUwc4hOWvxCco0a9I=;
        b=WBHKsNDMlTW3AolZt5khCkRZ7F29FnWaT8ozgq+kugoHBOFTG08fKLjftDAqaNrS+M
         VwkXpkOU+6wUEdlYXetsal4wtDIWAsnmOVyI/yHxlpbH+vze5iEbZB17Rj+r/v4mYQmf
         FeydULNmwR2E9R1VO3A2sSzZzqsaU8/cNhdOYZ/SrrLkzNHBenIHbymE+ppUfzTBy37S
         cWVOFlZe3XEFhun39Eev13fTGFhHCXS5ZHPKcDh4WX9AhInPx2NL9hmzScZeRkc8fedj
         NNveBOjmpxc2HVRx2yxLXake1LVzJHy10BE6r9+xtnU2Ih3mNDCAQ/0gWjs2BgVSz99r
         trzg==
X-Gm-Message-State: APjAAAU8eVL3Pdlk9GiMEgSL7vRvxRcG59wiZZxJ35EtOLTm7T5tir4G
        eTnyKOrN0sCxnER8ipc/SD8=
X-Google-Smtp-Source: APXvYqxq8WcWZJehFEtzySGeveJA2wWGbq2PbtkKQxzS9h2nh3ktAZIdu/rff4Lb4jLDxuG6kg2/Aw==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr14222211pla.132.1553335737276;
        Sat, 23 Mar 2019 03:08:57 -0700 (PDT)
Received: from mward-mobl.ger.corp.intel.com ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id b15sm5637717pgg.90.2019.03.23.03.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 03:08:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <2815DD46-4BB1-46DC-881D-1C30200DAED9@intel.com>
Date:   Sat, 23 Mar 2019 12:08:49 +0200
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E232C390-8571-40A5-9E72-2499E9973959@gmail.com>
References: <20190322034927.6247-1-inga.stotland@intel.com>
 <82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com>
 <2815DD46-4BB1-46DC-881D-1C30200DAED9@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian

On 22 Mar 2019, at 16.00, Gix, Brian <brian.gix@intel.com> wrote:
>>> On 22 Mar 2019, at 5.49, Inga Stotland <inga.stotland@intel.com> =
wrote:
>>> +#       5 - on/off model client menu
>>> +#       6 - send raw message
>>> +#       7 - exit
>>=20
>> Please don=E2=80=99t use numeric identifiers for commands in =
interactive tools. Use intuitive, human readable strings like we do in =
the other interactive tools in the tree. Numbers might be convenient for =
computers, but they=E2=80=99re not particularly human friendly :)
>=20
> We do plan on making better tools, but this is mostly intended as a =
tester script to quickly allow us to test stuff, particularly the d-bus =
APIs, and demonstrate the way the methods are called from python.

Understood, however what I proposed

 - Doesn=E2=80=99t take really any extra effort
 - Is friendlier to the user
 - Is friendlier to the reader of the code (no need to do number lookups =
to understand the purpose of a branch)
 - Is consistent with the rest of the code base

=E2=80=A6 so I don=E2=80=99t understand why you wouldn=E2=80=99t want =
that, even if it=E2=80=99s a quick test tool :)

I suppose the long-term idea is to provide the same kind of interactive =
command-line interface as meshctl has provided for provisioner and =
configuration client role? In fact, would it make sense to keep using =
meshctl for that and hide the detail whether stuff is going via meshd or =
not?

Johan=
