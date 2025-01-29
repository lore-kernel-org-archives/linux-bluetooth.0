Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F0171CD
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145402; cv=none; b=NJsStsTWbkHPE2qZBtbhy35PAk00/xxyXNaYUkUmrVH0V8raCg4kySc9W2LUnKkTmOznZwIqjcaxI6QzDOuUKjJsrfr/Lwu4O1RINucDAiZbSgVg2Jwdvmxv4/0KQtAC8SSAgMiy2Pu2FFUJf1A2ngpU+imN3GcfOD7Rb4sAiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145402; c=relaxed/simple;
	bh=Nf7ZTpdMIq0LlZeHjrIzHI8L3v9x7y1Gf+VTRpQX1T0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DrP7dJIVuBozRnGqoFVOVVMiFcsGKgsH0h7DBWrkGUVMKEh38D/YqUU0dxD38vDklU+ZlqXW1ZT2V8aekFOfzUuRBBSC4sUWKcKcHDEl4ZepgNNXWsKgQ6vjO6ggGCFju8TDmzIO7UeV8zIr9A5Q4z4bAyU5Y9xi9Kge0CJy4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSHF59sY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSHF59sY"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a1d43821so5123041cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738145400; x=1738750200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X0u495clYOTNMU2mPXwGvU7wgHs3eLAm1Bpab8RgGFM=;
        b=HSHF59sY24FbPcyLquS5mb4K2cDe4hpyHN1zZtvPUa4Kymma9tiHkKoImPmzjk9OrN
         NwEBp6BoycaaWzyVpIwPgfKKFs9qvI3gdrZuNVVqTvywKqo48Dx4ZdR4jgcqxiAFY3fy
         U2KhpV6qCZlhY5n/8Joy98Gmm1JHTKEdqXh+fqs4svK0TZSxs7lidUZO1qj2DH8tPgGr
         hbpSrSqgBsr65xBcKDOqCeRVdbS1jVe+rDW3dzKWyGcEegJ7J2CKxcu1ya6fln5SkFEq
         S9ts2w/YVYVdQ7NfCZhOqY8vSPvYUQjvHXb8I3q6AFFznPpMIJXYdizrLa4oh6e25J3b
         UznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738145400; x=1738750200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0u495clYOTNMU2mPXwGvU7wgHs3eLAm1Bpab8RgGFM=;
        b=YiISjhbYKCS1F3Bm6xwPPW4AihJxgqjaVWT+nMwneFYDy8B+G1qX9fkElyfWOjnOOy
         TngS3gGoj0YQnVZ5txUISq3rd1olq/csXSV+4hBNQGjuUdky70CMWB8AJHWieEw0wXjB
         Zj+ixLT98CLQqm1vM212K+TvF256MPoD8qqqR1Ovs1lRGQc/g+RvG6smRqWSmbVFokGB
         IEqCoKRh0nIRRpqqQdggzXAgiA8XdKB17/1eTkMbro1n8t5dIcQ6PAee7TvZMtVnFFe/
         AxN4P/R7g+uB32u9rc9GR7CXc5IJQFaMWMjMOIc11L9ugR9/DtPnnqnCObaZlUHQep5b
         6uUw==
X-Gm-Message-State: AOJu0Yz4wnT6LexCfu+vUkLzqiIu/2d+YxaDLu4pTmlM6Z3BV9CV5gGC
	IA8Rfq8IJt3l+sWTcbzAWeiqwYbAWtXeAaq/OMR0FLYNdo3Eb0nQ4k24TA==
X-Gm-Gg: ASbGncv+s/YB6ze7wRKY3y/cahnN3mTDw1DeprI2s2hkdbLbis3F9d2M92WKCjUK2MW
	/teslnffQ1yNPtbEhTD91C6OWiYJMvSwpUf8mfSpuO5o67iOnqDcaUBLBVfpKOVDiPy6RiiLJO/
	Na1ytWJ8VgiVW2E27zKQuiOX9i0lgpx3L733pAwJTiRPiUr8Dyw+LlZjUJbk9+0D5Vko73AS63q
	GFPQ3mQGU8lKLZ6xGAstRTidpvH0wrZV0yb60aCMxPoxVl21sThc7pnF5afGh1nBdpVtXLOGqkQ
	MImt96XJgI7mIAVhg2Exln2+
X-Google-Smtp-Source: AGHT+IGuWih9nQCUyQ3lWiswJowmwhABf9jhmSNxrAT/Z6gA2KySMRJMQ0V2Cmb56CUr7WCWI/blUw==
X-Received: by 2002:ac8:6f1a:0:b0:461:7558:892f with SMTP id d75a77b69052e-46fc49a77fdmr121044001cf.15.1738145399907;
        Wed, 29 Jan 2025 02:09:59 -0800 (PST)
Received: from [172.17.0.2] ([172.178.110.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6687e614sm61414681cf.20.2025.01.29.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 02:09:59 -0800 (PST)
Message-ID: <6799fe77.050a0220.391801.7d83@mx.google.com>
Date: Wed, 29 Jan 2025 02:09:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2741481268288236729=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: [BlueZ,v2,1/2] audio: actually try to enable MTU auto-tuning
In-Reply-To: <20250129084950.41987-1-pchelkin@ispras.ru>
References: <20250129084950.41987-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2741481268288236729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929013

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.68 seconds
BluezMake                     PASS      1518.75 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      161.86 seconds
CheckValgrind                 PASS      215.75 seconds
CheckSmatch                   PASS      272.39 seconds
bluezmakeextell               PASS      98.65 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      866.92 seconds

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


--===============2741481268288236729==--
