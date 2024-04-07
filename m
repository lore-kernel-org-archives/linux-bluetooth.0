Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BA39AC4
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498344; cv=none; b=M7YjsKmhMsu7wVPbLLEMQECxs41HqibbTIS0VohBnYiTJ1Jik3xl50QHyHwOtjqxu2ew9psiQWX8kAxPCMSTpAKmcTbmhl3k70xEaB/dsdy9nLnDXF5SwLrJUVrwNTc7pY4V+fqGOrfwkUlinD2E9yQCnVQRus3pj7YVoxCf66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498344; c=relaxed/simple;
	bh=G3SuHFbHFzh8ypZatqs8OpXqZOj87aatW9KjH+JX3+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oZqUkyEIrn8BdSfyMhNC4zAKsTdk2ZgEjD3fJpMeKA2DX0ZCnBpyNddMB6hrdAwnAotGFt5SsHCJDLs5mGMAkEdoNsEpdOeLIF0VQJrLjFJHgOP1uA/G+4s1znP6duk6cdZsSJu2O8WdNOnHOltttAeIIjv8YHEg1Bgvg0u3pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-369ada367a5so32783135ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Apr 2024 06:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498342; x=1713103142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8th6mi8YZ4SsK+AiWToLd2PxMqZqV+eb1WyXiyTunM=;
        b=AWCBuFfkb0xE6nMB7buKHDUaYPifaKkr/B8bgodbLCFGyEEM3qSH1LNYdImgB4FUcG
         m4uPfmXh29nmhgQP8EbxM8sX1/qVYcbj6TfZdSCHq18uxFqtnorbxPYfsRzoJPL2sXBO
         0APN84D/G34sPP90f52pclQ2wdBWA31WNv6s4fdDtSxpvzWmrsrrdjq9OmX8euyq+inp
         fVeFAKVYQleUEglFhiZDVifcla7Mcx7UUwI265Tfj2ptR1KI6ZU3/1PckRDcH4IX5KPh
         SkS7E7tNVCx1JinUgrIm2GgR3mgwiLBYgIAW2I01IOOnsFhZAEhwPXP3kvgRnWKjvkvU
         AUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0gDbXcf2Clre2rKWfm8sH8j1av4hXIrGKnT+zDuvVH05aEOvMstvppjkn8HmgEHS7/1UZ7K0BvWiERij0DOb8kIOBMyFwqUVfBuhYAGWR
X-Gm-Message-State: AOJu0YyE8UAf7YgistAM7oezbrBSugSRZWBbWbbs2cia9W/k6HvPgRz4
	mRie0E+xSHww/g+32e4VxRBj3vgYdZzARGxZqJhu26IQtkBV14jU0v3K55s/JsALtSccQuP9WIm
	Vv+eOMctNirX3w4zMfxdnFwBWIWQS4j8Nm7QHcFvrkQ78KfQ4ASgf+ls=
X-Google-Smtp-Source: AGHT+IFRKc+gPnyLAxAH5+XQEeRuYzDRDNS0sDrq8v2ttGi7NqWFtGQeCgDhZmSWhznz4tsckWDm4Cdcag1QA6QB0dcB1gsjCuuz
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:368:efa4:be00 with SMTP id
 v6-20020a056e02164600b00368efa4be00mr555322ilu.3.1712498342650; Sun, 07 Apr
 2024 06:59:02 -0700 (PDT)
Date: Sun, 07 Apr 2024 06:59:02 -0700
In-Reply-To: <000000000000dd84650615800e67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000647e5f06158217d9@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a0bfde167b506423111ddb8cd71930497a40fc54
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146c679d180000
start commit:   8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166c679d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=126c679d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338efc5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15428f4b180000

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
