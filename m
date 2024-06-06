Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3174198E74
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697213; cv=none; b=BNNk1D5PTBQeH10m32MUeWsNT/Lp6+jdxNZaYZrs3r5oXMQ/jOK95KL1B+ircgnwuHk9wg4dZsnf8ztQ5umqTaAi4pKWKSM2aOI2uWR4/mH5qmc+16gm1z73eeDp4l+IFTXW/nuu4qTr+ni76rLOwcxnJD5Kz3ra3L7BpUY2XEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697213; c=relaxed/simple;
	bh=4PE6UFSfNfqEtKKp9w9Lz9hU55M94QxtFryp0CAadII=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TTAPHgITpIsKwDQfVCQER0fwkPRCnuWmLkkvAmb4TNJFf1SXirU9ygt9ZBqzFyAD4VW+6vU6N3DLRv51IxG/ukyXrEa2pVFn2fWO+qa/8Rb0Y7zoYPhhZnGAQVRpNS6btd6FCzBzw2BbRTVVt/LPExz9Dn9/umXw0r/ba0LkcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haEOAvvo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haEOAvvo"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7951cf70432so86264885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717697210; x=1718302010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T6+aK8R5mA1yq8kq6wkYtC1xrjzu9s6Gygu/PwFKB4A=;
        b=haEOAvvooKLegmUktmgkKfG+Op1Asru/7IlqTrWN6g0pC1ftDp+818sb7xVLiBcmWj
         7H1Al1dngh4k8XgHmZMJU8c4pPHkk63NW/AxHLWmuzHUvifBn226ROweDPtLabJ/uA0I
         KGwZsv/BD/2T/Y6RWdy2CCowrRNHGkuUi6l6mLA/PW0a4AZISRqSPn5eHr/ILMmv2AH9
         ATQTVKyFAlXiuUuURthGIhniJHf/LIpvw3NiyeWU+pT7nSnui30+LynCB6mNwou3i147
         2m2mnCjiNHA0W8xlL7daWgBY1GekzfDuEpBdlVpi8HAIBj6hc+7+gUMvT5rTSFjOaJW+
         +aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697210; x=1718302010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6+aK8R5mA1yq8kq6wkYtC1xrjzu9s6Gygu/PwFKB4A=;
        b=B9LM3276vliAdAX4y3vkVdGeumGxJ3T5lvhx/f48bjFdNAr/mAHSW0qv8ZB5JhbQkg
         4sldXddKeLPdaO/4Hz5WGsDh1pNv0PK18+PUBCFhjpPGFA1RpzmySky9a2MNrrjgsBnj
         HepFblF3HHdPGLcWLEX5O4tl0ofMZXYNCfSRetNF8ehOZfCdiq4c2/rB+0KIb+YXgxmO
         zAScBx/5Cf9Eiazd1Nf6sCz1idx/zNs4Y3EvffMY1FckiZx7lxBwl9ZE7LW/NmVT93Zl
         +grVZ5vOhv7KJ/yLWCFKEw8wIVtu2rGEBoF/KVUZcMjx72lxlyOmO80rf7JsJeprMIBn
         c5Sw==
X-Gm-Message-State: AOJu0Yw5one8MlHGlz0pvVWYjMY0FV7WoKqS8v0f8JavZ4JSBprnyobU
	2P4m3JKx7Pih0y75vUL0B09jeIxxxJHXqiGnoiC6O0OGXnncnFTVaTuSLw==
X-Google-Smtp-Source: AGHT+IFhCUX3nvmjaOUwIK3JJc4pxa8+lEfHFzRhuwk9YNdEnpjHTDLjoeaulaVBGdOz6D78IoSwbQ==
X-Received: by 2002:a05:620a:4090:b0:795:1c6a:686 with SMTP id af79cd13be357-7953c5e15f7mr12316785a.11.1717697210364;
        Thu, 06 Jun 2024 11:06:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.106.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332e7558sm81816485a.130.2024.06.06.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:06:50 -0700 (PDT)
Message-ID: <6661faba.050a0220.1e2df6.36d2@mx.google.com>
Date: Thu, 06 Jun 2024 11:06:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2047590016712980319=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] isotest: Fix ISO send data rate
In-Reply-To: <20240606162903.620906-1-luiz.dentz@gmail.com>
References: <20240606162903.620906-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2047590016712980319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859627

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.70 seconds
BluezMake                     PASS      1778.70 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      181.33 seconds
CheckValgrind                 PASS      255.58 seconds
CheckSmatch                   PASS      355.87 seconds
bluezmakeextell               PASS      120.02 seconds
IncrementalBuild              PASS      1481.70 seconds
ScanBuild                     PASS      1004.49 seconds



---
Regards,
Linux Bluetooth


--===============2047590016712980319==--
