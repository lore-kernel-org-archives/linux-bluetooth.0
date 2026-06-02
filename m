Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0ED33B6FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384122; cv=none; b=Y1rZXYx5dV9Le2iW6BcM9GXuGQ/gpFj5te4/lSXraMl8R7KHataUVDi6GR1vYhM6KaowayycKG/zgcnM+TxYD40ppzFCG3GEcATzhl0VvMNZNXAGQPGVLXOPDPGmWqHOeuD1Uyibm9cKa6aiV1Zs8NUGwZaHVnynATaxCxZxusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384122; c=relaxed/simple;
	bh=STEKT2qWNs6Aopqkh0yiHzihdy+himjzprOywyK7V/8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VTUc0nUmbZnWb2xzgQHpTvWxxWpYssUD1tn5ebs4mH49aoGhyk+l8eM6x5yMHVpp/PjRIT5KxyYoNdT45kf8FfILjTtkq485MjacNvnWn26p1yRe+qPpGQSD7OrNjafSb+pVcMaky71bY9HLFyfv1c3Ykp1bPn20pzeIYLGqeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw6FESNG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw6FESNG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517654b8e28so6688341cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780384120; x=1780988920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L83mjeqvznzmQSp9evtstlo3ssJRUQZ22CbnttOD7Cg=;
        b=Xw6FESNGybROqVm4qiNkc5Z5MWC9lTkrbHvMsnCSWgQFA1Gs9JeyPz9DYMaYiW6p/d
         K0de5g8nAsgT4AKBx24wZGTSG2Q+lMpLEVX/XaEDrSCY/7she556NxqLSseRfkrQp6Xt
         QiHgLnxKnSFXsKbUiAuQLeGKERDIElzPoWJZdvtsVJ/IfIB3jpSzLUNcyK4pXZLpqkO9
         5Vk0BTyDcWud/jDAv+24T1OwQHff2iHBF8yruIVWFqrIW5FQSzStN0rh0ZVjZkP1oUuT
         hoRDuqXE3BJN/+FcDA33JFJJL3snSHiO8A+5yWQhp+rckhEJRBMIE8r10kBRGoxczLPW
         c0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384120; x=1780988920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L83mjeqvznzmQSp9evtstlo3ssJRUQZ22CbnttOD7Cg=;
        b=V6E2W+IV2CQs7uWs8C8GUVatZVnirttLJdDPJZefYz8C0N8pMbIsyIEuat0A7++wlC
         m9EicI70q8jIprfDuRviBp++QCAr/lh6Zec0DOCSYiB4pkM/DqNebT21b3HDDGdI0NRF
         hSsfVzejpgXeG4TySr3beqDAz415cB0H304B+DBMtkARetxwWNz6v8xhMQU0/5YUCmIO
         PUhJZjwnO/pp6BB84+eJ04DTvGZC12ZFzqXS1uBM46p7GpBhdEsNkBiP71GTm4sxn6R/
         el2jwnm3+Y4To/KNcnj1jGsnhiqN4ZeSag1hL8QaaxgbYZdg+QKI8D7QyMVUzuvjATgM
         hgFA==
X-Gm-Message-State: AOJu0YwIG2qJgR8593gusRMzBi0G1htpS4VCXAgWeXaBStWtfQnoeNCh
	xgaDUbfQt8SSO1tj0InhXMlyi7gMSEwjJDEQIUeaSrVMJ9Auq3y3VaZOD+mPLQ==
X-Gm-Gg: Acq92OEKjn6pfsPlKwy9u3yAuofwhVJ5DZkzCMXyquyOV37Rm3GtNmIgFtOVGYVfbQU
	h4EJ6qK3zcQJUR2y4l3hvp5g4DU/V1YHPY12sddRGcDC84DAAMzMqEGbsIY1AXIUMlTDmftpNUP
	YULqOAtupvoV6/dtnv9LqA0rWJ5SC250YR151Ia33ETB5WWqW+AZxwr+sjPNioNa+sw7zJRccek
	Q5Lj+vQ8hsv6vB9VLzc6LbR3uX55F54MHIOizv9BQjGqUyQQWnYYUggFKnY9hgZvfyjFqvOh+Tl
	FHFag4zAcPnEQTR9iqRfyojaTuGrOMlLBcspS2MBY/LFAyK58TVA2KR8mlOVbXN6S2hREnXvAk8
	YRsI9P4EwRMPZiNyBEYFWNlq/R9ryThD/ga/7XJHRqH+DbwpTDL7kV6KWCmqsZfYx3/P1db0tzY
	H3wF/MjvswccQ524nqfJJR7xYO52Lq+DHnSquVqfP6eSs=
X-Received: by 2002:a05:622a:1e91:b0:510:1b61:d103 with SMTP id d75a77b69052e-5173a7d90b1mr209073531cf.36.1780384120336;
        Tue, 02 Jun 2026 00:08:40 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2587a5sm119906666d6.46.2026.06.02.00.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:08:39 -0700 (PDT)
Message-ID: <6a1e8177.50eb26ae.197720.b0fc@mx.google.com>
Date: Tue, 02 Jun 2026 00:08:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5647446727858945994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: [v2] profile: Set L2CAP IMTU for external profile listeners
In-Reply-To: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
References: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5647446727858945994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104327

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      1.32 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      666.26 seconds
CheckSmatch                   PASS      365.80 seconds
bluezmakeextell               PASS      187.14 seconds
IncrementalBuild              PASS      659.47 seconds
ScanBuild                     PASS      1050.72 seconds



https://github.com/bluez/bluez/pull/2164

---
Regards,
Linux Bluetooth


--===============5647446727858945994==--
