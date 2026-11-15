Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785859;
	b=lE1VFjTff6tNIRuPf8j7ekRiT2M7yr8f8wiPHImcCGesLvOwXM8lq3n4Wv5IcP48mWaW
	 aOJ57SKdaDdFgTc/hExZsX82dI7uEoUuF4Avqyo32NSAhxD4XUGc4q45cyyQt2rokAOLe
	 MbATbszjFhkhAns/z4IT8U+giO8rUsy8fvXncAW0BMSW9E0HhlsuPstfWCtQaoCyTPs+D
	 xpYUXZpWkaQb0wuwDM6XaZj9mzd+CXUV5qRC9WsYGYUIkXX6HJM6/N8ZJuEdM37k/6aeS
	 Kh5e9jGC6Q8k2Jhynor/F7R2NTKAckFtu2TLLw1UUEKaRvS/UYGA90ITS2yHK4y1yLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yZPQ/kTJtq86RBpEny6yYj8QHokPPbWMhn5TCE9m84U=;
	b=OzlHJxjrGXoInf8ob9eq0I14kwx7iuN0wpIXG0IMaUa6iFhqcKVWl8KisIHaZXiGyhPu
	 wGwnmg9uNdBpqZkEq9HzrHu9b1wZKHd3wyhXPIc1ZT8R8bt2GtmJ+aLunnQ9trtct3sOP
	 rF2TiaaPZgpgTcrFVjtQ7hXBhSuUHr8n6TsLylepxYsWWjP7+Api2LmMDH7IZiPJXjcxE
	 OEMApGoIx0O0gR+FdPkwKwbnoTIKbAxbpgaC81R3/tndYwF/Y3fYZwjzo7R6UNwDrC9kO
	 aWjiY7LWmNWMBv/jZrBuXzQPmiyeVYqKP/BPQ/olF8DSCfHvNEa2ESmi/9I3YQJkejA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPAdN28d;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67746606A31F
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67746606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPAdN28d
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ea2e29d90so47570536d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 15:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794785858; x=1795390658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yZPQ/kTJtq86RBpEny6yYj8QHokPPbWMhn5TCE9m84U=;
        b=zPAdN28dAUHoWtQfyXCNSewuEiN6RX7eZAbqJHQhHWRsCNUzi8JhrgRIKd7yV88Kz3
         p6IvbAb9H/Mv1wsgwGEimrVR1uXr4ZSOaWLz2hEp028TuI7g/p/yUSmPcYcovzjZeA8F
         1mT9EEx7S+2HO/2OV2/L2ToqO41Aa9w4acd5+KRzWOjNcxZ96mRPCbk7dWmlp1xB3mQ5
         QUNrNEpD9U7+MzKnY98nTk4emtg6IgRps1bZfyZxSOJOg1cisgt30R5PbaJGIFVWBsap
         Oc70K/ulh9GULUdZ/9REhvxSwNuxkONbFn7KS4v1/aT+0nwf5/HldW48fnaJu/TJBo3K
         KnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785858; x=1795390658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yZPQ/kTJtq86RBpEny6yYj8QHokPPbWMhn5TCE9m84U=;
        b=arBW9tFjePhTWUC6RyU0qSbClEmk7VVuY1TXbiJzehlORts7to6lEMYw7acZq6yyjF
         mcLuUXDXRrAsVr2kG/QuYFKKTUYd6wMZFShS9kQRexmta/W2dRaQprsSppBaP8XIkOwb
         lpbHDZ2aFMP3yN9OPnZg2fmmDAnsSI4gAtJDwDOdycmON0+xnO0i+TlaT9wgpS1av98C
         Frg9AlDGlI3Wnvb8TyCH1hofMJLnXHWnxczmSWeiyN99VVSamvGhN+V4oeYhZEMy3Duv
         SSSWktDBa0nMBTrUQesSPGUY9ZVRizXmSMGs5GQWFKJ1CVTQLlMpA52hye0q2YrRcPti
         ROEw==
X-Gm-Message-State: APuU4Z8TAuQazqsBhQ7H0oD4YIqVkqfkIa2bEdBsBthZyURfkWq3eMdV
	VPYqu+Vdeigyw5YBcut+ESA8xynAJDRdqwJfYV6Vd9WMq5PX40bzmPNQjKK0cA==
X-Gm-Gg: AYBFou3knEGxPqINdMdzLIG+Aq3u5HlBXYUO+m6vSjWRHfwXGN8xQe/XKlHdIEuKa96
	iN1VQx8pSyg5kO59vVeJB0TbtKb3ay5ZPcSxnKpyn74Q9Xk9RQo68XEK+l+mXQhpKE8yVLopa+M
	nd56HjgbqU99CkaKoKuRcOF+lYe0xoQHjqAYEZtX4d5+2Z5o60iMC3uAZ79mYDowZb9pSoC4u5j
	vFqrifwzn7OXhdnvCGXnnOlVYEHOeNbIIoJiiYWP+KAEa3Ld9Ays+X++wQyRaq2eSLP2p/rxeOA
	OHvWE63nJ/tSvtmabeR6L0hOQ14iH1ulpi75NRKkmrcVymBeAc+27g+TTopvXm1GP1W3udyeN6l
	b/MU9wABaSUATvbU1zLBcGL0aXkDdpJ6gYKCxAu93tLkNRy7JwvOVW8sIhlC6HwRrK4iYNIiyhO
	NGY+1NF69PyTGHT8SSV3ttUETmuXivanOGM7jeAU+MzfgxlDMWeoa4wVrNau1qldQfwho9AQ3Y1
	Rz1d86a8M1hTU5/6dK+OJ3EaLal/7fEkIHwdtM1oQ9izC6cAfmdZmFxNpXZ3MM/
X-Received: by 2002:a05:6214:5bc6:b0:91d:3600:55a7 with SMTP id 6a1803df08f44-91f13997c44mr179665266d6.18.1794785858316;
        Sun, 15 Nov 2026 15:37:38 -0800 (PST)
Received: from [172.17.0.2] ([9.234.180.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9ade7sm73271286d6.5.2026.11.15.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:37:37 -0800 (PST)
Message-ID: <6afa4241.b0b4b201.2f9f9.9b6a@mx.google.com>
Date: Sun, 15 Nov 2026 15:37:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5067102308787967433=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v2] l2cap-tester: Check compatible interval preferences
In-Reply-To: <20261031193734.189558-1-cochcoder@proton.me>
References: <20261031193734.189558-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5067102308787967433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC,v2] l2cap-tester: Check compatible interval preferences
   Pull Request: https://github.com/bluez/bluez/pull/2744
   Created:      2026-10-31 21:59:18+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5067102308787967433==--
