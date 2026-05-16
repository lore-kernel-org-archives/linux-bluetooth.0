Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266424A047
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896115; cv=none; b=FG/W9W5XY02HqdomQJmLngAac/p+p2KnMlzRLSKmfo3bqddcenIaOYTaCxmNitvNfXutVl4BnVZ/xObMZcUiHjc91f8D0xx9o/GlvboC0VLZogSZveNNS5zQaojJqPUq0dasvbaXQ6uptk0n4RbWyMNHN32id/Kzi2OZ0lwBxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896115; c=relaxed/simple;
	bh=yE28riO323BFNC8iyK+70lxh+zffST5rEMOxN1wP+5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k13YgSGBfv1b2eni5j0yPC83Uh+LEruhovGukAr+Lqr6ZBIn1VR2PAHQlYsOxw0MBktGiD6ea3pT157UrfFX2etZlIEUhunZ99MQh8jZ7dcn2o8sHJwfiHImU6PcRGJkkCEG9cpJcmMnNecEGWEtgOx2ytmFSABIDxBEvzvzrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwtVg3n5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwtVg3n5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b98482b253so9796626d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896113; x=1779500913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXjddW6gq/tEZQLstWVamVaD0kDL3LjwkYiduVPsATs=;
        b=IwtVg3n5uHx9tpov79srUJ/51pBsecYLeoLOMHtVT5xiyn3nscjGnTwps8T7nOlFVz
         RFw1o0A06tczlgalxxnvPLPBcJewk+61alcKVYvb6E0cNcyNUHBmUiIjTCeb8UIq/E/7
         +FvjSXD8qu7UNRWY2YTw9ROx9a/xwp/ihB6NPLeXUwqJpQqj+sMHA9++5e1zQ+sh9qQR
         QaIUbpdyEX3i56FHDUcmKjcsVawwYpscvFH1/tmXV3ED0Vw9BZbyr3dSq6qorCVQRFO0
         g5Q5MnAbMTJYqiYCGMMPkiQxwNtXOggmVNpjYqvoCyREfdBv4w/F/doNOUuYRumYVJx1
         wIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896113; x=1779500913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXjddW6gq/tEZQLstWVamVaD0kDL3LjwkYiduVPsATs=;
        b=Epb3NlieKly4pof+2WhjOW6FoQRlSDpgf2AxZ9y1DgQMtPuHGg0aoTmF2eiD+4qflc
         69spJYG1OTEhOiFsnJgAH+Yro06YWlLEYwyPZu2OjvKNEWQfzg6rP5K+WotcTjvf2Xxj
         TJ9N06XtresAWeVVszyjSiWv3WGeREEPNcl0hfZos2zuwIqZ7ASLmWVfvwZQOf+k22UG
         1GRhrQE6EjIvncMEE30OsaHy4RNn7u1j88S8YPlgFNsQa1pY7S7+L3t7HMkBiwQPPRKC
         KNnHMme8qjlJfGo6nQMEhQZJIp3Wm1nXxNZ0j0Q2pTNdN/9n2b0twE5Rl45A9YcEANUY
         gTFA==
X-Gm-Message-State: AOJu0YxDTkuNx4AgHmMOf2x4Wx+10CNoFj6ftQFNzT9VnHhxH6s5F6ho
	Z7C0trd08fDRvWvpcIzlgfo0rsRC3FmNIXPw24NMEF9bWMuZStAxIvuQHr+sFA==
X-Gm-Gg: Acq92OE9B/vim1F3mIqbenNZnNKqpqpXlOrCHTO2uz+Vo3KF6URdKBTjgbffMW771FH
	mp4kjG/kK2aY5kMY97vL76UeZ3pdhe/eTcFw9yckjcRTBw/4s5xpDYXgJbs7+uwhycqKAuxCsJv
	r5wWpya+mvyl5wKcGKxyE7+5Yv/VOugjukhrcwtbRoWMiy8ccbYd/SUUKUD7lY/dyaxf5Mnw1Bp
	MsLjkx8etr1zgwF0bYuZVyy4oyGFgGzQID333aWCbzzpe2zwTFhjV5D7yk3GyIL8Zx0h/o0hGdi
	XcZ6QQpFhzxYtDPgFqyywC4fvZFeaYaIDd6EHOrw/NUrZNltqckVE+POZ+x0mGcdqrMf/lyxCl8
	7Ugs0Az5edmTzwfe/F5nY1fV5YtjU+l5aUMbJbvTYWzfSkLACXnk6LMKozLaK7LIAEJ3aSJN9nb
	eZHMdeK8YGedGGIRM/Hqa6vYx0HsFSJw==
X-Received: by 2002:ad4:5cc8:0:b0:8ca:25db:d3cb with SMTP id 6a1803df08f44-8ca25dbd753mr8400166d6.1.1778896112655;
        Fri, 15 May 2026 18:48:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.44.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc41fsm69251476d6.25.2026.05.15.18.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:48:32 -0700 (PDT)
Message-ID: <6a07ccf0.7f7f1747.324c72.a303@mx.google.com>
Date: Fri, 15 May 2026 18:48:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4262079441489521600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v2] Bluetooth: bnep: reject short frames before parsing
In-Reply-To: <20260516004433.3199522-1-rollkingzzc@gmail.com>
References: <20260516004433.3199522-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4262079441489521600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095732

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      26.53 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      522.12 seconds
TestRunner_bnep-tester        PASS      18.54 seconds
IncrementalBuild              PASS      24.94 seconds



https://github.com/bluez/bluetooth-next/pull/198

---
Regards,
Linux Bluetooth


--===============4262079441489521600==--
