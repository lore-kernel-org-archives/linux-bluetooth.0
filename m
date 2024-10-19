Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6F173
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375385; cv=none; b=faGDSU3VYBIYOCN4Ts6+dAw01aw71RReRoUkqICHTQsR32mR5JuDJpoG4UWfmTmYy5VNyICgk7Xv73F2lxYGUpF/YYB1c69Qq3E3htlZLSeZkpzsSJPWlF3MnUax80dm0GMTiqc9v8JjtzfevtN1bYEio3zc+16cd/JouMVR1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375385; c=relaxed/simple;
	bh=4r/dnSU2iv58zYZkcF3J2NBOOcfh+f3piDebouy/9IA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oc9JFjDx2RYRDNdoa8sxKvo6hn+AsqSaI5TjxxILdecbEa9iyzgHqIOcy/AkXWzlnOcZOkheKAokndyv7ZTR7Buc1tzJfhgac0078IHckVriUMbYMBwH6CUa1p83VNJlrIG8U5d8UssH23NASwlecIK/Bl7aghkL12lzFu6mScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c8853d76so33856355ab.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Oct 2024 15:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729375383; x=1729980183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RLqbF/44Rgljiqe7gmVwXbfdAgdxhslKmNZMh8Pfbw=;
        b=SVIXoUJ5l3/0FC7iN0ibD1iyh7qYPTGlq9vKDPgOD7jpfZ1g9HLYBQaB+gdpgqRVMB
         I5FTFUB92b28BgYnzQaK9yFsgXBbw8W2Ubvdl34lP9syib6cezHQgqumItT8BK/H5nP5
         X0hU9xBl/jb45B0tmG2N2p+yrjCSa6WEMoGxgsXlVEGfwm3G/LfKOcE5F1LWOkehSlDB
         UdtgI6MpwGP7/icLpzSo8Fy9pN0CgkcgcnZfWzVcTfjiahExaS+Cfva2n6GcOv7OgHt6
         8nqs7CRNI7AkLYRioXTEj0Fxo24kR6NqK/DwnH/9mw19PTEPdn5cYGkyLLs1qcHYS7Dq
         AsAA==
X-Forwarded-Encrypted: i=1; AJvYcCX6bCMdPc11Qhjfq6MTx+xnNrMELY5Ex0xucH6UVS1k0Le/NFAaFWuEYrWFrDU8a2NjlC+0yLoVqwVPO1vgdYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVy5wKdCFSw7ka5evJ8vBltqePvvvW1PgqV3x8u6zrh1tYELME
	odWbdluzlckwCcmq3RVSc+2hjr56HoLYqtFcpPjqS/eW30tifXgAEWhq1NdKSKSztyz867njbQk
	5ey0K1F7p2CDV7LCgcpWuQmE9k8wKK0CxL8JlCW/FSNZketwTwSF24hI=
X-Google-Smtp-Source: AGHT+IE96T6mtPOXUI/WweupFLsfamKoYzsTZ0Bbhwr3/cBXtjGsDjI/N0hiSqdkU1zKkxy1ivao0cGe6sBEuVvyhhqrBErxxqXc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a3f4054723mr65915665ab.10.1729375382809; Sat, 19 Oct 2024
 15:03:02 -0700 (PDT)
Date: Sat, 19 Oct 2024 15:03:02 -0700
In-Reply-To: <00000000000087e83e061dd271bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67142c96.050a0220.10f4f4.0021.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in eventpoll_release_file (2)
From: syzbot <syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, isdn@linux-pingi.de, 
	jack@suse.cz, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0023d340ba86cfe50b935829a73adea57ec2c629
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Sep 10 14:22:36 2024 +0000

    Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1594c430580000
start commit:   b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=63ab1a905aebbf410bb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10662bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bba00580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
