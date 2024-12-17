Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4982E628
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428846; cv=none; b=ORZCCZ6WlEOPc7ZOkWlrA9Qm+ypfSdS09Z+KfmPwUT9fKt2nJcXZjvswA8MdQ/wDa56hdronTIQqViFeiesTKwTRgP+BVK3gwyE8Z5GidrCGhSuQThf7p7XUH0Qw/54az6pCaOI4x7g+bN/NKeNpzyLC/uOA+YKOrmth1fBiTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428846; c=relaxed/simple;
	bh=5HEZH2B6CHk22BI1HMuRw3sZX+UQFvOOQT6W75ELc1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tv0gL4Ut/ahq0h2oFICejUDzhXYDo7EGulHm8txdiINZgVuVFZ/eLqceB75ZqNXgy/kNt+bH4pIHPJdZnqKryeE+vb/+cvBMN+BtPdftndG/KNHEzQp7InZB35Zj964TbIMs5EqnKLr+A69TnZibeOZG/qz+y4c4IzTneAuw0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a812f562bbso103022235ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 01:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428844; x=1735033644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SacZCQL02OTfHgYO1wkgdlbR5QwW3dwO+inms0XcACI=;
        b=rACJTR3INyeynUBSnENLXT8RHXwKEl3m9B4MEYNQwzhPFm56DQ2WjuRdrcRJTxDCv+
         4pgvBxWuRvdk6TsQhGX39eLKMfXFr/BPOlfjG1bjeafUSYH8HEyvi4pffGj1WiDMTRIA
         OC2xzfQaURct2DbDmobmsHn8DvTDOCY771rDfowRNE9gLZpf8pOBr3lGSFbFGEmSHrbD
         UVMzxcPOf4s/k1l7PoGQPQrzPwAl8/0y3vjTw5KgqIOx/F4VFMlqZ6MopieDDgRvmQTB
         Ylh5lT6unu2mTLgMEPNmkwUh61VOYhIgz/w8+HNdCxxheqi4dCLj5NrNzxHWbs1ouPER
         Os0g==
X-Gm-Message-State: AOJu0YwOi1oGguFJdrp50bPicxcKSWx06uJ7ZxicfWaYDyReEmpb5uHy
	5rBwY7aVdHtTf53vVLwuwIr0DZaubrl29tE5V/MgLkn5qsdGhHLZUVfw27INTTf3y9LB/YtEnBN
	47qQAut3UYOPgNC2Nl5bnyobE4l3BsuI3/paBHEwvlPqMUH/FJoDXOtc=
X-Google-Smtp-Source: AGHT+IE3b2Nm7LnXOOcU/wJ2UwmW0zqSDWdP5nczaji3hQBnBdk6OxmkmdLn/x/E35mlE2lCIBlVLAyOpbxZRnSrbSQPhbguklnF
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168a:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3aff88b85bfmr139383445ab.19.1734428844675; Tue, 17 Dec 2024
 01:47:24 -0800 (PST)
Date: Tue, 17 Dec 2024 01:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676148ac.050a0220.37aaf.0155.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Dec 2024)
From: syzbot <syzbot+list46237703043d572e3df9@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 1 were fixed.
In total, 49 issues are still open and 76 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11971   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  5150    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  697     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<4>  570     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<5>  83      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<6>  61      No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<7>  61      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<8>  55      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
<9>  32      Yes   possible deadlock in mgmt_remove_adv_monitor_complete
                   https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
<10> 29      Yes   WARNING in hci_recv_frame
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
