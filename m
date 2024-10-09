Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF918EB0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437767; cv=none; b=UeJ/vZMDArrL9uNS3SIdM+cWCaGPjbygPbPgCIkQ8kGJ1yg5+4qrdU7w+CVtlmTgx2cRXD+5itoeO4lsokOxW+JFg8/awPpXSbDrtYihUZ9BVFnNX0wmcaWcK5vZF/vzLcFM3Ml+JJa4yVm86RwFaTmL6uSvfHoklrqhFS0oaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437767; c=relaxed/simple;
	bh=fv6teWhfUYzzexM3JzXVxL3Zyi4dV0yeBLI4wMP1T7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nhA0iBca7cJZogNuOJOzXUVwKZ0Eu0raRb2DFvRrEGyI0K7CUO18VyDdwjOLNHOo0kcdIddoAJU+fLSvk6v/Ed+b7YS2iy4NN6qVMQq3YB6jqd6kiPY9/SWmoxryqSieewcqV11xWaRS6CS8WbUEVBc2fy3ZzDNNhQUVeeAzmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34ebe595bso76160715ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 18:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728437765; x=1729042565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMbmcc0NEDOLCs27tEkuL3iXogO6pI54JQAcH1O+sTk=;
        b=TT8Ug6fZzqy32dSkGFEqw2YEl4lk/BgOUheyaFCs0hJ35/bbp4/xqGXdIa6iKHDhAN
         tYPVXXhBMR/Oj6ZmhY1CFdQXsnXWeQ1krNFHJRBOlskSq+hxrZhQn1Vb/snwrjrIb7dj
         xiytzZ6dJaZKHAML0a40JhvMqygWZbRImSiKKRl3xEL2BZomiSNMYUTj2ES0SADVqRJr
         4P+rWDTcPqSoFUSp7+nZuD1VyS4QApmTvbFyShdQ3sb2ftPJb93+uIuiUtejTKeOBA3y
         j10UBJE5pTdJCySYsjIoWBjGBfv4aeo3mv+H61+Opa/7G4vF7PYj0yhGI3+fQvbw2xQQ
         cjFA==
X-Forwarded-Encrypted: i=1; AJvYcCUktQXJ7f4gPbI/hIpmTPrPZoNNVGMxG8HRyItsFuSYyWiEtPsMVCzk+JxmM2pl2Hzl1ujFHsKOapD7o8eocO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IBfMRWA4YgrHaxJgEMhvmYgzxrPEg1s9oQXDK8L6Kjw/Qgg4
	GfpFl/z3VJ+Cz10J3fCEoZJ0GUUCo05TQAu1/gGADlLM/NAUPD//MME6dDho++/aiSvVWNHnbSM
	91yxCYuLB2f9BhAJ97ZAi5tnaYp0MHyF3qxgx81r6rOIpFCNTEqT5NbE=
X-Google-Smtp-Source: AGHT+IGuVo1kX9zuPtjY7LcZi5euNxlBM2LcUmWbNR5GryfJrVBtMJoqvazkjnbS2g2wxjB+LdygH9KyOYDO7S7PNkcBH3dRILiW
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a397d1123fmr7435775ab.18.1728437765641; Tue, 08 Oct 2024
 18:36:05 -0700 (PDT)
Date: Tue, 08 Oct 2024 18:36:05 -0700
In-Reply-To: <tencent_68B1AEF2EEC20C9C27C246DAD2F2C6568906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705de05.050a0220.840ef.000d.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: eadavis@qq.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

Tested on:

commit:         75b607fa Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1415f380580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e37707980000

Note: testing is done by a robot and is best-effort only.
