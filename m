Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E099224D6
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053427; cv=none; b=o7kF6qz9IhyYZCdfBKqiGkPZAJGdHN+91IFzdyjYGTEQQ9vjK2ZZd6u4S2/PIObv432HEGvCgI4cZhh4iSnGipxo3Qy2nZfnFXeM/YtXM7WnLoytGbdfBeP5d5urefFMBgA3AjkllFrPfJZQ9Rw3/0sdZqabLS0/0ZbLOthM82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053427; c=relaxed/simple;
	bh=NTclJSi3YbSGHgiI5XcsR8AWQhozBRRiLgDmcQF4ATo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OPnyRhHNJSZ6TbKQksWf8DZG5dLrzEqVWlNlXNFq9/oMYJjWBiso+8nfZiVc6wyF2hhHvkm6PR3Jy/kJ1DFYVl77pcVi8xx4AgX3BDygqvXiji8KDJTRT9X3ygpdL+JpotCI6zyG8LlSbJas9VtQjsdRs6XR97mfCc70WUKXCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c2179337so5868835ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Feb 2024 05:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053425; x=1707658225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=739SuBFX3Be2eWWvd/HjWGQMj76u6yId7jGxm6HQSbw=;
        b=V7YBtx3yp25dYQG0AiLos+v2u4C9CfbgAIluFxqUi0c3n0nWMdKybz0apTpTX6Ba2u
         l5izUMP/k5hPE9/VQr87TikAdSWH7BBUxyV70cfwy890/+Mm3Rcreqej6Vtqun5Jeck3
         nY85HrrDVDSoSqtJeckk8VGN7mJJnjoxvWEI3eViM/wx323r2j3HuWm/Fl0aAlqs5WA6
         c+92tgdOFyNFXMidVrNL+9fL1Sz/M/oInp1MDBRaxTQm1Sc1wKxnBYabBHpNxqkQFcN/
         PUlfPuQKB3aLG0tFT2rAY3k3iRVgvbsAtAe61W/p5N2+IjaMfBaz1bs5mWs8Kc3wjFuC
         vM/g==
X-Gm-Message-State: AOJu0YwE2+dNMW5nhslzlD+qxKiilZ/e9JyuIDb1PIBrvPLZENcvUY7i
	Nan3RvSPWvsxSXXYW5OqPS5n+RkeWaoTjyGlUGHaBYFvp+f1ZS4M9C1wOhr9kz8S+CgmtnglHvH
	W9MDwE3lyokKqlZ4fL/4Wqw1MENcmYrox1hfxhV3bG3EkJF3NynRQ7b3foQ==
X-Google-Smtp-Source: AGHT+IHZtwe9wzzCSvXpwP0XCV8e1qgf2CMySJUT6M6548CgiFENx4BQB9w2dxgc3CoPLz/AXw75wO+Oj44ECSF4sz6fu/6k+qm+
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56b:0:b0:363:820f:72b8 with SMTP id
 b11-20020a92c56b000000b00363820f72b8mr894532ilj.1.1707053425494; Sun, 04 Feb
 2024 05:30:25 -0800 (PST)
Date: Sun, 04 Feb 2024 05:30:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a105f06108e597c@google.com>
Subject: [syzbot] Monthly bluetooth report (Feb 2024)
From: syzbot <syzbot+list042bdebb13aff52dc486@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 27 issues are still open and 59 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17527   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  9390    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4897    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  565     Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  143     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<6>  63      Yes   KASAN: slab-use-after-free Write in __sco_sock_close
                   https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
<7>  34      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<8>  20      Yes   KMSAN: uninit-value in eir_get_service_data
                   https://syzkaller.appspot.com/bug?extid=5e132fbe94a9ede456ad
<9>  4       Yes   general protection fault in l2cap_chan_timeout (3)
                   https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2
<10> 2       No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
