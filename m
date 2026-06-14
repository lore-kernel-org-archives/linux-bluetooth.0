Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20A3955F8
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448900; cv=none; b=o0rp0vC1ES5xTGV4BV41b03L7tJjo3aPtGJ1KR2dl8keG1O0Cw/ABdusT8EUjq7Cbh1iJS8PmzfAqVsYHH55dCxuUCV5g0q2vZDnIosnx54DrD4K25+MZ50MOLBj9HPvLfz6Mq+iP4XnYi/bC02Pwki5Pjd9K5es87jDuk09Bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448900; c=relaxed/simple;
	bh=RNtiE5wEaW9uf7nwfkKEo2NAM7CiZHiV355sypO+l6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lByCPeWzXEUu0cWNKyca/RF0iSYOYqzenpAOSUWLSGlquIP12ecr0ZuD0XZd5CHu72PGwJN1cGFHTCtFy/cLnT+RRgCxUHzAabxiVOt4TxCBn4YZ5NBxepA6aSU0YZuEqlF5DD1TIF2HmeJzd1J0PoVEVue72xWMD/9sgxOnTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpCuefPg; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpCuefPg"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304f590dd91so2808249eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781448898; x=1782053698; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Or/G/k0/8a6BKDEserbeeztyND/nEfk/nSFCFlZpVn4=;
        b=IpCuefPgZkeOcB74D7Guk6Lnk3LN0TYdoGx5ybR4eEG+gWMchwnSajwayryeCF6Vxs
         2wj+Rxg2eXANdDTBv3RllrMiFPFjxbdp6iMot8y6UTzRpIh+ivpiR0yx4qzRFeegeNh/
         KsRJvlDZpQNkvY/PBYTsC4yQ8l+HTJsza4vZGo0Og3reognU8QIfYMWYJjZaK73HderO
         +oMCHKf1jQOlUx7X7Cp5vGSPw9XfGrSp6JsnJMnKSoUA2FPyyBsvXdxgeJRGy5TRKpzq
         AWwnK2qYy7z+QL3uhKQCwd8Bf+PYLrvz0iFlSaEzA9WUkazOp1OhF4hTZWCKerPq4iV4
         PtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781448898; x=1782053698;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or/G/k0/8a6BKDEserbeeztyND/nEfk/nSFCFlZpVn4=;
        b=YNAZSiJF4q3V1RrioZFKGPfsCNbI71pJeB9X3ARx+pvrtc7AOuljFUF/nnMfGZC5ic
         EqYorDzZMWPRw+HMwZec3pbs1eFvyy3iZmP+6NtaeGyRe7K+z6VJ8AVN1OrbPZ+VKaMg
         ZbTGvOiTPm4FPSRw77akoxPIsoUnRBR1dzqSaDxp7wYBi/hPzCnkFGyB7UrKpv+FS/ev
         dQTvswMJ8xyBS5Y2lY98Cw9XqacdatsxfG/LLTi7KOEaSMat/tHT2Q/E2vzK9R9KytqI
         WlcKFovHg1v4OGRTnvyJymciA1nKr41zBW2Sfzt3eYOeU3AQQ7+07h2U4Fgrlfl+Vj+6
         FwAg==
X-Gm-Message-State: AOJu0YzMhOmQYsPtP0WylP5tkVcXrHhGGn8zA2PcMUeRHWhb+v0mz5oK
	Y1LFraAmojbhjtJRlTjMjw+v3MEsdHgdQPGQn4NSKvvsHdwGdcUI5WcS6/8FGQ==
X-Gm-Gg: Acq92OEiLLop1qTEvvU8CqAwi473RO1QCtyqx74iKcdNk0SOOZBRJFJKJ4lg/T5mN+R
	oY28NTY0/MjXgGKOP7ImswC+iLtLdHZujg+6Y3LcSABphf19vMs6kRLb5kleas+Zypb/lt2QzPk
	5WhvLXw2uumNMeFAWTKkIO6l0MTawf6v2yeKPHNhk3Fn1ociCgOmNeO+DIpk8Pd9jvFI7O0ynD+
	95fmEXUgH+dQUW0ZZ8H/pGmcwtnMZfyMExEmcGr/Mlkps1MzmJAlWlerDz2+vvhbKwQ/usbOSsw
	LFd6uJ6Vc+YRsskUTnfGMIz16fIhx9YPikU0N3mT14PSVJ0f7WIvlRA5TA2m9F30D2WGmiVtz0F
	oUJBuGH8rQIEevpgIOHACt2hNuG1Qr4m+mc3YF29CJIE62HYeo18LNoHnLuTTaAbIrBQgDYfU1/
	1carFx0UQ+IEZ/mMAXeFW6Gzeusr4ilIjrCQnLEew6
X-Received: by 2002:a05:7300:320f:b0:304:de94:1c2c with SMTP id 5a478bee46e88-308200c908cmr6047696eec.34.1781448898029;
        Sun, 14 Jun 2026 07:54:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.39.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm11593630eec.3.2026.06.14.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:54:57 -0700 (PDT)
Message-ID: <6a2ec0c1.4a342cbc.316e90.c3f9@mx.google.com>
Date: Sun, 14 Jun 2026 07:54:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7412414883148886672=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kirill.kz.902@gmail.com
Subject: RE: [RESEND] Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902
In-Reply-To: <20260614141258.1011-1-kirill.kz.902@gmail.com>
References: <20260614141258.1011-1-kirill.kz.902@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7412414883148886672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111290

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      15.77 seconds
CheckAllWarning               PASS      17.33 seconds
CheckSparse                   PASS      17.61 seconds
BuildKernel32                 PASS      15.26 seconds
TestRunnerSetup               PASS      314.57 seconds
IncrementalBuild              PASS      14.93 seconds



https://github.com/bluez/bluetooth-next/pull/315

---
Regards,
Linux Bluetooth


--===============7412414883148886672==--
