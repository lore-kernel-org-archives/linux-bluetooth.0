Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723542AF1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437646; cv=none; b=n/K/8OdsdgOpTSRPX8I6Pk2mfB25IhKvJUlFL92rIC4PwKFuJ7GE9U4U9EkUm+dVoKdCtj+1LzqQoFD6goTSpSWgivm5sJvpaiy+58x9lkzsaGrqkLNJPD4guqoFZfFgg0X6RXzh/7oe3fx6uhsfz4D4CTALIOwLIbXsj6BlVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437646; c=relaxed/simple;
	bh=lxyUyI7Ml7rGG22Ce9B1f+w1Bv/1wiDQpwFGxLAqsg0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kADQHYOjkOaVfGPc+wRo9crAr6N700rBaiwRFu1exF+Wh8tFALOlmFjb6wBXKFHfnlb9LVyF2pQbkPorx1YJMCAagRM72u06dCT4v+Ol44dpRDYetQlJ7L6tTfFtPF5X39kOevi1H+Jq0cLfDFbcN0+moYw490TfJ4kXfcWjA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so663858139f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 14:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719437644; x=1720042444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/wMDiKgLoFg9RcAgb7EI/542G1u2cd8KM50iNDh2t8=;
        b=HYTAYkEPIL2JVCFPaaLYZrEb5fZlCPh+Y7dFwQlpIk1v2VcDoUD/YQE4BAEXxcMYf8
         GKovRnOcaLnCgVlDhRuB/qD7DnWQtPhuh5wQc+pI5CJaRNueKcOc3vgLuNg1/hu3T2Oy
         7oHuDhop5CKJRDXRvp9Yt1vmfdVZyiR8urSDeN8j79pzgLt/sQ7hYCuyuPQjOfCPy0uM
         GREfXE4qqTP81fCgwB4tNxn7aqnn2MfQuUKq+5Zcletkj/idNObeR+CBiW5k1Oqm36xZ
         0dWGuOJdkQhPayXPckesGXiamq5X/uc9CvZ8Z1Zn4YXOMp5clDkz6ySYPaYsodcNiY15
         2hSA==
X-Gm-Message-State: AOJu0Yy4GkITVdW8L5w1Lsc+JO/tpwpnNmHoEoOVJVlFX8mIVeLcWtwz
	vpwMvtDtXPbkptM7ObOJWtW3SVmIieqhBnBHGFvCOvhFzXSoJLcuqAE2HPj3WHuKON1UlSzAVnK
	aglTgqKryVcMTqlNOkHNS0MXDpkUg7rtPL7OdyFvszuA33kQF73xt7qE=
X-Google-Smtp-Source: AGHT+IFfy+Nbjrf2pKL0wh1L3WWKDsM5FXclSrHWOcJREVsHFK3u0Rm90ZSuxk4ROSbHWYVpL3QFeINWnPTJTzRZFDwTRmOfMqbh
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-3763f70d037mr11866155ab.6.1719437644570; Wed, 26 Jun 2024
 14:34:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:34:04 -0700
In-Reply-To: <f3ab10ab-38e0-4856-9d89-3b5409da0e55@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004b0dc061bd1c6e2@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=146c143a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e096c1980000

Note: testing is done by a robot and is best-effort only.
