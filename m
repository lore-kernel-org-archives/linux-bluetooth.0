Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62ED5101A
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff23275b8so16927485ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 03:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703504404; x=1704109204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71kCgbM33utaKn5BMCDrTj5PJAG7kVfOyQV51IZQKBQ=;
        b=tuX5seyVNygdUEq1FFHCkDawuAP0G16GcVU2W61gAEV/KMATlPb5YrtjyBKc8RrmFh
         SG3tPlpr4M4tghYFPmrUYcvZiSfDj9l2dbS7iru3CkLkQ6EQpzUhAABp4tmUl9yjFO8C
         asd7eNjuWjYpEGQLZxVsmnq5p3mJL+d68j71L9xZ2Zq/HyFlIZLV1oUHoDtADQz2TSc6
         Yu13ry/B+6DcDDcWS+gTjlncLp121WZsl2zjfz8mEJOBxuAj5194b8LDFG7riQHD+x4w
         puouh6p4xl/4iBQBGjndGobycmIR3E1V9j2xAquEQE/A8LIw6FJ2HkxDJU5E7RtWGz95
         kOZA==
X-Gm-Message-State: AOJu0YxWqPUYQiN23gzVvtdtgtQrmf4iBpZIe0AXmCKUZyIIsb5aEnE2
	xMoiBim2BH6KImhFHR8Aa8h7txi1XuvEf+2g/syLm9gzsNMT
X-Google-Smtp-Source: AGHT+IFhxcJ9tk5FyfUnUpIIbakXuToDfa46uJd5K9yO2+cEAsusUl61NtfW50SDPW/cdQOaoTXt432KoUncWYcBxMOHU8A65NXf
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:360:fa:2c2c with SMTP id
 n13-20020a056e02148d00b0036000fa2c2cmr126623ilk.6.1703504404109; Mon, 25 Dec
 2023 03:40:04 -0800 (PST)
Date: Mon, 25 Dec 2023 03:40:04 -0800
In-Reply-To: <0000000000004c51dd0605109d19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e16572060d5406f8@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in lock_sock_nested
From: syzbot <syzbot+d3ccfb78a0dc16ffebe3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f7f6cee80000
start commit:   ae074e2b2fd4 sfc: check for zero length in EF10 RX prefix
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13075977a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1012d447a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
