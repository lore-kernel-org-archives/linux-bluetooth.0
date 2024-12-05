Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6121A425
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412906; cv=none; b=dk9a+GyX3p4c/5Cjj85Ivze8JcVl4ju/Y0bIRrLSI/NHKWFt9gNAorOYA7dTOL2WASCjbF5JIw8xtpw4WZELhOHiFiv8ouwGnT3kNu212H2BTF9OT7d/Njljaxem+Fu+voDRsD3S9YkLFORaWL14vhLOgR/60Z/erL8J7gBlSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412906; c=relaxed/simple;
	bh=8Zy1xJENSRu/fqSg7gokqtE05l/AJYqZwKbRMqmwaNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=npnBfn8vvfmvFAIYAHoenT1N9v9mKZI91aOqqO9oLkxgnrFfebwupycyquMIIZoJlRcK2Ai0uhk4ISTG/ORzp9XMjlnSOBa9mc7IAR2LBRrGQXRYukFv/Nq9HTK/QKpbZTh5cWMU3B9K91yIh9RoYFt2EIDZPFyki8k3V7PstK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a79088e7abso8194535ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 07:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412904; x=1734017704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tMLHk0vogVjsRJO4YICZOAWW/ayMFssyV1IsDTp+fM=;
        b=p7eXwbejVzg79dqN00YWd3m9EWI5ZQCpVkj2Rnnp/xWI4IiXHWortNG0A3gYJDooMs
         rJaaD1iGXuFw3xnb4sSSqPz4lWtYB51SxiDAGKPfQ2urweYFmNOao0RuxBxyy6RLIcOK
         ATclbUMV6Be3EQ11rGLPo4c1A1azqIFYxem9Y+t1R1XEhNI0B8eh/HIQiu3T3uT3m72N
         5oJaYenYLs7tJs7NdPPongQ+xSA2T32fer74mEhci1BohtOxZYjAl63/sM8w5Hv3FIF+
         g5PAuQAoRm/+c1f/nn+wfKdjKY0KzeMZ3W/NyBPyk6ezGwmvktJ40+6S3+Up9yoKXucg
         RTeg==
X-Gm-Message-State: AOJu0Yxtwpv8QDEZg96744XgEmvKWUcWTP+OjIpja0LLMK0okNuQ61qp
	8luKMSVzRxiOwmB77KqbNAmMSIyQji7SjjfrK9E1PnQMsPz2YdAbY0LSE3Acrm7rfS8aESvQDyM
	Re6xHEKLPdn93gy0sKkourukBqE9lGE2zx/Jxy5dkNYVkE9KQ1ypfB2M=
X-Google-Smtp-Source: AGHT+IErmAHBlWlXUmxa08W4Aht9gWLfTi4WP7iATiLET26xxGfxuukTlDDdYmE/t74tupmEmMtaylFktf9ZbEloAKLWi8AP4Y9a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e800:7d26 with SMTP id
 e9e14a558f8ab-3a7f9a45a64mr126695165ab.8.1733412903811; Thu, 05 Dec 2024
 07:35:03 -0800 (PST)
Date: Thu, 05 Dec 2024 07:35:03 -0800
In-Reply-To: <CABBYNZKEK9QXBbtopROD=94h7suNA_UbXUJp=H+7q_2n3OhO4g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751c827.050a0220.b4160.01d9.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com

Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e1330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=773e6b07384b3087
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178490f8580000

Note: testing is done by a robot and is best-effort only.
