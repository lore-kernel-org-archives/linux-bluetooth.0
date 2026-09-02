Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843B2FFF9D
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358859; cv=none; b=G7iD1vlwVh9jLggmp2uKBnYuYJQIbbe+tIcwpWQwv91fy8WjwL8LwJBd0qtQxCaTjg6XY3zxsHgGECzsreclwxghXgl1B3cKa7RkFZ5InfiwwSs/07YnEHQyDQNP1WcvOKzcr5t8v+H8T69O1AHDqxOkPmms+YfhR72s5lKqujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358859; c=relaxed/simple;
	bh=aMgQ83kOVKtOT//8a3YxSzKyOhDVLUMuIP5zhTCpo9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgkua4uhwrWxyM2qHh0HhE7wjZeTZBVssPZaAHIPgufRJ6ED+fSjVhDio6KcGA9m87FxDqaaGh8F8o2MmFU4XJN3ZUkFAT5zUvMW21uBLSalM6KavqmIyti6UdLv1U+LxBPwMC3PsEkwflvLKXqesfG3FT7OC1xbjfOLoYr719M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQek0EbR; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQek0EbR"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b3671a1b20so741662eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358857; x=1788963657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMgQ83kOVKtOT//8a3YxSzKyOhDVLUMuIP5zhTCpo9U=;
        b=pQek0EbRZsFlOfv7YNqczbgGGfiafpxRvObT8CVg3DXMVAeFtx7TCwHLjCIAcjGZXt
         boBZN8QG272ETc6hOprIvOl5dyOJBbmntfBVVnT6O1sfQIoIAT9hlaEBbKIHon93kmkX
         7EUp7rXdMh/Jc3nFPjzR1OS3zoLHTKLBn6u8yQ4759aIPOg6oUkyGaPY+npH5uWJ2y0B
         Qi83tSKjIfLH3zTS2AzGBqzYAh7ydLXvQ40qglPwQ0eJ6sVI2Y9NShvZw8qlX99q03rA
         wb1/XyhUBp/7+GxvDFdGXpnnnc0fcyKN2fdnhGwIbcwZKN/h1b1Y/Btr3rzIIIkKf/5f
         D55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358857; x=1788963657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMgQ83kOVKtOT//8a3YxSzKyOhDVLUMuIP5zhTCpo9U=;
        b=N7P0NS9Cn9Y7tV9+8xDoUEpxZXT8cnHAr+fvmEMj4gLp0mB8Zx0FdjpXJ9bYMQOhP6
         Tl/QMc3lP9+/Gcr064tp7+MMzGQVlc7q/Pu1FQx9wE+gXse7/Of//jmrzWl6aXPGjk/j
         zht/cymtCpafrs4W3kAKNVq8crv6QQk7+cxgYsDQjelKgiQwfXus6gUBVCe6wzcWA25G
         aon/HS4mlkAlCdsIVw8QWAq4xlfJllBIamWVSzqjd9Dez5URmlML7Yx2tc80WsSEco2v
         ttfbYxSIuo4cQwe1ASSbmay42S/mZcY2RpIuOEZMEsdMjDi6XdseyoUWt4l3VoViM5C9
         qkyg==
X-Gm-Message-State: AFuF++k35H2o0uvE7R6n5qKOARamrGBLdJLTDX00koMNWAqIMR8PMyC2
	KlXpBM5ZN2s2UeN987BoPnJDl1uG6mrDEyHcV3502NKTPUo1ObL2fs2gfc6Yv5XdOBc=
X-Gm-Gg: AR+sD126uTCANg7ttoRoDRc5g8BDkKD4nSuhsdYMEMUSoq04mdVaBjYejxpMdzqR8jw
	Cd8T0DIjyn3X0XW3bWKa4ptlxmWT19QdEvJEirSjjU3gnO++NUoiJHEuWn3RRfBv6MKytm5N9CM
	jn61x33J6R7bG6kV5qo2q5Dezj+4qbZRI39dgqWuBsShPlaJIQU5Ma974GiZiTXK00k/v9IdFHw
	nB8P1jEegtJqozxVFdJUTX6Dj9TSWjcyvhMZXhi2SkvcGwkkxM4LNBN0PxIxw8fC4szaTz04Ycd
	WaDAlYIn7HOnbzGG1oAvVMJ1isEw2AZap5TNSkPvEFD3XV2hlmoJ6EZXiYh8PZGQB5TuKxA3t2J
	Grnxe3GlVIGDuVJFQMMZk9mouNqJmtO6UOsLldlJP1BZjhTjRakCCF0kAM9fKqqovz9wI1Bm9Ac
	v+h+ucxvwFEuapj5B2EyE+vWTVBntUi8HP5yPZyv7c3Ye5X57/NaJDrGn0SHYZUTBrp4hPCamu/
	yng4g==
X-Received: by 2002:a05:6820:210:b0:6b4:63bc:5249 with SMTP id 006d021491bc7-6b48153e1a3mr3735995eaf.23.1788358857171;
        Wed, 02 Sep 2026 07:20:57 -0700 (PDT)
Received: from aditya.tail9b10c1.ts.net ([2409:40c1:4c:f2c:672f:3d11:f7e:5e19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30baa0d4sm3804836fac.6.2026.09.02.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:20:56 -0700 (PDT)
From: Aditya Pratap Singh <adipras1407@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+98baa83c342e86a836d7@syzkaller.appspotmail.com
Subject: Re: [syzbot] [kernel?] WARNING: refcount bug in bnep_session (2)
Date: Wed,  2 Sep 2026 19:50:38 +0530
Message-ID: <20260902142038.345734-1-adipras1407@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a86bb5c.4d75e56a.c9a88.0039.GAE@google.com>
References: <6a86bb5c.4d75e56a.c9a88.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I would like to investigate this syzbot report:

https://syzkaller.appspot.com/bug?extid=98baa83c342e86a836d7

I checked the dashboard and mailing-list archives on September 2, 2026,
and did not find a proposed patch or human response.

Is anyone already working on this issue? If not, I plan to reproduce it
on current mainline using the provided C reproducer and investigate
whether concurrent BNEPCONNDEL and HCI disconnection cause the reported
BNEP device lifetime and refcount failure.

Please let me know if there is related work I should review.

Thanks,
Aditya Pratap Singh
