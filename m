Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D8146A79
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735299846; cv=none; b=KZf8s3PNLZ++wYkK904R2u5uCHFPd/I/h10mS02+eVE4venaV3qyh61c0+ar2n7bvRn7N4RI6vHArzV3l0LAwrtaxzqy2WXyR9/fjoiqiIaPs0VLPlfi58tZUfXbEt8wUNe/Ug0A2Ma8z48tH8GU2hfE0HiwZ+YBXOyIGFI0L3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735299846; c=relaxed/simple;
	bh=N054E2hPUjrN8O4UfuJw9B60PfZ7JiN6Ga9VcmzZY8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=muoGWcClucAGoV5ASK74UE79yeHfNXMaYO4SY8ecnL3j3f+/vWk4+iB3pISzl6mFUJQHYjeDD8NVor01XtRZ4fUDE6LMzkA6MptcIvNdhr5W3SNrPH3+KU/Y5yHeAbV/00kTArlXlx5/mrxexpGNmnriiWF1LKCqAN9T3cMxD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844e9b92401so1244046239f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 03:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735299844; x=1735904644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipPkb6KOlLDvzxMnkIGLOQKmscT1d4gHhUtPVBmehaI=;
        b=lvjxa7fh2byjLqCSlbkEiqkvxScaoLz/xYVt5lFn6BBb5/nCmh32PxvTVygAVGFv8G
         55SyVcg2Gssv9R8R4p6oh5x8RQIzRhV5K3V4pRCHUhx8v167+LYO2STxmzXLrgCoepky
         MbLO3ZXYiEzWkwQ7tHxBR+l1VHxeArTrpLyDfNYGjFRpLaMHKSHbFtlWOsLd98HyYsKN
         di29k9moW5XStq8CyJUmhDRYbMQeDvO50xLlUTaeaRvzQpQI81h9ncTrRzISesrv/sjW
         KEqulxD5k5BErauZeYOSl5gy/ruvLj2p99g//cgCZXODMky/6lLln26ebRNmw4mc1Ws4
         ix9A==
X-Forwarded-Encrypted: i=1; AJvYcCXOLhJsE70nbnu7u0NAJra3tG0Bohpim8XMkigs4WSB1jXVOw2ezZ5kFcqpZQA382CKYkhSBQqCi+4Gk9Np20Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9CkCpoLgPrbQeEDgethEFA+KxoGAAlYrMnPTj8VYmVkKYylC
	FdhUXaLBOpwXCPvxRPLoD2fd4NSXAisAGnhE3oUcYwHF6Gii2zfoGiOOrHzCkw8JMJz9EIsAb6r
	dXNGPS4TTDRbzeLSgHtiaStjx/OMfkcPTa10g38ioAl8WhLZXEuU7y6g=
X-Google-Smtp-Source: AGHT+IHlEtwWB1XKF/+Bc1zhWvIQ8P+I4ZE99xffe9w3Tx6UMVWior0vn3+P1kfI3CMm0b+2gAFW87RyHrVwYmO/2h+XyR/kldjx
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3c2d287e024mr215719745ab.12.1735299843924; Fri, 27 Dec 2024
 03:44:03 -0800 (PST)
Date: Fri, 27 Dec 2024 03:44:03 -0800
In-Reply-To: <67476c0d.050a0220.253251.005d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676e9303.050a0220.226966.0098.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __timer_delete
From: syzbot <syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ed9588554943097bdf09588a8a105fbb058869c5
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Mon Nov 25 23:58:43 2024 +0000

    Bluetooth: SCO: remove the redundant sco_conn_put

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1441c2c4580000
start commit:   2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9ccb1c9235f3d44d53
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15184f5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16143778580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: SCO: remove the redundant sco_conn_put

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
