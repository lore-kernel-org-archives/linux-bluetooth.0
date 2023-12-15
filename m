Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBF495C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7a9f90ed9so98269639f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 14:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680425; x=1703285225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZWZIC0FcoRkbciVDc3BkoS0NaydfXxlAVCYnHQk9q8=;
        b=DpZzuIwfrZeQszrev49wU7QRude1ZMpdC3r4CaDUoqjXFVmaH+YuAWFcc4Dw2VefFV
         mh9Kwhvtijax2aHSt/X3mYoushretgy5BKKZDRRZNhulHQ/x1FsEBsYe3otaJBAnhfAW
         c6uvAZtn+oXNDixu5cddBL+bpu0ORZ/a049GS3EEFhMJuY41eZBEZ1xjUh7lN28D49j+
         5KwN+yZwQVWu3JJHiHYYNDT7Md5S2+GJHI7L+XfXxYjdZI8iM5BT1AFli5FrQuY6R8WS
         iTHzH4dXSQ/0Ps4ooKnY0t0qR2+vVJbe+/Sq5LbmnjFkIG3qB10LdHb8nWcqWrN3s0lr
         m/yg==
X-Gm-Message-State: AOJu0Yx70y4YCgFk5cGKoUkTDThMY4KosbL2tIrx+mG9h5JaZtKyo2ug
	/vwwkLdwdTa85aZHzDr1xk236Kfw6mOSA+R63+H9fIeZ3fOJ
X-Google-Smtp-Source: AGHT+IF8ErutNgm2nKhcrvQd7qgl08tqQHShioYvHK7Pd5JAJTH0sNsgSRlj4dNZ0AM1OqNEzWqPQyh46GhmMkdI3CGKRcnOKdrv
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a3:b0:466:63f4:c6f8 with SMTP id
 w35-20020a05663837a300b0046663f4c6f8mr380739jal.1.1702680425250; Fri, 15 Dec
 2023 14:47:05 -0800 (PST)
Date: Fri, 15 Dec 2023 14:47:05 -0800
In-Reply-To: <00000000000011da7605ffa4d289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9c652060c942d35@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From: syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To: atul.droid@gmail.com, davem@davemloft.net, edumazet@google.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rauji.raut@gmail.com, syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c7eaf80bfb0c8cef852cce9501b95dd5a6bddcb9
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Mon Sep 4 14:11:51 2023 +0000

    Bluetooth: Fix hci_link_tx_to RCU lock usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16dbe571e80000
start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c9c64680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f91628680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix hci_link_tx_to RCU lock usage

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
