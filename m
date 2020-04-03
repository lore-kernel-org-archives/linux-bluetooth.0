Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322C2C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE03820737
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFX2qFpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDCVpG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:45:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42698 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVpG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 17:45:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id e4so7473788oig.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6AVOof6asm5hcDloaKNuyIUKdyCsywzyeOEfgn1Rrw=;
        b=fFX2qFpcOeghqczgr5V3xKJkQCTP6XGnEhRX9nPM4JRWuNouMHsLzUTqJ8b4Ep9NMP
         /dypDFgln39dIeFoqv6lFxLCyARSITA4Fb11o+CjNrlcT77hjEbjHBMX7DqHLJrOs+bN
         KVkYK6Ft1BYq9slVKM3HbIm0LRJhE/Tew7nbGu46QUgwBoZ3YImOKR1Z4qN+tqWdN+i8
         XGJEPDnoqtgCQ8aSMKYvS3atH3c9fXIUkKf0NWWytVFC20hjLW7BNf9knVp3NP6mLiRm
         BeOhf/xwy6rFIyZU457kdpy5Po/I9XZRkkm5+SMm8q5/GMrx05Xp5q3sP7jLQdOH1Lfc
         LQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6AVOof6asm5hcDloaKNuyIUKdyCsywzyeOEfgn1Rrw=;
        b=n0sBBJHQoBZ1mWTurBwbIBhK7YtcB/tcwWkfKnjERg7jPcM0EoJ4d9UfvQHLnkzHi0
         F4hqqC7iqNEJO4LLtAnnrbIaa2Od5kMpV1oHy4m5GcLI3cHrUUADRnXCg1DWj7d8FV0a
         9/M+AozYI/S5CW5Syv14KrzXo8QRKneuhSTf0fK88v36JZAoE/AW0YqT1ZH8Q30Tq8SR
         5O6pZ8o6UZTKRsu4A3EOJaqcxNCC5hEoA+IBgpVX1sie9ARCdL26wMiDRtL/+fOeDDxq
         jbC4+HRw5nIKG83hQp4Wam2FQ6Gt53BLgEwFHsV/TPUNt8iw3TSxtRaUtiGrHypf9Vd7
         Y2BA==
X-Gm-Message-State: AGi0PubyvNPH67ovXnGe/8hbVquNs3YnsK8B841+7TgbA25sucHyBiwX
        HAyBON3lBUXIVNnO+0cVc4NBv/BzPxF4+h0IWbcdmBcN
X-Google-Smtp-Source: APiQypJBmq2HrH7/BaZ3s0MsbZJbGUSjkkMOASDif93h6pM9x05y3U98TBS8UYml8BE+iSxPNBfjlkkvHII1xwshbCU=
X-Received: by 2002:aca:5345:: with SMTP id h66mr4918669oib.110.1585950305594;
 Fri, 03 Apr 2020 14:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
In-Reply-To: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Apr 2020 14:44:53 -0700
Message-ID: <CABBYNZLM63OXFcQvP-Z6M_rrYZMVrZyN_EjriaqejJTr5PUn9w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Added Manufacturer Data for Scan Response
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
> A ManufacturerData field is added to the ScanResponse. Keys are the Manufacturer ID to associate with the data.
>
> Schachschal, Maximilian (BSH) (1):
>   ManufacturerData field added to ScanResponse
>
>  doc/advertising-api.txt |  6 ++++++
>  src/advertising.c       | 25 +++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> --
> 2.7.4

Was this suppose to be a cover letter? Imo it is pointless to send
these for 1 patch set so please be more verbose on the actual patch
description.

-- 
Luiz Augusto von Dentz
