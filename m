Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187232D7D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247349; cv=none; b=ivSd7JzQ1ExJ7vkiyQsuyO/g8G7Wpbf9ditUpDaBEfVopf8Bu+E8/RlHgb1x19xqApEbB7B2YB8miiqhJBJxzCUktu4gbbbpl6cbeMjYOaqxe1LoSfcofpuqPFFXuNKMQBcBVj1hTENuN1ZE5lIBKl6Zzwkcyc+bXSMtyN3j5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247349; c=relaxed/simple;
	bh=kXFV9UoHshjCNKHfOQ/QK2SapSSyuognZrMVhyfHRAg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L2MdLrIrfcwGiqcz9lTalCcegBRzNvwF5zzCbBxz9j+tneg3TQwJKl7Jp5NgkbehjpetbEqVNOr1+TbfNkqzyXbkigEnPSWz+fbOuXDNM15eO+9QRKD4uu6EjNy/LmzGjsc+VguB1+8QE7dDh1bUKIkNBW8kBXqrow/YVc8zoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433312ee468so6975585ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 04:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247346; x=1764852146;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXLCdfVWYDfhLqMpf2ZZ2A81MGaJh2cyN1erqr+EJjE=;
        b=VQOlrACwT678LgyyeH3KBA7ij1QuQX8YcA6Lw88+gJe1Dujez0SJAo+RwEg4ADn0Dv
         2h3HTv91Kk+txdV87ll/4BVwVvEo82w6x9aR4T+th+XqoFBa+2p+AQK7hDVLlIEQ/KTF
         V76CNfFGB5qr76bmeRbA02ABmCfwJfYIPcvJuP4xmJcX2VCOifzNJEU5ZELYnYvNuOIX
         qzU0THtlh457SM5ad7YaB+cu8uP84XSqjTde/sfWOViP92tZf9nVFE27AXRMZZLTLj6f
         37IaRrmvMibT8xDdqEJeBDJzENjbaX7rAq6zC8+8BJDy5XXL7Fm8Y+8arDgdoNcvohXQ
         Sl/Q==
X-Gm-Message-State: AOJu0Ywb3eEHQabmiTA3iBEZsjQvyZNouM9x1mCdCLmLvOv8I6ysfMjc
	aySi0TlZ1DOdb7n58m7edXv7+LhejoCJoT/A1yBBQ6Cqg56IMSrQrL0QU/B2I5mowuVsfD2gjpT
	nQ2FyMPPMb7ohKXXNfhNDRmxIAUymqMSehHMPywGTy5hFzU2ChSVNQa1JvWg=
X-Google-Smtp-Source: AGHT+IHnlI+NFC35D6qerayODBGTnfIUqT+tDTkqascrE1lyN7rtNxtfMKhnvHqF5Y53r+84bTV42qIrOquXIzDzvfUjuAfgOewU
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:db4c:0:b0:433:2cf4:5ffb with SMTP id
 e9e14a558f8ab-435aa880479mr171704775ab.6.1764247345875; Thu, 27 Nov 2025
 04:42:25 -0800 (PST)
Date: Thu, 27 Nov 2025 04:42:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69284731.a70a0220.d98e3.0102.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Nov 2025)
From: syzbot <syzbot+list01ecc151fef18ec81f0a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 3 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 92 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  45175   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  27015   No    KASAN: slab-use-after-free Read in hci_cmd_work (2)
                   https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
<3>  7673    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<4>  3791    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<5>  2456    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<6>  1282    Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<7>  391     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<8>  390     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<9>  329     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 113     Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
