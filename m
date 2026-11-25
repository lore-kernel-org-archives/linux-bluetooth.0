Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608484;
	b=Dmob6Ux7n8BWTsMtDVedE4nNd8gLcnd+w3OJegBHLXw3JgaS7/RG91ybdUO6d+KBErBE
	 gjLE2bdttJWoIkVCT9snbjZiBmfjcbqgylAFErlj8GfnZ+ygVy5fCNxiZNVCMDpgY0OHQ
	 jKwGcYLxn/F2mAAJuN1LX/LQOr5UDuHuM1zMddzWEwX870P6YE8VXHR90OST978jIBYe3
	 kIwkmcwxH5tJjnC/TqpGKl0K+7F6qbmn66Z1ud3H/5E0klJmPWDYoa4xNdZsttTE4lfmt
	 POcivsbBUrArQBgliby3K3iwdwhOtktDuFaiY4KhnoJyakHjW4OjXoH4e1rst/CtvHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=IJEya+C6da+0T0n1Hy07xIYW1Aw8Ul00YAvhNc/KtLg=;
	b=EUuSc2mv9F5V//8hSapDE5RX9TScktK1eRSY5QAX1rZbNnBWv1RJ8WfzFYDpwI4ip93g
	 2+9Lc/7DYa5zlD7QNo3tQfRGqU5VsgeEg7UYvktu3fNh8il0mRQQ2mfYELbDPnTStBujG
	 E2bj6GgFiJOK0g5NXucIRv7xiOomvhjpmoXEbmeb6JnV4+XuL296eo+zuqwJii4agmamS
	 ecWKnL5mdTnS1zumKpn7o04C6t0gv95nuqTEHn+cmQla1SViUGJQ6w3NjQKeNVU6MA6NC
	 /Vf67COQ6QllM3OYBtM7zWEfei5BmrPNKUArtyDE+rAPAH0w9sCaP9T0ReeFs2fLYtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTYw+nX;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67709606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 12:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67709606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTYw+nX
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-717080a2d50so5277075eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608483; x=1796213283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IJEya+C6da+0T0n1Hy07xIYW1Aw8Ul00YAvhNc/KtLg=;
        b=PTTYw+nXTeRaw0SraSTCXo1UqixxpMTB1zJM1OQLPdtag/jJWiwYh53EQSM16s5yKL
         NM2VYL03YD17Tezjymy1D6wXx435PEaswl6YaR1Xf5ovdmt8R9k8+olXtISfQl1rJOnu
         Asc73eHlBjro+UIPu1agBWScu2fOcMCMBLrF2pdHCMT7Dmb9VWWFdgQll1syOZYetRYf
         0j/hTg/yb7UBUbPD7FS7DVVqDcKQsXpMCJWtuc2tjqGxRxoR4M3ZQRCr3NpfeX1iz+5Z
         4SXPt7u9en46bHYKquPLDx5+1CkapxxAHqwY4WYFeWAoaC+GKnKt07pv1xkYC/Wcskhn
         opqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608483; x=1796213283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IJEya+C6da+0T0n1Hy07xIYW1Aw8Ul00YAvhNc/KtLg=;
        b=bNrwTj8tK6/bXVGdcuA2vEGGFjLVrPwEaEnAZYlfqe16LH3CQY+W6M2cXMUf8NAavH
         3LYPxaS9UPec4DiS6IZ6wWkhQbW3NQo1xFJzmdhhch5tLbnrzGK4Rkw2zOd9McAZnhoZ
         MwJeRZie7ZiHAYUxF9ywjodlKiNoNfnJUjKTsEXFVWHZzDlEeV6lnRwtCZR6j6qAD2qc
         xq5cJJMeu4Wa1batcnhWXp2S9EwtdgEmQ1xsy1QZyamZuWIytvHHv4pgoHOpekc9Cdne
         oME7AkuxQLpYoy+m9yR6/p5uyzjHujlWqybmG+Fg6ZesIi84b5f3WXqZSlv7rs98eKlU
         Xdiw==
X-Gm-Message-State: APuU4Z80l+slmqpjSIvQbxrDpzPuB0h/IqZOLG6RvioNWFhyuNeYh9lC
	GyAv8ywZjiO2dnYMdkuHhHGEhuukOQsOnjiiiGHN0IrsGQPaVnFG9OaVjsozTBCk
X-Gm-Gg: AZFdTZdZeL8ZBJ0WqSt/JjEEd/iBkqKoY1npfQDzLE0IPwuSdVKoG3YvZmnld3umU0Y
	IxgNKd9F/za6/zPm6WcXBm82dfqJSaAOoqMpijNhEl729UOEAUyzgAFAfXotFrfscdGZK0kkxjF
	4cjADkMg+R6SYbhiO1jrOrJhWoOFYKkNwZiA6GBlyGGn5llRGUESGQv7G6BP2u7BNcr967NQBLF
	PL2XCCFXqrbve7B1112B8wOkPfgkISvEQcOCmz2d6ub61SUlwRifhLYHOT/O0KddbSBZjtuLh6w
	DozS1+j5M799LZtu+v8YeNblBHOUZWWDq6eMccoRumGtYEtG0Ln1ApDzk90N41O6+PJ+pVfWAap
	uvD9c/1eDU9tEuRfHgTxRAjlvaL8OORvlS7MNhRFLPt/ZXU7SDZ3grnD3liY2EjMKobeYykaVEu
	xS5bTI+NXfbBda9jBJAf3LOTsCxqvRp75pB6eOYnJjj+LaDAakNcj69kxc2+BZj3j5JA5N7wez/
	PEyN58WfHGKDMvWciEokMZDaOyKpcPgxnCiBGWl3vAYt49B7dsMfusJs3x9OHqiyg==
X-Received: by 2002:a05:6214:490:b0:91c:6c93:4482 with SMTP id 6a1803df08f44-92134a5132cmr323347966d6.23.1795608017785;
        Wed, 25 Nov 2026 04:00:17 -0800 (PST)
Received: from [172.17.0.2] ([172.208.101.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bfe82dsm158608946d6.0.2026.11.25.04.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:00:17 -0800 (PST)
Message-ID: <6b06cdd1.2a8138a3.4b484.6e05@mx.google.com>
Date: Wed, 25 Nov 2026 04:00:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2889738573114415824=="
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
To: linux-bluetooth@vger.kernel.org, rdunlap@infradead.org
Subject: RE: docs: ioctl-number: update entries
In-Reply-To: <20261125061340.3402300-2-rdunlap@infradead.org>
References: <20261125061340.3402300-2-rdunlap@infradead.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2889738573114415824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221643/

---Test result---

Test Summary:
CheckPatch                    PASS      8.20 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      4.04 seconds
SubjectPrefix                 FAIL      1.46 seconds
BuildKernel                   PASS      31.67 seconds
CheckAllWarning               PASS      35.57 seconds
CheckSparse                   PASS      38.94 seconds
BuildKernel32                 PASS      30.49 seconds
CheckKernelLLVM               PASS      32.68 seconds
TestRunnerSetup               PASS      754.23 seconds
TestRunner_l2cap-tester       PASS      14.81 seconds
TestRunner_iso-tester         PASS      17.19 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      89.46 seconds
TestRunner_rfcomm-tester      PASS      4.54 seconds
TestRunner_sco-tester         PASS      5.67 seconds
TestRunner_ioctl-tester       PASS      4.76 seconds
TestRunner_mesh-tester        PASS      4.56 seconds
TestRunner_smp-tester         PASS      4.43 seconds
TestRunner_userchan-tester    PASS      3.27 seconds
TestRunner_6lowpan-tester     PASS      4.50 seconds
IncrementalBuild              PASS      41.75 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1222

---
Regards,
Linux Bluetooth


--===============2889738573114415824==--
