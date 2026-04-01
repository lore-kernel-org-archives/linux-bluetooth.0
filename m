Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD837FF40
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029346; cv=none; b=hVXhTJk/0p4766DwZmDPGOpGwHXKehQ+vJvYIdrEhmG6tw45MejZ9FFxToC3kx9l3NbqWNZYLDGNoq6r5YFnTEtLQc65E7X+U8SoJs+aqyQ4VNOOFJd0vLZn+1WU6wqAd4Yiw5t9D+Mi+kOlEaIH2RtBCKyGD1/1iEBwAqjQMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029346; c=relaxed/simple;
	bh=uYAkN5OfpKmKah76zvJV3EVnhHOco4kTlTtyRslYQ3Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=enqTvzouHFS45dIGjK1dH5tUrxqIHJna4CJOIPUumuIIYbQE3M9ff+3Yt/ae+zZo8mYnN8796UFrhoZB5Z2Itdkp0LKlyJWvflCDpHjqqA/r7TT6+78KnmvDkvKU0V4OQSxw2La3owglQ/iSRIv5ymQNc/Jr9NDDOV84BGJNZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4171fdb5a67so15050402fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 00:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029343; x=1775634143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cndwGR9l7kA1H6LQYvMU+aBOcFE9tQt/7nrNQaOAmU=;
        b=drtaII3ow7Gwl4KlST8UIJEMklb4+J425tu5L46iocKPP9nqSyN7J7lyFUV4XfCLkL
         GcFnIvnHO+WOcynmldvnbwet4JkTt64t/6W2+QgSn8zp4ytwtRsj+Kx6M54PPSM/2kQ+
         LHBwJWfzxPQ0VShf/1HGuV8jGvQemhv4AUdrLlRrJ84Y+JFFbe6ZBdmJ2X7tS5t5cs1f
         8ignleYtahylZrKEkZjCZRukWqj2SSpoh1cjkN/T6O6iqvJBwworUcGgcBXbNfXu4msY
         N10to0xspnGYJ0ehylAqfMmQ9Iae2JVWsKpny3kf0g7N0pHBmn/Egfh/LhzNrMqdgTaL
         nglw==
X-Gm-Message-State: AOJu0YzzFdZR2pPa8Hqx8xoC+85XwV9KW2/QOATCsF3mW5il1feY38M8
	lkoNHyrWK8w70D4ifE8fH1fb4AzOFE6VKdWJUtigCnVHCiEgMFxBNgHywGnjUR8c+PIY5oobTzB
	p/8HigWbugjV/f12fswnwyF9WK0wlYjm5CNKgsFRs4LJNH+Z7XD/bCFcwWiA=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:992:b0:67c:11cf:eb0e with SMTP id
 006d021491bc7-67fabbd3bd1mr1325705eaf.7.1775029343582; Wed, 01 Apr 2026
 00:42:23 -0700 (PDT)
Date: Wed, 01 Apr 2026 00:42:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cccc5f.050a0220.183828.003b.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Apr 2026)
From: syzbot <syzbot+list17bec2e18045749d8ecd@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 1 were fixed.
In total, 32 issues are still open and 100 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13597   Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<2>  8418    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  4468    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1400    No    KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
                   https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
<5>  1022    Yes   KASAN: slab-use-after-free Write in hci_conn_drop (3)
                   https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd
<6>  569     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<7>  351     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<8>  273     Yes   KASAN: wild-memory-access Read in l2cap_connect_cfm
                   https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
<9>  167     Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
<10> 147     Yes   KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
                   https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
