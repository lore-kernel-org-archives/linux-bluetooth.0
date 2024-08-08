Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979715444E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Aug 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114984; cv=none; b=JGIsGAoRRioPJRlX5NxBvy1oEpqYhWvLhPxI3YvJPS8i+naRLrZ+Fn8rPpP1lw25vSz4hX7tQFa4jwATFWUhKXEV522JDKThkRQhOQdl81zMOOL/Oa3YrV2nZjnIgep+0TGkKymMVxbzAYIdB4FAPVj3CIPK5vu8Xz3nwRQf/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114984; c=relaxed/simple;
	bh=Ok+dZk9SstegenVqbnAQRN6NWf1Fam24wrC95Gyx7z8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b8E06wU81yc3INilF5RlEAk2tQJZExYQGSHzF1XsarfJhY6h3ht7V7BEKb3EpFn8svCwHeoUyJIJPx204zmRkqM633652tWPqwrR3TEJUiahNWOHiyq9N9Y1fyLfxFJnbZrifVIHIUqfnWiyqx6Gs6o/dh/317mCxbI8nyG9A8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso10618155ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2024 04:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723114982; x=1723719782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njYrZI2KAenj1tRYEV1B/WyO4YVNlDOY48s1Oi9rOOw=;
        b=U29lQLhZsBPjWrlnFKsAECkVxEFdzSe2MjOHqLWO2kT5t9oU5l53GZ+rxtuv5gzwgE
         RHFDvLZ+rCLZ1FAq+3imXJfrWdIKqYZzjPlVPKB6SkKHbztIPEQ+IKQKz/XjzDpJjShi
         hODWqawpLR01/1e5UndoA5Gt7W0vqkLHG5cTUQVnXdAGm6t2tnQ1GIJ0c5MUwbQNL7n6
         l02LmJycqnWHC08hRbg7oO9/VBVhEBi41SsLEbW6GmdkR7tbvwHr4PuyMJEWngmydK1A
         heJNvFZuJipCFoxUDC5VWxMjZohVJpJlo2Qt7E97pdSEgIKgnDAGXx/earvj/HpzF1Rx
         JUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEaKKI/gVP6IHIm0902ovJxTa+hUc3YOhaNk1rw8k1cdgQ8hI5dY8ktbpzqJN1OyYHJ9fhey7RrVya3DfA0RxdQd0dFpibJtZvjJlwUjJM
X-Gm-Message-State: AOJu0YwbqMaUXuoftrzEQVjU1edpKXqAx++Ee0dEvZMf8qOGL9soTvuT
	8LDk7X9fHA5VUP9fxIshdCNTBvEf3WVdXE7e3jP+GEEJzJvc1vrqB59O9rlVrUfWDDm81l4XBar
	RQpRfpklJl+Vki0IvjnUixRQZwGxkBRcH6FF5nYv4K8g3/NicnAkcCZo=
X-Google-Smtp-Source: AGHT+IE563ij+gekVscxGZzfs6EJqcj+1X3TmLCDhC/vmiiDnRfFQpLPrgC04GgGJsEn4UeHI4k+7X5clLTXlOlpcUEhyZXG8ftJ
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39b5ed6c734mr1119185ab.4.1723114982649; Thu, 08 Aug 2024
 04:03:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 04:03:02 -0700
In-Reply-To: <20240808103754.2783-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072c34e061f29f8c9@google.com>
Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
From: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com
Tested-by: syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com

Tested on:

commit:         6a0e3826 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11eff061980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73b1a61cb77f73e5
dashboard link: https://syzkaller.appspot.com/bug?extid=27c3c57b78da2a0995d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14872e5d980000

Note: testing is done by a robot and is best-effort only.
