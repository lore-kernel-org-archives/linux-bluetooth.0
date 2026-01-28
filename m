Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD6343D64
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639915; cv=none; b=Rt9EVCuBeZGP+F4Tv3Zigbul0PO+HcJxANKcIbUgtTqmJLp4ufuUB0QS3TS8oJY39jSPDw3cGQMAQs675sQNRFUmVP9yiHQyF4VTwcwbjPW36tTm4xRnrjzecB+P6YrgRkUNbr4w1NS4AuLyg9sMYW/pFMulNjZ9whMBGC4bIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639915; c=relaxed/simple;
	bh=zXNWvIjs4F6YqMULk2tJeDRU9S2IuJD2liZZibV1TkI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fWvtcNFBmW5mx7JbhKlHs5aBGLXBefwZUIHTVmIyCQSx5ghTLTq4+t1lKle8Zkmm9+h2vCt+PT5swCoMyBHNzShS9cED1VgY6YzgSzCX9HWUps8ltNcELD67x2gANnilm/FGb2/zPV7hrxg50MUYp6MYQ1BFzwQwkHQZNCa+mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-404332162d9so1284353fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 14:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639912; x=1770244712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yycyJvje41UjYay12DlpUJ1KoA4ywrwBoBvXPu+kvYg=;
        b=w27Ji6xbXNBypS4pCfa+YMZM++l76/o+xCQlAIed4IXq9TC7trrsG7LcZRgJjzGPxV
         i1Od6AZrJvcCWsAVDijppMbq0TuQ0ENBABFO9PEXos6rpYihY33BThOnS65ecnU9A5QT
         VUp67bHGLgurDJZ73PdBxAvD0ao9ozuBNfbyHJj3Ha6ZKeVQF+tjFtjJJDGuRumTdg33
         jwXBIHZcsEDMNwAef7NqU8C7JhqflGtL8YVU+7vPfnh4gTObPu2oLlxc+9thiWtEarsN
         jhjkmY/46MVLfi0FiZgWShr1T33KdFmRSUEAT9p+ZpaOz3IsCecV3a33GBVyK4pvRMCe
         vK7g==
X-Gm-Message-State: AOJu0YwxRVpxs4aw8INcrcQBnVoiBQYFXAEQfE6PDclSrNLE3yUkCAdy
	oZEJusU/xKQadVcd76vONi2V/uAg2VL7hoIBf5SrgAz30Gn+4qzLjwD3QOBVJuQWGBtRkGFFJBc
	klcQ+otAMaFmQAboA7dajfnvWRwIkAPN3QohkqWEcFu3KeH2ACXIgCsbMkPY=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8b:b0:659:9a49:9047 with SMTP id
 006d021491bc7-662f20342d1mr3911938eaf.18.1769639912346; Wed, 28 Jan 2026
 14:38:32 -0800 (PST)
Date: Wed, 28 Jan 2026 14:38:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697a8fe8.a70a0220.9914.000a.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jan 2026)
From: syzbot <syzbot+listcdce069f94e74912c477@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 0 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 96 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  45919   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  8086    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  7211    Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<4>  4192    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<5>  3504    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<6>  827     No    KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
                   https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
<7>  770     Yes   KASAN: slab-use-after-free Write in hci_conn_drop (3)
                   https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd
<8>  502     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<9>  494     Yes   KASAN: slab-use-after-free Write in le_read_features_complete
                   https://syzkaller.appspot.com/bug?extid=87badbb9094e008e0685
<10> 452     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
