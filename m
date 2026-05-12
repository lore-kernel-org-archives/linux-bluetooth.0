Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07C36C9E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588823; cv=none; b=Y8egoYaib4bMyqlXL46nlCr46Yb6f2uymSObk86e4vX4/IaLbgPEh0DHByT+K9t3THMp+3zutYuGhz+3FW/rlYJwdm4j5iypFAfLCtvnOI2wNnfyp0p/JCWHnmStgWhAr2OgcL/1aQhtCU5/hm3EI5fGPNOzzjwgG+/ely1e2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588823; c=relaxed/simple;
	bh=4VB3iBtddUxJzj31KYKpS6jWtU1zgOyKVla0ifc7F7w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OGr8g7ajMcyNhd7Jn8danbeFkjX1PQNKNCGrJwAMwKAqSQIV+PaQ9updHrFaBESnW0JrV9mlcQQiV3tr0uwznEalV55xEio/c4+Sv9Jvc40uvFier1g0G6Vl9tGBJrgKUjxutlV98XThKamyxELSnveoSsEl0PM9v4jvPvdTY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4EW1UCR; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4EW1UCR"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-515226c0cdbso2752091cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778588816; x=1779193616; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Npq64HUfkO1IXH6Wh0gwJ/HEw127b25morA3RkiXfoU=;
        b=J4EW1UCRpzyCvn4MGvsHphDUI8s/NXmxr56cJKhL6qKRUd0zi7ShIF0IRZ2EjG4h77
         HtdV0AuwjioCdvY79abAqsrgWa3b9cJLepRBLtYETTsIHB3wI16j8/yaCQ/3cbKhNTgF
         GFQtXQNKNfYYv6NXth5D2dSx0gvv42hQYYgEA5gxf7gLMvNTIYoFVYx0qImzC6oKi0En
         6bTM/jLMWTpDUdhCpuQlWQXGA9JJ/89RNvx5V9WL7JdB1begXfN3nu9zFwM3FTcbkOeL
         aaVMUqAcFlaO7he7gH94WXEE4QmSInyfQLN/Uc+Nb0RyBiE15SzyZPbjOzCxrTb6qc7i
         pnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588816; x=1779193616;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npq64HUfkO1IXH6Wh0gwJ/HEw127b25morA3RkiXfoU=;
        b=Kw71UsbEnshowKXf4yHnrqy6HnTmcKjjmLWCJizB5Msctzp4nXO7R1bqZDGaE6mRFc
         BPr+06MoY3E+YY6jZoVnhvN04flJiy3rZZ2AWPP6F1pJrmNEKHvUV8Tj/bhhPAkya76X
         U8ttAGaK+wjsD1nMOFXovOWpRY+q+RkNJ7XBqrPUPYcXV61oj+21o4idjQSjkIwwyLln
         GIAwEHw2lg7KZmE8lZ6+B88Hkwf3SnjVQ1Gzs4UvMaH1wp3u7gFhhTElAKVHbiVs/QcD
         YbEMl/EQhFnicIdcZRWPM8dOjhBHpttkAWj6x7YM7jE4Fow1YxslqNPr11Q3/H8FLsUc
         k48g==
X-Gm-Message-State: AOJu0Yw38A80Stt7AJNqLkJY7abVyfO/t0j94NFu9qkJEgHjjpWztepT
	mymzNON0oIgohOgQBiwAwVy4CNCgBDyb/XFgACA7TF3PAZMMgzsCAYGAZzyjhA==
X-Gm-Gg: Acq92OF3HhlpXqbMB00cp5COUZ1UIYChppdrwZdZ8oix9Bk34Jeml0nqNF9Jbuqklhk
	cR+lHYSvzbTqTaCZZy/8744hMZTDzofGQuCZRjTvihV/XI7JtkL6D72XSAK1BBeHr3CciHntlmj
	V1Dj5zbHmINLDm30pgte94FWyNf9/rofeeZ7VoaEgfTV37lz1BJebueL4jv5DsflvAPkytyZhKq
	wyR+3x7/kswjBnHrGkoItIKD71BgTpUraV9L5Z+9hDZ1i0pWzRgZ1k99tPixYzPiGGYKIaO3CQ3
	q/MSYToXMtRMsqfTaCMerTdSqBqJQPQAGLiLh18gmPpw0Kf0t5PuoL1E2KLMcIEc+nDynKzEEXL
	zXKt+ArjzZ8NcqgsJGH9pSZAaSsjrTbbz80cWWeV6bFIkjg0tcw5S2FtdELlCd9TYp3eIChKs6E
	AGf2u5odd0s7rU0lfttVNGT2MqkCsSRRA=
X-Received: by 2002:ac8:578f:0:b0:510:2506:1ba9 with SMTP id d75a77b69052e-514d2222c77mr39093881cf.49.1778588816013;
        Tue, 12 May 2026 05:26:56 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514d6d463c4sm13404991cf.8.2026.05.12.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:26:55 -0700 (PDT)
Message-ID: <6a031c8f.050a0220.1cf1f9.b06e@mx.google.com>
Date: Tue, 12 May 2026 05:26:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0384280997590100526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [RFC,BlueZ] media: Fix possible crash on exit/adapter removal
In-Reply-To: <20260512101431.2017966-1-hadess@hadess.net>
References: <20260512101431.2017966-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0384280997590100526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093445

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      657.53 seconds
MakeCheck                     PASS      2.98 seconds
MakeDistcheck                 PASS      246.45 seconds
CheckValgrind                 PASS      226.08 seconds
CheckSmatch                   PASS      350.07 seconds
bluezmakeextell               PASS      181.48 seconds
IncrementalBuild              PASS      664.24 seconds
ScanBuild                     PASS      1027.26 seconds



https://github.com/bluez/bluez/pull/2122

---
Regards,
Linux Bluetooth


--===============0384280997590100526==--
