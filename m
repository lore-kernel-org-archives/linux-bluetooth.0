Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE4194124
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181765; cv=none; b=AJyKUWWe89nBecnjiYj/8qzG6pIgsP9DOMeduNJs+7ejCSkUGI+vQzNFhkoACYDEIa037JtgXt5qORzPDZAzkcy0yUCoi1iDW39BLgz76gimv+yAn/RF4SUqcjhKCKZ6UFVMPsQtlStOkkNb1WeZH3yiqYGzRvbbwYP7E5HkUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181765; c=relaxed/simple;
	bh=po5VHLFgAh0+4aYh5ZRnHIy7yH8amwWKV9UqEt/DDsw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHjJ7e7Ddn6ih+GwtAYVcUmSbOlctRWyNPy/BQHQ9Cdz1P2/g8cvXH+rHwqaR1mu4YVvLmOjemb/he3Z3XJ2AKoB+pHYy0u+dFQL1B+6I5RrDSKznt+vNDg+PNsrTIA0/4vXGi0zfr8Ro0lhgtEei5bhy920lwQ4DHGXyjBxX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so70916095ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 10:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181763; x=1750786563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRp9PCwUOoJxnwPAseC8adT2g24KGuJfatti5I5xZLM=;
        b=B63Ig9Um2O3KEpiAuXdTQNdVPjbKAQKl499udQ6aBZiop4kUDdiZECnHyx0JsCZJXL
         N8UU7JkhKGAvDtFAnldMo3sojJ2N/nq6qb0Cb35PuHDOJc9NVzzMuPVWI8U9qr75tf7t
         IW7wDCcUeSL6mNBbkn1V8JpZTgviqB7BoSzogR1qYCdf6zjK2o9oodJ9DDK/9QcO6JW9
         W0q6ho+3yzVr9SjkC1Eqa6m/v8XNPrCHOoxH9wbzdCIpZS182oaGP5D027cJDgX639TV
         fQ8+VzX/Qn42s5gkd8fO81+5GCdZEk+/V9dHoQtMY834SCwR5LnL1Rd6tbP1LP1iVEv1
         QEIA==
X-Forwarded-Encrypted: i=1; AJvYcCWVf0mhbGPGNA0NZaMFe5MH9cBD4MREcPk2FYgJHEsqDnJV+T+a7jsuHGGB0Xl18agDlrF6d5HODG9MHwyDeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZNofQ8iG+yaZp1Kb5jZoF0v90pEjeU1mdr1EMDfRTqpEmkcZ
	ZX/CLrxUme3lWNmaOZ/0PSUNnPFaPCIgflmQTbjlf7hitbVUndXGJ804YgvHibZEgGn0yNDFMX8
	w9aFhmn2O7l/SH5uoPnBml2F0+Awh0G1VWi6Eem5nGcz2Fl72EFLKj+QOvYQ=
X-Google-Smtp-Source: AGHT+IG2NnluvTF+ZS28/wS/Yl0jJbq3XTO0UDSSYpDOQu1R2P+FhlbO87/9ojA0d4TJI8bdCFXKYRbWZeTyt/ycEYH/ig194OZg
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c72:b0:3dc:9b89:6a3b with SMTP id
 e9e14a558f8ab-3de22cef37amr31040435ab.8.1750181763142; Tue, 17 Jun 2025
 10:36:03 -0700 (PDT)
Date: Tue, 17 Jun 2025 10:36:03 -0700
In-Reply-To: <0000000000004fc49a0617826da3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6851a783.050a0220.2608ac.001f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in mgmt_remove_adv_monitor_complete
From: syzbot <syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e6ed54e86aae9e4f7286ce8d5c73780f91b48d1c
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Jun 3 20:12:39 2025 +0000

    Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177d790c580000
start commit:   4c49f38e20a5 net: stmmac: fix TSO DMA API usage causing oops
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11348b30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17abf40f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
