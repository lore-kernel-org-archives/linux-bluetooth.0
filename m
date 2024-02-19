Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7E36134
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350761; cv=none; b=NAM4u/Qe/XOtos1ksxLGAsH678z8K4fPQCZfZHm2oGXZ1Jj9i5htHiVkEu39szU8fJhHTUgCaVc0yTQ9CTSNB/ARKhyQaj3eYcmg3lp4vJZ94mW5V4xwXo6ChNsQWdcWQfPyYR5hXVvqcuqwtaukjnkc5XN0sA92KaN7TmSoitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350761; c=relaxed/simple;
	bh=aZyFRl27DBvUoVYtZmIOuyZWsq+tn9n58jGmkjMJGsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qT6lJlw+lR4xYBQyvvLG3bvsEml6h98GKOqrYAXO8sjXWH4tYk2QstW6RFWiR72e/xRavUERA9InIxF0x/fLF9vWCwv/FRq9tVxR8sctnX0QwcN+BIDVUlOpNPvQaZMAB7m/tvkg2P5YXGkd3seIj2tk4QssKWv95XnZ36GvkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9GS6NXJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9GS6NXJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42c705e8e4bso30157901cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350758; x=1708955558; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I4daIq7nPVT/7Bo1IPgQZKDs1l2jzL5ew74Scg3vd+s=;
        b=e9GS6NXJQNSW7sSBuXoOIMxkO9ma7tUwGX6LEAaIw5fiyQwno8tahyq4DhMFX8K8d3
         oDM1ecWglfKJDmF0Rrgs80Y7pi5D3GVOU3gCYZXoVamu0O5V/cGkec7WzvJP1MB0g50N
         9ZzyR83BwmFqU8gB6i/ovuafjupOF9o7xUOp3uJJV1YZoAOx8w1p+jcN5K9l4HmUh6pi
         0Jsj+h5N8N64gbunamMtcaVpMVMeTSLb82rL17UN9zbTmVTkly/HZX/+dCmCH6wkoV8p
         gmVq10P9CHj+90DB05AL2sT6z/1Zw/QOQgjn6PA3LtqbHmswqO38koYT74ls643x4SZy
         D9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350758; x=1708955558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4daIq7nPVT/7Bo1IPgQZKDs1l2jzL5ew74Scg3vd+s=;
        b=bljS6vggyZycQbZpdPWxquDHRW/Y0Ugio5DNXTilVMD0bc1a3zJe4+rgbpxbZAtdHM
         UEW4fUFkniZZersTIWI+iZz6dVo5sxtEIY82Go5NE+0CWvBrCI5R9FCc9Ka2tU1YyN6+
         RSEcpzyQ3cdg/dLngEomGLETcouvNM/zbiwpKXGwjuLIx+tWqQKST13rOiTCG+hOMFR4
         MxYppQm9dhZ34r/TQ59bzs5fowm2IvsfMa3kWxDXvqmYHl1coYCQ9U01n3bJeQPsYwjQ
         TWa5vkcZapz0j3pbz8X8MRLvAm7ArdbPGhqfzAH2T9LvLbX2FNwiu0Mg/okEXRRXWL9s
         h45w==
X-Gm-Message-State: AOJu0Yxlc/5+zZXeczaqkYAt4SQqi+gpiXkQ6iaxTEvzfyG22ssw09b1
	7p4l4/IO7Pj6xuaUjkCF7X+3v42hkMujuN14gQD8VCJ3VnmAUt0LlenhtnawHFE=
X-Google-Smtp-Source: AGHT+IFVZ1cs6yzi3i3D8Y+q5hGBGX0WOnBX3api1WetPYPXLuuuJbvs1D9/+POgxmfUz2+DUpOjTw==
X-Received: by 2002:ad4:5cce:0:b0:68f:7127:a2d7 with SMTP id iu14-20020ad45cce000000b0068f7127a2d7mr3247357qvb.43.1708350758317;
        Mon, 19 Feb 2024 05:52:38 -0800 (PST)
Received: from [172.17.0.2] ([172.183.148.24])
        by smtp.gmail.com with ESMTPSA id mk9-20020a056214580900b0068f760929c0sm749535qvb.71.2024.02.19.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:52:37 -0800 (PST)
Message-ID: <65d35d25.050a0220.1b85b.1b57@mx.google.com>
Date: Mon, 19 Feb 2024 05:52:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5238182350620082273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Update Sink BASE management
In-Reply-To: <20240219121509.5702-2-andrei.istodorescu@nxp.com>
References: <20240219121509.5702-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5238182350620082273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827440

---Test result---

Test Summary:
CheckPatch                    PASS      2.43 seconds
GitLint                       PASS      1.22 seconds
BuildEll                      PASS      24.04 seconds
BluezMake                     PASS      737.33 seconds
MakeCheck                     PASS      11.93 seconds
MakeDistcheck                 PASS      163.85 seconds
CheckValgrind                 PASS      227.56 seconds
CheckSmatch                   PASS      332.33 seconds
bluezmakeextell               PASS      107.79 seconds
IncrementalBuild              PASS      2747.63 seconds
ScanBuild                     WARNING   953.47 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1117:2: warning: Use of memory after it is freed
        DBG(bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1130:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1225:33: warning: Use of memory after it is freed
        for (entry = queue_get_entries(bap->state_cbs); entry;
                                       ^~~~~~~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============5238182350620082273==--
