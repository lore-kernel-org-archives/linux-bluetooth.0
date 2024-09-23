Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD97DA81
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108464; cv=none; b=pdK8yizYqokEen1jyo0TqZ5fk0he5U7rh9a69mfWeYru/rD6jUX1WEM06uAIXGPMizybT0bmnOyl3/2bJa3NvfIGmEbyyEbgrJbKQeTAEo9tVGZq0H0IDzgW/XQqDWj5/d5Xfc+VKt03cdn802Al9K88BYw/NTGQ1OWDTV/MFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108464; c=relaxed/simple;
	bh=L+9N+3jNgDaYbqwAlmJ0cEzDvhkQwJ1dQex7ayV1rzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QwpHRK6IaBDAg5ZvJ7Zmv5Lq+FWIKr8qL8mvhcG/0cgWvEbdCWNKeCsE3EcZ6tlsfNO5x5GZZU1T50yymyJpwxv38QOFq7GRoilTwRWMCaSwZFq/zuLh6nOXNJ1IRTKXY5XG2nMC1VtbZgkwyrD9tRcHWhQdT/HHwFxWKpxiKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so75528825ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108462; x=1727713262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyXLZ8YcQWxUiFP4L5BAm3AOQgYVSxXc8FGcwG20glc=;
        b=C9pbpCO6xcdXvjeNEAobRJOICxbxbWKglFau6URZ0uDqURE/1EBOZhs5fAGfV6GgoV
         LjHyfD+w4UdQfZR7i02aAeMn+zCFwnlpXRIhvhfLLB9SQSfY/YtW2+qOIV4XHysaKGfe
         SOd8lKp0Kl2GM9pcA+COt4UvG3Xcp1J+Wpf3V71gHRDSAi6wIiTYs5t4RFftmin4sRSn
         1Msd5AYAZzV+cccmY4BFETM0+dmOFPV5576nWV+8rZm9vMSd2M7jWXyY963SDsHEXf2Y
         88h4AzdFiuzfo2ATqhKKNuy6vgi7bFiy/G1tNTATQhtQp8F6WS9qQkiIXK6X8Q6yc0dp
         uhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjJlKxGe9AKluzXi2r5Wgv8XIKiRZj10IHlwoBkAVQRl24Q7u8ETSNivyTdJm5g8iHY4qVuqbYRprSSvf89I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoEyQABQXgpbcoGje7F5NTSwGoXP7oBy8DJ6mE5SDdAW9/9bE
	vMErC9jN9+0valDHq16tbXSbGKBU4K+K2PIbaBwKovIMZ9G/rqY2nhKPe1QeuuFoIWnL9HS+m7e
	ZcAKBtbHcm8B7Av8+V7VwBRjCwvsgFRfuHgUEiJPc9ODwPlmt4So+rw0=
X-Google-Smtp-Source: AGHT+IHu6xO2NprjhpjUnqu0sXeXKxSgmtjxkZDyTx/YPDMumgh4eSm+vTEsSa2P8/E+7U5J7QnlEz8tZhaF4o4MAvCRALkqLg6J
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a0c9d70074mr98104555ab.18.1727108462650; Mon, 23 Sep 2024
 09:21:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:21:02 -0700
In-Reply-To: <CABBYNZKg28ccCZXqBphNLp0WEOznS89Z-AiShC53JAVbsSsbGw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1956e.050a0220.3eed3.0013.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** malformed patch at line 6: diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c




Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f72107980000

