Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F561CCEE7
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735218304; cv=none; b=TK1FIzgTjMuBYYXqfIJ5blz4Hl4/wLWBHSQxvpYc4nmnwaA5qn6LlhmRjX5JGRw3ECpaVlhh65V42+aIkzZzGGOPLiUbfTpNhYIWuM+Ei+U4CZ6cMoPY/whET0DbCcjcuCBKiAfItTBnsjVS9mdcwAPpCht1m5WjUA38LUTKELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735218304; c=relaxed/simple;
	bh=ojuoVsWI7D2MehUHk81iFoc6zeavGNHJ2AvCOakoohw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rUYT0B4/dkKHx2AgcecukEaQ9cZ4txMw+5qxuys7F2qM2njoqSPNvqPf6JXKe9izwX1x3Wg8CVj/aFvlh2GvlvAKQ47St0qMur0jdRlj/i77r7XZqRKiCU1AVCWgHQLh3Bf+qrYjWc2XVzpgAeOWf9IYl8ClMP5x2FLIz/D1//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a812f562bbso139640635ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 05:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735218302; x=1735823102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfZAw6nkkopPycDGHxqbXAsiMVaMBshiMpUf9RRGGKA=;
        b=lqxNuE5bqpxN4m2d7EnGxNoJiyKTqOQ9VD8f6FS6zNeEOwsQeJe1Q9nm3rfWOxzRRL
         VaeIWN6jKwts9mCSM0/MkODfBmBA6/YtNtA39EmNznH3guTLpFgxJeIUCsgsesbwyRO1
         l8Rphkw+oVYdo2qfCJJ2XJ6LRYJugkfWUzAEb7a3u9xMYF00WGNVouy1a3djf9xQVwlN
         /AbvlekW8ke82XVuEESJsJd853Y1oRks6nQBSRjeU8rrTO5o1fLuFpOrkzYyTFBpAo/6
         JV8naozYCFUNgA2ep23zxCWWNj+kfEjfUtJx3nQ0WHmYIusYJQe4KaZPZA9bqjpIht+G
         eZJw==
X-Forwarded-Encrypted: i=1; AJvYcCX2r5PRu8n5Jfk6CQoIGkU5K64PDaJlMjJvb+4wOUaEkb6EMbXjiQfQg8xUhMe1kholbOYeV5/9b4aNAb8omio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDZnGVDA3uZrt0y8a9ZyqZ+ZqPgpmTZpX4DooCiyDP0Rh6dBz
	seWNKbJSGNT2B34gbpKPs3osioM0oQ4nAOCrLIcwQ4p7rrOabJRgeqtvgl/sFVsUkDraNzDx7gs
	BEjtVcjGJrVNjO588DF4rf+opYkCpDMhC/gezUF2UcaMMTrO5mbIQJho=
X-Google-Smtp-Source: AGHT+IFsClCwKKxNjh2qy8IFlSdR86iJ6l6Rnz/rbCrEuCBbR90dTtUbE0c3fjildTbFNKcL6denTgyepBX/r2SPgRUFPEzxJQUJ
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3c2d2f3b65emr177346025ab.12.1735218302197; Thu, 26 Dec 2024
 05:05:02 -0800 (PST)
Date: Thu, 26 Dec 2024 05:05:02 -0800
In-Reply-To: <672efa7e.050a0220.138bd5.0039.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676d547e.050a0220.226966.0084.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_cmd_sync_clear (3)
From: syzbot <syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, iulia.tanasescu@nxp.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a0bfde167b506423111ddb8cd71930497a40fc54
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11845adf980000
start commit:   0a9b9d17f3a7 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13845adf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15845adf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=217e3f1283cafe80586e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1094e1a7980000

Reported-by: syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
