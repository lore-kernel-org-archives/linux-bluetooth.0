Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93213E02E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863745; cv=none; b=VCB5HXJm4J+ILXMaYMOnifl3RUH1ksxxZgDXFycO7A3vhqtMW0SvHJZNNFkfPFOKAqhlrMehGkFra42pdCW5Afi/RvgbI3EmeNnsPmO80ka3Qnr2Pi3WYUKRRHnE1qfj5V3XQrU5iqcBC9cwqodTuc+NePJNcdpCIxKIR64so8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863745; c=relaxed/simple;
	bh=/bd3ma/dAD7l96Or7WAx0hfZjgtiDmfL11Y6Li0f3TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m2Oc/mfgk63hp8RB54W0ld3x+zG1tXFva3B7FV/5DkbfsZ7mPl/f475Q2oMLgbm8uKZ7+xd4pLe2bb/TZJRGlOGaQll/7v2Ri2noToV6Gt91JKSM847WppelbaGw4RcgPPl7tcVCkTPMXFhoiZSfwBAh6IfbSQvchpiijQoD5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cca581135dso94000535ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 06:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863743; x=1737468543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joZ1x2i8obqtOPNVFLbKHrDgqWfAhM7RFuwpd/o9wy0=;
        b=LUNb9ZgSeELaOZg+zaoB7GhLeOtlHLihkZiddS2n51tRHjLm56BA18qvJsnmwq+iU7
         WUB3kXwULZO+TNzd0Hn2Y/a4dDt4XpPvg1PR9OwFERvmd8SoatpUmSQ8qzSweTjOn5US
         bbZXf95t/7Vi5gIFbWqvILFWd7Xz0pmtkvJXzuLMY31qzbfGkDzMORRZkJWWK+c3LO9r
         ls4zHqRkJdiXnn+K0Exbaz7aTLfp8Fx/8SD+VSUUDIsTF0Oocx+OjXDkF271EHiFCQtz
         erAYLLxCP48bdWWYHMtFx7XlvoMkusKGHfe42tgYPpyeanERiap3UH0Hw4erZqPKvnPs
         6NpA==
X-Forwarded-Encrypted: i=1; AJvYcCXTxSSBemkt0Zi9UzZAl6TzK1nyQWDzzzHu1W39L5AUvk+5D7Dwecrw5hlA9Vx2VrPMfM54pUpXMcs5h3mbsMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUm8XaZNvdB6mY76NHA8Hx5TknXPQqM4g+QjwjwQmRPaO+Hoo7
	BTOxe/wVof1o/s5eJ4h82iPnWix8WeV5PZ3q3dh7mdeBxeMABS+CqZQ92WyRAgfQSbuvXaHfZr3
	W6BnK0NR7k5RNAzN3apZlAbApSMnhK5sFOhQ++x67oZJSQiKnlo6qRTo=
X-Google-Smtp-Source: AGHT+IEOwFv/959LrZgUjPZ1+PGyTZgehs5vYxH2uYC8tfJTvl9pvj9M6c3Kff/OwMLktJ6EDRBHCZ+JXxJHBLsqQqbLuJDiZdu9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f09:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3ce3a86a220mr220941785ab.2.1736863742784; Tue, 14 Jan 2025
 06:09:02 -0800 (PST)
Date: Tue, 14 Jan 2025 06:09:02 -0800
In-Reply-To: <00000000000070784806124596ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67866ffe.050a0220.216c54.007b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e7b02296fb400ee64822fbdd81a0718449066333
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Feb 1 16:18:58 2024 +0000

    Bluetooth: Remove BT_HS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10665bc4580000
start commit:   ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12665bc4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14665bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11261edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa36f8580000

Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Fixes: e7b02296fb40 ("Bluetooth: Remove BT_HS")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
