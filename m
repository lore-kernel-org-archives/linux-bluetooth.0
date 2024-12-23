Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B48194AC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734992945; cv=none; b=SBn+QlkUnFoo7PGHjqFuH58n9fcIIq2WscZomKbboliZFMGONcjp89ttYnz+VFaZNxX3IjHEwrGx4Feb3UtV1gl7231sLJemqlZKJbxjcG4v0caz/flMFODdQv5jz7NFo6naEAd99/pZ03SJQ4Nr+eu0jSpgCvdF7zZdQaBc+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734992945; c=relaxed/simple;
	bh=tbxROftgZUDZCPQS3dgHui9JtdKjojV/NV4pSLa7yLQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ePPyR2gI7YRBLFTpwvwrFm6KbjmXXn7T/6NHY44j8imlQ3J36XruSv/YWDpgUluxzz+Wo0MaYP6OdNjhMMACw+ZEjdWZkrkTpHInZx9imhPgXspzOD/FEJB3DWkF26BwYE62MxpThwtLi/OIYIkefq3+HOUiAyXAehJ4U07YpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-849d26dd331so83333639f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 14:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734992943; x=1735597743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXFsWc3cBjQmAVXhERtP+fTViDwJmrmB4Hycvb0Vczo=;
        b=XpTMtOYGdfyuijQ1piz3uf209s43wtjK6kf9c3LM31W0X8EKpZlOtqfwksBYSUWNCZ
         TFekCvnFAwJc5x9Xwiz0yFYLiTXbQHvIwBQuTXXeCHOsZ1Jr99E0MbbOIEb1EaLkVYWa
         sBQJp4m8FbZ4GtCFO7ug/Obj7BJe5nSF/Eo2+RACzA6kYuqaRec60TVEH8j7aa+/fie0
         gbwG8dCMg9Czbpd0lA/cep9cWWeR6DCaHFvU6l6Y2gjSrvAiYpJqg+d7eboqrgGm/Iry
         fpYaeJeBAv56SWCJF8euC/I1g6+IGO+A7iCa7BVVYxyBkAq8z2zFScoLyvBQMB2UYKt1
         UWmw==
X-Forwarded-Encrypted: i=1; AJvYcCXyQ4xx/9O8T4c74hmlHvNsgNW+7Q+ADdEVoAj+IN7iY/k9JfLMgtJdJnMRn671qkoCUci6Or8253fhz7VczrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpR/bHhDgK2aL5rtrt1pfUPGYFgVSeAiKG/VjjxKEPGgIJ3FmZ
	bC4E52pD0WgknEQHMhkKCTKeiSu+wqZ7izXwWrFlW32QhTkxDAqba3MQDmRPQFWDiHynYtPLgkN
	Zz81pCehdB+J8/ypw3dcAhZMu5wwtAO3oWJzSSacNVQWa1P2o+yPU3J8=
X-Google-Smtp-Source: AGHT+IFr3QOdlGNNLXo40GG/X1v8nXNMTvNIdi2jExJyW6chvs4r6L+prLfUOcCLhtwD2aer2+8CRLfr3PGFBsbAKNcKCXStVZub
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3202:b0:3a7:cce2:d349 with SMTP id
 e9e14a558f8ab-3c3018aaef4mr96055575ab.8.1734992942934; Mon, 23 Dec 2024
 14:29:02 -0800 (PST)
Date: Mon, 23 Dec 2024 14:29:02 -0800
In-Reply-To: <67251e01.050a0220.529b6.0162.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6769e42e.050a0220.226966.0047.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c8992cffbe7411c6da4c4416d5eecfc6b78e0fec
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Dec 1 18:55:05 2021 +0000

    Bluetooth: hci_event: Use of a function table to handle Command Complete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d538c4580000
start commit:   30b981796b94 selftests: drv-net: test empty queue and NAPI..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d538c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d538c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12050adf980000

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
