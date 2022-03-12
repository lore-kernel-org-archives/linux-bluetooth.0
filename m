Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 23:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiCLXvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 18:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCLXva (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 18:51:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8EB403EC
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 15:50:23 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id n11so4779783qtk.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 15:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LpoV2jlicpJNNJuUomhEb7K60Xm3p1MQo5Krn5hqxXo=;
        b=Q5C8rfXHSt++L84iNXqXxlK5w0/tERkbpYF6wrXMjZyCdW7UwmeQz2vgZZ+wtZEBvm
         Iha2wmF/dqXfHuLxx4jRZG+vEq3Ma4y5kdlRab2F2URIA7MOcW5eHJthvwtsuF43mA2e
         HPpVylpjxsSj8jKiY0+PYY1CMZvlWlz75Nj8WJvhXqO/FLTdpoTkfy0qpkmfQVWlRxmi
         Frd4K5asLtZwyf32ZSL6zOXn1SDF15dIVLnMP4S/20J/FzpMh7hSQGQFZ4lAUjFwQmya
         3DrW7Zf2WxQBDZvV2KPhOQXhCkytL2hEThpbuMSQwH4obZ9IHo57Lwznm/Xezi6LREwI
         bs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LpoV2jlicpJNNJuUomhEb7K60Xm3p1MQo5Krn5hqxXo=;
        b=kxnAVuHdDrA/SLb9NRVChaozshGhFvsyGgOU3dO/0jb/NWXixq5HnhgZtDJGTbZaxS
         oHxvMY7KPb63gGTmvFcRPjkIKB5qCR9HDcYAT1RHo+XF3lRU3GUMg1FgqL27ComsUoYb
         foTeHYGqY9zP63jVQzv38FjsGq5GZ6ZNEOwIXqRiEpmBtTWK+xeE3kdJGyc2szgHdpTO
         JpO2W8de29aEYXW6AqabqFlZPwhX2sQwdnJ6ZHizHT6cTIMuCYFNQ023CVobNNFNWHeU
         ZECl3Al+bvI0qy8nOk+fWwmOEW3sO+3TVN0ymTw85+egW4s4HbOq78SVspAZl6s/aD6N
         FMUg==
X-Gm-Message-State: AOAM532yYa/LWq35EUDMxt0Ns9IAXNlEC7/MObpTAAmHEsYwF25buKzL
        mh6gg3zvPaqaNs/f71KFrjvR/g0hTe9Y2qaHYaralvkzbjBh5g==
X-Google-Smtp-Source: ABdhPJxL5bQrFNy6R34aXepW3QtoR7f1jr2dUFk5tiGAckXrDFPuaFnLiHGYI7QvgCBmqrUETTf/+44WTO5b3CZoRvQ=
X-Received: by 2002:ac8:5bd4:0:b0:2e1:bbd4:e4a9 with SMTP id
 b20-20020ac85bd4000000b002e1bbd4e4a9mr7633672qtb.73.1647129021746; Sat, 12
 Mar 2022 15:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20220312164550.1810665-1-mike@fireburn.co.uk> <622cdbe3.1c69fb81.494da.e338@mx.google.com>
In-Reply-To: <622cdbe3.1c69fb81.494da.e338@mx.google.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Sat, 12 Mar 2022 23:50:10 +0000
Message-ID: <CAHbf0-GuKQeE8AnrBSeKVEp0udEOr-A7Bc_mT-BtnALBzxcJUQ@mail.gmail.com>
Subject: Re: Bluetooth: hci_event: Remove excessive bluetooth warning
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I get that I'm not supposed to reply, but I'm not sure what kernel
tree I should be basing this patch on

It's currently against 5.17-rc7
