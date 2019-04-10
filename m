Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D04BC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 02:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF42082E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 02:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554862856;
	bh=f28MH2lJ5p3lrlUegVvu0keFjVwQ1/gHvgoKScPAJSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BfYsIMDOBTBtMClNkkHWc/mJFffX2F+Ae61Ev9Q+c2ZwppzAj1GwI6oVG/TZBIn7M
	 vnabtQZVmboIF7JXXh/eybIzyIfWEKcNYRw7tAVeQ0bKKgsLgN1xbPxTxsvVdjwRyn
	 DvUSk2FBfFodZqMRN5dt6E1gxkG2myntJEpnMshc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDJCUy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:20:54 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34108 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDJCUx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 22:20:53 -0400
Received: by mail-lj1-f174.google.com with SMTP id j89so607669ljb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLSNy3bJVp7BVkl1lok4xvwCW7Pgx33X0n0klEhHpDY=;
        b=R/yJ0NqvG2dizompCKzG3qNxsiQbuNUrBTTXiRnFNdf3JI8lEtwd1xtH/hDURLbE1p
         V7ODjFobkMGn6g/4qihlqUe+K0HczVWL6o4Ok3UECfNv03El/Pug+ROR5m6kT7qt0gSH
         iIv/8/0OJzKa7ZJKMxJ18a/bY5a1ry5OzHkZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLSNy3bJVp7BVkl1lok4xvwCW7Pgx33X0n0klEhHpDY=;
        b=faQTKUmrISRIhgHknvrrh8n2aImAmoF3Ufyr3YjYx8hCo5cd2QvVa20X+y+/D7sTtD
         4+q6poahPR4a5bzuJDqtOYXyn6gmmY8meJ3e4Rz5RRm9on0/ROCSSj2PBLlqnK483hsG
         YfnEnxI5A/x52Fw+1hLZiz07vJ2I8ir86cskwXI+Ohm++QTGSwzkhG/ZflE27D2EfwsL
         PLz+H+ajMTmKVxk17fAlmPVFmJCH971ER8SEAqT1e72ZmpCQHaJs7j5k+Em3lPQG0Qt8
         9SxoVj81vNNwLBa+fZfRtwxUnBzc6nGpYZtbhnV2mwCLXrtNTbJU+Sy7qx/yBAcaJYGP
         tyqg==
X-Gm-Message-State: APjAAAWfmObc2zzgDpxhRXNxmIZpSgnzd4bpDtY2vcqqGQh5f2qSUpbk
        x6lCIYmhByLcT9M1q4EnwOeFBVRllX0=
X-Google-Smtp-Source: APXvYqyUHjAv+nRDrs6g6HcZLQqo/pLgEq6y/Nl3Z6bXJz8yg1o+sl4eIbxPsZDCU1iiVXPJ+tj8MQ==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr2892742ljj.44.1554862850498;
        Tue, 09 Apr 2019 19:20:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f25sm6287631lfk.69.2019.04.09.19.20.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:20:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l7so582410ljg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 19:20:49 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr20942979ljg.57.1554862848913;
 Tue, 09 Apr 2019 19:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
In-Reply-To: <20190409184917.65062-1-briannorris@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Apr 2019 16:20:33 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
Message-ID: <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 9, 2019 at 8:49 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Badly-designed systems might have (for example) active-high wake pins
> that default to high (e.g., because of external pull ups) until they
> have an active firmware which starts driving it low. This can cause an
> interrupt storm in the time between request_irq() and disable_irq().

Why is the fix not to move the request_irq() down to below the proper
initialization sequence?

That's what drivers *should* do: initialize their hardware first,
request interrupts only after that. Initializing the interrupt handler
before the hw is actually up seems wrong..

              Linus
