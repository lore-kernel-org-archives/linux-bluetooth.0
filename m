Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697127F75C
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369517; cv=none; b=QgMy1k4pvWVBwVANFSwJ/rdg/5W6xHUuSgZNN5QT1ztKaMwJHG6zYlLXwmYE9QAQtNxHsYzj4eY9GgnH+dYsh4iPICS7/3ORG2zA5OdvS9hit8P6s08qdYwgCHpV7CwJG3BaD186nTfyuJ6MDk9F4hSSkR+uJn5Af6ke2KXvLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369517; c=relaxed/simple;
	bh=u9rmZpBvMezDctwJo0rwiGqkxhnz+tnImP6t7UnhM5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NJFmW0t6AWSIiwYUnw6SdQXNBVbyz4gKSB2M43tmb45vlJHShdKntKs08ydrdd1cwnDDQdz798ovygHz5m7oWEuK/zZHah3Y14Up3xIynek5wS9MtYIHQgzFYB5Ki+ABvifuZKyueP//rbr3j41dJsK+fco9fPFEdYmns4nUylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOrMX1ZG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOrMX1ZG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso229069b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369515; x=1762974315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=YOrMX1ZG3qRuJxf2YxT2qxF+pcSwNmUVq6tKJytWmBHayJHeDJiFfcHcZxGNuhxg5N
         bwRFLFhfl+v94oQaJFAlAT0DVScNG1otC15jGL3HwXsMl8A6pJgKipsLKg9I3tZ6Z7mj
         aBLxHBsXcq6Z5TJthgf8dPKe2kKSmDHI4pLGE0cHfp6tfD8eg3xhcfG6hM2X+eCd73yZ
         vuurpj5Zkd2XOAAL28N9lmJYGYE9KdgAineEhe2l+sOYGJE2n7qXwZNojtc9hqV2JSPY
         VxwMMMlDhr+V14zL0Eg7zVu4Y4Vt5WvJ3XzrT4d6UA5/4REyaG4r3+VZEbmM92I9uzLZ
         aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369515; x=1762974315;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0oPPPAsw+FYjV2RdYT3vlBD7M9XMtEjJDNDkXAtf5Q=;
        b=Oq6zC+Fmq1jKiV5Vl+e7ZAFMG2LwkORjDWCldMwiI1AGwZ5SPYriLxNqiy9NVwuDIo
         Iab3Vc1exHeTT5iApvJ3D+LkTYqRD7AEW4Fw/fszoNBIr5+Bqtndy7OwOkig8qtv9/Qe
         p4H0MZU4Ve6IpsavJKQ9rZSx2sZyxWIE6l5m00mcOKgohmJeA0CF2VJc7/s3Ge6cMoaO
         P9QONHkiED83C9yf5Fj2a7SRVZmZWcuLq8O3bPdqIt1/BVWJd+grzKYi3rX6YVQiZW01
         +hqgsTT5nLFfP5uBBFnfGPhj7grN81fZF5niF4bHYN25fwbxJBJGDn+JpN4v9YIcH+0Y
         f1nA==
X-Gm-Message-State: AOJu0YwVkqIEXNr4MZnO8zW4xs40Z29kdoE5wPD5HhDxN9oijk+Ssft0
	4Q+qDte5uphP4HFXJTBeoCe7bTXZBpZ2JgzRtEkS26hoFUaL8OpdxYhYmwHhBI47
X-Gm-Gg: ASbGncuF3REaqKzP9oRA2ydlswkzBQNLbq25RDBn2iSgR4pt4G9yES/O+kPU6Oel88Y
	Gplb/J9QMJ/VDVaulFFtvxxk3THvAh+6ERPDAk88CiQ+CCIEHo28ghY1pBkEnXDVryK05FnoWSD
	aIYx6xEjR51IPR+ZmtCidFzXP3pe40NvwJ2X9Vl2w1b/ljt/XMCExu/q8Hx1IvxpicDNduBNbAd
	N6WzO2HgrUiGgC/SWvuZQU/cMxXESCuVo1o/LRfrCqsZ7xCjFJW2fSbyNvMWVwKbEBocbDF0/eF
	LK0XdHdu41GcXbe6fYKNX176KSvWim3dlNAL8JUnszVra0kmvi0bQlwQeXjFxMQWkQCwZ/gQwib
	1p/vFdE/lJC8TZOtExEf+i4a+IGpYg+sZkr5vdDsdHcUHVjnTv6izCgiR56buThEEuMrmoeroln
	3OmYRGBg==
X-Google-Smtp-Source: AGHT+IHgECVR1m9iJ0n7GUB8KKihGMta471ZrUTiheONsefGEk8IBr4BJBrzRXYyPpsTSEE5KPjH+w==
X-Received: by 2002:a05:6a00:1705:b0:7ab:3454:6f2b with SMTP id d2e1a72fcca58-7ae1f19a6c5mr5279780b3a.19.1762369515268;
        Wed, 05 Nov 2025 11:05:15 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f84fc12sm165733b3a.2.2025.11.05.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:05:15 -0800 (PST)
Message-ID: <4981d33f-c45a-46d1-b091-e3d5989c8516@gmail.com>
Date: Thu, 6 Nov 2025 00:35:09 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
References: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <690b6df3.050a0220.2e3c35.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/

