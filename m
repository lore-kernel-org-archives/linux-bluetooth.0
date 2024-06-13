Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E403140E50
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321104; cv=none; b=KpSj/27ZICvd8tisNsopErePcMhXBEY4OWX6U9L5oPxQ3xTDCdBbt/cHWaaT2p2EyYxGx6K71Nl2R6aPRun/gCep9RtOIQFOIKRaOB69UeiLM9qTWQlN++Y1kv8zXTB8l4J3Kz3xcrDuSXYV08Vn/wfwr7MKpjCR1M5NmDpA3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321104; c=relaxed/simple;
	bh=kRSIYh+IYVsXXlkBrcyb1CecN7b4j+1hi+u7PUdG9pU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Unjv+OVfIqd3Upd9gsYOD66/IyQZzCZrv6qAqQ473vwNHXu+NheBokDqZJB9tugP4VVEMiV62RicpyiWNMEoi/TTYh3EMsKogSmzj1k1bqCy2HkZ4urq/PNw/GYYWmqlPVT1+UAiPNXlBOEhsmE/d/aStZxGf0sPC2XCXrJ1f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so159747939f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 16:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321103; x=1718925903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qG6e0f6B6AAWAv+NDZols4qYfUhB6B8cdTbTKaoc4lY=;
        b=aAkdBlUPuUYdBqncJkFqjgedX6LsBuvvSY3yWn+gnxzD2mrCajsPUZiRY8vSAH3Een
         ext6G5c5tvBucTepN2rh8RUZ1ly225hQgkYOzE0PW3RURMzO8w3suKiDd079z3VDrdAA
         aupbj8lR4PdcRIB9+MU+iIZGm9YMSO8PbUCtpplw9NZt6p9CnoPIk6841/cxmDCiUvR0
         tsoLh4y7di35kk2Roys4nR9guDEHBy9ZXQECqUS70JmJi7R9T1E6iYGneBmX7VodANBb
         PlWG/0I4GCYUcxJghACtgo/Pw1EDQb8mCTB2Xi8Rafg45zgAq9981cEOt/omX1SVXFlN
         7zfg==
X-Forwarded-Encrypted: i=1; AJvYcCU2X76RRn4eUuvTwihskhvSNY+IzFabj6ULXdzdxc7fHca7L7xFKd80iEVOWNmDkLTv0+PvXzcFOUpobt9RGaCIGmsvQ0fX8OjJSspn65oI
X-Gm-Message-State: AOJu0YzDWShF4su2OpF8iJaVIOUYiktkr8QJuk/+axvPiSag/142IsLi
	TLk5FGKfGjq0OW5UawXpN8aSBJ0LDhkjm2QM2WU0PudPscg08+oHcxjmhsY69LqvO2tyLfPLDNb
	r/2Hz/k+klhgFdyMGWu0s3/ePaZCor59JNd2lVPiSJp2gQoGlH8rRcGM=
X-Google-Smtp-Source: AGHT+IEhDJvAgrT7IU1f8Os5C1RPrBKRLzz2lQBbD8T5VpaHGB5z5lOjl4EfW2O2KasgHQP6Kj4s1zW3ckdJhh2SdkGJz5NJZnVa
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ca:b0:4b9:23bf:6fd5 with SMTP id
 8926c6da1cb9f-4b96420b2c4mr11353173.6.1718321102775; Thu, 13 Jun 2024
 16:25:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:25:02 -0700
In-Reply-To: <4e155544-60df-42d2-89ea-924ebc9f7057@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0fa5e061acdce6a@google.com>
Subject: Re: [syzbot] [bluetooth?] [usb?] BUG: soft lockup in hci_cmd_timeout
From: syzbot <syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1258bf6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2abad17596ad03dcff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137d960e980000

Note: testing is done by a robot and is best-effort only.
