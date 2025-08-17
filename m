Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33471E868
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Aug 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755411487; cv=none; b=SpQHrja5BH0v59I+kum8sE0KpU8C8J75W3OWoJuQTEPaT+udpEyYzrWFBvgM4pm10V57CfQvO74qtXDZIwTbkMR2H4EAQa/ZvkWP+I3lyAYKAq4OhmKsSqBx0v5CnHYe+VSH5LmyAkT0P03fANXxLRC2Mqy+T++5OlI+0T+HSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755411487; c=relaxed/simple;
	bh=x6SRgnib0G7M2g+ot+TWQJ8h3Z9ID7PuY1Ye6vQiO7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lCcdbWbVICL1Y54sVfcK/40iIkCh9gXfldKFYH4OC6vfQVeDe+DC6yLAZJJ24698pK/bgsEauJnN/MD6o8mxZoEpQ3Fcpos0mR1aptIw8PW/wyDyGbaopdSjoTTktCk71NOaL6aRqShFynMQyCCsaIe5vyoYtDavOGGbFMQSkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e57cdb3ba7so16025005ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 23:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755411485; x=1756016285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdO8zLjvXGnLAKqt2Wo9ucoKrtcFQMjL+W6shvTRwsE=;
        b=e6Iw0Ntsqy9iVDO+aq+mp3+3eeAIRvYIHwyqvvueDD+b05+rkTG5WnZ/5dtEM4hlEg
         eF5IXyd94rOQXaY3E6TCA/VWkpjUDXitBKYx5ZxrALyXk+8WDw2/bNM4a2ftJnxJZDW1
         +355Ys/f7VIeH99omjP5R8dtM8ebprMqTSlJ/V0DZ2nsuVnQoKTKccQkjbVnYTR0Ly3x
         YX+CyvxgZ9N8byfma4HlMD6R8/q6bVFMRydn43p85buvsHID0ME+2FC1U1iE1oU5h2SC
         OyYw3KJNB3gRcl8pbHfb0fyOyUEGofzchK/92nNF+lMIJziH3yABVb9RJGtDPr1mdczl
         f+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBWaTulhjSj24RSITWYjDc5ywG4QEi3XJV+kq3TgA3IO13uyvfwAOAncxxYRNkbwwm9IFDjj7UM2lxrDt4nvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Nxv7siqSHv7EG0rWjV6PSItcRXSWSDKWaunOGbHziZo0fxRF
	tOP5NAvl432ouDzbXKkHTpnPtaaC2FvpfFaCB6QlcVl+eLw09Us9Ndo1Xar9TM7RGBbAVVhxw5X
	CXV9zTciCnxyCmYC75dcTedNACPIkmGrS98uZrOaMk1Sfk2qVOkaJ5g19Af4=
X-Google-Smtp-Source: AGHT+IHZFzSwDxf2TRTZM6Le8S0sSkvLrk9hGAeEtwb8V3MPhnIYewVlR7ckO5uIS7XAC1CPsuDIjUd08C4UFZSkM+VjvxP9yYWX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e57e84b6c4mr127240065ab.4.1755411484903; Sat, 16 Aug 2025
 23:18:04 -0700 (PDT)
Date: Sat, 16 Aug 2025 23:18:04 -0700
In-Reply-To: <689ff66d.050a0220.e29e5.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a1741c.050a0220.e29e5.005d.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in debug_object_active_state
From: syzbot <syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, davem@davemloft.net, 
	johan.hedberg@gmail.com, kuba@kernel.org, linma@zju.edu.cn, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c6e234580000
start commit:   ee94b00c1a64 Merge tag 'block-6.17-20250815' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c6e234580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6e234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=56728135217003dc6f7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118d2234580000

Reported-by: syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
