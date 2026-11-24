Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553804;
	b=Rv7IL8uoqFfbYT7LhqMndfDJdpWbHzzIWLNuNV1QR6QFRYawUxZ6gYahT97VcfL1qaTb
	 fihydU+MAa/1txmtZltvJlDi69IATiWngqo+PGyWko8IOGq6KwYpwJzP3jiuslGdDDMcq
	 PZeCQua+tsRsvhQt2lintwJsOxsHyQTp0w5sRtm7whrV/P/D5whRLHs6/xFAg7n5osyFm
	 6GaPXwzgNuQYz/yxr2XuhgjkpaFC5LAh9xY7bRWgYVePDptef2XVDoYu8mqP/ziK0hkh+
	 JwNZiKIzcMpWF9PUK5S0a5WDcSTXPVt3M0gkYveg6d9gU+3eTbc5zJWdG1GA5OzcWLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9vG2xMYJnPviUDWIA5MRU9tUYAthsKpIajpmI9idv3w=;
	b=bFFOtESEYFOd8YKOowjMn+7ShcxMbm350WHAPhjshrlApoOUA7W9Li83vwKu+93e8LWi
	 MZaNefT3hwd44Ja85oNDTHxpXmNwwFIo8IE66HfHujtYOhjO8mfd0b9w0V7zCoZ/IYNg4
	 BMMuqL4ayNqWoZg66Z2VpGTkPzzDGvFQvxpbhSJyb6fjvy9bSUNQsQ6pS5YsyQFmVSb1/
	 nq1A7nHaA34CY74HdXaLCes0F7icdSdMo1SDxp5XqP92n+CT47UxMb9sSN7CAbiZTaJA3
	 eqjJkOjRSG99YxKIdcj+hkJPWJwP8GKR1vkbfvnBghRalneX5/yaRRpvVXb8k1f6J8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZZX7lU0;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D828C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZZX7lU0
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-703be215729so2196569eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553803; x=1796158603; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9vG2xMYJnPviUDWIA5MRU9tUYAthsKpIajpmI9idv3w=;
        b=VZZX7lU0ZDC1VieIJDwcgF49RoW3+n+D8+CYfxhTHsBqnPVST9loumA19TdjwLFsdL
         euyiddJH2QjaQvttDSLUS33BSMRSQV+UTZyCbB/zL6HFknKYnKNNrj4Xj/ssA07hUdw1
         ZcyrpkT2CDEjEJEckDy1l8bAWwK3OW8uzkkGKiNtqzc7/FeilLhRZKL1Uwfc/eI0sspH
         r8iz39A7c7oFXhPZ7qbdh1zUeHqz0kKYR1rB2oyub2aYH7XuLE3r1o1v1cjqykNQEnTa
         qAJgXSdjLPZrcxFq/JfURkqZf3KF8DFLnbvRYMBbcz+4+SlRgboUbhtm3OJt58yPNGM6
         9YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553803; x=1796158603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9vG2xMYJnPviUDWIA5MRU9tUYAthsKpIajpmI9idv3w=;
        b=J4ZEv4KWdBIN1bA3o2paDSi2vjeXleCT4Z3OqjLGU50CiP0Xc8qS8ro5XceCFzKL1h
         GVCJ6F2ONKnJPd4Se7BsjuoIX1x5pgZfh8RVqL6k0FQPDbWfvqY9LrdhNkEBsptiu2G/
         hnBE3a5SoyZGzmIVF/hiu3JLZ9Y9vn5NGEjX1GxRr7Zi9rZRDhvYKwAOL7sLtcAEEhpf
         6Em5ZkfC1Tf0v+Gekq40TKqg7PP7WEMluSPW5avgr2fxZuPXXUkyAS9ZdJT0fs9nYJ+8
         eX1cyr4X6P6ca4lsKcq/JcoE802GhpvdN4nHrqpOXwivpyBOmEjeHumFMm406u9NszmR
         CT1w==
X-Gm-Message-State: APuU4Z9M55YesqNvKc3eG8ghTf1nUh16VvRitoz/qQRkKwKBKeRMZQQB
	r0Vl/pLwb49ZiFMGt/CIa2bCQqEMFxa+bdM8JRVnX6hqVfpi17n18TnQnWKSUQ==
X-Gm-Gg: AZFdTZc3rvsAyHLkxhsXrj+ugTVyBG7wGTWPxOq3nMu4IZ5NSOsl3QatvcLZYR6jQnR
	nqHecPCXxunZKs4AdbiCvIz1Z2YhmjwYNiao71/EbY5Uwu4tKDavBy7SYY0E0Ga/5AmlXPIPFwn
	r8bu5dChGpsT6RDrpkQOLZA8MGLaLhgYhHgp0yVH0NxIMZRjS0ph7r0KWjx08y4hlnYgsy4cfe/
	UlM5fMvREvaBC9bjKO1JFrlMqAAc4b/JxlvAuFLqWo6oC7MxSqrYBTRxTmu8/O0cIkvbwIFdbD9
	R7wxWx37fX7vjmiu4GpOqDP1a587HlVSMRBmM/f0MwTPGf6yGr08b/zvS6T0pD1auosQC3B5CBr
	CSJRrRBcJw4GJEb5kWtpmsTpFL3+c/gMQA6o7Z5iQFcQdZiSikwkwwiLrR5ZRYQ/BuhzZIdzpRx
	L/fL+/xPTMvuYX+AQmScrNKcqcvATYLssvpdPU1XNQogYWzwxwsAWGhu/bZVXXtCKg4q+UnJmZF
	aKxBH2yFOIOU5LHBxtbHk8URhjIZx/4R9AeTnp+EVWKl5CTiGgZpGP0Ec1S0+g=
X-Received: by 2002:a05:6820:4a16:b0:70b:9806:c916 with SMTP id 006d021491bc7-71b394f98camr11215159eaf.51.1795553802706;
        Tue, 24 Nov 2026 12:56:42 -0800 (PST)
Received: from [172.17.0.2] ([52.176.19.195])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c51sm10164136eaf.3.2026.11.24.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:56:42 -0800 (PST)
Message-ID: <6b05fa0a.a3ee09e6.ab514.9b92@mx.google.com>
Date: Tue, 24 Nov 2026 12:56:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4380722704522267772=="
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
Subject: RE: [RFC,BlueZ,v4] l2cap-tester: Check compatible interval preferences
In-Reply-To: <e9181806a0382a9ed0312caaf39048c222476fc3.1795528108.git.cochcoder@proton.me>
References: <e9181806a0382a9ed0312caaf39048c222476fc3.1795528108.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4380722704522267772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220909/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      314.65 seconds
CheckSmatch                   PASS      317.93 seconds
bluezmakeextell               PASS      100.21 seconds
TestFunctional                PASS      1222.49 seconds
IncrementalBuild              PASS      309.76 seconds
ScanBuild                     PASS      1183.29 seconds



https://github.com/bluez/bluez/pull/2905

---
Regards,
Linux Bluetooth


--===============4380722704522267772==--
