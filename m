Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080548;
	b=YF6Y7NnEdOf9l3oVzm0ZlglMv6AxG3Cx/mcEh8DyEpA6AhMtiMkTa4wmjVDKFoSF77uW
	 C/7Zk4GMGaiTxQXIPWQQvcBVQ0PdWOTle2MI4vw8MRNau2SGbrsPE+SfUjij68ISkTJtn
	 mafWQJQwYqN0JzQMUL0ULc/Y+AH1lXX55IzTLZ1Q1pJsIzRiIhKYtnWMdSo1aUxXEkJVg
	 2kISgnh9n6Sh85dcESW8n0er5O9kFhvFGH2fRHiiomzqrmwAaMK3MCXEvE5si3UmrW0id
	 vlLhJXXxsE0D0OoiEkkOuBihL3uiP/taYdVUn4nCxnbsdFyP1N4mvSCDfoBsTX0wosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BtHQcbkM+z9oGCFqo6HuC/o7ZDSES3OUq4P8Tqs24ns=;
	b=NEfuHTXHXcNi09tdVacd0BzgLb0I/ke6rsvAhJBuD6PTpyFBoc/if9codp4iz8/KMMI/
	 +MLLe7TWQfopi/esMhJXP7QMla42hYY9snffxyZN+iMbBH3c7V4NSe1LRYqCjfpBq3N1/
	 bz/9aAhUIV5qEK0N8OYi/MHFlOWspj1NMItuGpn3rQxipwfGQZAWzoqn3hgnSUskMzse+
	 spkeYRkKqbgLcGuDvh0e7J0EQ//RbPXnIQ5NDlkHqUtjidncVhzTf7SRK4tTlCaPAxbvs
	 wQICweGEhj20mg8bLMtzclOT/4NDfyFBtngenigmF6ONhLnnZiEQPq8dzi6buYRN/mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDx7zgMa;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26ED606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B26ED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDx7zgMa
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9496473b511so99185885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795080546; x=1795685346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BtHQcbkM+z9oGCFqo6HuC/o7ZDSES3OUq4P8Tqs24ns=;
        b=EDx7zgMakSTIcd5Z6Ok4V/czwZ7s+jjAIBycLyHf1kRTVA4LdTeqmlKVCg3+GD+id8
         330M/TchMk1K+npv9bjiHf+ud0LKAs0oOA8R41S6fa1gHXMXJtPyt6XQbbmffyOCBmuH
         1A9pdHHYlf7Fp06KoyHGK0NLaJcwNe8CVJzWmjjLMzR4jh8kLBZPHWPFvyJSaV0M5KvB
         5D75h0P6LjeKOi+3gsHG3EKq/ijSEktHPmTM1TnRZ5iPRCmggLmTNqFRlae1P/ShkW/p
         792OYP/a3yG5AU65VQtpa52bIFOY/Zs392SvcWUJws9dvQ/hkxDTuakRdpnqscUM3hSd
         TTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795080546; x=1795685346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BtHQcbkM+z9oGCFqo6HuC/o7ZDSES3OUq4P8Tqs24ns=;
        b=dcHvoA1OgI2V28D2csG3wTQqmDNlOFsr5ynbOXD9Ygz6jw8CLFA7dZe3Nh9Rr1vkAg
         iJsNGKsBzKFuOYAQgoda/y70SeGiaXyu2SrTCbOsI7AJoPBKsM8qBYV1CbU+e14OBni6
         6FAcsajQPT66yb9BBfYOXYVVjR8hhZDdVnjQcKR4ply8xcqW2sLkXmtF7RX64eRVcNi9
         I/HeHI09kwj1tnVaLLaMw14yOPH1FpkYg8g2NsMSVb1wZQC673MgjArGWtCWcGRSTLaK
         2+lepfQSPT+nrm/BFZF3s/qj5cWG2X7eAIhb10yil7n4/eATyxX9zY4e8OWeKiM75AI1
         GRGw==
X-Gm-Message-State: APuU4Z+8fbCU9bozVTXqr45hvROipE05ct8PLSHhyJvPQI6x6FicXOQn
	upfG0rp+9cHCgKz4+FWzFG8M6wBeVcTSgc1GU0IBqxObMvJYoSeyWvr1K5V1Xg==
X-Gm-Gg: AYBFou2YR73OumX/Cpfhgyc4Qd6yHProhdu10W6MhNmF+s9kmK0gkOUytDNM9H9dZKn
	zZDC/4OoETi/WbFpR4kBMc/L9iaANwjLH5AfgwH0658rn+Ye8pPp37ftCg2xJQ8cIgq9XRGOU8G
	mra25qOoigXfBT+K3pBmMKnrCNTyzP7PKsJMBlXGlFVswPrztLCn61aYEunoDDk034oeo5c3pDO
	SG3lMCSYeMeML7oy1TWmWMeG8LVRBpO4g63jaN+5IzY0JkBKK/zOIam27j3uveqMsEYY+8A/QKm
	7JNhAmLWllSyIze0ckVT/VJmsmDoKlxvdoQOvzAMDGDxlzwwxrNqojvkitkfblKvheYh7c0iUMq
	Jdwy+HQXCBOxIPU+tLNtiBjCg/nLD47v7MYn4dN5BjBFpbb0DPeWXz8Jb0rb8PjBUVAYIwRoi/m
	bn2vxC6jH8dM1MMu80q0oz3poAFH3mV0S3l9yuRNJoZ/VNUfrq2oRnvAoDXAmhOulEu/e/EP9xc
	snRnQZO1jbtrKX2fTcV8fwnSm2nSRrZ+ZjeM2HNAH8lyRW7E5zvRn/7UHqsq7ILuo+MQQaLVqNk
	Jrz1KsUykltTk4HwKICcOx2y2jDo
X-Received: by 2002:a05:620a:130d:b0:93e:7156:f814 with SMTP id af79cd13be357-949b340aaeemr73027285a.11.1795080546538;
        Thu, 19 Nov 2026 01:29:06 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-69.compute-1.amazonaws.com. [3.41.210.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7ad72csm400690085a.29.2026.11.19.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:29:05 -0800 (PST)
Message-ID: <6afec161.82798886.1918a4.d948@mx.google.com>
Date: Thu, 19 Nov 2026 01:29:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2549525558291423882=="
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
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [BlueZ] shared/ad: Return NULL instead of false in bt_ad_has_data
In-Reply-To: <20261119065641.2510361-1-apusaka@google.com>
References: <20261119065641.2510361-1-apusaka@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2549525558291423882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215766/

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      14.12 seconds
BluezMake                     PASS      208.35 seconds
CheckSmatch                   PASS      185.82 seconds
bluezmakeextell               PASS      67.33 seconds
TestFunctional                FAIL      957.68 seconds
IncrementalBuild              PASS      209.37 seconds
ScanBuild                     PASS      709.73 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2847

---
Regards,
Linux Bluetooth


--===============2549525558291423882==--
