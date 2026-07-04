Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4293389114
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783139555; cv=none; b=goWSzNyaIUrWSBaeDlBv6T3a968t2/z0zkMoLpu2NNmDgtovRtTMBUBQEQAC3lmHpJQt0jKpdpfZ6uK2tWuN7yIQe8lD/EFiOwioHWSjMGEpdaRPpMlA2uMUWJ4xhBjgIgnTIJANQa3j3XORFpEYzlfnvU33dg7K47pRH8C6e3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783139555; c=relaxed/simple;
	bh=06gc9IXpC2jofr+SXsgUCFWPC/mfwj+s1of1GafUVRY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y1zssu97trvnB8EOgxtz+kEwQMfUrT7sDGxwLZd6JOpW0ggcypzyS1fWbB/5hsp8mn65moUGeApTP805IOGbrfUgTxX5iF1IyJt0eXJjvci2lNAO14jjjB8im34XvtjIcV3n0frm+JSJU2JS/5JXuCATIijhfIpkIqCwmc5JgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6a1625758a5so1213346eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 21:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783139543; x=1783744343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5P/fePy8QSpMNDezmlu6pffCePyENab8eqxU66rFLWA=;
        b=QR+ZacJhKwBE9JjdWb6Oebbt3a6//qZh7fBxGvczosOi+4Du863NPov4GmqE3rRAAi
         3hswi3S2WsaunbHv4GZpw7hvkJiGp8d+3kAOvZWW8AoLoDiMdaja/91FDH6OgHS1ZwWm
         ajSnmegLjrbKoJ51GifEzPyEMuAYCEqd+M2QYSYdcHWaCVr0uESvkbvhaI8ILTUaMiyW
         jkJzXAV/5nK0+aZj140kUz2cv+HK5M6/gH4Shs3Ky1IKDgi3jVnoO729Jo3ZawKOq2ZR
         kjvHdh+lhQEUkqeUQK4NvJosDBQxs1Jq15i1zpN8YqTuw8s8jrVqP6LwvQsAXchK7jTp
         fwMw==
X-Gm-Message-State: AOJu0YxX+l+i7+L32x88q9qY9+AfCY5GMuRoiaG78Vkl8HmmznIaqkGy
	og2eVSeey2qPP2o7yOSRTm9gITFDdFdt86eBsbxUNSYoegN5wFIL1G6kMPqCwnfIzxp/f8jqdlw
	4ZRRS38mMp1eVJG7j9VFOWbojJoJx0v0kTJeguh7s4fiArTxMoyHhq+3lQYI=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f07:b0:6a1:4a27:cd22 with SMTP id
 006d021491bc7-6a32f346dcdmr1121613eaf.0.1783139543184; Fri, 03 Jul 2026
 21:32:23 -0700 (PDT)
Date: Fri, 03 Jul 2026 21:32:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a488cd7.b42ede87.8bd1.0004.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jul 2026)
From: syzbot <syzbot+list07f56372059d168b9714@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 104 have already been fixed.
There are also 7 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9439    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<2>  586     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<3>  374     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<4>  345     Yes   KASAN: wild-memory-access Read in l2cap_connect_cfm
                   https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
<5>  203     Yes   KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
                   https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe
<6>  107     Yes   KASAN: slab-use-after-free Read in l2cap_sock_ready_cb (2)
                   https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
<7>  58      No    WARNING in l2cap_chan_send
                   https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae
<8>  4       No    WARNING in hci_send_cmd (4)
                   https://syzkaller.appspot.com/bug?extid=00f5a866124dc44cce14
<9>  3085    No    KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
                   https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
<10> 191     Yes   KASAN: slab-use-after-free Read in bt_accept_unlink
                   https://syzkaller.appspot.com/bug?extid=a1595e656a83ea5b78eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
