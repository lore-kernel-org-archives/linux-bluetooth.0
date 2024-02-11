Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CE59174
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645307; cv=none; b=UR5LllNbcNxFLELM0FuJPzCNO1BCHcnO4brhhun4wZDTBldY4bb5nSm7t+92OsUTiufWQKkt2wx1mN4qYMeSAdT9r4oMtGvGSboKOysTIoWym3zQeU+uHnNSvYdwP/ybkJzcpByP8SH7PS8Y1+qnpWTgS8765LEQAmd0lpUqRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645307; c=relaxed/simple;
	bh=FamyLudsSv714I4GPKAWQ7S6nKsf1K3Kuh25o0PUvSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZPjNBsvOa+3qibDoYqMhhZYIpTJEx7zJOlaUGAdwp32x8Fix78ZGgkxmTt4WenNzSMYtV8S1cOkAjv7k9EZ/TsmVd6mZrI+2QdEb7U8g5bBAUxGaPMF2S0q6Kmar06QEI7L+bhNkIBz3y34ZZGosjjpmxinDcZLj88Nt8OLA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363bc80467bso14148835ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Feb 2024 01:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707645305; x=1708250105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XuWyRbY4wXt2Mt6STUVYn8j1a+Yq6fdJoZ0a9NfJrs=;
        b=iGUTd3VwvqxQeGM1ZytVW/xEKo2Du0E5KariC4Hhk7J7qhwCrArmg12BzOQN/6T5RH
         oJTw/tafId+vKHefxJun7rDxL9fqGIjTjr0Fcx5QFdyQx9HhRfApCYeXnCqgzdrQaCRo
         15NSaaqHWaiDk2+ROTdS/nVoI1bO/HoWm/GtL+bKml00o4R4kBJsYwiY8GwLw2RAkD6s
         LZpZaiX95itAdLNPztaSLUkCWqXpOtrGZledkOIq+wcmBb4fJtJP21IgCekz9z9N8LzV
         g27dEd0Qh76lma/RFKx9TuPb/YRth7CAU91zLns53oOSDX9NKrKZ+MqpQ9RKWQwrihuK
         7b4g==
X-Gm-Message-State: AOJu0YzCf/g9ZREc/Y2EUPEHViNCQWmc0uzfVDiQERujSuUDI5PyihA5
	8zGit9Ofshkdb6rH399S8+lyfmvLcl+HPpjtnJS13eApYVIWJKdhf55482n0E16S2IUFir6jORc
	ApCKccxqLV4rkKwRfNCWE4KGBxvSUSnMMEZvhF5cbKaLp+LgliEcqOvc=
X-Google-Smtp-Source: AGHT+IG3YZniosI/CpDU94Ng7pPafv+1B9bQ4XnJzYI/F435oR3FLGTsEkP6RQryGxVbCbrAEGkfujP1a2FR0BA29P31HNaNZa0p
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:8b04:6df7 with SMTP id
 q14-20020a056e0220ee00b003638b046df7mr338025ilv.0.1707645305395; Sun, 11 Feb
 2024 01:55:05 -0800 (PST)
Date: Sun, 11 Feb 2024 01:55:05 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4a29506111827e7@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Thu Dec 21 16:53:57 2023 +0000

    ida: Fix crash in ida_free when the bitmap is empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fc6ba2180000
start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127837cce80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12779dc8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ida: Fix crash in ida_free when the bitmap is empty

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
