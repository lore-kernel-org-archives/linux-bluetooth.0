Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16623D7DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025884; cv=none; b=m4mJzD4k4xQrx9QRqQeJa4ehrO+KMeIcY2DL+iOcUhkuIpmkgXbvQ1tjgZDDMiOIKVzMNljHaLXQFSvhFz3G3jfQitffMVxd/lX4Ikc1ULekGkOnVegzXy+rNW3lqjQwcfExp96gcSlLHx47O4BI7Qhx2kjZ91glIy8URUnMPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025884; c=relaxed/simple;
	bh=+bIo9cJqounn5tFWO+AlXDj10n+Ru2lW6w5VCXCaQQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dnWGXU8iSGVBg0yhahJ/0OlQ6yjXgsfFE64WcZ6H7w5ZLJurMsOrCnGzvudY67I2vmhg68/GmlpURXidT69w0AL3V1IkA5Yr9Kdnio8GQYr6wbI+PypVKJUjBzQuK/SySxss1DbSfdxdPp5Xt8A25EimFBB7GC+m+tDBpjIvlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4dc57e2a3f2so1618256b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025882; x=1792630682;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cc7DalWNCMk8aoTJaj4heqsGM0iGv+AJvAgY3BsSA4w=;
        b=LrXrvCM5RzCb/PsDkIz0FQYuzNmrFELnkGS7vQYW8wiJBVV3BuwgoCwuvNM2tGL3Aa
         7+ilfkfzvhF+cvF6JvBPr7Apfln87y91PQyLHfDL3uG19jl+m3UfMvvurDAcctRuj5Q8
         1tNgLcTu1vi3GzqTIiR5ozuTZ8VdfBWzkxp2OjFPwfwtX4UMGt2em0UBNxpdOK+QuSbA
         g1kXsy4gxegWeoPxm3ftG6tadBWqBXmAfM106k4ov6/60xCL0sEtBYMctafGUC0wqdWC
         58n+r3LvxS8Jh262gKb/YumEO6esrUx2aQ899y2MkdT/aHjhaJoiTJCFIagoYsjEbvEZ
         vjhw==
X-Forwarded-Encrypted: i=1; AKwUvBy0D7mqjVRPZD/+MKkw/q0Xl2CiuX/rfI5QOrEejRtbEul1f27eHZ/iJHkENs2vgtsqMxFl6PXSp/zd9XVKHnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKulSKdiy8YRcBzyMaTOd6K1RphvVrZMYsaLuBOms3kGjA0jSSb
	TcUiQmEdyJ2LyWYhPiDx/Cuk20dVEFRvSY50nV+bhk5Qzys7NQ1DhcFUnI35n+oyv3z65NZoDSQ
	ebLb/KF0PfOKFwCV3L5TQ3dHMspZ25xeeAZp8w5K5M53xjH6OgPf/2R7d3e4=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:338a:b0:4f7:1e2:e79d with SMTP id
 5614622812f47-50c56354c5bmr15028368b6e.40.1792025882366; Wed, 14 Oct 2026
 17:58:02 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:58:02 -0700
In-Reply-To: <20261015003852.532-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad0251a.5f317f00.247b6.005c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mesh_send_sync
From: syzbot <syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com>
To: hdanton@sina.com, igorpetindev@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com
Tested-by: syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com

Tested on:

commit:         0fcb05b7 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16034599580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc812281b37d1115
dashboard link: https://syzkaller.appspot.com/bug?extid=f20755f37da70df33a16
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173b329c580000

Note: testing is done by a robot and is best-effort only.
