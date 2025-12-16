Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397239656B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888323; cv=none; b=CXV0NN6k7HaweWmPEuaggtQGPidH5ixK1lSz5W4cJTdE9VHnQ3IFqHpVaAHtNDOgK+RuWnb/d9Fp3PBiBXsneu/x02d4MS+UIpywYuzVUu7uT7WEVTYQxRzs9u9JqXImROts/3l6b3Nvtp4gzTEf/bFLDiaxbGKbNtb8CpS/9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888323; c=relaxed/simple;
	bh=hxCTfl1rGkiLpQ4DSq8CbvDMqVP8BEiFGx72Zngl8K4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N3czWLpbNX3KliAAuJ3wdkCYj63YuKMVxhNWCTytJ6oZbJik6hqggKw/EQDJh/sCuOFbbiWqt2DgYFdzoxMDGlf7Nf70MJmbXnh6FAg9MdvohvVLb2DWw+Bv5uXRkGotbmjzBNBDPKAi563GS+fimVjg/XQOsgtBE6rzLkfk39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5z9NuWL; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5z9NuWL"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2f2c5ec36so467735285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 04:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765888320; x=1766493120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wzjdaaIaOT2NLEcBqidRzxzfFkePTrht3QPYwfYyT5s=;
        b=D5z9NuWLeF9IyrA5TNm0NPop3c7RJV4//YF2o226RHtQT/7Hj1OGhA7pxyhKBlRCkU
         F7CTv/mMDygMJe5W5JrgZLTG/xACXF10T5CpbxRhw0he1jJH9ZuQDdwt56rW2lshEMyN
         grDpSjW2i25JPea1datTMaNNLWOJm45jq4WucY+Itzvw/+actQGONh5DVUK7Q+2fX/8z
         zllTau6YUwXk4ILAaJxOQTpsmDUnkAeDSOmMUMwRyXrQm4CC/ZFyO6ojzK0yQS0eaQmh
         L/XO+4YPhG6UQHm/bGDtQkEmeJ1+Vg5licF6ynn5E9mH3P7efLfEC3Bq66IIPbb7XqG4
         xCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888320; x=1766493120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzjdaaIaOT2NLEcBqidRzxzfFkePTrht3QPYwfYyT5s=;
        b=TD099tHEmhYrXxVZosFuIXil2lksE1FclaF0BMFvN19QbMBtph/xOo5/MCAcYcbIfw
         7sZpnb2DflPZWvJu6LzrLSJadspiqvATUYblylv5uAE59KKa9Q9LIeutTVmX0Dctn4kE
         mjDbtm/jHa365Fyr4sJ/SJUpyHXxMDvSlwQqtcfWv1bVg7b07Mt+kJA1Gc5SJIVlMU58
         rYvqwLSp3yZPlxveIcpasa9YiM+Xk1WKHRIaKIT3oJWDI5rCPNkKlUa5B9xP/03fnTKg
         fWNmTBQHxIvdqmZcOEk7Q1tkBZ04tMG/u/gs6duXKATOn48gmCSeQW8CwuUklC09/VLl
         9Jwg==
X-Gm-Message-State: AOJu0Yz6UP7oYYwHrgnAIncgo8N+8/bc8kC/j//9VewgQeipLu07DBTe
	OEQft6XRtjgO4XVXTmqUK9IdLdgJmUZ9/XqWrfGD+/rDS1SvOuKt5cm3lIKiM/YW
X-Gm-Gg: AY/fxX6Sv1rwyCiBz1Pq+s0wGLJOt7byQbvlwRQ22XEHRlIfzHfHzyWqoFKY+IS5RSQ
	/SyRH8IZ9ue+7k9f6Xnig1/Eeo6iECh62lDBEX8Ne/CiZTojn3UxPPWoanDTxDxw58Rl6NRx7eX
	VsTBBZCD+ieuItYFegP8vKxHLp+DKWmDIfYSryqevePG2701er/LX9XtUaFhArM+NtiG8da9ulA
	ZLG3Ei4vCEymHC0pfVwQNgL5iM98kl38Q6yzzEjZNRumcD+Mih7VNLek2ujXZt2wticZxLAXtoA
	S+7naDauMcBpwQCeBa7FzALkXkcKminkE8fZ+J4DmjBnrpgAX/umAej3u7C5G3w6+l2/33nNrXp
	Sh0ULEORm/3m7e0EZLYVtGlb4Mf+NbENw4Kp2dyhHI4EnsV1++sPbCoeFcJK+B3i+mlV2uIxY5b
	QWxl0GZlOyXmBaK0USeuQ=
X-Google-Smtp-Source: AGHT+IFD5ELCvQxivJ4vVqrFDGnkvSLXj0d2k2oxPUfpsZ+vqP6j43zQYSTBj5ufN9/DWt/s4s7PpQ==
X-Received: by 2002:a05:620a:4508:b0:8a4:6ac1:aeb with SMTP id af79cd13be357-8bb3a38a322mr2018009985a.74.1765888320138;
        Tue, 16 Dec 2025 04:32:00 -0800 (PST)
Received: from [172.17.0.2] ([135.237.130.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75b24sm168747785a.49.2025.12.16.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:31:59 -0800 (PST)
Message-ID: <6941513f.050a0220.20d333.8a55@mx.google.com>
Date: Tue, 16 Dec 2025 04:31:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0043111913567419059=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: doc: Unify properties section name and type names
In-Reply-To: <20251216112941.701823-1-arkadiusz.bokowy@gmail.com>
References: <20251216112941.701823-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0043111913567419059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033733

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      647.56 seconds
MakeCheck                     PASS      22.18 seconds
MakeDistcheck                 PASS      241.49 seconds
CheckValgrind                 PASS      303.24 seconds
CheckSmatch                   PASS      348.70 seconds
bluezmakeextell               PASS      182.20 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1021.33 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0043111913567419059==--
