Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946D19A282
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552408; cv=none; b=u2nQjF7cUFfYE5w1u4RQyiX+5EIIStXIVBavc76TVwOxAaq5nSLPybDGG2sKhnM4ms4mjb2dWU7JZpgt2ZDK+CYKvZSXkN0HFIcyRcn1e9kKMP60cMpx2/wWoxchyXqKeVrYfUCxWKkFkt2fTF97od0V5NFD2+CJj8A4pCi6r8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552408; c=relaxed/simple;
	bh=/oWso4dP3JPRs61+PohQEWF2wq6iHo+TIScLnTuhTRk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R7QbzJR6XfZFmnohF2745kiy5Z8xRhJICW0mc3MFxB1OFrpYgVUdFVFLfGBZvW+/L1i6vjeEYosdamn3HYwPVXH3h4gYO4bsP+NkCXr2SmewTMTfwSdZG6P9xpKoUBx6h0MniBdNUfmGZT6+8Cm0UFFNMPfIvwx6n6uKff8juFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b0bee2173so74010705ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 05:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552406; x=1724157206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zumTife/MYtH/oqkk+FIrK9WbXDIWeEdMMGqqJjzQyg=;
        b=r1wDX+Ld7LC0T3brNwwJvVnHRfcXobnKYpybXsgGV/JAzVGJ5wsNJCohhiHo21e2Qj
         /EcXzvZF1BGYjpSe2Jm3KzJ/dL9HjhqsYPncJzcgjWwcIrXfpFQMCYDJOipaEtis/DYr
         ogaePIMpHqDhwdW+S+VQNFi3RLRaB0YIjImSULTfeAFs0AWueEW7XBni0HDYyqGjajBW
         E/7P1PGxtcd8v149HOnW22sutfqONs7TS4acxuaEmNWHBeGZuN+ZzusMmbd7GH7oobkd
         w9hRH3zHhy3G8T3QaY5dQyyIs+gZuzZlMkQOmyN3CZFJEhq/J6Xm0Akau/rE9txKvikB
         VPsQ==
X-Gm-Message-State: AOJu0YzBWw8LOPhUKnhSaaFxMVcGI/bsD7wvF4cQH9KQ/ov4o7AcidLe
	aTD5iUz9NvAcqxvntR0IDGsJVvfB+qIqm2qsODTl45MzzG1eVJfeZMsILbjbL96AJ7rpHwmNjM4
	0koRCNzpAFnz9vPp64DfdHnZNALwaM1H11Lsr/us8CbZCNszhH1MUd6g=
X-Google-Smtp-Source: AGHT+IGwX6UpUOoK1LFNQCpjSnGHTGqn2HfJRGcBsGmcaQC/efFUpfBpULnKFPn2kRf9jGMsQNV4F2t8o7xFjACcxUODgCc3VGY1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340d:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39d1144e879mr165395ab.4.1723552405894; Tue, 13 Aug 2024
 05:33:25 -0700 (PDT)
Date: Tue, 13 Aug 2024 05:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7ca54061f8fd04a@google.com>
Subject: [syzbot] Monthly bluetooth report (Aug 2024)
From: syzbot <syzbot+list4ec0f2690ef1e1e5b1e4@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 5 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 69 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22077   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13222   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5615    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3578    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  276     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<6>  259     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  130     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
<8>  100     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<9>  76      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 72      Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
