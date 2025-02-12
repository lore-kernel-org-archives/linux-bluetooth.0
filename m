Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F618489
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319129; cv=none; b=MKbp2Lx2iPBx3zTDWYIg3sudkXmiplYwYL7Y9PHyV+kbNptCPX+2Wr5MkdCwOqYRCQfVdmwv3a5BkRtoV3Z4FjdzEw/aIaOYPQm+T+ELx8cqymuvlJa3gdGVuk906knXSHXdYIFFvPAmvk9HtqbH4lmC5mTlLIqk2fp5L4v0Zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319129; c=relaxed/simple;
	bh=lTNFf4Jx0DppvCTHNRWXbbX0IlUtAkHFNtcMNoyLjuA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZvIv6cFP69v178V1So5h9z3ux9nHJlu9PBhWj6icPQx7iwAF55LoYzuNc+jMt48CGnBPd/WPGpb87DBT1zYUyWDPmdE9mD/R9ymjMPk6WP851vyyZKr8trtYwYJrKiSwyhSxVaZqCj2Mbczli6QTF7KuKAYvYEDxYVbFOf+lDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d14a3f812fso84330225ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 16:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319124; x=1739923924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcby8ZU87RNOZKSbgTgPZzvARbN7NcsN2AvvMArHDO8=;
        b=EborGmVqct5kW6EghKNw8hdDa13hqP9ht4fQ4M8kk6H3pme6XcfuvRxygT2rowWCYp
         EUF8skP3aGi3dbv0cTPlPLrqvJlMrw3s2YgY8HLvvNYPmbYqPC5OQlTDoU8sf50JJWsh
         n7ffZNbvdQA9BATy+D1Vd88Kt8MDTW54cUlBdISAknlvmuTQCLAvddez9GQgKhIsIxZz
         pxOkXrSMSqmBXivMHwxqwezz6HCzT3F8PmfgUKaS6dnr8yLLH1/gczzqdW2ueRVvY3xO
         72ZKfc/FOI3a25UtQOQeb1wJe8mrVDxgVhRX+okGG8Yi4qG4TiBYYaQLubJvpxk5KBJj
         6DKw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HJhIkiRR8/Y3KRDdjnHKfHlCE6/w8qNOFdMd6pLVls9zTdJ4FWw9RKYM83aNzalavDkCOa/mP+E22shmJ2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9N2aO+9p5/p8xxP2UF/XjCVJU8gPmeLbjsp668oO+9oVUvUU
	fmh0jGv1ON05uFaE6foE2KvWGj72ybmcsHKokKgppO8aL10TQLdi1rAcSCsfFG1KSkOeLFixTeq
	A5vfQoxV2DcIbJURSgOFx+hYdU7LyLgBPvXSU3m60d7WIFuTd0X7xgz0=
X-Google-Smtp-Source: AGHT+IFQw7fOY0zdY8DtNJHfAdT70+GKEMvEgw1UEPaZBMTu8krdrmGiVArsyuWS9dDrIANfBKIJW2a7sy1tjmR4nHKItSnXXVqj
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8a:b0:3cf:c803:1295 with SMTP id
 e9e14a558f8ab-3d17bf4afaemr14924365ab.3.1739319124092; Tue, 11 Feb 2025
 16:12:04 -0800 (PST)
Date: Tue, 11 Feb 2025 16:12:04 -0800
In-Reply-To: <67a8cd8f.050a0220.3d72c.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67abe754.050a0220.3d72c.00ae.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in h5_recv
From: syzbot <syzbot+b5691bb559396b262064@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, hdanton@sina.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138cdbdf980000
start commit:   df5d6180169a Add linux-next specific files for 20250210
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104cdbdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=178cdbdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c78e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129c78e4580000

Reported-by: syzbot+b5691bb559396b262064@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
