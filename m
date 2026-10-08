Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888F42050
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481591; cv=none; b=IRgbXe1SrfogXdwISUj5p98veJVxvxxTW8mBh+ltuof5T3kTYtOhpypD0L/ACnuuKgYi2CcEMbY1mmXz/a1Ogl7qtyL07OLZXQcg9OOWt5ZqgwdO3gkw74uGpaVWF0f35Idt+eEhgrQCk12fI/AOwJBvs8nnzYGKOm6QSZ/JMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481591; c=relaxed/simple;
	bh=W34fO21830eppwA1AM3YgkHjcme+/Z9ftA6eN9P3oUU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kv8Yn7euBd5zbixDhBOmDSWFow4xAh7yqPiv+IwvfsylLXOzy5trO/eYpQ++wMBSHbdJAB6nwbwqSFrc7+C7pw7vgwDv5P82PKt1XHH8X0X8srReQgLN3m9de1Y0NRhoulSvnxMj6EOLpB+NurEI5vAReIcSyX0ajsmyZOjmzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmRx8m5u; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmRx8m5u"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so5071614eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481589; x=1792086389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EAGZYcBR0DnQNw1cAFLrzkYOM6Nmhxpgy412QFyb8w8=;
        b=KmRx8m5up96K9W0ZrWvRf5/Y1DpaWvsbVRg+irQo9/+cOIEtTuZcxm40jtxvdOhH/4
         j1jU0URaHCGVKc4kIBjy4lNsyZ6VEopnMFr7XR77nTIsW26ELeQHCYHK1fIiEAsi5/ih
         7+DBgDfYqmH64/vyjBqLxQuDMGMp3kr44/04hD8FWyzTlhdOKrLN1cFMlCc/TFW5l6wS
         oTpBj7xd2Cr3XIAUqYK3ZaTWVkqJk8eDs+Qsg2/uoRy5OEMJ7hXW+Gl9mv9K3NtXLkAD
         ig2hCO5QpRz3DUK+UNynLNyvmXIanRbpCd3Si12kB2g7K8MEC5lJb6cJ/o8OGB8eW8o0
         oc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481589; x=1792086389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAGZYcBR0DnQNw1cAFLrzkYOM6Nmhxpgy412QFyb8w8=;
        b=x0RN1CsVcdneIE7hbGtv+fST2tv5YZs7Ilpvj2sgZ+UjiNDy5TluGn9/ZhDb2C3N8G
         4PpCw1mEr61jMbNWX/zoP2clw0yRx5S+oECnNqSvJIFtRUJxHsKdHz9wS0RXvamTkeW7
         eFFT/6ympaYMIBb+3kcJ0yAyuFf4sN2+DxCoGPS1uuJ73KKoYgyxnWGmco1E/M0CQeYf
         ysU5Wvx48q9WuxkyL+2ZhMax9O9QcVW9yTS71pPCvax4V3p+k9jTYmehz61yk22mcdru
         tUtW0rBpy6eJHxiKL6+uzReQ4d6baYETOcBlK+M2rJvqs7+Jyowdv8fX8jWsrTfx5gjk
         ZtOg==
X-Gm-Message-State: AFq9FYIOyvaYhrVHtXi8VvaHQ9vvJ9NiJrhI3xle793Bs4NGcwKrFY4i
	8x7OQS1T52xqJbqKcygEa2e0gISfu5dWbLKsRzR94rznNqoqhqMANTnCl1DScQ==
X-Gm-Gg: AYBFou3PrUL0/cdk973exqZuz1naCa4Ts58uxDd//MBtFdQ7hWDDJU5Gr/UwnlSUj4f
	wG3QejCXWMozZZWZYbJXuT3dmNfVUQMxaDppvv2T2Q94IFG+W0hlNEnTXqs7I3m0tfRWIbUXp2c
	vYc2kYfzFi5iDceZBcC8vM5ebI/G3heYwFCQ610SkpjfvVIx3BDEgbRSc3TKPdp8t/wkIlXytd9
	WNvQjI0E6XiY9HqLxIvg2Vd9m4gAcH79CpyGW+4nSXhNNhFIhVrrmWvNFhOR8n3B7TOZHHrpzHA
	MuS0S7H1AV3DGs9gvOiE9JSbThr7GH1bhsJRLerASwxTmrn1yetsYgeHEhD6nioX9PoutPP7xBh
	Z1Tncwz7WrfbYJJazlnH99rK9wN6P+ihv4yuD9fDbQgwDFqK9Q2Kb10SE0DvaU4UwXsFNW8t5Zb
	5iN0LrpGDV12btAe8YAPHPUHrU3NlP31k6bwG0/1cUgVWcvQeeFcCtHcJMRFGfaHiAf/qjrLJhW
	HDP
X-Received: by 2002:a05:7300:3091:b0:351:bb8f:540c with SMTP id 5a478bee46e88-351bb8f5614mr4110411eec.35.1791481589135;
        Thu, 08 Oct 2026 10:46:29 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.77.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b3b2bcesm41472eec.5.2026.10.08.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:46:28 -0700 (PDT)
Message-ID: <6ac7d6f4.116bf87f.3b97f2.9320@mx.google.com>
Date: Thu, 08 Oct 2026 10:46:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4539800171143414021=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Role property to org.bluez.Device
In-Reply-To: <20261008133634.30362-2-kevin@simpleble.org>
References: <20261008133634.30362-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4539800171143414021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181653/

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      16.00 seconds
BluezMake                     PASS      281.45 seconds
MakeCheck                     PASS      13.81 seconds
MakeDistcheck                 PASS      113.75 seconds
CheckValgrind                 PASS      184.90 seconds
CheckSmatch                   PASS      220.13 seconds
bluezmakeextell               PASS      80.20 seconds
TestFunctional                PASS      940.17 seconds
IncrementalBuild              PASS      282.42 seconds
ScanBuild                     PASS      808.44 seconds



https://github.com/bluez/bluez/pull/2636

---
Regards,
Linux Bluetooth


--===============4539800171143414021==--
