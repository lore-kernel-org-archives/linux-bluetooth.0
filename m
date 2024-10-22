Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A017C98
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626664; cv=none; b=ttPKveruu5Pp1WVr7yfPr2VCo3TOSinXtHisZ8ehSsvEENqH/SoaY1V1e8nVhwiXHC4rzZJ6HC21rzLX3SP0bBC4PLfsPYDIM5r0oJdWcZBRQ84o9x+PhZjL+OEwvCa0TIYANxrKOY1sxWofsn+e1brrtHO0DcNxeq462gOdMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626664; c=relaxed/simple;
	bh=sjKBGkepQUjrvlU2kiQ+Mr0w7TsVxlpRxeeYzwbHG28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bn9+5PlcsByiIYIPBv7IONKNE8smmq0Dg/kLCWWOkBZbsfnEbB3ENUGMmc3GrL6tijPLDe54aOqepZ2p9YNe3dvy9dmFvhZn+DYLLlwrKfEVpRcHQBSVi4vcvudX6BDr/++Wa3tZgzwx6ftqHxtLFLS8HwQ966N9QmwF2PSvBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so61382295ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626662; x=1730231462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mphveMtRTgg7DkCZcVw8eEGpbXeUtfITv+Yo0YL4T2g=;
        b=MfsP5CUaLXH0Xv1pdgNs1FZgiWxhU/wRXok2ixUrXwMpucRtZsbwq6oHiMWlRg2ASD
         S7vt0zVU9aotr/FwPxkrQaLCUSmfAsEv1AX+qPXU3tae62ODGGbtFAUW24BvYT8IS3RC
         5VSPfcHxXFzCvKLFVbdQAJP5aKr3ubSe6eeHj3nR2ZhbDBrxvB1LZs9DwSLdwKPuilEd
         Gvs9oCLZ4ibqn60QLPiYcBogFmRZagViL+2Qzpqww4FE1clfkl+Eeb9Vo4VcRh8iArja
         0IwfapuPECXcQl2aIy4gkxhKfmzHaxsqvNUCCU05XY2ziwsBJ9RJhpfY2f/NDDr5Mr3k
         1LQw==
X-Gm-Message-State: AOJu0YwVRfnj0g0LMbv95A+S6uLHauPSrmVF1WOZnJ6mfxU5yOsbp8XN
	+WptcFGk0X1jkXi8V0k9OhdxXYRJEPJ/Sg05WGeJ1pXdKG6rngu6TfKxS/xUVyiyHYy+uVqgK07
	lZgI6uuydvhNj+dzewU4ReBI8bIflJZ+vRpsvnB5uoECkCwRl4DWK9Pg=
X-Google-Smtp-Source: AGHT+IEufu1zyaQDXbANIArKoVeb3LwjEWPRlP4EywrHHI6H0O3hBBzbROtbYsrqtHwf4aiB7PRgzCn5DjSCayLfUks1ABPDhrph
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a4d596027dmr2974095ab.11.1729626662566; Tue, 22 Oct 2024
 12:51:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:51:02 -0700
In-Reply-To: <CABBYNZJYtnHH1MjnNFdzfvu6jFOypL6iHjQ1Ujh8aYaycZzjFQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67180226.050a0220.1e4b4d.0078.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a34a5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=346c6d758171538d
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101c0c30580000

Note: testing is done by a robot and is best-effort only.
