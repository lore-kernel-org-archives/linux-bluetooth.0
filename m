Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E6EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 06:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFSGKh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 02:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFSGKf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 02:10:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C06DA
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 23:10:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f85fa03cd9so3030e87.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687155031; x=1689747031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+l56EVhv3DJvNU1IQjzDjseQEvnEEKyVbt3cN52claY=;
        b=F/kNBWEEgaE+8lZUPTIARp5HRaAoZ3OJ/XgML6vdgc6EtwY5p58wPd7kV++KSKFm4b
         OyFBJALpf5kDPATAbF5lTZpwdyu8JFxTuRi+4mcLd7Guw1jwIhL298AzYLOSzwyjpcFs
         diNAyNdCsjpLeq6GebJUxF9gkklqRHhSUKMHppwtT677LSlbWJNIV/RdCVO8WNFa+K36
         OgZIXUfm9t/cUUrLLTNJVyCLnRJeUoJ+PQMpUk/s6c2YsiD1uPs7ajY4/f44OtoctmS2
         w1T49dUAe0bYDleIE21DH/ZQZYp4NMlzFH7d4LkOKrbpxy5b2bL//xP4GGVLpTB7e7dF
         p7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687155031; x=1689747031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l56EVhv3DJvNU1IQjzDjseQEvnEEKyVbt3cN52claY=;
        b=IQA3yKb5wFhYqON24uwnkSBo0e4DRLT/PwE4HhvGf2oghX4y/ITrU9HKtINareLuc5
         kRiTyN9jFNxQIASGGYAGSA0lHNmcpdkPUfXzeWj8pVMmg/9A/QopsbxjkudAUkM5tEoF
         UT8sIzfu8qmjRAaFrwMQpM+0RV8Bk2ywHpufQcezeprPt/ZWWUxb37yzOzUMwiK8OMsk
         sQZLz+i5jHLGlovF6RG6MmGySpxxSvGJXCi8MyCybYCLNdPAAsb5OzoyCrzzLqItzb9b
         2BBrEDu+eWulMjMBAqIQgELVTVFzTHw3k0eLhvyNvQaBqhnKP5Ij1MPu614CP87wOtCY
         QcOw==
X-Gm-Message-State: AC+VfDziNA8tm9tmH3YE4o2N/A9D4j1iCNYbSUlQvTGSYMdHGCPzUSnq
        L+OmjhILOrtcdjn0wM/y5pM4dwgdtug/fRGXqzi+IA==
X-Google-Smtp-Source: ACHHUZ5YZyM2139hV/S/LS2+fvOQj0z9kDkZezC1c+rH06UyGBkfRjikrsYcNhvom7a/Prxm0KpMhNj4eVR2w8dGe7o=
X-Received: by 2002:ac2:5450:0:b0:4f2:7840:e534 with SMTP id
 d16-20020ac25450000000b004f27840e534mr267987lfn.0.1687155031253; Sun, 18 Jun
 2023 23:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000098289005dc17b71b@google.com> <00000000000051087405fe4092cc@google.com>
In-Reply-To: <00000000000051087405fe4092cc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 19 Jun 2023 08:10:19 +0200
Message-ID: <CACT4Y+ZEL5FKx+R7poFFE_v2Di=qFRfv7GNnEoa9f9Y4r6ZK=w@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in sco_conn_del
To:     syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, fgheet255t@gmail.com,
        hdanton@sina.com, johan.hedberg@gmail.com, josephsih@chromium.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 16 Jun 2023 at 17:09, syzbot
<syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a2ac591cb4d83e1f2d4b4adb3c14b2c79764650a
> Author: Ruihan Li <lrh2000@pku.edu.cn>
> Date:   Wed May 3 13:39:36 2023 +0000
>
>     Bluetooth: Fix UAF in hci_conn_hash_flush again
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13755717280000
> start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
> dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10052058480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190687c480000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: Fix UAF in hci_conn_hash_flush again
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: Bluetooth: Fix UAF in hci_conn_hash_flush again
