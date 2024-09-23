Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDD80BFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105284; cv=none; b=VLAwWoicmRuimNfF7vrAuItKjyfAj0CE/ifQLaNX3PItubnzdONjM8iQEyz2YjBkSGMDuy7xezOBNt2lA/NSnVj9M8opJAcPdqIVh8c5DzgYWKnycyvr/D2SGta4qwhYvq8x64DckWnDnm/D8Tfa22UCv/kaS1JGuxSjbtp9aFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105284; c=relaxed/simple;
	bh=BXuKDvmxn/uadsYCkrctcocwNsA/C0A+CEomiewh5lA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gzCyhJPByxoWWGSjVIgSlfk+Bui5rfkwDnnYzi6sHs8HQc6V/UxDmV6xrI5LuQ4++LApgFU8FVD+ipgKtFk+GIzv9WKZwme3rOeFsQnDIHUZlw7jbjAVYaWK2wvsLnYqT0C2LljTkpfLcRn4DrYcbStXutw+FOphIr5kDuTb1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0cbb9da2aso30127455ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105282; x=1727710082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ckOujVLYUX9L8YLfbATQHm9iM+ZOY20csnjvxP3xEk=;
        b=QpXUrNtlXn8UjM1DHIOyGUwfePGh3qltfBpoa7fKXdcmWhIggW72JegRGeStTyoy6x
         RShFcPUspjKn0T0Ve43Id3zKIpUOXdAWzLOThPFiGo8o4FsQWA0yZk2ZeCp5KGIFp2Dq
         SM8JhHQ9qejnKS4W25O95Ms1egOjl86mlGknF+coxYnKUFPnXz56mTQggdnlmHXrnCHX
         VwH7Y1lAXLDz0cBvdQbBLGUSiICpNA3vB/gvI7RtuD+J7cZKJ0fv5eVxdeGQ91plF/mm
         fi9y/YufPRFR72uWUEck5Bb/GFR0ce8B2ugl0CyEb9mkc8IjTcBbISlZ0zTpYTfoznEb
         ivIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRq/YV5SXVN5W1XvNfp2NpiAbsfzj1QX+B3OSwVt6+2aRlX1nl8Hjq5wA0B/8CKEZF6fL+ULt49wV070Fsigs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAu8ipvxSQneW2GCNzbtKcVaMhGysaIGkOw95rZ5QfDIPnyBb
	ScB3DNPFzJc23TifBF1BFV+oQad+F+0Ym69vC4XSsRUyyeQFEfsMypZDsJmvxF7xAhc2oBgRK/4
	puEuw8wFLS3eBdxiV0RSMz3MlVr0oEvbwvc4687+EfzTezeVpwxgEYjY=
X-Google-Smtp-Source: AGHT+IHrPeUe8EPwaXPn6y+dpbt+gLxKHTMO4wmuATQPHI6pQ8kHRTsga6xrvxBJEnOu/3k2uQ5rws73bXS2yRMIqnbmHvWnhXtu
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:3a0:c88c:e668 with SMTP id
 e9e14a558f8ab-3a0c8cba344mr106518145ab.14.1727105282253; Mon, 23 Sep 2024
 08:28:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 08:28:02 -0700
In-Reply-To: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f18902.050a0220.c23dd.0011.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** malformed patch at line 6: diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c




Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127c12a9980000

