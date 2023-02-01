Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A1C636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBATD5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBATD4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 14:03:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB74C3E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 11:03:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id br9so30763115lfb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIYfXXbH0YLdNuKyhSoR7UV30Dc7GEfCrSfiuZy4dT8=;
        b=gx/WghhM4DxaEKjLAnecE//6FsK15ytiibDIqLV9m4ZgWsarb9qRSQ8xwzw/UKsJEs
         uZUAZHQWyX+05fDma2CYnznlLrEiv/o8nboZjbbzoop9AIQZPuN5kfILrIJ0INDwZdeB
         TvBioogSpWBRFiFbKjFX9ImgX/2gNa1pp+EuVmcqOqu+XmlkyqdMJoD1DQOBkpMk40xv
         y5oLrBXhDQHWY96WEfM//73QPb9JacAJNCC/lCGzfc0fDrOPoLxcT2oj2G261I3ztTXX
         W6XRQ/F73ZqmXjhjd5WHYbSNHXePxroL70Bm/qzPlGfUXpJChF4Dmn/YfvXdKfLjQn1X
         q7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIYfXXbH0YLdNuKyhSoR7UV30Dc7GEfCrSfiuZy4dT8=;
        b=5GOnqOpN/kEpk3iIM1H8kvUK46wzMMr1pMz5/zC1DFH34PSRlgWKxm9F52TrnGRHOB
         hkkhkYz4b2CLHfFr/hJ971zMlpy1b6PYyFswdKvAJMxgyBtJI+6HvTpgGUA4ZqGvC10t
         S4XZKQJHD5MxObq3I3tvhxZG8G+eMA3tSE6tXYUwf0pSD+o5hZQ459I+yIuDsZzw/Iyl
         xui8TbeMLrdj/nBrf76/XOIoTwAyorP+pT8xDcC2DVHskO9c+SzRA5jF0ufLukkcsSga
         wUZuJA9s3p8KOquTtx/hxchQTS9x5WcMw3heB9NPl5a48Iu6dnUWeE5Hr7ZEm9RART5+
         Zqvg==
X-Gm-Message-State: AO0yUKVw2LiIq0YtTiQRxq2l6Nw1F9xUzZI5vob+ITbtgoycoXt5+99j
        +7SvlABVixkIbRKcoZHQshYvwMAMSqLWEap+PVNi+APLftEZcOwB
X-Google-Smtp-Source: AK7set/5VBsyNFdL35j9EXMMf2WgjjUTdKcbUD0PW81ZDA1fTTKjiAHqPjuTkR5iZ3UVqBwrvh8nmquVwj5yI7TYLl4=
X-Received: by 2002:a19:ee17:0:b0:4d3:d4e4:9b85 with SMTP id
 g23-20020a19ee17000000b004d3d4e49b85mr641310lfb.46.1675278234024; Wed, 01 Feb
 2023 11:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20230131230105.139035-1-alex.coffin@matician.com>
 <CABBYNZ+wXYH8vag6Xk2X7U7U096_YENasq1cPCEo-0SD5ut_wA@mail.gmail.com>
 <CA+hUFcszm1UnoqeEsViR=0NO4M=rQMu-2DvaefJ70HDNR_9dtg@mail.gmail.com> <CABBYNZLOxU9WphAsjVMHdGYRJ1OF4OBsmRrZF9jMqRa5ktOj+g@mail.gmail.com>
In-Reply-To: <CABBYNZLOxU9WphAsjVMHdGYRJ1OF4OBsmRrZF9jMqRa5ktOj+g@mail.gmail.com>
From:   Alexander Coffin <alex.coffin@matician.com>
Date:   Wed, 1 Feb 2023 11:03:37 -0800
Message-ID: <CA+hUFcuoM+6tQyw0YPnYCJZ6TSrgVfdUf297DVPStGahRhhJLA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix use-after-delete
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> I will prepare a proper patch then, but I don't have access to your
> testing bot so it is probably a good idea that you test it yourself as
> well.

Sure, we will switch to it, and let you know if we face any issues
(the issues don't always pop up right away, and we don't always test
the newest version of the kernel on all of our bots so it may be a few
days before we would notice issues).

Regards,
Alexander Coffin
