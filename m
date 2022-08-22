Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CC8C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiHVRtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiHVRtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 13:49:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF98F590
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 10:49:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id be9so8387502lfb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0QKNjSE840fw5c6vc1rwk9EqtsGXs/RkWczLiFUccxY=;
        b=Kiew+hXydUNAdqnhjUmeSbBP61ABTE71JrelhBjpBY2lqb8Aj4+iwIxY87bullkPl4
         WJVnrphhiUsDTVNULBeR6KAKTvpcN2rZJGSNWHrVNVQQ6IuSb0Kdjg1h5ggOj6ahqYA+
         0vytd4Y7UxcFn6sK9a2Somuh3/MsNcggzycVdZFau8Umslxq6FqSSAlcTJw9qE80kj/U
         2EFPOt4Nn71gDrG1cgY+/HHNPP9FRdC6H9YOuXcbPT1HoetPCplDi51G6O+jjWW4BpgV
         +H+KK/rlwR3x6tGI8aSTnYwC/g+Wl6yoqB3QaCZ0b5GJxbTD2fUJ/mFHK5wHnGsK5QXc
         EjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0QKNjSE840fw5c6vc1rwk9EqtsGXs/RkWczLiFUccxY=;
        b=uACDOfg1YGgi6ZCrj/lfmBdbb7h82WoqhdELQFC578Ngj7CAmhAKQBKd0feKmFTrHX
         2WhcedpiXBFgnQVyKTbKUkn+au6YLPxmJB2LkBSKBfrMOVu4TmnppK8dNnNPrC6ST1VD
         Gs72+Yi08D/A72KqwENPwHNZxaYZClcoHCf+iRySrKnEcZGL+H7Krh3I4tk2PsncFlb+
         U1SyQ0XmDG1lAJcG1rlCkw+nw36Oekc2C0lzG0Toe6oRTlxITX0gUhnBkfHtfi8Iadno
         CngCVw2DYzO1X4cCWjZjo25iUDHH8f3nf86EOr3zgnMbpNA5v6gyvdzijEM27xnRtQdX
         lCEQ==
X-Gm-Message-State: ACgBeo1MbcbzsuRRW/bmMnLb/NpnIT2QhlC1y5kk/depSTrIjRO0SJaD
        hr7E2F6pWtpZNshGM99Vpn7OsnhoFKtWO5LUbxG/2lqA
X-Google-Smtp-Source: AA6agR5UDSZQavTZakGgQdyEv1PXK71aT/FcTARS9/QzJbcs/wSMTBfP880SYquqUKz+eTwCknjFTMO7eO4bUqYXFis=
X-Received: by 2002:a19:9108:0:b0:492:ea66:d05c with SMTP id
 t8-20020a199108000000b00492ea66d05cmr1315518lfd.106.1661190548528; Mon, 22
 Aug 2022 10:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755759CD2C40AE2F350A556FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755759CD2C40AE2F350A556FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Aug 2022 10:48:57 -0700
Message-ID: <CABBYNZ+KRZSBYJiFo2X5CXE-SuYyARScephbJq-nvN9oCH_iXQ@mail.gmail.com>
Subject: Re: Can BlueZ D-BUS API identify local Bluetooth hardware version?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Mon, Aug 22, 2022 at 9:23 AM John Klug <John.Klug@multitech.com> wrote:
>
> I did a diff of "bluetoothctl show [addr]" between Bluetooth 4.0 and 5.1.
>
> Address was random for 5.1 (will that always be the case)?
>
> SupportedIncludes: tx-power was additional for 5.1.
>
> What other API's could be used in a program to discern this?

So you want to figure out via D-Bus or perhaps you can just use
bluetoothctl --version if you want to know the tools version, in most
cases the tools version shall match the daemon version.

>
>
>
>
> John Klug
>
>


-- 
Luiz Augusto von Dentz
