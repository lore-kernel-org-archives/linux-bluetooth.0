Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0D1ADFF0
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075244; cv=none; b=YyCLofY+r5/X2B7nCWIQCg/4G0VkX1+Iz32SFr+ghu0QKLnsJifUcwQHFVjGd4Fkzx0FDpbrccR+0A7dL+z4EY0i5zT2F8Url1bR4QAylCGogd8h/qXMkryqQvb0u1F/XNDcDQ/+QsrpzPN1GYSC1iYP5rLdaOJ1bwrtWyOQMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075244; c=relaxed/simple;
	bh=sHrNFovkx7cIfUOdmMEBpo+snV8G9B0mz8ruz/fphSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ah9ns4LMpSLI1jFUsWDc4Y8XUPOcwZpEoW4H4fuWyD06wmQUODY7Ml94Q1uJhgJuIRGf61cqnYU7cP+oONxTjpKjjmpr3+/Y61gqVaA0WKmrIewoPYFLkOQFtAS93azBv0ecBfvO7jLJgpYxOOOEHT5G/Tp/SqeRe07WlK2C2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a348ebb940so27621435ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 13:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075242; x=1728680042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=le2JLJB1ZWwLNcK4vQGN5IO/HRsEugT8/CIAYs9lFSM=;
        b=D4gD+chtu/eCLLaB9j/cAkkrDNh3u6fWGJRFaIilD1/Bsb/cFL1GbOlicCWH/uQhJf
         VRL7WJs96IwmfcJGDcCk9RWefTexY3MG0nwuT1bVG/sFKZBeQ6BIg/BSl+UOmUUue0MN
         zVqv62tB1TPezWdqMC7qv7hbHVa9qzs0RI/2jdhOR5FDx8Xn+Ylz0mYKrpQv24l+4owM
         DDvr2TdJCWbQRZpShq5QObwK6I5QzunyLqOt0u4T+FG8QFZ++Z1BCm+x31AlUdlaPi9G
         U5QJDhBMSb8OnzrPmHhOnvKbh/zE+3uHuI7vh1UqN16VpziDkgycw66K0+6m38V8TfsF
         zPcA==
X-Forwarded-Encrypted: i=1; AJvYcCVtk0mv6FiNM4gWdNvTgCLZCdO2xfCk3TOmdXjU80yP3bMEQ9XAkCiVP5CZkzp3crrWNXX3BeDB7bNZWBbKITA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FTLlqgut52ftJ9f8CtvRYenJH9H14skA3b7V6MXlN+GD+k6l
	IwpkhCMoBETLo35RqGXeDK+aXt3ITnCC9m87tztc8nOPccpdrn/DVEuNtN3mO4JFpTzjr7gzEW7
	er6LQ/7WPldtvXfTPaXVmppQiLPaQwo5xgaVgpJUgWG4xmgl8nFMm5GY=
X-Google-Smtp-Source: AGHT+IHgv5TMs/7T7aq6PVZ8bJabIyYEU37Oudywg8Kmi+ABr5pCKc0/mWyTJLeSCIbUDmzgSMeSQPcoul6ZVlBdS1iliKDhzoev
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a375be1cedmr41886895ab.25.1728075242253; Fri, 04 Oct 2024
 13:54:02 -0700 (PDT)
Date: Fri, 04 Oct 2024 13:54:02 -0700
In-Reply-To: <CABBYNZKxOsgd6FpfdOKGUD9tbSadCnBzzsnf1K8sVZQ5Tn0cQQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670055ea.050a0220.49194.04a0.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

patch is already applied


Tested on:

commit:         5c2ab978 ethtool: rss: fix rss key initialization warn..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cb079f980000

