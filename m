Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261887E107
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198385; cv=none; b=NOXoVzgvC7Lg5Ppecg7eueu7JLntn1vvPnX26YWFyC+lPt/1zvlM388R9r97wv6NaLiWCFHc3DipfM0+N9avFNBvZWtQzEczwvTfVvd0yJB6Zho0vKtIm0OMamBkJAvizMXoVL61biflAqsiD3l9aeyvuBC2GRRDJkcS3U2kbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198385; c=relaxed/simple;
	bh=7+NRhfY3XlQPeEVnAjDcYEqgsGjBLuZWk7Egl9VMI6Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VPCCsr4EAAZ8CACEtvBERmqZg1yw4HDT9hvZvWsKVEKRF/GdiSOtvDryKT2ylZma12CxaRD9tQuKlrQ3xQZnxTWL/qi4lvU/rZxmQsBRq/NykWGwoTgiExViuBeAQkWm1N++lHBv5uC2TmuoS9+VQHxtzi+EdzQOifUxDWHVGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363b161279aso20246405ab.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 11:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198383; x=1708803183;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmuT+4Y3ckag63fBQNN2TnIvWbyVruW93vdFG08DOgM=;
        b=oOa9Z45jjg4QwkaCWicNEQQ5DDZMiVwDe9mDIxLfEs1SUNr7Mm/ylNVSKoBUQwjc6S
         13i8wyMjUWEowZ/MG0pI3XOeHFJ5V35Yc4+TzjEwTQdZWmMs7SzFB5JvR2uUkjvKUO6G
         mhpiG/M0LcIAZfKccRi2LEpM8LvoL/UJ1H8BMIJW2dDS85B4rX8a+j5rCKhQa9qc/8ZF
         FX3K2qiikXTlJmnogpNCTOtadO1ZpfMRI0+ujCyqZReANIAWikJ8a/GYkeVMcHNj64ee
         bob2/9BUQOiCi+898Scxbxc6x3Ubje2SS1OedY6/bPZSHAptd+7YXrgDpSUxURWLUbD0
         NNRg==
X-Forwarded-Encrypted: i=1; AJvYcCUcN44j5Fqy9bBpRGfd8iYWg+6tZF5QnwthY1Ijv0JHnGIO42E5pbfpfpdNiqGmuU/2rEDi5CLiP5MN5ZY5343/lLMBJwyMG4hJjHA7Bpn4
X-Gm-Message-State: AOJu0Yx/Zqq45KCxDmaoSePeraglhKodpzoA1V+7TbSUtLY075wAB9HO
	Du2z7G/7Bh1jb8NvfI3tGX4gnoVsRrJwFsKNWloIPv/GMFRM5udPwa3+qqyUT6h2tUJzg7T4iUe
	I++T19C6fuSP7ddk9ssXlQxmmQwTiuff+pkmlRCejxbuVkw/oHEDrFZA=
X-Google-Smtp-Source: AGHT+IGH7w2UlxjmTBe0S2g/UvpEYqwDqYdy4smaGKdctO4xILFQWdMYdl/msB56jEw7naxLG8BtUPMPcT4hWagCelVq5kX/pLYc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:363:d720:a9d0 with SMTP id
 g8-20020a056e02198800b00363d720a9d0mr608264ilf.3.1708198383284; Sat, 17 Feb
 2024 11:33:03 -0800 (PST)
Date: Sat, 17 Feb 2024 11:33:03 -0800
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d77a69061198ed40@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
Date:   Tue Feb 6 11:08:13 2024 +0000

    Bluetooth: hci_conn: Only do ACL connections sequentially

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D132137fc1800=
00
start commit:   2c3b09aac00d Add linux-next specific files for 20240214
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10a137fc1800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D172137fc180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D176d2dcbf8ba701=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1683f76f1b20b826d=
e67
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1765258a18000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16c27a58180000

Reported-by: syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com
Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequenti=
ally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
