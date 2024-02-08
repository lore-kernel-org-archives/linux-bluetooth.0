Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6579940
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406327; cv=none; b=KbODYp9zsDPSWRLtIVy51kIQtaSF9R1953KDF5R8vNrKKISgE4bEu6c6si0vcLnyNc32vhsgkKXawgBocQzAlrDBDmtV2OkOC5zY+oaYcr/WvOzirszBPPnwCELfO1Zm2pmZBPQWb/AinOfEJ0mLEit6VN6c1tTbjnXW7m7Hdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406327; c=relaxed/simple;
	bh=fjsov3uRgEiW3nYU2LA5ZmDxMOxNF1PFM1P2zKSNJWE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y8wz+eWDSpiDghQtzocd6nzHFVZLkw7S/gbO7y+w6uIYV4GFyvUNC7s18z4GbM4ATq5t39oMlj7PVEKX5NecR7e5w6DVyXAJEYJixAB2VMB+wMVLFJhp63/UADPrvAPTC6dXqaQyeQbrhAma6be+rGnGWo/FTfqorcbxzR/LL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363d6348a07so15329885ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Feb 2024 07:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406325; x=1708011125;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J13MMIPfh9m7LdVejmcRDcZr7MHiXnjkLGh32J/ubZA=;
        b=MuL40qXzStxy+Vbsc90ETzoavihi1WZkppMCyoBzd8crKi9nAbkGowqzxYn+EPKcEp
         JZdZHzAjGYdsXHD5Lbcbn/E68RD0bapFb9sdvOlkoG6Qj6RsQ9FsBi25J/2TTWJJYVky
         PMVDFdoipKBtzeQ8PeouVqRaL5CWzUYxax65FtzWprdfKKWuVnD2yD11yCpNk8JZcOS9
         mzyKx/Bd1angZYKD0gaM0HM3lcmSYQLIoRkY4Za/e1vJqxIfVuQufVoQisggfISu5xEY
         QBlT/xTUD3OHhj+GoTl2dQ0uSJja1BBBaeuU0aA7hRkq57rwO2nOL1P4Q20JET5c3Nrf
         twcQ==
X-Gm-Message-State: AOJu0Yyo7isrJJDTiThp0or0nxIXfGakWhZKdgpR6K8k3904kIwxPD5n
	AIpL0lktscBZFUAHlyrahR+AerYwOrIm0AanVhPp1k38HOqwZFc1Upd6eGPvr61uw2D0pAcwKza
	2zIJTlcB6x+1XWFRxXqmix8LzNPvPkHFLtBQC43/5ziWEFKwyabcScsY=
X-Google-Smtp-Source: AGHT+IEXxARntCtqw9oujDkbqJu9ADvKd22NWzIad3D7h/2PbUtbLKRNZ1E6fc45LDIqWXP+mEWNhrOSFdMlCPfWKUfh+NZCzaLl
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:363:b51a:7e59 with SMTP id
 w7-20020a056e021c8700b00363b51a7e59mr638787ill.0.1707406324981; Thu, 08 Feb
 2024 07:32:04 -0800 (PST)
Date: Thu, 08 Feb 2024 07:32:04 -0800
In-Reply-To: <000000000000b7b62e0610db6b8a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cea730610e083e8@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
From: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
Date:   Tue Feb 6 11:08:13 2024 +0000

    Bluetooth: hci_conn: Only do ACL connections sequentially

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D154f85501800=
00
start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D174f85501800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D134f8550180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba195662a0=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0a39be7a2035700=
868
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d95147e8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D107c2d8fe80000

Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequenti=
ally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
