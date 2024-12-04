Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A775227
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277844; cv=none; b=DAPqyd1YKDCeE+22MIZo76JHZmjVlKN70WOl5hNltEiHfi2JPa3HFQsAaijYHT+mtBdi5mV/APAOpnO+LJAV9U8e37+06PI8asUWCtPi1H1mILRMfmU+sre/EHtK8huqXna85EfAcwEoXI5XQN/5SB/jDFCRY3pOOCz/PnM30LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277844; c=relaxed/simple;
	bh=OlDBonlqaQvSACghsmQzxzPu8/DPiMCakSpfBChEvLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lJEcHm3Gafv5H+J53dx78G55FidG6w5N+mlD+Ndx0bJpHlOHLiDTxOITiQU6sHHrG3GAKUJkHPFCyjTvfb1MOAHn12V7wKuPTcholN2tEwZzGRkaFJ4r1HoHkQaJnsJPbZ8iq7hdZ3JzsRVhDrwyBtgO0bd2mnUwjAfQ4OH3mvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843d837321fso531247239f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2024 18:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277842; x=1733882642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Ls9uVEwuObwnsAhBmRyunL/mVqcW24uiUwjjBopVM=;
        b=ri7ELS/yVVvCca0TVeOyuXrJjfxTflbtP0g4LolxCxAkIFHHzwohtIJjM31vPTkNcc
         SUIIax60i9ruY0+WW9VfSCGAD6gcgbm5KXRokBXX5aqon40I7J7jXlbS5bsDHi2kZipj
         GtORl+MkZIU0bv+H8cCusd9lh7Rjk7DFuokbAFTuGTGl4REmMfszkTGZY3GLIJ4MLaAr
         QQN9JGBcPsbeAqrEo9SU/fseqMhImTdiK+Af+lJEJMkZMVrCam9d1z289yIX8apIt/6f
         LSKxzyqlWJUSc7rKD6FIza59anL/86wSzxEH9BulkwCSwMcf+fhR8gpDdz+w+ocz9P7Q
         fMnA==
X-Gm-Message-State: AOJu0Yz3mn14xhzIjfFpdoQ2hV6w8db7SqSoTjNh8QSaTpJ/xKy7vkCC
	sC/RCwOTJHRe78HweAUNjcibbZHtUgxzmgc0gbyZcAVnPry9o3qcKVq0SX2oypohNxsKrkrcZUJ
	pbce3OmqhYxISk3i7pJg2s7EQ5nggFUv/jw/QiT7J4MKx0LAfXoqGa94=
X-Google-Smtp-Source: AGHT+IGxbTbdppfonyHhoQ7D5//U0U1nNOYQ7oQFgPr4U385SsxYeVJpLUnUxoAlXBsrI8r08bPAz8RuG9fBIPcwotXBgB1dD8M0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c567:0:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a7f9ab1c56mr53842995ab.21.1733277842544; Tue, 03 Dec 2024
 18:04:02 -0800 (PST)
Date: Tue, 03 Dec 2024 18:04:02 -0800
In-Reply-To: <CABBYNZJeXf0Lbe-vwC1XX6-hRmw4iqgSRbTV=zCZHbT1hWZLoQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb892.050a0220.17bd51.005a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com

Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e708df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=773e6b07384b3087
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100c0de8580000

Note: testing is done by a robot and is best-effort only.
