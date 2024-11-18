Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B6154BF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964566; cv=none; b=X1KBLH2gd4g7oUFLz5ouQOSpO+51gb4n1H7HnlXLihuSPnEQUqI9xQTaJMZSlWeny11YZrxcXfBlc3UhxD8918Ps7D3Vfexgqm4F/IIZXF/P1kpI6E4O/HPsVFP2LoxGkQQDR1DxPamVAbh34JeYw4tTKV/p/iNMDSPHgFnGybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964566; c=relaxed/simple;
	bh=Yvbzap5GUns2E5E9yO5Z2P8Mk6Bcww+S4mM7sihaT1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ecdn6BJJp12Q/BKMXb4M6furHFN4fIiWBefy9jzPtuP/N/Ti0Jzzb+oZfXpvf8y45j3qUNzTe/rD8LhPyzozlWdEVEBieeUxMkdt5DHFaB+pondjYfVJkGDR6QANkhreu5Hxh0hZO7JEtNbchUYa/g/IyFtHDB11uY75B/hK6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abe8804a5so26146739f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 13:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731964564; x=1732569364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWyQ4VaAd+gfDclkQci7PLxjAOBd3WOZtaBU3RlnMwQ=;
        b=s91SCE/WRSKFJGeeLjyLAEzv4e3hlG1evEUJGYg4rnmljRqQ2+BAYflyTRikJJyu5Y
         0+ECec774SHnoAAjO1xgf+qMwdiWpifKEOmncPrgB2jWIFy+PPFhlFGmNnqdvD4X4lgY
         Z2THqCVPW1UWlVjbW7x2B90lLZVj2OzvfDmhkSgOa4ShdgBXM8rF/zs/1L0KrqMKEIfL
         sNH3J4iVIj3vNRQIwBuiNOoOUBZjW06M+JH80TsbIwaN8G98T3opL5XuuDgvznG3r0U9
         45gZjR5f/WcdeJr2Cz951JeRIb9UXdIi4BWFgxpQIAN4cTSl//rGo6BWSqFGKo5IF11f
         M2mA==
X-Gm-Message-State: AOJu0YxRxWT/RYVI1hWRnglCPw7+7WH6+k08rFtex2qM9Db8EfEPDWnN
	U498yp0FYHUFYsMCjkiFRN8k7Xw2CkPN5SHtjs+fuVa3z0zohAOQlKXDx0KDJCoVZAH0PEmBQxP
	0Kqoy+J4CxTiQ4SJolqqTs86Ga1Wx3Sf3j8JH5dJPbHSw1J8xeG1bPhM=
X-Google-Smtp-Source: AGHT+IE9CQk2sRP8pASvnozQPGwaKYk2aXALQtkAgaNI6SDi5oY9uYA4IP8fes48qRki3At1KbEI3eIXzOsbLK+59NdsW63ZA16A
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a767920751mr48361945ab.4.1731964564134; Mon, 18 Nov 2024
 13:16:04 -0800 (PST)
Date: Mon, 18 Nov 2024 13:16:04 -0800
In-Reply-To: <CABBYNZ+=qNj8=Osdzxx2n0Yt0H0AjKtOAx__QkZw_Gk3a1ygbw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673bae94.050a0220.87769.005b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Tested-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

Tested on:

commit:         d7ef9eee Merge branch 'am65-cpsw-rx-dscp-prio-map'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111eeac0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9e1e43bf6b46a4d
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120f4930580000

Note: testing is done by a robot and is best-effort only.
