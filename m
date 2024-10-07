Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B81DDA36
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323764; cv=none; b=a1yEhlcq7kMUpRUPvKRQYDr2Jqd7kjdpjK766c1OWoiSWSJ2+hnUmVhs7PdEzQcGdgR2XSvC0sQlfYLYb4foLotY2d/zful4a8AqZASY+xN18/kbvZssL5zHI6CXsTKbnrt1IiRDbc9iCW/mxr1NiEMGCkxBJe/uDM8y2jHmVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323764; c=relaxed/simple;
	bh=1kXXgQ6pXFLsqmPCedpWDBpYPB0MB8bjAHTS0Z3nbXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aeuurLtP6QitlM4gLLu9Vn8od6iKhuEFjCVJYWnYOq6s+z6279HSCYtuzfm6DQnE4jkSu3zO3s+jAoGRtsDCLElniWhQwigHNsq7DWOJF1QbG5JoJPPKcAF8mcXyRGnWDuGDsVp6V0zzVXbdMmafUfjrUgQ7NIDOdozZV6EXxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1925177fdso53875935ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 10:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323762; x=1728928562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPE2DlXlQgHtF9R1VoWf7KZY7YtyqN7X49j3CJzC6fk=;
        b=K3KSKFLvQ+g8vHUXbUEh24+4BJVrz/W3EfCNtGzvZ+4bng40QkxomHZ1sXMuldg4ut
         x1TA+ErhhQG6UkZBDvRtCSL0AK8g3utI0x/agWPIgp0UfhiALcxEFdYD1x+17zlKTzg4
         BYgzqx4wK2ddRHDUD8UGDPq/KqGkUfsgN2/gNlbTfLQgmRGQ/ZKxK51OdB8BcapM0lZH
         TJlIqBkGkTJ0I5/D6bMrJW38nNxvpZ3kwRKTQXXBEZAvexsgIsYszDZrPUm7F1y48dGL
         P/tK25XPlTBeMCuq9oFtd6LZL5/rYiB6/mSuY4tixjZCpkAYK1GgNxdeJXa2W78pJ/Aw
         Ey7A==
X-Forwarded-Encrypted: i=1; AJvYcCVyRdkD+HjBUaWUnYJqd69CezDrkg5yiUl8G4ila/PQSIWn26hK/JFtqK1hbYlAiJnp2mkqkLj0EaVOt76vyzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZilwJCW2PYGuAuljazwnCMMCfF3lbr/H7V+Fev9n5EVXWKONA
	WkwpPh1kYsKTFYPkkZHpP0Ur7O98MxWFag244z8JtjtcmRlD4a7nWe8Xh3/8VHk66TgWe/KWH6I
	7ctNfMchOxbm25KtTdeU14O8yP1YNdXh9GM6ZYRL79pa1Aq2nAtCKwNc=
X-Google-Smtp-Source: AGHT+IF9H447R8v+BBuaDt2xdDzaKWwWRKSLnQwhLFFn3CFWOf3XiPZWcCDVgpY6zJveMbhEXDU7Mc5XVBqA1K2iCj18ZVOXQ+bH
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a375a978dbmr123384115ab.10.1728323761813; Mon, 07 Oct 2024
 10:56:01 -0700 (PDT)
Date: Mon, 07 Oct 2024 10:56:01 -0700
In-Reply-To: <66f7eee8.050a0220.4a974.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670420b1.050a0220.49194.0514.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bluetooth?] INFO: rcu detected stall in vhci_release
From: syzbot <syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, edumazet@google.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132af79f980000
start commit:   abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172af79f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=46c3d1706c2d2688baba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10564c80580000

Reported-by: syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
