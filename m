Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D915217F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913229; cv=none; b=mHG2uQPd/R7CYx8fgt13JoohYRK7UEtr85nOD55saL+SKAQ1bPdv7b4/glAfiecTWUXgfC0NM/PZAEQPzVg1oaoM/NdeR9RgjwaPwT1TpJVINfx+5YBJeP6ExG6SQRazDZoTit1uKLuEgLr5U5+D2r4hjXiIEaepDzbBog/0DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913229; c=relaxed/simple;
	bh=ISJydkgrqEJMLH7ABxezLPWUUeHaUCW8vQSRx9Qb+vQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rO+ipJk7OAsLaoA9q3COb+nUOnBw9FXlztf+YmpRpcpSc5XH/mlSkl/vSmLHXauKPQ63DeDkKxs7mMhUIskV1Td/+laxKD67tP7vHjAny1l8KHYkXDzq+VSqoeaumgRkAd6uJjgY4r23ynGXfolb+aWce8mUweBj3XnfuRjoonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNS56DXO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNS56DXO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79c084adaf4so280048085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719913227; x=1720518027; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Db/hkEN/L9pWNcjnNUFIZK2EfjYgTFAbFdoPc+965RE=;
        b=CNS56DXO9uUtEovprtwYXrLriP1ClkOEXMesOb8HDDuUiPqqMNtQk61bJU75FPxBxc
         inwAJdnwB0/my/BTuexI918L0AzBYmRDZZV+DWjcNELDufSc1R0AnwR1FhLQEBkR+S/D
         feeQ4SyKvDP3Knyui3M5JLvhdu3yHz5qGZM4jLqVs85+rycwGCl79uh/xQkXU8w1cH4b
         OSIE6NLOi3RXq2nn11gGYdsXcxPwZsRiPB2xqC9lbAnVqTCG6xLetOe2ds5+DvqCzuSa
         qi3CIkjHeAeZVAc7LCmFPyN4Tvw+Yrz1wzemEWo3zMMJ3nAyBmnJAhrACvB0+E37sziv
         aUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913227; x=1720518027;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db/hkEN/L9pWNcjnNUFIZK2EfjYgTFAbFdoPc+965RE=;
        b=od/XxTBAE7CuXRc4WNlFbap0KWfIEeeXTmv1ILVtBjrf89sM/8mK/jp2YgLMw10ylm
         7o49PNvvqxG8P//JtchZ9bQ99FmL0yfEQ5FBnuScWY5j5KwxL+CZaiXOEj3J6yEk2oC2
         xQ/ViEy/9knghqDPJ3ZPgC9dKVEsbGZi8m5my12HC1uMsknXQJLOWTjrku/a0pkjb/u5
         L5jWwph20+WkG+Kfd4CFc3J62iFh6BFunZhSA/nA77rvePCo1RcGVdx8zbpO+tGqtuGa
         YF8yoxRFNrh2irxXZX7YDQ541ORz2mK2d8YFofYeXTPmrg1VPURY81D+4RVpvInq5zat
         98Fg==
X-Gm-Message-State: AOJu0YzFwZptH2AaDCA/BGIG6KECR3u+aUykpFQ+XVCPwvm363UCBaHW
	MNnn8CJ/Ev++hgD8xepjQ61CuqpujLdWZE+OtfoxJTQWiFeEtGQ7vc9oFA==
X-Google-Smtp-Source: AGHT+IEipsewMyPc2rUgqG7XXolulG/RcRcx6kbTDLRaqGnqqvljZ4SI/QivETJrpmDkSnoyx36dHg==
X-Received: by 2002:a05:620a:4611:b0:79d:70b8:98ee with SMTP id af79cd13be357-79d7ba5fef7mr936062985a.34.1719913226857;
        Tue, 02 Jul 2024 02:40:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d88a192f8sm221352185a.68.2024.07.02.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:40:26 -0700 (PDT)
Message-ID: <6683cb0a.050a0220.74c3e.6eb2@mx.google.com>
Date: Tue, 02 Jul 2024 02:40:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7361167847320524624=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/csip: add NULL check to foreach_csis_service()
In-Reply-To: <20240702080132.16169-1-r.smirnov@omp.ru>
References: <20240702080132.16169-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7361167847320524624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867433

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.46 seconds
BluezMake                     PASS      1564.46 seconds
MakeCheck                     PASS      16.61 seconds
MakeDistcheck                 PASS      176.76 seconds
CheckValgrind                 PASS      252.55 seconds
CheckSmatch                   PASS      352.90 seconds
bluezmakeextell               PASS      120.30 seconds
IncrementalBuild              PASS      1377.09 seconds
ScanBuild                     PASS      998.68 seconds



---
Regards,
Linux Bluetooth


--===============7361167847320524624==--
