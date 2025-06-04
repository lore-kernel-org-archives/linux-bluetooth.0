Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C12397B0
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044944; cv=none; b=N9HuBUrhHpWVRKUN5pdASLy7UmXD8o8sm7jQWhp8Gs+yWMYE0cEU9CM+N2BDfMC1Ylv/+SaCwWo+wTJAnwcUUJz48lhst5qF/jjY4ydZPyCRTRdkBsNaggJIxeHac4v5+zaOvQd2TofZn8facUad+PnCMCLdcpsmfRHRoguihJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044944; c=relaxed/simple;
	bh=E6AjJsZoQR7ATw1vqbUKxXWRnlc6fN/YqQrTu5Fj2JM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B0y8mhK64KU31cu/31ZqGzvb8U+BSKg77nkqOpJuuoQ7xuyh4WQ9gx4OW1Ba/RXzxp6uX0tYoIZlb+u6ZznRH2B/lSaBWNVE9YkxHJIyFgDgRxDgQ/IWID4+5Q6cvJXljBPjrtd1TJqSBUEm5mw0bMVcRzEeLCtkWVw7oynaAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dc854af016so75200265ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Jun 2025 06:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044942; x=1749649742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N11uxGJUKeG559sG4Xn+XEgkd5khL+2AZw1RyfROMGw=;
        b=LYJL0sr+vWvH8OEZj5DmPcsz3aSqI0Cbm3mQXl2R3jtHQG6tLKt90vRl6x+ovMCcOQ
         h3+eixqPX9S7nP0Z/RZdZH3tp6OVDs9a+pVRRQfDHjuVW+yFEJ1emrXUmdeJJ0Nj3NdU
         ecvV5PtjNnM5KhEEjGdSr5y3wcm+0nLQHIdinllxvRTHdx0bNj4nCo+4juhqWEmh2e1O
         INY6tMBMcdXwBxsdc+5XDk6j0JkWkK6CrmEyAI7qO+3oBVGaZiUO1il2NqZjy+dmYnEe
         yltE3idgj300oIXZtwsc8lUwJE8d28EcEJC8tttdSiYaa8q1DWvqnQ+MaNwwADDDmg7I
         /xTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrDvb4MJY7h+LH0scc2KSpc4ShsfrZ+i9T4JZFp7tKRfiq21IL+cHufHdurbGYmgvz7dZh0Qee2xtyNtb3BB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrag+IL1iviEsjtrEL4jRfM/lBklo8DWKB80wbCXqk+RDkp8Hg
	lADm93P2gmzVKQ6igfCn6NNtsQW46l6N6F+4c02mRhamM+T4f1xvt0WZH89a6Znk80NsYwuUYsi
	ANLPHIYdL/0p2xQS49gPbzOv8dSLGFvb+kU+JxCmEostfEaaPTm/ojZ/aJdI=
X-Google-Smtp-Source: AGHT+IHSSnUkFWqcgI/NtYmboP9G/XGenJErYrL412ddFEKsEXLA6AoH8cnZsc6pVZ4n+njQnEYpd/Nxew4+Rj19uLZbUqzVeV+R
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3dd:8663:d19e with SMTP id
 e9e14a558f8ab-3ddbee3d578mr27737905ab.10.1749044942381; Wed, 04 Jun 2025
 06:49:02 -0700 (PDT)
Date: Wed, 04 Jun 2025 06:49:02 -0700
In-Reply-To: <66f7eee8.050a0220.4a974.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68404ece.a00a0220.d4325.000d.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in vhci_release
From: syzbot <syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, bsegall@google.com, 
	dietmar.eggemann@arm.com, edumazet@google.com, juri.lelli@redhat.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, mgorman@suse.de, mingo@kernel.org, mingo@redhat.com, 
	pabeni@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6d71a9c6160479899ee744d2c6d6602a191deb1f
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jan 9 10:59:59 2025 +0000

    sched/fair: Fix EEVDF entity placement bug causing scheduling lag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a9780c580000
start commit:   abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=46c3d1706c2d2688baba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10564c80580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix EEVDF entity placement bug causing scheduling lag

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
