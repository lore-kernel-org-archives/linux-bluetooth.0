Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F3288A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186765; cv=none; b=GimQfcPeGvrW9W6D1QAc9c6hyDo9jKglKJHW7AvUrcZ9aAIL5EY3Wev1vWz4Mo7F7I9o22RlLArTfiXM/kEPqK4i016n1EmmdY0wBbKoesijwRFRN2tnBoVKgoSZLgQK8bImev1iQXRMS5Q2viZPmh6+0ctzXsvf4UPjC+KoutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186765; c=relaxed/simple;
	bh=NnCmgpLc/a19Z//Ksh5P5uqxhEy9Jo+bHlhN/OP5T5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y+jdMzYzTcRC4VLD4g5SSHP3IuHThPhQs0K34l3qYU0aRBBTokZEA2+7bzSkrLjljlytVmZUYMyUG2mHyhlwM5eUd2IJCOpM1Dg5CoXQEXRG6+vRtBSGko39z3DZE9g1JFlp9Jw8xEtyX+C3rpvdJ8DUg2ChgyhiFfAqirtRv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d060cfe752so25602745ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 03:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186763; x=1739791563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ+h2LGkuRXC7DIQsduiIG1fRSIWK0hwahaP0xsxH60=;
        b=dUaKhSGIzrES21ozQYX4UA61NqmKWUt2QetcZY2EsuIcOKXRg5MWR+xmtkNj70ujRi
         tXGTpLDZaY9FjOOJ8Gwq5bU+lE7bvNnFaQDhSgFgQ10XhSX+fdI4k7sB1PqRjVCaZdjq
         HixcJGzpqhAZzRYtwkcO0l/DqrgmVmsBOf+jwWSf6uLF+O2Zcw9rP4IfBuInnPw2oX0H
         fRlZWXqMZGWSsoBoVCrJHuVh7Nvbj9gG1a05ausVsEvi7v15IfDZ1aj3E+G6fjxWUQTK
         2tiorTXii4hTK77EwxwwARZ/aCR+rN3MPtIlZNiThRuWlcOTvS6jcAxdaC+gaAECFVYU
         7m8A==
X-Forwarded-Encrypted: i=1; AJvYcCWM1neDmk+tmVyjQ2NVZ2WBfhlFuTvWqke2Ra0za0g06ncGm5fX1YEn86tFqFaLFdCp5wiUjTJY2UZ+RWozBoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYDdnFn5YqQD+h758Jt2otYc5pMY/nUbcRX0ojR/ME4krCDMn
	4QgsQDYZjZhxMw3Eo3TBZo/a5XTC6P7pAJ8Z1hM+1T0FpqmeTZJU/DYEIHx79Zcp60mBqdhkKft
	yXoCixiHPRuy2POx8CPB3UfpHDsQJeZlSFdfYZ73sVJJkHUag8j7M9NQ=
X-Google-Smtp-Source: AGHT+IGvQR9xhBJMp0yCwBu2IxYGsiNQHOCBgzHhuu/0KXacIXDsqC+PSoMINzNx3ybIiyk4U91FErnEIhDu9SfZp6zgMA5+5fVa
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:3d0:2b88:116c with SMTP id
 e9e14a558f8ab-3d13dd4aaadmr91686965ab.10.1739186762869; Mon, 10 Feb 2025
 03:26:02 -0800 (PST)
Date: Mon, 10 Feb 2025 03:26:02 -0800
In-Reply-To: <000000000000cbc8670618a25b24@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, hdanton@sina.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cebdf980000
start commit:   40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cebdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=156cebdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000

Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
