Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877230C0E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909934; cv=none; b=foh53dEL/cc09UMJ93MFCgvpUyg43aKTrexEoavejJfFjBRtOi4cHuo8g8Vk91c1QhFWZzzJsKshn/8//HO33bWAwhZ+fZ+j8x08OKwCrBcSgHqW40bvvv+xdTHGLRt97ASyF1QyxO89S8L9kYaNMSTy8EgS1ZqQMQvnFfWeKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909934; c=relaxed/simple;
	bh=6GW30pCGE82CPOn/DILnCraKQ8V2D/gheykWEFeuGo8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KkAyEyt5Qqffdv4MgtYvl4a3IZcj66h4uNgqQyrQKUSmxrRJkSjUfRW4i/oh7bufOF4g9YpcadYRGFaPd8aGtHBFUuLFcwDvFL23MuhLUd5Md85kqBJccBNf+ALypxRINsuTTe2WuYEUcx3+kyP1a93z3k3zA+1wgoDcXi0f2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C67aN8Ty; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C67aN8Ty"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so2354979a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758909932; x=1759514732; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Auxniv/6w6wSN2zqFtITNYXsIljqGfOQZY8lqppJN0I=;
        b=C67aN8Ty5Fn6CbO8+xWpgAa8y4O/xAKQOcvrw4HWym0NGpX+AtkovkjFvQGN79P95Y
         dQh8Ai4mBpHu/UG2Whcly7XoWCvBV2K3pfYBlz0r8sIC+usUWofmWbyUAEHJngAkhi7V
         NMlsKIWb5OPVIRSaaJuCM7NAc8puaPuW6ReqNAR0s+dHf5cMBLWeAQ4BvycQkWK5mm5C
         zPjr4c1z8hxq1fTKf1GEfga7OCYRwolrL4DeoWU/fQP6P9vF8uRn0oYVnf1BM88WUlZ4
         tnCRFMK7bgz0lfDYt+fohkwG1iJPEe6bRvri9GlaElajmDVd59k9xsTfl40w94aTDxVg
         9njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758909932; x=1759514732;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Auxniv/6w6wSN2zqFtITNYXsIljqGfOQZY8lqppJN0I=;
        b=Y8hl1n97/GB2zZ1kSuOwGxb9i4hK7gp8OzTisMHlv17IRmk7mBTMjPHj42j0MXbUNt
         OU5DbnTm9HQCjQdJEurvSR4RsogLkd0UDjtkkEWyJQfYwHQbEoz1wJqXwP4vexlrBDB0
         9goX10aa3JK+wUH6TtA7V8FcmzMFUGTiPW5q44/WbgjvJdlQDEclyVKGDXlOEXzmz95J
         unsAFQKkZAJI2STMnE3yNKhf5FXgw8kXnR5F09+6QYzBfVTZ8y0XmWbeYOw6Po/jtRsK
         aC1l+qPxhsX9L46QiJLeRe2BnumFPkXz2/p1ejnb9o0V8hrRJMkCw/ieCi5GZacLZAQa
         CyYg==
X-Gm-Message-State: AOJu0YxfvtruMqu/beTn5HZIbUhxxlhHWsJoSNXNrtotqg51mR4FmtEJ
	j8+CpSO6tyt3D61OeS8koePXttKkIBVyjvNJg3w1RGyVnY7FoZODfL9CbHRXaQ==
X-Gm-Gg: ASbGncvp/3qPQUbSDQ22dnxikJUh9hZtoVp3t6RCkT9anBqjCJTMizLQEgO0It3aj97
	UFTKgL/OdfGvSaYPU3Ad//LAC5TcNiLf6ZBbZXRqzlIDokL7CENUCkDuTGPGiUizxq+Pvs25Iej
	U7KQD7HRsqp72Zg+TXqsNr0P1w8OPFSo3dZ7/WsOvFhsu4ZDC+o7/3SNEruwv2Wq6qib//huPRy
	ZVAjvXqpQ5aFBLnSq7FAurnAznQITOV03SHh6S5HMVXoFNtWMBbsyxFWkGaE384SK05SVOA49ou
	zOgsibc8NjUc2vOv55uROzooVccwpciMblgMKcioPneKdMghEf2uxkNdsaz21OH/wXIRzYmCLm1
	uE1HQDClFfPduWePcjRYaA6K1uyBoKZOmSLf0EXtQwr7XjqteHg==
X-Google-Smtp-Source: AGHT+IE0eVWlPtJPgeVjIzcOJJJuBT27/j+DwgYoWE2BA+W8aZDSjdgv5J6m3ummaF+GsKJwNqk3Hg==
X-Received: by 2002:a17:90b:3ecc:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-3342a300aafmr8619109a91.36.1758909931977;
        Fri, 26 Sep 2025 11:05:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b6d0sm6225591a91.11.2025.09.26.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:05:31 -0700 (PDT)
Message-ID: <68d6d5eb.170a0220.10abdf.b43a@mx.google.com>
Date: Fri, 26 Sep 2025 11:05:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5800292217943966564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] btdev: Fix handling of BT_HCI_CMD_LE_SET_RESOLV_ENABLE
In-Reply-To: <20250926162003.754423-1-luiz.dentz@gmail.com>
References: <20250926162003.754423-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5800292217943966564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1006636

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      18.51 seconds
BluezMake                     PASS      4365.77 seconds
MakeCheck                     PASS      19.86 seconds
MakeDistcheck                 PASS      175.19 seconds
CheckValgrind                 PASS      233.22 seconds
CheckSmatch                   WARNING   273.46 seconds
bluezmakeextell               PASS      124.03 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      866.50 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5800292217943966564==--
