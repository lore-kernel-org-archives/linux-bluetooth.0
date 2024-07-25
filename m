Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B7149002
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951105; cv=none; b=qvwyzxHTS+7A65e1LwCqTOtkNFD6jhI5jcwDKZtxGvJHho4LBwkbyroYnEncT3NqeYAEKDGBVwRcVOLLn2ESXD/b+sPVawC+d06OyVSYLscPmfa3w091nOGDAvNATJfg7b7VE/6qFdc0npMN6S4TXejaCrpTmP4kjm+vJ/3dAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951105; c=relaxed/simple;
	bh=wwX9ogO+l7SoYYXmYsTfnxkf2Tf/OV6Krfu4CDL3YrE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmJ62Pvu9Krs0JO5rtXoDz4s0BMOim36qMGNxVO+VHKXU6CF9hGIOYycrm+PesZLf7AEjSR48yQ+YB/EwNj1Q/lzRT+va7fkYboZBudjmQkfM+kyaN53oh6tRQLbLuZmdIXkHyQx/uMtoWHI7bKjLLqlL+wDbC0J33/75iCeuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so101324639f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 16:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721951103; x=1722555903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kD7O2lXC3zqdl4EtbgcEWNtaDBfdLurNknRdZY7aUgs=;
        b=IPH84n5bEkReqmlXMcCzvgukaDHH00hubcRjAofVhbyZKK7FsB4ArMfbUn/q4H3xla
         wasiS2R/94mXdKxxhDoQpKwKhjOImadVNhO9bG/Wc6GYsxHyk/rQGbvyTkTiK6oeRZoZ
         dNGj3G/T57NFynleQqNenCzEp1Vw1285Mm26W64NbHR14XHI18VMQIY3dLHdERKfaxTZ
         78sDFEy/nf06AdI67XdHVW8nPhkeJ+QL968XabC6wayQPYjBusYh6aILm2WzBeXKN/Jb
         nPIHs7pTnx1NxSYkiuo6bXboEhpskbWs1mELwJQQhlA4B0QGUJbEGhjRS70FE/Gl0HYI
         MygA==
X-Forwarded-Encrypted: i=1; AJvYcCXkIYfGnwIUrH7YrUDYXreLCZTxHzgg9m/IV02xNU7A8rIGXGPOt91Lq1xwuEHumMmCPqfLmjaedzNd60lVU529pNO/yPw9inuHr7z+Xwth
X-Gm-Message-State: AOJu0YzUjgsEHfMZEPusl5jX7ZVQzMkcsS8cMUglJsdrEoBploYppxx9
	Nhvw44GqTKIrf92HI0cwKw+vFcuf+qQBaRUYestfDAX5Z053BumKxmtKg3/ulr7vLEW3NgyrSiq
	GWYMoD2lB9AobCUiwgHW6T7Ozka/24r6ozIuDCtovpRqqU5Cp8YdkdD8=
X-Google-Smtp-Source: AGHT+IH9qgQqpxH+zD3KrXMCHbTJdndRs8/9ObQNoj+OGubcWHXMkjSrsrRetYcTWr2Wd6IW3Zl3Hupd4ryprl5+ta3iYXXm2MtY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4c29c211258mr149009173.5.1721951103186; Thu, 25 Jul 2024
 16:45:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:45:03 -0700
In-Reply-To: <000000000000ec64cd0616084ae9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d390be061e1afb9c@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_set_handle
From: syzbot <syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	mukattreyee@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 015d79c96d62cd8a4a359fcf5be40d58088c936b
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Mon Jun 17 11:09:37 2024 +0000

    Bluetooth: Ignore too large handle values in BIG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13110dad980000
start commit:   480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=d6282a21a27259b5f7e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f3e213180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d4723180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Ignore too large handle values in BIG

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
