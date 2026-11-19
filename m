Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076513;
	b=rZxaG5g8rXlvFqUNjjgKTfaDAyM41JTZeG10kY/keJklqZ0thdX834Ht7v8rCcZ0OvdC
	 0QBDlQHUaw+et0vHWKICanBZFaGHMX3nEj+GbapgkyNgwqyKWNoMOZOHNVVDK4kqc+95v
	 l8qZSS3ZZHe1FpCcfM16c4doHHPzK3X3wye3xXAQjtABxsw13K4bXl1OonQYKDBASaE5P
	 RHV7SR/20MKFlvNPTcXMNy6gjcNiVQN/HTWnSXalEFZ4x8l7TGRMMap8ovCbqbu7jF7vD
	 tWRoy9ECzUULgOPs1kMrBToJ1LCdOje3clt2WULqFQ3zMDUqb89tcTN7laM7Wem1IBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1qz8o+HYXHpcVXk5IkNv1bn2hOHJDl8OzBjAngAQCQ0=;
	b=1nMXuF8jogbhByRdBvgTn6cNyJAPw5mmHyAYmuygyyOXFYsO1E3XXX/7z6oT3Ru945kk
	 MwOKdIq4EU+EwGOK4yFS1gL/r3AeHw9nharrfqtZ2L/cjMWozlapN+dCu8Ckt3lmAi0yy
	 MdHHfmPK1GLmIkzwlCCVAatA/JlU+dAT3Uy366RptLhznECWCva0BtEXo513n8NOouN4s
	 RGI6EnKqXq5QWLgS1MF4mrlzZb3U6oe2X6pPUlZwqZtIT1LY2WRVZoaa8zn8GZU3BgUlR
	 tK4MUPRLhfPvyn3tJ22RusCVulVJHyMD1arcNHR1JpOtMsmY3e0bSwwKXK/AIkowf5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xc/WanXh";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D5606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xc/WanXh
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so2901984c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076512; x=1795681312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1qz8o+HYXHpcVXk5IkNv1bn2hOHJDl8OzBjAngAQCQ0=;
        b=Xc/WanXhNvTqxlWF9ZCb2BG4NrqC0Y/CvrP8miK7Mrm+jUR81FCQnnvk0RqCj+l8k6
         eh3aER7m/zDtDp3IOedIf8XYGot4+7qgnfdxVCgFb8Ve3U6TusEX5fI7MMRWg+MgVBJt
         tEw971vBb8uLLaDdvJ4sEU/lJ6AWEughY8m9hiKQ6EndYK3kFNZI6qoPrG61F+FTP3wr
         b9/wGVGEHUJcbnFv8UWkx9pDQ9Rrs8sAl+wKtm3sUk3GeLscNOLWXAr08ZKPgaHuqkWB
         e5/6NHgQ+H/CTAilWhso/h1SQ2tgDGCM1zHWDVuqj8QSpmDTPpOMPWT/pRsrZvb8ZzRq
         7yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076512; x=1795681312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1qz8o+HYXHpcVXk5IkNv1bn2hOHJDl8OzBjAngAQCQ0=;
        b=FWXqX3CvElj2Df3Yt9fwVIeNSteQeaOJQIEuUMr8uhyFSgKxQLjdyLXZ93npfJ1eol
         nMZEJFgiDOTHEFwc6iB6klwXjKqrZsOdRpZndgErDzNLaffTiYJAYph+THg8KJ6fCvcK
         dqG/zsqATmhFe0x5N09A8VDyNXqW07MpmAmWCinOxsj5j8XQccPjDyo+nXB0aSFKFDcc
         ZBqz1s4sNbH7szk0k7RQzyQ6osyw/EL8zz3oaw7BVIMPrGBKefzRndOYTTDL7+aUAQ+b
         LN/p7xFPeM8Hn6MdmDpDJWHN4rn+QqVIhs+U+fTzx4ww6A7S+QrZBMDIj6HcNeeZTe1l
         ZnsA==
X-Gm-Message-State: APuU4Z/xquRDWynb6e+H7lbkl/4/UDbqHZ/yLrhUoOmsEAREStdugj5i
	8rygfoM1KQpgd9v2S1GK/PNOy58pzjMGvaSb9NUsdNmqtBgvHpvfTjAwhaxzFw==
X-Gm-Gg: AZFdTZfrvIbxT/Z6V+pqs2W0i1iGq+cvGR/4+zIsAT2g/P7D1LeLOmodAW5JD6jBfU4
	CKhsdNxgJsaD9R/7j7iZChfcuwD++btuGG7B/suef7Nb5OnNyFJeSilOnVxlwVdtk0krihdF162
	NkPdSiSm01y5IwC1Q2j/CMldXoodfYNWCyKx2WStrMVdSBr5FfY2ElnKfHoEhc4smsQ0gh9pqzw
	7xokRfJPzfEGaoSWKo0Ee6UL6FDX7NHCkroQgSIcKxC1tEvxCAZmhHL8yNzyaG74eqK2dKqg7b5
	bLf/t6vnY4dNgtPS+KOfyyabUoqajg4RutNuV5orHl4UyGKSmL9OAqy0ErlFt9Aik05fz1i0NIZ
	oZMVbex6vfRPUElfycHxz8PsyXjLOJxkyD+DS6aOyL/SggEcZ7RKO0bObzAcSu6W+URUG2uuj5V
	dWWSYKMh9vZ/0fc1JNQm92RWDnScRXKtAe7eYuu+itCcQ9ykPIYpL1BqdATFArx1VCloB6B2Fn5
	s7Ip0PEn2IHfXr3RivJjQ/EiHuxAneyz4Ox22Npt0srUhXM75Rd2fL/qwB6G8CwuKjRGI7WrvBP
	qMP0D7fydQ==
X-Received: by 2002:a05:7300:6a90:b0:369:ef63:ea95 with SMTP id 5a478bee46e88-3828101fb2emr4260750eec.6.1795076511933;
        Thu, 19 Nov 2026 00:21:51 -0800 (PST)
Received: from [172.17.0.2] ([57.154.167.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bbf0d6sm14928758eec.25.2026.11.19.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:21:51 -0800 (PST)
Message-ID: <6afeb19f.4b6e150d.159faa.fc28@mx.google.com>
Date: Thu, 19 Nov 2026 00:21:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0685584616739160014=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: Fix advertising instance accesses without hdev->lock
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0685584616739160014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215537/

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      31.85 seconds
CheckAllWarning               PASS      35.19 seconds
CheckSparse                   PASS      38.30 seconds
BuildKernel32                 PASS      31.79 seconds
CheckKernelLLVM               PASS      33.26 seconds
TestRunnerSetup               PASS      758.96 seconds
TestRunner_l2cap-tester       PASS      14.93 seconds
TestRunner_iso-tester         PASS      15.04 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      89.31 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.59 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      31.75 seconds



https://github.com/bluez/bluetooth-next/pull/1155

---
Regards,
Linux Bluetooth


--===============0685584616739160014==--
