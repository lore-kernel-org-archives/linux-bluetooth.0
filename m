Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BA1CB305
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803326; cv=none; b=J/rS32uRtkVUzhPE+BBGsAcJ41paJfVYHLs/PiSrKemNQIx7uVoUEiYUJhka1R/Ueg0T19fL8M/YnTCmn+qSQrSGEIZ/4vEI4SsY8k8Uq/Nb6vYdQgflWLqSNWghm2Sd8XM8WRTZogC/G2+nPC+gXGzf8UUMC7r9T5t5Eh18DiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803326; c=relaxed/simple;
	bh=o3d0hdAZf/irpw7oxAIgUO4CV15JImGZI5ckb+IJ07E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hJKZpQk6Z26G8xPoLyx1CvTqSdBJ0Mf/jXrhgKDGwff1nMg2BADU9i+ECT78+1f90CM8/+9Z2PdYj1mdPgtiIqDmCCG+5SS3u+ABafQvYT5Usm2/XriE9sfGXA+d3SDen1uIgwu06p80tpNs3f75U166oTJJ9lNCpa9cPzExTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3481b26d6so44177255ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 10:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803324; x=1728408124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DtdhCG+8L1IQigBDd5DSf/JOs770e+ycLen0eSt3Yg=;
        b=eSiXr3z4fo+IM1hW1Zv4He6zewi6SWEfjLH2uxVTwKEdk+uN1wWRZXtGLginEiAV2a
         6bmTCkjx8wQVBg0UL2OK/Cfgorz5JFhsz2KN99TTvwa4bfukDiR4y4JubEdE4LcAKBfg
         YTE9Eq2KswPhbL3hRzBFWG8u1TOhz1TNErbjgnrdpRR6kP2sOHPanUimUSeId0fNAdMl
         H/Q/i2P8aef5UI73hAIh+sO+MLvBn9w5zf3akJtHwLXuE2XC6w9agkkynvTIfYxJKNo6
         ej1vHJ8QIcuhoGPJwi1HaGxNK4tvV5PptUjlTr3zB5yPU+JiSBN4R2Zt1199GNB78niZ
         CfmQ==
X-Gm-Message-State: AOJu0YyCn3EK5I0+zvjc0WW4pRQDQqoS0JJZN/M45aEz+k48Hp3aGaof
	8ppDw7P9DyJAEcLgEEpW2bkYll0URvphGVZNROzwodogqbwrUtZ6KdnTzPHhxv6g4jyj9CV8XsK
	2sF4XAsIPY7h7M8V5CnjzoYdb9I4JOw0nQl/O7ilgWVLCI0U1BXCs5yI=
X-Google-Smtp-Source: AGHT+IHtbclfBMf5/RpPJXd6eXpS07wmFK4mRnqUEi9VMI8PBduQCpvu58rPIdnIpiYxXajDgxqUfHxhR/kmnwnygvhJLIWl/0lT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a0:c88c:e674 with SMTP id
 e9e14a558f8ab-3a3659133e4mr2970675ab.1.1727803322800; Tue, 01 Oct 2024
 10:22:02 -0700 (PDT)
Date: Tue, 01 Oct 2024 10:22:02 -0700
In-Reply-To: <CABBYNZKKq3=RqD5Y2z=qy3Mv3Y8J53E+UEUi8bqWVAfx6CXGRQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc2fba.050a0220.f28ec.04c0.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_timeout
From: syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Tested-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d28927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fccdad3e2ebaa0c
dashboard link: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14060307980000

Note: testing is done by a robot and is best-effort only.
