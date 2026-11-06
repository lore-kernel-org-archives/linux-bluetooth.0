Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939631;
	b=zAtT8ryN6l740ceRdLnLuoZTMW+Qs3O0uZuEZuWdMfuCuB86EPdxj5q8FxVDAHT/EzyM
	 kY2Z6J60Kyk4p53uXOUxBEljyxBEC/+KrqQtwIOubivvJlKt73an4ChYcBX+TuGS7MRbb
	 7g6IqSZ/T/iUDdX+5PSXM9f5nUP5Vx06ncR7UfQ70VhP1z0R/VE0eMEcYi9FERRjF2g2A
	 CYF/Yk8VdLiu17PJmTrAVdjTAQPSowbK6fMCnXEX8QjWqjvaN8DIhRc3Bu3whjKMnssLu
	 v7MFFOtaQMAquQ+2JemlxwaNk9RRmfTonhvsqzRw65+8LS4EJQeI26IhRnRJKITszOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939631;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=Q2tmnUML9xjff6/p1fEMU5at38Hc24S806y3q3ahbQA=;
	b=Va/o+mXQw1xw+qQXeA8wu8ml+SrhG6F6B6z8c8Np0ouAmMC48rSjLo4JLFnuH04jBdDC
	 ko27E4YuNGM+Va3edfArKT3O0OgXS/heVrzLt1Jk0KGEIRDQ01LM6ppohrvD/jWt1LJF0
	 nfx25JTEl8CaQIrBWEpcPvI6xJQWGnBMEWZDGbnFw12Vnwz/44Kgz9BxmZQcb1PVHzcPX
	 tVfTSVPRB4avdiv0AwatX0bq+88HjUfuOyLA8wjzBFPyk3r78M2U/67c2KMGyPshYaJMW
	 uS4i9BgbepgVSLmV7fUicCM3BdIUIiGPDTjHFhXc3PiGQa58DbKlf45SzU3kylGb6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49A606A331
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE49A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a41f46d629so344064b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 20:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939629; x=1794544429;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2tmnUML9xjff6/p1fEMU5at38Hc24S806y3q3ahbQA=;
        b=H1d2Mxs+aLSxkyQn+dihS8JWUx0JzFoDb9HRTlJ0TcUbxBpMlYScDoo1KDdEPkVIRF
         UpUdZtcEFekLaxiOjiDP2mT+3slOpUA9YAQIL2TYOgeeot1RpxgCoe5X1argwIun9aG3
         M6YIhafrBTNPt/wlYzNNdZtVhz/C3PX97QelLypJRcPMxQiLOGr1MoDF0BlOhseL9Bl0
         iGFT5XJvNtqaW35TiDM8X9KCtYmw2S/nXIWa6a8PfGRhrO3KaaTNUA1j/s08AyMq1Q7Z
         AsyqhegbhhUQPDM/o4HhZFNom6AR+2GN9mY9zT6DRhgZIRKA8jzMD8JqpFvrM9XBS4pI
         DaMw==
X-Gm-Message-State: APuU4Z8BPviBH4JvHvFFxx5zk6hSrjFZOIYmtP3pATGeQ3qq3u9YYzim
	br7gjCJO/mC30CQiTYFyEF6p7SMLSkI4iknfebS/b+oyz9CS73fCa64FJw0c0nHHvOioGCAS5c0
	O18SwOizKXkwcCqcFKaXeoZ7HAJuqT/2/zW3m74sscY0JqRyMQRB1LnLrphw=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c110:b0:4f6:a430:1822 with SMTP id
 5614622812f47-567e0fa62f4mr1022308b6e.7.1793939629709; Thu, 05 Nov 2026
 20:33:49 -0800 (PST)
Date: Thu, 05 Nov 2026 20:33:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aed58ad.02d3f859.2829d1.0003.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Nov 2026)
From: syzbot <syzbot+listd5b89f3aed1bfe64dd6e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 116 have already been fixed.
There are also 6 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10047   Yes   WARNING in call_timer_fn
                  https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<2> 5030    Yes   INFO: task hung in synchronize_rcu (4)
                  https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<3> 162     Yes   kernel panic: kernel: panic_on_warn set ... (3)
                  https://syzkaller.appspot.com/bug?extid=fe5ea83cdd7fc263f452
<4> 17      No    possible deadlock in rfcomm_run
                  https://syzkaller.appspot.com/bug?extid=0adf2aef8ca78b84c4df
<5> 10      No    WARNING in hci_send_cmd (4)
                  https://syzkaller.appspot.com/bug?extid=00f5a866124dc44cce14

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
