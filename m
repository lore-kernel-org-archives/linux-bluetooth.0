Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778093;
	b=Pj023+GYCrwmw8QHdC810+9heMgrw5kk2lGI9kIAGKt+OvFUMQqZDETQXCCFOhFkXlFr
	 6VG0a17sKkHm6ACqreZkj9itTSpbtmWkg4zs9kB3obLk2dCmyacjSCNrrnWUrZCDxfeLr
	 RBTl+LaTfVVtAzzslgRYRYwkaQQTj+ohSp4DtYmyqJfMFrpoyO2qrWBGRU6cRDR1gZHp/
	 nQIDq7gE5ShVAi/5pH29oCtUMZrjIsOzObwx9AIrxDsdlcrmRhEa0hCN6/o0hNpCKzvH2
	 fmrVcW9y8TwokVtojaoz72cwxj4WR4brf7moqwb5aI40aXRbcEhS3lun0EqUS76cTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=E7Rg6iRZLSh8t7ZTRyMXszb9WrFxr3fe0fJRFHMDG28=;
	b=MT9fec8J8tEyQmm9zH4WbmjZp9VHMiKrRcMdjgcyOVfv2fy6Yd07nobgq1Rpr0t0yREp
	 hRStgpEX6my09LmE0yaa2dJj9rUpcHT7GEghuaoPnrAYW2lFC3rcuBC8TTnNUb2Ux9C99
	 8JzsSmOy0k2fYwCVE+ydOAoeHZofQW4USw41xhQUvQxB62tVpR2DCUMnUs5bz4+HT9rSF
	 vuSfb0sRzRi+GVCoQ2JOzROq1UGwIZGyrTeuOkQas7bqyDPOT3en/Ssg7XJ6v9DBorrp1
	 fl+56wJzliEepDpxC+czqOi33Zk+JgHaSeGrvFrD4MdKdI0WOOd4wV9ZQpgL7RbkXKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cAnflYKg;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA6606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 17:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABA6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cAnflYKg
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-353804b591eso1948851eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778092; x=1793382892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E7Rg6iRZLSh8t7ZTRyMXszb9WrFxr3fe0fJRFHMDG28=;
        b=cAnflYKgkpPmqZuhrWMOcZ7AHcWSLqyeaMnqJntZ4FQaI+UYWEQxt7v/ZW0tg2Gjm+
         YLrHBBrAPhb30ryq5G+qhTCMCjcqAJfeF0NAqT80PgOCn5B1ALGlhx36rFndxJ7PzBOt
         SUQhvaVrxOKrnkDAw0LZV4yY8Ek0i5ESpIY5LXvO326ZQ0GrupKX5+g72Tl3mII5rOaJ
         UXm+ivnoV0wY7bOaD5EXjWLGcYmwIAG4M2qucg1z1lRYBxBs1ir8+Ea5JAErIgFVfFj9
         JOmO/k9bqZkOsZhMoEaapqSUGxBIfSDYIaPXvWNcrdo/yo/aMyof3tMU84rFkc3Bxyyf
         fj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778092; x=1793382892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7Rg6iRZLSh8t7ZTRyMXszb9WrFxr3fe0fJRFHMDG28=;
        b=GWp8HwBEpKKld37PbQTF92XMO8KNSDlVBBgKTrzyQa3wsR097kzB09OW3mtB6eVNqY
         YOGjaMxiEB5C/++w36F88cN4XXTxalZvwwj3v3V4GOPXQaW3Lq7sE2V+SgyaqRWtg478
         ekTeeSn4isF9dmEwolNWTphQtiU2YhtsdYK2YeOa0j6gPcqWpjhxh5KX7knllWpbvhHl
         Vyqf2amjT6qqvjw5j8D0IbtDpOC04H9CF9iWC8iBBHN9VTBnNlwhHEknukFSGKJnEv1M
         quWs/4pO0jxHUzxMzuiwL7xpuOg+tFR518KGAoLf6ZWlt8M4SMf+ZPFVCBeZ8e5VMv+L
         e62A==
X-Gm-Message-State: AFq9FYI2qgdZorvMIfjSfO+yOL1NVNvWb+l6VTInbw1mkeb1Orc/Z9e3
	lvdNVGO+fgP78OgGjqGpum8nPz7n+hTiywfus0zDNe4rZtynIHD3gYARwjIjOA==
X-Gm-Gg: AYBFou28x2jiAFTHVZwqTHQNXKJGEaRq7Zt58MOBLlM1UwbwST3+pCN/8XYxXinzBZ2
	mH3/AdZMDIBKiGEuJNYw7gjwOl8GWeO2NV43vGWBZWES5DCLDJq+wHjQqehWBGFrrJF3h7ofFIl
	d90CIzpfN/gixTytYVuGArTtpsymTuHrr6BCXIqp0FGP9q8tdahYRAaTRm5EiuCj/pgf03VFymS
	G4qcMoFd1/lKA5uytMc0NAUVmohoJt9fkTdndRBJ6CruEihDSSGtfPLPTVIGl0S/x9p28bgvKec
	yvtl2BiN1MYlq9wzogcZFNbJzwV1W1Ss+EKRYGLsuK8AA+Ya5srONbjz35cfvafZKOJxun3dtVj
	QFE2bKm3j61+t9Y1zlfrL5P4fhaO3uRalG6YLaE74fEsqKgryXTOJQc+hhOe4Gro8fzOIbPAKoj
	pmF2coo/ueT1gwWmnCC3yix41GEbA1psiu/BYmj9eDMiVTuOHqoyhgptBUW1nE5qq2YOaiK/+5V
	yN/x/03ffbB9XZ8FYdPvSb+G+xp0LjiYcCsLhnr42KQX6e+34zaEeEPbIRY
X-Received: by 2002:a05:7301:640c:b0:369:a162:af96 with SMTP id 5a478bee46e88-369e849ec9emr96551eec.17.1792778092182;
        Fri, 23 Oct 2026 10:54:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.81.6.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e6c7d478sm1805715eec.2.2026.10.23.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:54:51 -0700 (PDT)
Message-ID: <6adb9f6b.99020481.3dc02a.a330@mx.google.com>
Date: Fri, 23 Oct 2026 10:54:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1575309466656463539=="
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
To: linux-bluetooth@vger.kernel.org, weihong.guan@gmail.com
Subject: RE: Bluetooth: hci_sync: Use the advertising set handle, not the instance
In-Reply-To: <20261023132421.1889022-1-weihong.guan@gmail.com>
References: <20261023132421.1889022-1-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1575309466656463539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192157/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      1.15 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.22 seconds
CheckAllWarning               PASS      33.94 seconds
CheckSparse                   PASS      36.52 seconds
BuildKernel32                 PASS      30.53 seconds
CheckKernelLLVM               PASS      35.05 seconds
TestRunnerSetup               PASS      705.10 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
TestRunner_iso-tester         PASS      10.63 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      87.37 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      5.54 seconds
TestRunner_ioctl-tester       PASS      4.61 seconds
TestRunner_mesh-tester        PASS      5.46 seconds
TestRunner_smp-tester         PASS      4.30 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      10.85 seconds
IncrementalBuild              PASS      27.78 seconds



https://github.com/bluez/bluetooth-next/pull/988

---
Regards,
Linux Bluetooth


--===============1575309466656463539==--
