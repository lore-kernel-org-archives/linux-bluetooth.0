Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4C29BDB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369518; cv=none; b=PmSdWlQoTdD2KPplnJ5SBoAAlZAoU4LnbCkdjaBuBlVfS7cKEqcCBIRIauxONrY6gOd+AaghvnlqWX5cxHKcMa/KDvBHGumKt6i6J7GFAQ6UIyye7ytRdGNEkW7AE8ZesFf1Gyivju8v7B8VPmbN/uBODTv/0+3IB2jXo0rNGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369518; c=relaxed/simple;
	bh=foAD3VAp5D7YieYlBATJtz5KKRvnEtO8TJhnZDOQw0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KciEVr+g2TaTx8NiO0EoHhp7KS8PnZb91Q0Uc9veR8aSf+fsA2vSJIAcL0+Wm7X2o9HiompHdRzsdB80vWZSfhZib2IaP0EczhpYwR0YJvwD486caRRhh0ZkVs9yrpfLyRR2sVX3ADJuPlNrlqLnF1ZNna/uFj/77zvw9IFDDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4334affe616so1464405ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369516; x=1762974316;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRRzlP2SUfiESziI9LEaCdshMF/xNXFnIzUbHvATzWQ=;
        b=Ah72SYEO7DzLmVXwLQB9huIzRiwRFHLTQFVrA2vT+Kg/bCwrt3qhxLlZQ0LuYosSzx
         ipsn6UzNgLZ1pol8ywlYxl/zWiOD2+79mA0BFoj4gyZRnqycb0M4Z9BMxAwvg/2pT8q4
         5VSOiGel1Px/sTaAYMN4TPGOsyD2Wzm6kerTcsKdoc6/OTqvoui3q8DNd7boUvcjDd4m
         6IJqq7RAEDbYON1HK/HxpQoCRjd7ylQHgvvqLR3tvQaD9DvQP8rbXs+XYn8/am0l4X4c
         tDdfHgs5jFKcsBSDnKv4JBnv8OyT4agQjTzbX28kJnw/Cad8vTImhG1Y2IQsh0W9xw3Z
         k+Hw==
X-Gm-Message-State: AOJu0YzwQSRpM3yxMdrsMdd2fVYN1yq7lrh9S2XQTBGoAh1kcNg2e4hn
	i3e79SHf0s3tppTLZ08EwDd24yslK8tHn0YVFBFt9xZ1XET+URnL1xbYwR0RP2MkTomarvPCTRe
	cscnQ4QrvOzdowQk3lho1Hh1hn7V9rxKhFmLPnEfTgSIklRHl3Z0qx1JHj60=
X-Google-Smtp-Source: AGHT+IEJ7BOY6DuWAxm6vOrKe6KftA2tlCq5b20CZ9M+xK3VVjzMwMfxmhm+W0tgbeQxCc9Incv51aecgJHT8WRUqCE4Zv2lITeh
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c82:b0:433:2844:111e with SMTP id
 e9e14a558f8ab-4334079a241mr65949175ab.14.1762369516287; Wed, 05 Nov 2025
 11:05:16 -0800 (PST)
Date: Wed, 05 Nov 2025 11:05:16 -0800
In-Reply-To: <4981d33f-c45a-46d1-b091-e3d5989c8516@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b9fec.050a0220.baf87.005a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: ssranevjti@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: 

I've failed to parse your command.
Did you perhaps forget to provide the branch name, or added an extra ':'?
Please use one of the two supported formats:
1. #syz test
2. #syz test: repo branch-or-commit-hash
Note the lack of ':' in option 1.

> https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/
>
