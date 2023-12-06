Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C6D42
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 19:58:10 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8960f1a65so7702620b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 19:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701835090; x=1702439890;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kowtJ3erIuB+junPJVnmZj+8P3bHd7MVP6/UASYAO2Y=;
        b=ZKsx4JbMUBb22oktMeerbcNwONsVE8w7PrCcLy9fCJe+QpIIVcSO6bfEDbAtoJxa0I
         9y+qwHjiyDQCbOu4woI2yWbw8JW5eFNDqt9SyNEg0hN+Z9ZgtAQlveOlromAZg+2n5Rr
         90ERH94Y+46MQfRl01eZYr6+pt2RrjhbS3W7cPeFWtmIwLqJFazYRAWiOROJtJURxVCk
         AVHvzqw5Qou5cE8MZGgzuww84WN570tsJOqpdZ8r9iQDmkSywb1+W7wCkJyB1XyJF8lp
         JyI1F6G6muG6JvABorzNM8erbrXAcGwGVj9mXM5wjuyzqBJh5l/iyHQ99G03DPIiQKgM
         9CDQ==
X-Gm-Message-State: AOJu0YxaXzSnUBJmLb6CMJOIro6e5df7SVKfR+pvbc/FqyQs1haFUQlc
	n4NARY2hcbfGGwE7lKKY+WomXkZv4ttrTrRDALQj2bVOBPBU
X-Google-Smtp-Source: AGHT+IFgghFouIRUn3iqyZ5s/Hsf85PRJMmibbGXKnnfFoA3CNAysUkTLcYkwd+dQjrhhNtZ+Mk7dCqwuInXNtLFga8mnTqxKONF
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2009:b0:3b8:931d:d1db with SMTP id
 q9-20020a056808200900b003b8931dd1dbmr299703oiw.3.1701835090175; Tue, 05 Dec
 2023 19:58:10 -0800 (PST)
Date: Tue, 05 Dec 2023 19:58:10 -0800
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000042dd9060bcf5c23@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179a65d2e80000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145a65d2e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=105a65d2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504504ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14685f54e80000

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
