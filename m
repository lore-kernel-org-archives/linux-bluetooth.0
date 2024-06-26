Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4019066E
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426548; cv=none; b=fERAZUCNnjISJJDTUXK9ie0zClqJSknb7qBqPUKU2RHDoypAl4bnWHo/raF9erd4EmokjF3mytpBSkx6wL/Hm3fI0fhUN0s4RqxY+9TBbLB61E74updPnCPV6Ax1s3c661xZND+p/7Bte1GhCOvk9rQkpFKo+4OyKhtt/BPccfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426548; c=relaxed/simple;
	bh=4/7baJuhh/lT7Cd2eMzZakIwFC/4OqwUDvhcrIGu7/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dOa9J2DUIf3vn17i77XbkJbvzvRflBY+au9PPmBGeesQhnW/k+iP4mST2uEZOTB191E91VG9fymR3QvXY1zuPW4MbPYa2NK+K9mVYxHLizNkhfu+dXozSM0edhdx8wae03kVUKz2/gtj2X33bixx2RttIFmfCdd0Ysvw7EiLqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so73937039f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 11:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426546; x=1720031346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwpjXibG3egVpLU/Cz4ZzBYRJ9ct/ttM3sVTBx+12MI=;
        b=D0y5xSGVRx15GEz7hGLvP6b307rxgWYVPctMCvI1hlzHCGI7CK0O2yMKLxj09f1IlT
         lHZlOb8t25wdz2VSrGZVBTvuK48zW9ZhN9inqY85XF3DJgnbaiR0BbP36+6q7JvHqPvJ
         5Fwj3NhQN+EnHQGdVVryQOv3PaLUEYnQZUe1XJyAftL0J2ja/YQgw1y1aQSJr9P/ukAd
         MZlOWwFlAuXIz+D0HF7nlg8D7hnYxc2LwA2Shsqa7IlBz6d0w0iemhHFYknPB8H7ye4g
         vTH+3aqflwlYq3o46Ujb6wOESKN/mWh2Qx3aLkWNAxFGPYmIMt7UkBoqaE0sKdnJd4xH
         HgrQ==
X-Gm-Message-State: AOJu0YzegUGz1F04f/6iYl+9xd76tO/SVMt0BzETvff18f3iyZjiy6IH
	bYiIXYKjVyBPZr3vNI61cRWb7VZu5ptNmRA6d19vnDO8ySdqutjEh9FaPjyxP2m0iKvMcPJNcH6
	ysQV8sMumD0jZ0QbLJp6lu1HJhIHmkrmts1wCFjQYwpDCug3U1xwvZBU=
X-Google-Smtp-Source: AGHT+IFBXRm+dBGPSfZSWjNzhRkHktbN8nPeJbAzSA80x+ytjT+oDOAM5vlPE9zKuN/nMl/oYxFLwa990b7qwYmKL4y2QBFbf+L8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6410:b0:7f1:3a4b:27ea with SMTP id
 ca18e2360f4ac-7f3d75a761amr2557839f.2.1719426545598; Wed, 26 Jun 2024
 11:29:05 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:29:05 -0700
In-Reply-To: <6d1f6bcc-2918-48cd-bbb3-e8cca46622a1@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077d198061bcf30f1@google.com>
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in btusb_submit_intr_urb/usb_submit_urb
From: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com

Tested on:

commit:         66cc544f Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a59299980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169b3789980000

Note: testing is done by a robot and is best-effort only.
