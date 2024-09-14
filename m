Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31277115
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311507; cv=none; b=Vb1a7et2TjRT4XE57iHm3RYfZdXkVG2W80ADJ67XmWDt/zdoglrtCH3Odl7Zdf4IQ7izXNzDeFckuNoEQu0lR98srQg4jdxvDax3rmnz3MdYhOr6dPB+8qhG407zDRpfkOzLzKasr28ZSgl4T4C0B6vUyTKaqmW2UVFnk3m1wM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311507; c=relaxed/simple;
	bh=DTkYzvnHqco9rQOUXz2XRQZxajWtuXqCK8oXSvONs04=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u2nde7QYUjA/A5G+lNtaxQwRY0WcbwT8dduGb+T5c9GvWhrHn5sV1RhLUaVJoOqRqPwKtMDQvuQYI3AZDzmZVfn/5dTPPWw7PpVgUWlOG8TnsUYn2w8n/bNCvQ8uPF6guAwNw2S8gnXHpyD3PiBiONvl0ynifiVea7LvctjS8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a087f805c1so58856585ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311505; x=1726916305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2C5K8uZnWh3ulLYjAusOjWaZCIxeifUvq8qtQntTFUc=;
        b=kWWXnUUeJob1wXo1SB20sg7D1vBpc0ctQePlQkiBmu3ApljtrwjLzoA7pLLExLUS5f
         862CWCGFMfjnwmoxQpSM2H7t2fZ93rEhxeGyVpUBz4TXlZCRe01JwR5BeS+2W973Ku/3
         M7h5WoN3Z8gPYPQveKZLqZpfcnxT6qvmncj3mB1VRHvfht/8ojz3r6PekvjXHLPg27zd
         0vrkXk3eg4PA6cnyx0cxj9BMoxH19EWFv0wgcSBdsHX7nYX826b8UwZeb2hDMClE1fdD
         gQyN67npAKYVpUp+XQ+48NCmZV2ODrNbxyoW0u8uy+WWmM59aIIaGkw7IihuUykUMV/0
         mCqw==
X-Gm-Message-State: AOJu0Yw7H3E78a84lzLsYOTfhFe+8FlBds1tv6vfBHe4ndGbWlb5meMO
	MwGpPlSyAFB2/zn911qiBcxvx7BlymerUeATW30/GcGCyVDvuET8yuekNt+O2gxIHPsh1OZzwSB
	3H09GS6XGagYJEa5WsEb4BV9/YSEyhdLL7OlGkOwDSq3M+vUIiU3qQTQ=
X-Google-Smtp-Source: AGHT+IEAoNsD7xvfNYkaJsheQNi8xbPTqVG/fWGMbXTWNHBLQFfoUb1IyPFWBeXqy831rozWSVd3KLyeDuj56yOniPfNygW/Px+e
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:3a0:455a:3884 with SMTP id
 e9e14a558f8ab-3a08494a886mr101566885ab.22.1726311505547; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.002e.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Sep 2024)
From: syzbot <syzbot+list5fb7cac78e857facc2f9@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 0 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 70 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22304   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13307   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5704    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3906    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  291     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<6>  268     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  135     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
<8>  134     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<9>  50      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<10> 45      Yes   KASAN: slab-use-after-free Read in set_powered_sync
                   https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
