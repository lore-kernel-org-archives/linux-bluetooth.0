Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8D1C9DDB
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797925; cv=none; b=AJloFTtYqHoYilVheJ6FWSQuNaNO4O2oA+jJ9j45Sbt+2Ib5v+Ngd+zOnma42h9NX3tZvjPxHd7JoPYUjbjO67ng4wpNuRUkwdhDpD8bSIB851OebZhPmNUKDWJh8Eh5PK76n5uw6/P6ejON8I0jZN0BPYpV9yEpQ+M2Bhi9fSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797925; c=relaxed/simple;
	bh=hLaGC1unzGRXv60Ntnixr0kWcN7sp3RmvbIHbphIIHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RjkuYLKO0j31SZlPpzTOrpLtwEYaG3WyLVT8dqIOp5acw/s6/of5fiuZyIM+3huKjfh2l0QBjyCWvuehlBT41aZqIOTHDb5t0mcI/0DvyVGWW3Tba1PXKkN+eGxdXr1HbzdY74S+Ho2vSJ0a/JTXJsOeL5ldPs9cA1PTTOIb2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3496b480dso44511515ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797923; x=1728402723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59SB+V8kGrCj4j9f0TQBf0du/i+6iY0rJlO9QAMoS3E=;
        b=GaJ5FBIAM0u7cUibAeuhy1hkZi6pDGh5lUFOhoOyGyHyBr2BZYg3/FU2pNdjglxcJi
         B0Vxzi5uoUDChxd3sV1YafJOFBqKtCrvt5WBcTAGCv2wQZ5Lf5ql+aiUBSaPV9KGNCls
         mUOhypQv2o3CChzLAqLDZ+d6htmV+J+meh30o1BsiX2PjeXCubZORlYh+spIB9WC5S00
         UYHIwjYsyzTtULoS4dxProRNuxhcLz3EZ2+NrU6NU4KRX16jLWUHDt9uUwGFrAgBqey7
         cy4gLq+lwX8e9Sj9VtKW7deeZohzJIX952agsqXyTRldVCj/oMacXF5SEQOTrP1drULP
         PXrA==
X-Gm-Message-State: AOJu0Ywkj0fcN8e27bwiHKnMv/FRa35QjWJs6OJE4+8Un40wtoKrEBpK
	YCmUgCYHciSdgyx1IKsXei0w0iE/3aaGBGP2Nli1gHwtBMeFGLt1/haoRzQ4VR9aA5XIstMwu+r
	59HoFyNoF4V6ryg2Gw5HUxil7BRMIhLb3hZgqMY6Yi06MlaaQk+pdrWo=
X-Google-Smtp-Source: AGHT+IFdWoiNWcHPm7jFLXmcVI/1in0+qYG6NCF5Na0y45if1mwde/nXQrJqUMPRxxVtuBaXQSHmr3Z4XNxlNmZwjRmdIZxyiaEG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a3452bb9a8mr143447325ab.24.1727797923000; Tue, 01 Oct 2024
 08:52:03 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:52:02 -0700
In-Reply-To: <CABBYNZJvjcnQm33Qn_ZbdPcrd2ZTF9jOQGJJcva35YigkfchAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc1aa2.050a0220.f28ec.04b2.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_sk_state_change
From: syzbot <syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Tested-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a33dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c87051d13eb9da
dashboard link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139c139f980000

Note: testing is done by a robot and is best-effort only.
