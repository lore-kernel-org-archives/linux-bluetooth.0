Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A051D5CDE
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045488; cv=none; b=d59xIHviz7+MJmRsKsID/o+LbmR5Y2r6gf2WMwbQM44ePuLQLSbdk5yIxiNI9YF2L/qpDVUYIZhVa5BxM1++Nn9fIhBonGy+DBCSb2gHpq3WlO+1DbZVSw6XT8szWcFX49MmX6gHEQUVtVL7/NuTOgmk12EjxqbPkzRBaHr+ih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045488; c=relaxed/simple;
	bh=NpYdaHkUh30py+dM0k4Dh/rdpYZ+pzHgbX+BSeoBNPw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bc3eNYP72jepfeSnmxiydCt8DMwqq4LfIzAPkhDIjiNgucQluAMxo+Yz+CIgRODJfo8ftf6HlFhzwpdiFbXCd0DmPAw+ed4kV87+290hFSSYnEQY/UMrsvAWaIlEkEld0GDtIRDM6pju2Z7RE1r4zJsYIptWMe/FjSPjRHOxcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyvARktM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyvARktM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so1402514b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045486; x=1760650286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xCquKrrcl30pdPU9uXOny7qyKXt8RgaS+MKcVpDGYTk=;
        b=LyvARktM8/GQ2/JZWUPxDkV2h0xDuh7GVQ5cyUfe51VUDJw7OQpWlq6NN07eWPqIBm
         Px/6tTKiEFPw9EDVfTALJaZsqTYbwgDo0g2lkHBtqWSHpKo1auqYlI9DOQsrT15g5cw0
         LwsG/yoGLxVGLfwaw8Faj7peX2Tw0BCFArbWOVJ94qlnqhDp9jTahS7s74Jqx6n4xcM6
         3B9XiAXQbVR/f68vYq35PGLcLSQwOvb+8PPjrWTDrDcpAJxr5dh1PjHLPRoeOwTgyDmH
         CH/Svi0aiyo2DC8X5cZoJCjm7/1yjoEY4KukQ4l3oo+zS8XEp+0GwHYTvkZ9Gm34BOFh
         cz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045486; x=1760650286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCquKrrcl30pdPU9uXOny7qyKXt8RgaS+MKcVpDGYTk=;
        b=kX8sMzSMnEcNPUSnYzqAx1FsFrxkKVhUZpJbmU1HE7P+i3zqsok9oeQayWoMzP9e+6
         iBySfsveSciGrE6xJ3uo5VRVjppjXaBUH/gk9jLud8z7uo7nsnYUg/k8E5kTd7yo+B9e
         MPn9a6pGRv5Or7ILNqHkcIpnp/gvXjT2yyryyRS3Qvy5KVJyeRxEQ7hntOk9GmzsJ9m9
         ZQjNtlhfOthL1vUwfnyyxbyiGmP1AunNaD6JegBP4YNZ+LFKMPqYZssMuUGsShs5ypCH
         O82+2ZJC4uwFAq6uqPdqF+G8rassy5Y1YxzkI5K5C4jPzX6HYCR0EB4r6f3UeabgTmd3
         zdUA==
X-Gm-Message-State: AOJu0Yw31ZtLHl8s6F+i9vCrSU9+rogb2Z6EDbhFr/E/oT9XAl8rkoSK
	+xMepDVSOn/okQtE4eaFjDL5PQeIEO7TWAxR+Zim5nG2xr4lQbxbz4yNV+75Dw==
X-Gm-Gg: ASbGnctsGYZ9Q999ghkIi8vHvyVLN7ZVODVdoV36bD1VIxXwualEpMl6+tbOSOo7lJR
	9Gkhat0iN62jGegsJBV1JYxrPcY7xWSpwIu5pLgLTB2UetsidMD7Iau8MwranBy1l63fMm+P2vi
	fVoTcFy/lhKmDQPZlu/Q5pTllTtUP45b0aq8CkkkcRRvg/giP4l3decUC8vTdcCnd6V9G2zQvAN
	XLDwJEvtaJVVyqMCtByFRdsGfJlX8289y3DLqUAOHECdTdpIoqQbbmja2/Z/iVss3oEyrR4Q3iZ
	CxNt4r4HnacYE9flx8AsFn6rCxpH9m7MlLJ8GD7Dt8jiNI9/NxTQQbWANknJE/YRGLYgOqT8g7K
	W860Dvxh0Dc4U5QD9skDVMz9h/zWXyY9QKSPk/NHI3dxnfsRawHKy5P5ps9aD/xQ=
X-Google-Smtp-Source: AGHT+IHTfTrNOWE2mtDXrBLDZ2A/z1/YwFUnmXMpeZdVSTwHgc2cTSoq+KOdDY7kTtlfCadFZnk2kA==
X-Received: by 2002:a05:6a20:5493:b0:32b:7041:21b9 with SMTP id adf61e73a8af0-32da8217f34mr11562912637.23.1760045485813;
        Thu, 09 Oct 2025 14:31:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddce4b6sm584799a12.13.2025.10.09.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:31:25 -0700 (PDT)
Message-ID: <68e829ad.630a0220.285863.3bb6@mx.google.com>
Date: Thu, 09 Oct 2025 14:31:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1566370459607994047=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/6] shared/hfp: Add dial support
In-Reply-To: <20251009195842.776231-1-frederic.danis@collabora.com>
References: <20251009195842.776231-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1566370459607994047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009862

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2676.09 seconds
MakeCheck                     PASS      20.70 seconds
MakeDistcheck                 PASS      187.84 seconds
CheckValgrind                 PASS      238.71 seconds
CheckSmatch                   PASS      312.68 seconds
bluezmakeextell               PASS      129.02 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      922.84 seconds

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


--===============1566370459607994047==--
