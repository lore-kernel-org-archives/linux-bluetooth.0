Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732C135
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfb96854daso22963985ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 23:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701069185; x=1701673985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbhetaEmHDXsErRVxv8JP9G/LWBw8d7TWXbXFegje8Y=;
        b=rgXUxKxkfvexR0yeQ/FX9bQWY/meQ6b28gu8ctlcEWlb9crPYgu8eFj/D8idKY9Egu
         MeZpSDnkLz7gZZg/d7lmLJlWS6o2xQidv4WUqPox6lvMpA76IKX/xmoeBg5uYQnZlEGW
         p/g6DXrjWaKwgu6OVCKbQ4C0cDSATWi3cBK6moNoFRcef0NmrO4MIbkCXqbkZg6K8w44
         RoTMaystvV5W1byZ+nYwGu5YblT3YADlO/iOjarXm9hpfyHv/HUAsfi0F9m6nPbC4U8F
         NigNkv8f0R7SI290roD4IyFo1TelXWrZSpDMp8tOLQbpfSgzxzPM8xqWZ0xOEGNzRwxt
         RZMQ==
X-Gm-Message-State: AOJu0Yw2Zt01Qn1Hi01N6RQrhsV8KqqBNYiv0ZaIvi0JmerZW4sN8bRN
	2mB5rXb+bzmb1TjCZhC2fzwvrWDY+kTM2yMff6mNkdryOAdn
X-Google-Smtp-Source: AGHT+IFNEfof+Dn0EQCh3xoFE/GYY7yEj0K6LHERwW0gKqb6aQluaZTSa9z+QLSO/78XIHCyzPsL9nqq78gmkq4CLWqD4Dtpx1LN
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:ce8a:b0:1cf:935b:96e1 with SMTP id
 f10-20020a170902ce8a00b001cf935b96e1mr2751808plg.0.1701069184815; Sun, 26 Nov
 2023 23:13:04 -0800 (PST)
Date: Sun, 26 Nov 2023 23:13:04 -0800
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fd73e060b1d08ec@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From: syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@sina.com, edumazet@google.com, 
	hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140ffa0ce80000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145586a8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bf8dffa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
