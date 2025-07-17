Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E864C9D
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728164; cv=none; b=cwKdB7HqPFOpsvme0VP1Q4lgy18RZ7UbJH6kzk/fsLZaYLlTyZCyv0yNAGHdsUajbW9n1ggyzUpKtvcz6Dvtye/uCkM9ebfbwNbQJrSCrRwAAYTBw5tWhRqIs3GkdetjVgjBOKwVSp/5C2lxEm1OASzQJvhYeLWR7jVXh6wVnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728164; c=relaxed/simple;
	bh=DoUQx2vhcUN85Xl80wzbysCOIkPrdD8+hhrl5e5dGTo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n8eFXve68o8jL5s0EFJCZpt76LlLRm6qOAeIFywDxp3T834YX0C05SHotzsInyr6C/wzQRW6DGf148fQk6/4m+8b3D2et8Pk0Sw+BcDFfOQHVTmqlhlScsOZzbWGbqeIZkMmYxEpZEVNkQCyT3uRcgD8fq0NU5sHfy/VbPQL5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso5586325ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 21:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728162; x=1753332962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGL9AxfQx8QhC7YCMVTtwYJNq4RjiaB0PWUVwDrYvAg=;
        b=Ihk3mA8yOBVkThyIJ6Fpsysxf7Ctgu23f4LF7HXAXY00LyceRoUQFcZlILjbm7ch/l
         awVjd2UdoRp/YIW3Q8UVIrxGJtG0SQhWUopOAiaKtUlOEqpKPS8l4qskXKjdb3Eq4Qi+
         ZLT9ETK/SuSSOk7xOfnNd2AKCCwtxyfGkhOP4E92cFkQ+mp31zytJXTcyVDCqbFyo+WP
         EbtO8Q6J5ooOiBLG96ZFqx6O/VYovcNVfZ53nscy9vBIPK5KAt/LDbIF+SWzHol6HhyT
         Gooe+3Ugww8NOKEDaXOjLu3VK6FKeIyRPVdIsaxGkQxSNvK1roQBEVOYNU8czHYtPcgS
         1CvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNJVKUIj8MwGa0w1mpRQobeIqTeHcd5SQ5sEsZBo5ZrCvByM5AUbcw/yDiIRon0OSB6gQKFBbUDbGqUL5aDP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEem3KXFlFOvWwZMc9eFQboC74r28jusfHzPXo0xLGj18/l8u
	u95j0AnCn8hF2O6NMavDv6jF3cBfb/kHDL6aVTasrEpLfUjERrxgoJgGD0/F+jJytImi9Kimbyr
	o979C2QxlRP7O0jYXcE27uM/EyCfuVtVv5/4R51SM3YRP1xONYxaw9BJ8T9M=
X-Google-Smtp-Source: AGHT+IHTiHaf3C3Ox2evep1eETGadAR1R6osMNjc+B14tXzDp70nM+a8/XflrhMtyxUPyWcfS0RsyII5vvNO/L3tt/KjYM91klUI
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13:b0:3dc:8b57:b76c with SMTP id
 e9e14a558f8ab-3e28d3e7aa6mr13274945ab.9.1752728161841; Wed, 16 Jul 2025
 21:56:01 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:56:01 -0700
In-Reply-To: <gkct6i53onzjuzugsor6pnrhjfef7trwhgbjrgfie25xirebhp@dpqxvkguqdnf>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68788261.a70a0220.693ce.0039.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Tested-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com

Tested on:

commit:         e2291551 Merge tag 'probes-fixes-v6.16-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103bc58c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1672e382580000

Note: testing is done by a robot and is best-effort only.
