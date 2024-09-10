Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B713B2B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993785; cv=none; b=Si3iExOoGYKUMbDHjwZ4MGxz65ZJTElfUjUrB4tXzPtk6n/ltbGBmomlS1mFknrp3PuLSxeQUsKEp81hK2aWbNRgvpibFmfMVK4X2mK67ynQmCtDg7drED5aoVR3G4h2GktSlbM56X91aaqTiS7NCA/4YriqL4PmMjELLo1+F5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993785; c=relaxed/simple;
	bh=QJz2+qd9pwzdqTsO888vAe1TULrvaPskQI/SG+nCCEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dx+j/eexK/6cOja1B6bGQffHE59Xs2phBL1/E+PNS3n+yqvxdf87T8v07yywo6UJMOVPWwmyzBXCFBaJFZBfmSPZ6wKFlF8cfBZUEViV25sD8j297S3VwBMqsAkIVxPq/1TDW7vj/7xaoVa8dIMOlgEGLwOyAEc8BCnKGPzsvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a050af2717so24115545ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 11:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993783; x=1726598583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLBAk3ypWdU8hGWOq8zDO/0cDlT1FvBQWx+mS/lVnI4=;
        b=Jm3tLj3LF5zW6qO6dwKT0Z0DLujJ1AxmJUVveYsk4UDuEXEVIwpxBAQ1d7eRtpwATV
         s5SPGdJq+o+PYI/lM0PhRIzRsJMis0ya/pc/pVFAV35Rbf7PkB7oqzaql/4MBWJWwIR6
         gnyShQA9gHLm4wpB40syFnmiDxZFo6bkYV4sYeYpD2pcgVQk/EQaDdRTtNiRFRMVB3MV
         69S1gxwKc2exYgVm1cSYXx0Bj91saHpAJuFEFbk7JK8WDA9HVxgP0YfG3BM1e7Wqwpo7
         v3PJ5yX7wL72LjWFj3LxMSr6Tgubg1M+nWPPvG7/vpWgrKKh9W9EJfeNpIAZRhHGY5KS
         FtZw==
X-Forwarded-Encrypted: i=1; AJvYcCX+sf+nUYR05To+1ksEqEd0mNeVHBZAZs3/SzvRPg8P5tIK0BpeyweIoRTMsk7adszE0N3mHFVb+fzAY64/W4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53bpOmKE3jVU/YxBb5n2bRWxiTU02XJpdzhe7evy+uFIxnNBr
	RFRbP81r1OsIY5Qekdyzrf+DTE9hHZ3nA7BOMqiQYybOnzlNl01zUX6BrMAqd7LGOxYOjatAchy
	kTYUMoKG5YjZgAf/Sm2X5lAILC/mWsX5v/0ZN3MmeZ52mRjVlC3Lp7pc=
X-Google-Smtp-Source: AGHT+IG7GcQYG1RoCoerkBdfw2Sd5+jf8sy9YrgrCZJM2ThdZn0e3G8MdGnv1is+AGVrLtEfbfbGSdpYxxTicFF6bkfT3u7PzbOX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:39d:254c:ece5 with SMTP id
 e9e14a558f8ab-3a074296270mr9157985ab.16.1725993783232; Tue, 10 Sep 2024
 11:43:03 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:43:03 -0700
In-Reply-To: <000000000000d8f51a061ba88d22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000559c060621c83e97@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Aug 3 18:04:51 2023 +0000

    Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12477bc7980000
start commit:   788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11477bc7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16477bc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11da6f29980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
