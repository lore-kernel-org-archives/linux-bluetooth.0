Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F03EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 18:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGYSHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGYSHV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 14:07:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D7211B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 11:07:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso1767171fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690308437; x=1690913237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN0zdmQ+1E3hM1xkGjX/rVmaqWp9GiVbOxPA6Ux+FOc=;
        b=JHfgM0kwoOrqBYrpUWzgYP1HE5FAbad5uERuEzAux0Mqh46KxeXlY7DiWtHjxLWS0Q
         tod9E4vRs06Ok8QA06BRAmYAzI8Ru1uIf1raRq/W9Ho7l5Df0Rf1LktBf9pgA4C0GetQ
         jXcPfzkfIVN5bLgyPBrkiq4MBBSpqk2hlq15QJyuXPE+sbIG1bfhtszmp81wSyeg2Krr
         zWWVqSkIP5qYha+qxQ01eowFfc2IXmvchRRG+qvUl2t2z2lnumUIcSBbhfTe2fCkqCcu
         pg9YVNAyj3bthPKAYScpN0UzdJrCwE35USejje3qa7MiZrMNy5imggcYwXftS0oliRXj
         /iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308437; x=1690913237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN0zdmQ+1E3hM1xkGjX/rVmaqWp9GiVbOxPA6Ux+FOc=;
        b=DA2k9w3yL1aV6KMBVULql919TBO1KnaGY2leu76QNktvA5Nlm35bE23gHqA6rXSio/
         KBPujVj2yEC2jSepGNkjis95uZBljlYtfQETk73BGpc6YDdD7T2E/MVZ2apsBgXM0r3a
         KRoP5oRtIp5Ukpe+tgkD8W5wwbcZx0/76zAtfL3sOzNC9ojg+CTHtbZ1Xl1fNzvLPFx9
         mpyhXcJGf5E/8cwAlDkud4yg8J5IsnJfEm+WgDle/BR5vsGUMkZFIi/iXWsYYcWotudf
         Rnk4C88J2DZt/tXpNHS9bkTiqtbH8VmEqeywuyNrxdhcmxhMVehMT7hB8u51sC4cLhNs
         TBng==
X-Gm-Message-State: ABy/qLZK1DfY0voGGs0Zz1Ltir8k/rdkdrPfBZpuey8iTgvD8KfckzeS
        r4ErqwLdEikIUXihlVS/qtHuOEEC+h1hB021rC066Dme
X-Google-Smtp-Source: APBJJlFONmiIsGIkHfAYk/a2JLR6J4s11SAS2KUqGoHh1D8LCkfSWjCvh92AMW77N45ogrpqUM21kmkc2AVCmtHSoAI=
X-Received: by 2002:a2e:9cd6:0:b0:2b9:344c:181e with SMTP id
 g22-20020a2e9cd6000000b002b9344c181emr1112394ljj.19.1690308437225; Tue, 25
 Jul 2023 11:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
In-Reply-To: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Jul 2023 11:07:05 -0700
Message-ID: <CABBYNZ+Keecvkfzf4+m+e3M5ohc6rGHrFs_wYEYzSV9fSt-aZA@mail.gmail.com>
Subject: Re: Bluetooth for hearing aids support (ASHA)
To:     Stefnotch <brandmairstefan@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefnotch,

On Tue, Jul 25, 2023 at 6:49=E2=80=AFAM Stefnotch <brandmairstefan@gmail.co=
m> wrote:
>
> Hello
>
> I have hearing aids, which can be connected to devices that support
> the Bluetooth ASHA protocol.
> https://source.android.com/docs/core/connect/bluetooth/asha
> That protocol is open and somewhat well documented. However, it is
> only supported on Android devices at the moment. BlueZ on Linux does
> not appear to support it.
>
> The idea is with Bluetooth ASHA, one can stream audio from a computer
> directly to a pair of hearing aids. Without Bluetooth ASHA, I'm
> limited to using a battery powered, clumsy accessory from Cochlear.
>
>  I was wondering if it would be worthwhile to support that in BlueZ.
>
> For the record, this has been requested in the past, but hasn't
> progressed any further.
> https://www.reddit.com/r/linuxquestions/comments/l54zku/accessibility_for=
_the_deaf/
> https://github.com/bluez/bluez/issues/481

Don't think there is any objection to having support for ASHA, the
problem is that most of the companies contributing to BlueZ are
focusing on LE Audio which supersedes ASHA, so the challenge is to
find someone to support this feature.

--=20
Luiz Augusto von Dentz
