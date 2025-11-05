Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94952299AB5
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369447; cv=none; b=Hch21+ld7zrNz6b0AzJCy9P4sljPl+Pya3HffOCGNIabTEePO1r6x05gMWKUvJ1yjkPOWR1YR8il1fRHY6CIiIifRFecWZgFo6jJPq986o/nB6T33rO34YaSxFKKTWtzPWzJbBh0tl7eyLPFFOEN0LH+WvEsYkHDkYHJDnK3kXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369447; c=relaxed/simple;
	bh=foAD3VAp5D7YieYlBATJtz5KKRvnEtO8TJhnZDOQw0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gZQM7engl7ESl3dPnptEMhTWxYzMBx45mqYhqLnv0HifD8GWmR/4zppPeJ87eY+q/XA+f0EqQF7FxyDTsFlbhkEVd9usN1vtBBq2L3Sg/MKyTfZkYkKrPGO7RutQouZH/lV6lamr0VJVCpm1gaR5mDxyVcW9gqZ7D8SebRP90kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-432fb58f876so3575315ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369444; x=1762974244;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRRzlP2SUfiESziI9LEaCdshMF/xNXFnIzUbHvATzWQ=;
        b=T/R8vxSQUXE8bo2nRSyd94zSMQyXKbfuP0Y7zhgdagTSkv4l31QoiV5QOAN62bgooQ
         7JZ4sLmhzpC515yn1PBVdbRNNsUrfz4qDHTuvnePzlrsIyNSKFVYlOWKyMQa+OysZce6
         GxJwgy2wZQgMg8sn4r5tXzPWjllvPsjNDxTKcYg3hAJF/jX+i06qaql7OVkO7RAtRGbZ
         P5ZK2CmPZfnFmphLRt1lLB4vl8pdS/y3C2cR09KPP0UDU+xORN4nI/lXUBcqqQ/Dv5w1
         DuG0qk6cbieLc1aF5JMFEUFDE2NphqEoortO3OTY7J5zTaEuclp3uYDfC57kQlChUtNv
         VS9g==
X-Gm-Message-State: AOJu0YzNZ+qYI6dsMV7m48JdjRmX8OCSEu/4nME40ch8JvMEVFFWCtH9
	qpLU9OZQRXxr7ONpSbCV98/AF6DuTgWb/NGsPayrxvA1U3UXWWNJ6a7xswB6NpG8jRoEJY2WMmo
	23qpv2QkMnj64WatwwHpw7y0tEFvr2bbcV0Y3W7nvXas6LB490kzr9DyDIQc=
X-Google-Smtp-Source: AGHT+IHc2NID+f3wxoc2C6njAHWuBl+T8sz7NoKzzIOo8RC/YSjusT/IcfAH8i0LQQx3fH7zUDHvFRLQ4+XstPweDk8nR0LX1mNb
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:433:2a39:1b96 with SMTP id
 e9e14a558f8ab-433407cc96emr57471205ab.23.1762369444660; Wed, 05 Nov 2025
 11:04:04 -0800 (PST)
Date: Wed, 05 Nov 2025 11:04:04 -0800
In-Reply-To: <ecb7b4e7-5006-4642-8807-01b764cd4b2b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b9fa4.050a0220.baf87.0059.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: ssranevjti@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com
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
