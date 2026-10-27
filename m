Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091710;
	b=at4olJzV+j5v+fqzKgSLl5h+q15vr8LLDUH9r0ZB55KiM9MW69JrJKUH9fWDmnOwtUTS
	 6nP5cFGbQRG9DmAHKUtiasYXgK5lbC4kjIdSKssmROOQwOv4BhvspoJdx+DJlN1EcOVwL
	 /mtQ5ihz2xaPa9lJe3aPiYKiFtfxrjgj2DofDZAmZucVzumep7I5pC2se11hMT8EWV6oL
	 WYYrRI9s1PgCgd6763SZ3KPdKMisgHv+lNdHzAbNOIiDSg49K/otuMTXGmZ2w5QSvlWUf
	 euxOO7tv938GFQgKyi8f4i08aeeMbnzb7q3bpLZ5rMTHRANfUngROXtHHxKu7ZjYdhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7gVwCx57p9veIKCfdgMrCMI/OnEh4Cv+1a9XESfHumA=;
	b=SON2Xgkt06+5GY/nOpc5cSEY1QXuhIkGBv74EifV2n661QXflj2oDA8KoWz/bVe4ydsM
	 scu2wo8kqRE0pUxWMWaxCmTwLrTNbMpeUqjEGziOdh8nyEr6iQtsFflbhc3/KXCTDFzW7
	 FCP4FetP3bZSKPXl4ErUx/sjhXMIrfX56KmJEwHgAL8o4oES2PHOhXmh3qSelAcLoLcCH
	 y4lTTn5KLSHbA5mKYzJfLa+uxR2NJGk5Xy0Y4MT7nf0OMtNyMTD6hlmt0KbO4qk2XMI8H
	 pe1VgJGGj7enb3RlqMaAyXNjQfNQRRQYc2L7Ggf6/7CbPzqLImcn8yjOxreBneXeCjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dxrv+9jx;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A5606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD3A5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dxrv+9jx
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91986c5cb75so39090106d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091709; x=1793696509; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7gVwCx57p9veIKCfdgMrCMI/OnEh4Cv+1a9XESfHumA=;
        b=dxrv+9jxsPCxb2emcZdVb4daLL3qWrySavEvUPR+WyZDkRY9Gz0KPnbACrsdeoyhei
         8tbIod/GyJ0MwCTVAF4vFX/pw31rlx98FpZSo+Fa4xHRA6stqkE9+sGONkwA0sbQhNu8
         JNL4cES94BAjTJI6MYaw0ahTAPqK5xG9JGuG4YqdQqFunur6Rcw64L6nR9BPMnbMCzG9
         2R5O+UWJj43bIBhfzzn4w5sCm9ACzdEycgNs27haA9bZ6QZTotHXeDd86RIg/etzv8kr
         1wqIypwexkYSyR0jIuUaRFZN0KS0TOyaCERQkWj6o4qyNV1CcMftCK2HR9m3l7fej/me
         sSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091709; x=1793696509;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7gVwCx57p9veIKCfdgMrCMI/OnEh4Cv+1a9XESfHumA=;
        b=PTRcpc8sQWG5xnEG5Y+oLspVJbWKLnndh8zeB2DtQHQsroAyomeb3qZ552uETEGcg5
         axsvf4WKlIfQdqMoCFQs9QE/EbDxyb8bda5ttCUIRsnfgJjnknPICX/PKE05B0lC3XW9
         n8/azzkRsYLCmYVh2I87SuUT+Rb0ZwZww/Z2eZcYLO4kP+WQjSBQugeEMG0bCqNghO7p
         kogmpovvnxqbzIfkCspC3bixvn2y5ieDOUK1pqWv4HALI7ghiZbVVhyaIRUo6ykd1z6J
         ucRil4QfjAva3ZLpXDJVi8Gqk+Yk40QiQJPIK4xpaR/K7nUWDDqoarXntnFh0K6TQnCN
         pXGQ==
X-Gm-Message-State: AFq9FYIDboK2r0Y1SU9V7srj/w1qUl1X1Wb+cGD4y5cC5eMabysK3McK
	+rOMXGJywhn3beRWu854KY+sbFPWXg7WnCiC1v8JeJDwfeT8jPYgIDC4wfw0+g==
X-Gm-Gg: AYBFou1HL5FKwUppvQpMZlgv0t/ycBHh/nt4et0DYNpR4dc+3lcFh/g07doQCABdNy0
	jO7vPgH07m4TXGq1bYvdbKsTikjC4rfux8mVMITExQpZOx5Px0pWYQCm0qS3gOINPnl4iRQW2uZ
	6cFv9YfgTUCrJ2/kVxDX+xWrTezIR3neOaHKbKSUq9As4rmRCAgrvDkXh+e2JyutyjaLXSRVPan
	3LQWaYLHUgj3VkGbY98GntMeKckb/7kdPdRxZYsqcIdiTGkeXk4vKXy+VQTS9IyvvKvU9oknem3
	Z65tq+uv0gCyQBiNQmMO3GZdowH7rqVVrqSJe15+3ELLX2HLdDjaZ/3s79+GQFXRuVtftMIMJiH
	HpofaUu+WEK6p3jr4A9M8rdG3SGOoP8qmegKJY8UJTWqLVNnwXZr+DJtZ0lsX9zGKd7AFmyILjR
	EJy+8kuXRZjlIXrzYrMrHPX31FiiQ5S00y+Acq9qDhaqIYbb4VdkFs7fqVdx6Hpa94FCpUM+A1W
	Kv2QxMOtZxYFcRN4IQ2g/HkhJMLgsIJsT3V1AnxZDR19y4D9rLQL+HuHYNL40o=
X-Received: by 2002:ad4:5764:0:b0:91b:9536:21c6 with SMTP id 6a1803df08f44-91c48e3e142mr158661046d6.9.1793091708640;
        Tue, 27 Oct 2026 02:01:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.207.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47ce49d9sm97612436d6.45.2026.10.27.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:01:42 -0700 (PDT)
Message-ID: <6ae06876.4c9ccf10.91305.2af0@mx.google.com>
Date: Tue, 27 Oct 2026 02:01:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3045059218621094630=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Fix NewMissedCalls reporting
In-Reply-To: <20261027071046.2272116-2-jinwang.li@oss.qualcomm.com>
References: <20261027071046.2272116-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3045059218621094630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194324/

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      1.23 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      305.86 seconds
CheckSmatch                   PASS      298.69 seconds
bluezmakeextell               PASS      95.71 seconds
TestFunctional                PASS      1129.11 seconds
IncrementalBuild              PASS      299.93 seconds
ScanBuild                     PASS      1142.38 seconds



https://github.com/bluez/bluez/pull/2719

---
Regards,
Linux Bluetooth


--===============3045059218621094630==--
