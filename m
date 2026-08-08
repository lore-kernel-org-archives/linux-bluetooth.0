Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD93274FDF
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231026; cv=none; b=uXrbZM4eAtbi1cUTNHCAJEPx3kOkHtah2de9BezuIelCciMYCDpcuI8I7B32jNRiIFouO+rNBzmtQEb4f5caswiRPvq5H9vVkRVy5tZaFoMxqi+tBF25dQucYeWZ2tBfMh3GChmgv+XNBWYZF85cvZWdiunkcbfxutq0mxVZBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231026; c=relaxed/simple;
	bh=tUxjlKpfxcOn4m6LnAkxje4v9AaFTA9kQisf6/a4HCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7myKXp9qNythQETyDmEgg9a4y0LiSp4Gp0Wnfgsbz5C+HGGLry0ILXRA/O17ueR+opE/fdchjM8/5dpa6LVQY6xOa7heIKRsue8FxUznzG9ZLqHbH2oh//6U6vt096HTJeu4kwxXHZzpGexkfxQnNXEdZ0zDgttcJhV9nUfCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-448bb8bcf38so544551fac.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 16:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786231024; x=1786835824;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BThZCEfkCExqC8g8IxiY2sBSabBBkS5595qggdWWifQ=;
        b=UD8CO6/zfW4l/u2HOikZAaW5Lfv5xCUaX5j1ObZSW4sLHCJz7x/qgmZPpxAcXHCGMh
         tBZkHlK0qIEPuPkIby6r59YbLleTmks/isU/EDKQMe3Tn9BMDXEFG+N8y6POyuvVMnMx
         ihdjw4kAfWM3bRbXu4l0ARQ/J3K1UqU6IySlrOX9UTzqtXiz/7Y6FVTHB1f2Md5IHRqK
         Dn0a4qZ/XtVlJ4pZoyOP/PGOslOGVhBIrKGHUtt094qmobUEd1L0EtT6swYBXLcHcrk3
         S/KbQrffmUpSWscFsWGVw7xAN2LAZ0obEe8t2gCrHmJcN7HUWknMqPHwYky4GULRTs0l
         yKzg==
X-Gm-Message-State: AOJu0YxmcrqNU60kqtNKmjMn9lqRayuVzgp+/CxFJA/1qNZcIez9UMX6
	9cwGog6LeWP/W3ev4VUIZpazbtRX3X0HRnKn/ArLJiNan1H4CdLqozaxT0ArjPioRMn7LW/jGG0
	jBsldQOOZ7JdDpRKwBgSd6PuRbzPf06yBXIPfouMNjsB0wnZq3vjyc5D03JE=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6809:3cc:20b0:4b1:91e1:6740 with SMTP id
 5614622812f47-4b191e18af4mr7291309b6e.10.1786231024538; Sat, 08 Aug 2026
 16:17:04 -0700 (PDT)
Date: Sat, 08 Aug 2026 16:17:04 -0700
In-Reply-To: <204b3dea7b0e001f64920ed1114d38c16afdb397.1786225848.git.pav@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77b8f0.01d0871a.3a0d52.0076.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_sock_ready_cb (2)
From: syzbot <syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, oss@fourdim.xyz, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com
Tested-by: syzbot+9265e754091c2d27ea29@syzkaller.appspotmail.com

Tested on:

commit:         a7c7074b Merge tag 'fbdev-for-7.2-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1105bfb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4887c52b0f7d06a5
dashboard link: https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10176132580000

Note: testing is done by a robot and is best-effort only.
