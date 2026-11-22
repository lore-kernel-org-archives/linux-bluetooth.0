Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372825;
	b=yIBue/+y/t8+e4Me9pp8vbXQ/U00jOPhWrUMxggY7nR0lNAgLXxhkAqZZHc3tdw1BjI1
	 1q4lpIniBQXAaVa3OMnzOG5RcMdghHWNSzaKUWdTYxV9BAXzVOaX7VVSfbJb3D75FLK6i
	 Y1T5fKmI6mg+EgEwcRJmNSqER72mu/Q1ebRW/s0U5Qo83BZLq4cnez9G6dizNoF+xcvK9
	 fpeIAS5k+OCqm5g6VQiKSnTqQmittf2AQq5qsSH+c8h2f3xKYK8s5BXlxsqGqHxVG1P+C
	 vuYJrJgU5kSN51rx/kH4TMutNRJKhBxNnRRSg2S4BB+IBAZAJDiP7V4wRAZkFhr0rug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=HDTCzwJFf7L2bddJr+412QqRlzFgqGiBSUUpFVV7T5A=;
	b=rAAenNnV9twHgP+pZqjlkt9shwizyD3WqtzgKWNJA5wLv62qyvyFicCvLXtP7swgxwN8
	 udH6vKJ+KNKlbnx/tWGAdjnMhKgP6qSrMLOYOfKFJSZNiSCznfZLIvsJUHJ3f0oq8ai/i
	 Z0xhvn/xzccx1A627bKEMt8AfpUR1FE8triYeCTKvQIT82FRKgyCR4TeFGllxYqtlb4bh
	 RGs+n2uOr6fNoWfvAnSfjC+uuuMMZ+YEMn2irauLqvX7r2eF+V8kN2zRkPuMZMKqixZjp
	 uRr+0zpwbwzTklXz2EKGXCdaByPAEpe4i5TWZfapnCOe0MYA0avzP7VDH8ANjFyHlQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWbfn9x4;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D6606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWbfn9x4
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-56431524c22so1045282b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372824; x=1795977624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HDTCzwJFf7L2bddJr+412QqRlzFgqGiBSUUpFVV7T5A=;
        b=DWbfn9x4tX/HJttUbIDKwCWTr/ZXZGa++irUcqi9vbvqnqSo5uUhiGIFc7Xx92W7v1
         SZNv1o3XwOFwqd0TLN/ev+1qf5Y7INuKRcAn6Zhr4x9TIQUPA4OW46RZAEbo1TQzo86p
         A7LGmmvIU6KkaCy/W9emAMOOnLJOAxr2IiccjlQqxTwbkfYWtqVSWmLpk9k/HRhtmSN7
         6FldqtCXAISh1/bL6hlN6Z4DvGAY11fX2081NLmgC35ZNXJ2gLyWVd8Io5wbiEAow4B7
         Wy16SsO3GVClNqQ7M3QfJJYDQybFiGNQN34NsghnTSyfBs8tkE7jG+mZiQq/gqYfnIGO
         IHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372824; x=1795977624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HDTCzwJFf7L2bddJr+412QqRlzFgqGiBSUUpFVV7T5A=;
        b=v3EcWzZYb3Xnuf8mtjCWaRLUNGKz0QuCC2nYl+89Oln4d1QWLlO3ANrWlX1aJfJZq0
         Eq/kBPSpPJKmbVvANEsHY/KMOoPEmw9h46ZDw9pcG+S2Pese3jW9WWNo4uW7f6tXPdCO
         sdkLPirwghZWCGqwhpQKKda7UAugycr++s93q69Y3Y3O/k93qmmG2NH6kwtkfvGEGB7Q
         AafS1AL3I1aGgp3ms62AWpz4SdyJYMkbBvGjYh8XhMkDMsx1IMMMNLT3hOoUNVOEonby
         1RJQwNYbizBsD92ZZUi3YWs3e4td97DeAnCc2PZRbXOsJ7KYt84iOdlK0tfpzAeYamTb
         Kcbg==
X-Gm-Message-State: APuU4Z9GLOhcHsJ3ThXcki3QRkJYW7Pfytwg4hdFaevfzKCZ1FreYdZb
	heTA96yCBQcPk5a6kV9q6a6eIHcs6Jx5JSiJdUh4mCXBt82lGM48h7qvfMx23kroe4E=
X-Gm-Gg: AZFdTZfAkscrsTiPjelLm2zDC17SHVX39J8jVtbVFVFPY/CeJyWvRavDqZjRBNEO6bW
	OIr7X21yzBW07u3TteiwkK0vPpBEG2wLlE7fOXpYk2HOhhvrt+y1/RjzRtHqFT9Wu5VY0UcubND
	vokL1QE9ogWnjXFo/uy7HIgQ1tI8B+Z62l8cCnYbv4Td5m0IzkOuk3rb39NCVfYF8s+Gqvvi9vV
	KBmAecre10fIYTPz9ggZyF+ap9/4XdYgoBZJA059Eo2LkSKCijQ66IxZgh8ifB/TvasgfkNpjBm
	zJca8O5CFYZq/bpdGK7+BDvRW6jyr79RixL8qvRkKPI0B7dNnQg29mncvCHuPsoPF0MNgxxqzIW
	a3L32epgIbGV55kvpGeeKSBUnNzKCwdOVnhlZcHZYoISJkvSDUn/6qvnlxI0IjEEHL4iAMommh2
	OjNjvS6gK/40H03xSVV0lfZubIGsOahybYTk/MharEv5YubAqwSO0CvxtalsSKXVgJNix3yz9RO
	h4Y06pljEuR+b5y50alzdb5kTow1UC7u7bCPId5OQeZzRHfCxYPnd3Ge8yQlKxn
X-Received: by 2002:a05:6808:50a4:b0:577:2888:47b2 with SMTP id 5614622812f47-57a0a1094acmr11268951b6e.22.1795372824324;
        Sun, 22 Nov 2026 10:40:24 -0800 (PST)
Received: from [172.17.0.2] ([135.233.102.51])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34250ef2sm7709055b6e.3.2026.11.22.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:40:23 -0800 (PST)
Message-ID: <6b033717.24a8470f.69082.7b00@mx.google.com>
Date: Sun, 22 Nov 2026 10:40:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6669181078582919095=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] bap: Reset broadcast source stream when ISO io is lost
In-Reply-To: <20261122115002.1064419-1-simon.mikuda@streamunlimited.com>
References: <20261122115002.1064419-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6669181078582919095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218593/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      15.24 seconds
BluezMake                     PASS      202.91 seconds
MakeCheck                     PASS      3.41 seconds
MakeDistcheck                 PASS      113.84 seconds
CheckValgrind                 PASS      115.44 seconds
CheckSmatch                   PASS      219.95 seconds
bluezmakeextell               PASS      76.92 seconds
TestFunctional                PASS      998.31 seconds
IncrementalBuild              PASS      214.25 seconds
ScanBuild                     PASS      740.98 seconds



https://github.com/bluez/bluez/pull/2874

---
Regards,
Linux Bluetooth


--===============6669181078582919095==--
