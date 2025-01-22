Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728382116E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568326; cv=none; b=dljQVzP/YSXRd8K0OJ0g120A+KjuK0cWHqwCNZRmIbscMzOfBmIuj0MhQuq0lKYy+G1RU1KdjnmdY2NAxuXq1KzqP4Gqmn4HzfoRyp16UXd66yo4vk3A2EGA9/lCW0eISNVny6JghHTzLshjxVqL84nv37wGNq8lYtqQ+YwApXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568326; c=relaxed/simple;
	bh=R2VFEQNjMahC7ZD5k3pNFvxP/RpCG2By1p6tWwNdhGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ts5bog2Q8lCV5kDyIEfz+5HSj6F8CUPBYhiibuDtWWLKtILcXHfcAY5Eygk0Ew8xh5lFlGc4HdkO7MRGA8pUiRL2wY3YYdy1tRuqhfFS65yEU9y5E+FCiSFFzuXXG++NS8v38G7WSJdV2vtPO/nFUzEA92ABLgIvc/n/ayYgBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso1199155ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 09:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737568322; x=1738173122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51ItQhiCJIDq8zwFa7zWg6CT3zpoUUN7ge3xEWu8j7c=;
        b=AxlYXW1BuQ/hUAhwylHvAOD3F1TWocEJe+MiJhaW8oGucXzD9/HcXhhQ/V9mEwJlxd
         xvSAQqaeTI4xcalTFxhIzuGM4TTQSyY3mCGmYLcyYk8U8+9hQPIR6se/bEfU43CNpxWp
         42cC+/Z3fGWaUuVbBa2Xi3I68W+pw5HXDCleZ3E1uB55eilvnli+fybvVtxmTBcgIFGu
         vBqdQIyyopPcTk1QJmfHNZKXaGl5M0VTE5QIvZZo7XUDOkx534RNpcUiIpLXqqMugKWd
         IQCcqcsjdlhIsjIQNrmZUguHSRVa0mY33mp2j4KyGuT6506JYI1prnv4W1BDINa0PMrf
         kldw==
X-Gm-Message-State: AOJu0YzjSsBBEeozGcOChBCSe5OlFq/i9TGscUuAYqEfYQLRw8RL93YP
	wCZMhWwX0nB9CK0ctXR71hrYu2Kw1KTYvewW6o4hThaKFGtnWgXkAoDuV80iXOxy9S05qlrUuGH
	G7jxGuI6vjNbN1Cip4XCVqBxCNPOlzv9aqP+TeNqtjxHanX/m8dBGDP0=
X-Google-Smtp-Source: AGHT+IHHDbWA29kaR7kNkzNUoeD9n8hZ4b8r7aEQA5yp8BICSTZ0h7gh1A/smmDCuIJEMbMBIH0fEad6aB2lBxzk0Dq4V9AO3/vk
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:747:b0:3cf:b3e6:4c07 with SMTP id
 e9e14a558f8ab-3cfbc12fef8mr2051865ab.4.1737568322169; Wed, 22 Jan 2025
 09:52:02 -0800 (PST)
Date: Wed, 22 Jan 2025 09:52:02 -0800
In-Reply-To: <CABBYNZKDjf2wZYCmumoifFJ_OnG2vjJBqjE+0yOf9c6iqWA8+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67913042.050a0220.15cac.027f.GAE@google.com>
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

commit:         c4b9570c Merge tag 'audit-pr-20250121' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126f1824580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d46425e33fe266e
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147b1824580000

Note: testing is done by a robot and is best-effort only.
