Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF01AB51B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148508; cv=none; b=N+6ii3+2hO0C3amiS/boz2PasHo877o5n6J3IEPFENElqI51ZZvDjdbgQDDpwVMMsGw7TRFUGgz+kwtzyrKgr66Yk6HDYQ4VJ309oIsBYbreLT0tqs/efb6UR9lA9mOxge3X4mrm63GyTzFbOEOz/YKEMEUfbQVK9I4fNgk9sjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148508; c=relaxed/simple;
	bh=teWO9Csv9Qkjd4mGWo9Z5zsq2bSUSbpjKG59mlbJkQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TIxvIvZwRVxkRi8Rq/cO7JSX7se6Me+cqdBtoBh225k3kFwR/ME0Xpd9E4r3j9eOsqtQS5o9zR3YocDeJfbSr94EqlRqJAQ+bocfxA+FS6vFUEk5qAS/89N3cvwK760HANXtnxdwjdJx6dkg+jS54dGXZWmeKDBY71z/JC65JOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so48860335ab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 13:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737148505; x=1737753305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcMAFza9W5gqBw9cppUDWatQ1brFv/F8m84x9kx4cfw=;
        b=uHOTlcFXk5HXM6z+c2dybJXYpFAs6SupZGvOEDCw5aWGi3QRyZgB/KJG8r+dMy58Rv
         ePhKB/4uJHT5TiSZaHT2wjM9EX3PIrNU2/M1sihdDkzHc6p6CCKoHT/8PEsRAKvVpi37
         rQb64IAqXApT99KP+aw19IP8lnkVxSvYzUEwlxaikfmISkSdCVIFFUvMXT27g0LPgMmA
         9Q61c7SZR0n9zRm0HCBK+eeP5SNSvsbk3NtQqNSEcY25v/p03igwULBhB1MUpS9eoVCE
         dGDm2JvqdjPktE9xRksgnY6TmkW7/rZBwXgvQCGUjCow08xOeox6PnGOGctjhiBXjuZ7
         +Rwg==
X-Gm-Message-State: AOJu0Yx0Jp7hERqSs2DzCPoWCzUsumzAoXW/aVkI0tQiSwN4bj46t/Fb
	9UfUle3ajeknqDPHKwv99Q/nGc6gmbKNG41tk8Rpxk/mxrbxUryNmAT4lOIaaRG5wo2GDCcCnI5
	lnXbIrvkDTlrlNU7XSooycLWOjXQqOHfRzZhJd+nPm02KnQ9Z3SgAxqY=
X-Google-Smtp-Source: AGHT+IHd3fF/yFtc4ierj0bBP/yHitKriub2CAWV75/6jhY8hARwzTEtrtXdFYa/LqBq6Ag2HG/73EfLhep1okTxC9PNK3ZbetTS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3ce:7ac0:64d0 with SMTP id
 e9e14a558f8ab-3cf743c4a65mr35732895ab.2.1737148503949; Fri, 17 Jan 2025
 13:15:03 -0800 (PST)
Date: Fri, 17 Jan 2025 13:15:03 -0800
In-Reply-To: <CABBYNZKWo_+EuoOWTYUyAFQ2RuA1F4s3hgdeSHuy2v9A5d9XCg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678ac857.050a0220.303755.0015.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com

Tested on:

commit:         ad26fc09 Merge tag 'mm-hotfixes-stable-2025-01-16-21-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ec5fc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122bc2b0580000

Note: testing is done by a robot and is best-effort only.
