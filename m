Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554753;
	b=hJGVBXWHfPq6MQOi700aJPJAEL2TmlNJ+AR+s8guteUoRM1ivrfMX4FOCzlpUenp1ICe
	 nWB1KaXWxt0Ob8Vr57+dKYgXlV5Pm7YYliiZrFhuT4WWzd3SfahlRgEiK6//zYn4/KPek
	 CWUHu/OkKcz1MFQPYJLS4GarnqkL5GGpS/WZ3MOhaMv4ivsKd8DKirPrMB6s5BTCQ4qlK
	 1F/pMaL6mefwel5PPxXqlYIyH6ZgZ4F0yzJXbR0cR+iTN/hYyBvEIGh8dhcyofEgdpfVW
	 vHLk3O1Mi3W/2rL+uAxhrF7mKudDmzWmbC9EMT3Er6GVWGPhEhEQZQKAdd9VAN31Ilw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jJVc2FWtZqwfhdIFp67qNAajqVJdViynC12geWtQyEk=;
	b=ZFHncxrb8TEtll6MldQPmI/zvtnwFbcS+mE9mHYRG5kY3Ub1TgIWQ3I7lrgtXJJO7+F2
	 UCAjivZlKTm8sQHwj18IEpLrloyv1c9bSRmNnGJVuwPmdvHDrMqPM3XrcicCXqhuDer9x
	 sG/PYfSDR4ln8ugCgSz+HuPYATqesAFMUupC/D91HEu6axr0QTMgwrumb9mSsVb6+Zi/w
	 E6m9awIxcQD8cFij71uLEfd4jamehlQ+MbHyBSAD1A1COr+k9vUwzRsXWHfar7x8Tm9DA
	 3/bsF8DFo/71g1LVzDIXYuCFEBCk9mlfzuwTL2BN05blP+NidRdkPOoKyTN1HgfR2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TvSWvt5K;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82675606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82675606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TvSWvt5K
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38431138772so6444645eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554752; x=1796159552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jJVc2FWtZqwfhdIFp67qNAajqVJdViynC12geWtQyEk=;
        b=TvSWvt5K8QPFSbLQDz/Ek+pWJ0eaOc4E7UmFxm/tQ4YOmnWC55+Iy+PC5flp9Fc0lV
         U0q2OTgwx5wi1BTdvbzsuwLqUTyUPTRDQwEQy4m11+l2+BQunbsezc36VXIkYKNzYuqY
         7lf3hFrkd50K/c0Ee8Ur048tqydvJIawqBMbi7oTzRLqsZ8iXQ8TwEU3wLnkvSuGRctc
         M5Nke0Senm17cdqTwWQM2S6diKd7qN88Hvgx/34SlLyBvCqIoB0ghgaZnPDBFMlnSkRJ
         Ho8d1DEBZbyjWHruN0bEhLGH4mFoBW6BSsMo/XuuRcVybYPsUT6Pxfivkb8ZMu784vql
         MfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554752; x=1796159552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jJVc2FWtZqwfhdIFp67qNAajqVJdViynC12geWtQyEk=;
        b=B8KDAKCTCj/CMVcn4SyEnn3dn3uV+s39Qjr0fInDTDhhozlfQgn+hsarM0Ti2hOJxV
         REDdYgRx479uqHjfg+ZnpCQEW70C06jcwOtmL4KG+6U82aHlsex7WPYNTszaNGTKbbkG
         pdHegiNPWYewwZZ/gFj8gXI5PwzhZNP8DQpC3n9kv2+3+AQR4A+89W6OgIXxiFcaO/fQ
         ouk5aMXBGswhsZWXW3nJpNLP+N+0+eiOXbU+3rFuGB5SaaIZLvInVQwbHJxyI8MGf6T3
         wEd+aT37a6Qc1EnMKcKBBkN4HuZL1dXpmy5JzgyYSxX9txMBxzVlvIDC2LkkLTF7QBtg
         iQCg==
X-Gm-Message-State: APuU4Z+VfTWoFd5CK9s9lE2d0O1/leXeokQYAKRBU74qg+r5SZ3ypZCw
	Peyq02G7HhiSw9nqlwWTaVHbzTKWSR7LV2m2olSdXf5kn6v4Mp8QQGt68YBv8w==
X-Gm-Gg: AZFdTZfZLcRH//SD3YC3WkWWoUEvp6WgxhHiJsRk7BGgXaW3rN5nBcgCV1hqbHF1gtR
	yaCXfbAgt+UrfzM7YAq49spOI9VR4Jk2ie6dM62R1HPSDap12zs5XFd2sXvhmvWUaIjmUd17dWs
	5OuI94rrP+Hp4GvZYR+wp2TKAbV/LA8eLASjN/yZKyQeXd3B6yxJUusYsnHNB08LRrgY0PRNHVs
	zqbazUKle5WtxjemFWGgwQnySXdBQdUc4qSTSGrhjrTLcdf3ALERr5erUW0RB1xvyK0z8U/dUqB
	5rM7wWIEWK9D+JuELq+L0968u/Vu9DPKoVEQoRaE2bSsay5rW/g/xIGo/A+QS/MH9SI0+ojUrYJ
	P42iazmNWC2oHwXxtQoRzRg6dlLPlv3oLQtVWfa5XBXKwMpj+1L8VaEkPMVTKbH5j+sOzbCQQut
	VmNFVx8mik1KFE1BGVzedcRR1wuPvOWg46wp6NITXoR395HM12wHh+84Zl0qU+2UGsCzUmkkY8P
	jRXMD7HMv2BoNg+gA09Ao38lsiFjpOUnNjfAs3Dikci8Yi4ocx9PEbhHNXVLw==
X-Received: by 2002:a05:7301:650c:b0:386:cca5:3626 with SMTP id 5a478bee46e88-386cca53bd1mr1434066eec.31.1795554752289;
        Tue, 24 Nov 2026 13:12:32 -0800 (PST)
Received: from [172.17.0.2] ([20.168.119.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm39790452eec.25.2026.11.24.13.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:12:31 -0800 (PST)
Message-ID: <6b05fdbf.4b6e150d.279180.68b7@mx.google.com>
Date: Tue, 24 Nov 2026 13:12:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1289291365308152486=="
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
Subject: RE: asha: Notify connection interval changes
In-Reply-To: <e565cbbeebf165ab5e6efc3c3f2764bc88da929b.1795535897.git.cochcoder@proton.me>
References: <e565cbbeebf165ab5e6efc3c3f2764bc88da929b.1795535897.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1289291365308152486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221082/

---Test result---

Test Summary:
CheckPatch                    PASS      2.41 seconds
GitLint                       PASS      0.98 seconds
BuildEll                      PASS      18.93 seconds
BluezMake                     PASS      288.27 seconds
MakeCheck                     PASS      14.19 seconds
MakeDistcheck                 PASS      143.26 seconds
CheckValgrind                 PASS      354.39 seconds
CheckSmatch                   PASS      282.45 seconds
bluezmakeextell               PASS      98.33 seconds
TestFunctional                PASS      1167.94 seconds
IncrementalBuild              PASS      322.74 seconds
ScanBuild                     PASS      1106.12 seconds



https://github.com/bluez/bluez/pull/2911

---
Regards,
Linux Bluetooth


--===============1289291365308152486==--
