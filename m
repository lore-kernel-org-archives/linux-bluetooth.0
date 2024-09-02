Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241E1AB6D4
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290884; cv=none; b=s421io3rGQvAsU54GyMSk5mzE01J9JLrNw9jIkcVp4BB760sfKdbuTvHqLoVJhVwkJLD3zTAhwN5dUPEivHtSEJ6kaApg1DJQhOWqDKoUGpceILVbYjf+UyNFoXVs6n9i/mIcsP/BJUI9zmvMd/MSnB1ALNDyifzpXKaYUOUH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290884; c=relaxed/simple;
	bh=fcsvwgJHszrqFYBuVGMJyWBjEoNkn9u8s/Qvo7dREkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOQxW2JB1WuGe6yJw+rYIKmGN2x2mpkaFiiY77bqSaOfKw3F+JiMv1eYTnCYMKkwDnleFwNCOmcaG2z1PizuciHtecdPy3t5MkHfEH/AscBQZF1J6Q6UvxpA/2X3myn4s2W3JlukyodQmV4/AfcLfxB8aFDF+wOiabZJphdbbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a124bc41aso538494239f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290882; x=1725895682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPWC6U8f2qBdEbiB/1tHLk14BDYkG8mFDHPKIKYsGpk=;
        b=myRFzbXdVRzCStcZ/qrNsJehBZzUkI7wHUEq4xbJ/eST/CrAsKSPX4NgOrqOB78NeJ
         J4XSIfy/WfmT4AVQub1dFUxbVcLCYNI9cJaUrKdgfDVX+hPh9CCD1qv2PJwo3WO3BusM
         x7HMVOpT1sBfupktogGY72HNlfrArcSyetttzGQ74RVvh1OakC0mjzwMimoL5l8bCwpB
         DGgEfKkqwnGbcOrL6/gRlyi/vZEJzvNlW8NjBgUEkfCy2E8VjXrteH53kJchWlXOtnUX
         3WjzYL72hzwFfm6Di4po2wZgascrHBw1ID3a+/+5Ouf1sq0ZOvGNcyaXV6muRpYyKzXs
         X6IA==
X-Forwarded-Encrypted: i=1; AJvYcCXniaFRU5Q6RPbQibhnHgmQSNhdYJa163NQzT1uulO2NtRi9dmyJ0nutiGlGBA9FbTkt6q9oA7UYq6wTLdx5dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywohpq5hmxGhYk4ckt/zfoJM7WKIvZDZeErjZlDL7+ewktUrWbN
	w4hVqy4lrr9N40O1bWvCdQy5Nmo9VYt0mIqThPt79+eNuYTusoep+MvgSJXpdRoMr9VThOwrKh2
	cPKTWHyYMH664gx7q4/Z7lEfUXslrBlQlew3e0xl1cjFSmxMNNS0jI2Q=
X-Google-Smtp-Source: AGHT+IGYE7aRkq1QdG5CqeZumrhss9UwB66VHx1USISJdAEcgiBS8pGvcFiBithIiWwzkPxwiT2pBaJMBi9K1YaRPMlswNp5FSto
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4d017d77c32mr899228173.1.1725290881918; Mon, 02 Sep 2024
 08:28:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 08:28:01 -0700
In-Reply-To: <00000000000087bd88062117d676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b5250621249667@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linma@zju.edu.cn, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a579eb980000
start commit:   431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a579eb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a579eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f8f0fb980000

Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
