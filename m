Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E41E04B3
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399485; cv=none; b=AW3Bd54oNPoVvAcE2G8CZTsgiOKq1n/j+TEvOYUBjvmBj6oxsqehuo68X50hKwmxQ3WuifRmL41J79ZH/H83wTuNbYUho1LKliACEd//Cmi1buX1ZzVGOlowTS9h/vb9CbTSVKSmY+AFiv8HyDit1WldnyNzXxqQF8eQ/zLocIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399485; c=relaxed/simple;
	bh=nOwVle6Stxv3v1afRCHltJokfacn4AR/Tx+Mw/jcOxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=su4Zf04ES9g8qdnv0DrlwY19Aztc8BxqwDK1HujrSgq7sYdcUx0s0QJ0bHFxJFsJamMhTTColst9uWvibQADwUNpnt0wzgTE78lwVliPFiDUN4Y43w4cB8i4sb+W6Via4vBcxJUg7XqyZzAT/NTMOWITmp45LlipLl5CXSdSEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8324396d0abso501904639f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 07:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399482; x=1729004282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJeGD9Y8jrgl/oXElrMR31OMURMD73DY4O53Q4xsm4E=;
        b=fneJ61c4iFhHG3HOaUr5u/ihwt2b8cPv7BhALhPVd/FlbmnQPk5ZeBH13GEZVS1dpA
         PLgTUfvzIcaVqv9iQceII0pdLQFdpAd9k1RyhWZXOQj4py8xVPpWcfFe4Rf2zcemblMn
         iGzriCW+Dp09U21O4eu09Y5vKv4lGa+1NSCzlqBrpxjB1rcetgAfhO9z4tIaruscQtTU
         FU3BQ4ekuBcruvMLemyVIFEAfD8CFo5ZXGgIWmX37tZd4cS+Ec1fti17miG0HlvhMZ6H
         LLeTdf02HKIzSjfKUIbvrBwum3EduzakddTUj579PpBsmG7AuxVrew2hkggzeY7lhOtS
         jSBw==
X-Forwarded-Encrypted: i=1; AJvYcCWTg+az/ZnUXfpla9fUr35CE/es2hUnKEcfKFmhsEpXEOhMGaMA+T9XS19Qq7E5QDYvlhNiiiUjpzq58Egxv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9bujVoIGB8/eUxGj7G9kp2sAhwE9+BgHYt0PTM+ptdUHXSd6
	a+XT1iV8k265zDItm0YFNnAIPhYsX9ktG1O4RvLgJBWe3CCNdDLyXPOgW0TGSxYUPS4BG/Ss9ex
	utCe1xkpHWPuLG90u5A8JXWIlFVhHuM6I5U15HzXB7dKQyskaJ3epcYM=
X-Google-Smtp-Source: AGHT+IGX4SuMzVSoQiQAHj6OBoBlstm9xuwOTUA9Kerj7ivq743kOGItuXZZrlQH7lZ/MZN+dlztP2lAzxAhHOtHA6s7fBdkeQ/x
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3417:b0:82d:581:8860 with SMTP id
 ca18e2360f4ac-834f7d7804bmr1348258139f.12.1728399482375; Tue, 08 Oct 2024
 07:58:02 -0700 (PDT)
Date: Tue, 08 Oct 2024 07:58:02 -0700
In-Reply-To: <CABBYNZJeFv3a=WuKpN0=6KwvELtWXOoRn9HrGhxnVVg_TVaa-Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705487a.050a0220.840ef.0005.GAE@google.com>
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

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf8f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f41780580000

Note: testing is done by a robot and is best-effort only.
