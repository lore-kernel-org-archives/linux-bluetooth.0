Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 14:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhLFOgu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343756AbhLFOgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 09:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638801197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ciYTVnTt17t9gY0YQhSXOJSiviV+55klMrH7xQbl/K0=;
        b=TgcAhfqjtD7kW7ImdrZ6+TTjx6L8lW5AjMTKOtz3WLzxrCvEFtQ9sYy3KFjpAjSRhCjtPA
        4Mvuv4JKchJNFMbZcR+Op309YpcjpXCjjpypCBF+TyCcJ4BE3v0EFeIhifZ4NyXKLUTWAd
        haczsocRDkASXACeKxkthaxvRbbjSgE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-iUQ-Gr1yOn-A8LTx_kG6Hw-1; Mon, 06 Dec 2021 09:33:16 -0500
X-MC-Unique: iUQ-Gr1yOn-A8LTx_kG6Hw-1
Received: by mail-ed1-f70.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so8491457edq.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 06:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ciYTVnTt17t9gY0YQhSXOJSiviV+55klMrH7xQbl/K0=;
        b=atRi50YIFwAwu9dXae1ZGBbzj7OoTDJTBcOs0hRh25MoL1OW5Ed9ezy4zizmV0sp/4
         wsqeFDOGj2fWmNdBft0KqB5zHmXVJWgsmRAvPp+lTq8z2LU2CedBBX3vHpWIr0AcaHfT
         UMi4NDKX7Ldd/K65K755NAotx6JVD60t4SJDJQbQRQQcFI3qBaqryyPKNK0wCD+QsXC7
         dLsB0XpLng8fccsxtXbkyiRla9c75HpQRtOmzc8jAmEmrWiz0WJm+R7CbzL2Cp0W4zzb
         H21ICADI7Pp4YU89o0W925jteoA9AQToHVNX3Q+Y64ZK0TcIhskTRKifm2mEx/AugBHk
         QQ3g==
X-Gm-Message-State: AOAM532n+RX4U4mYfM91zUACIAL8TjsOzK2V9YEEqeBaZjfz5TgFz5qj
        iHbCvjVMMbdwSfZm8LwxlvQWFDimiocizvCT+UysNLLr7e97EspxhO4N+/YwtoQuYYqEZZr3s3H
        1ZDBytvBMseDshZ+hS67NMDXJXiMO
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr46797722ejd.60.1638801195397;
        Mon, 06 Dec 2021 06:33:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZxOOUfkh0DxHwBt2ZniPLX1PyrC/KBOaKOruLLG6EDQYHgeog49M3QgeytpKHA3kF42awQg==
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr46797696ejd.60.1638801195209;
        Mon, 06 Dec 2021 06:33:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id em21sm6612252ejc.103.2021.12.06.06.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 06:33:14 -0800 (PST)
Message-ID: <785d5e1e-b805-8b13-e4ba-7dc64cdec366@redhat.com>
Date:   Mon, 6 Dec 2021 15:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: New bluetooth related lockdep warning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I just got this lockdep warning on my system running a 5.16-rc3 kernel
(while using bluetooth headphones):

[   59.956325] ======================================================
[   59.956329] WARNING: possible circular locking dependency detected
[   59.956334] 5.16.0-rc3+ #662 Tainted: G        W   E    
[   59.956340] ------------------------------------------------------
[   59.956343] krfcommd/2230 is trying to acquire lock:
[   59.956349] ffff8dcfc4f78920 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   59.956386] 
               but task is already holding lock:
[   59.956390] ffff8dcf872cf328 (&d->lock){+.+.}-{3:3}, at: rfcomm_run+0x132d/0x1810 [rfcomm]
[   59.956417] 
               which lock already depends on the new lock.

[   59.956421] 
               the existing dependency chain (in reverse order) is:
[   59.956424] 
               -> #2 (&d->lock){+.+.}-{3:3}:
[   59.956436]        __mutex_lock+0x92/0x8a0
[   59.956450]        rfcomm_run+0x132d/0x1810 [rfcomm]
[   59.956469]        kthread+0x165/0x190
[   59.956478]        ret_from_fork+0x1f/0x30
[   59.956491] 
               -> #1 (rfcomm_mutex){+.+.}-{3:3}:
[   59.956502]        __mutex_lock+0x92/0x8a0
[   59.956511]        rfcomm_dlc_open+0x31/0x340 [rfcomm]
[   59.956529]        rfcomm_sock_connect+0xd3/0x130 [rfcomm]
[   59.956549]        __sys_connect+0x9f/0xd0
[   59.956561]        __x64_sys_connect+0x14/0x20
[   59.956571]        do_syscall_64+0x38/0x90
[   59.956579]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   59.956591] 
               -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
[   59.956602]        __lock_acquire+0x1158/0x1de0
[   59.956610]        lock_acquire+0xb5/0x2b0
[   59.956616]        lock_sock_nested+0x2e/0x80
[   59.956625]        rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   59.956644]        rfcomm_run+0x1346/0x1810 [rfcomm]
[   59.956661]        kthread+0x165/0x190
[   59.956668]        ret_from_fork+0x1f/0x30
[   59.956677] 
               other info that might help us debug this:

[   59.956681] Chain exists of:
                 sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM --> rfcomm_mutex --> &d->lock

[   59.956694]  Possible unsafe locking scenario:

[   59.956698]        CPU0                    CPU1
[   59.956701]        ----                    ----
[   59.956704]   lock(&d->lock);
[   59.956710]                                lock(rfcomm_mutex);
[   59.956716]                                lock(&d->lock);
[   59.956722]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
[   59.956728] 
                *** DEADLOCK ***

[   59.956731] 2 locks held by krfcommd/2230:
[   59.956737]  #0: ffffffffc1796108 (rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_run+0x135/0x1810 [rfcomm]
[   59.956776]  #1: ffff8dcf872cf328 (&d->lock){+.+.}-{3:3}, at: rfcomm_run+0x132d/0x1810 [rfcomm]
[   59.956817] 
               stack backtrace:
[   59.956823] CPU: 5 PID: 2230 Comm: krfcommd Tainted: G        W   E     5.16.0-rc3+ #662
[   59.956833] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
[   59.956838] Call Trace:
[   59.956844]  <TASK>
[   59.956851]  dump_stack_lvl+0x59/0x73
[   59.956864]  check_noncircular+0xde/0x100
[   59.956877]  ? __lock_acquire+0xf7e/0x1de0
[   59.956889]  __lock_acquire+0x1158/0x1de0
[   59.956898]  ? lock_is_held_type+0xa8/0x120
[   59.956911]  lock_acquire+0xb5/0x2b0
[   59.956918]  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   59.956937]  ? rfcomm_run+0x132d/0x1810 [rfcomm]
[   59.956955]  lock_sock_nested+0x2e/0x80
[   59.956963]  ? rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   59.956979]  rfcomm_sk_state_change+0x4d/0x110 [rfcomm]
[   59.956996]  rfcomm_run+0x1346/0x1810 [rfcomm]
[   59.957015]  ? __init_waitqueue_head+0x60/0x60
[   59.957031]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[   59.957044]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[   59.957060]  kthread+0x165/0x190
[   59.957068]  ? set_kthread_struct+0x40/0x40
[   59.957076]  ret_from_fork+0x1f/0x30
[   59.957094]  </TASK>
[   60.547040] input: Bose QC35 II (AVRCP) as /devices/virtual/input/input58

Regards,

Hans


