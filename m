Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FF15ECE1
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921564; cv=none; b=qc+WOvw3/xpLCHz1ZpERWPGhHaTFeM4vdSsaJ4dIJzzS7NCnmzV50I+TMokM/VohZ3AfqLmwg0JhMsSlYjh5+2zWXEDET6rewpUAhXRbfNxJCbwrZneoukNO1yc6jpLlO6QwB69zNs0hJRKBRNLSQXZhHaxMIuucZI4WOzeOEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921564; c=relaxed/simple;
	bh=8tEBYtiBh4D6k3sZ0ADs4S7TxvNQ3BbGOUhZPSrafdI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ELeYrGTFNMM+5PP/ZIr9L8LUcIfGYQtBCPqoGs8w8KQYmxX64IIbG4wqQr8vvJCZABfUwRBcYtGdULeSYDfVIUjcq++NyhSzGg8e1jf33hC3Mph9voo4uv4WA3s4B6A0cbI5isOTitZppIzh5qgRVtWsuwkoQe4bHx0rjtZsvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY0xA+G+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY0xA+G+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d566b147ffso2646624b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719921561; x=1720526361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NqzcB2T4xuqoFIfP6KVBvI2gG+ZrlvcUgB42vKxhdCY=;
        b=BY0xA+G+Jcg9YGHS5JWcUi7xRlHwfpAyumEidurdJ5etq8RQ1OmqEkrK6jYPwJKpAd
         SZRoHI08aTtqJkrjb/CDm3YQ+ESCmcb4eQI2jifZvKpNGSm/T5qJfeU09S0BpKZHYt86
         IxYWTYIw170Oy8/xlQMZdsAm0Cr10E2+JesxOz4l4mY3Oz/8AQO+qDMRlwQBsrE29mXH
         aRhzTVFRADSWFoJe5MFZaoYtlcA0fOrX9K81IIVamvAHMAT2S5V2i5UT3BU0fjUPQRil
         l+dbUo4USqDJ0vBWo1CBCJ7IcONf21mWiw7RTbjfLdHlKweUOwzQLjEzBSyp8iNKrmD5
         KwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921561; x=1720526361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqzcB2T4xuqoFIfP6KVBvI2gG+ZrlvcUgB42vKxhdCY=;
        b=vk/IPXSH1xV5RqNNbnZ2uBULLpje7gY5Zc4cbHMVwLPrv8iHLAglroytQPrAsNhbTO
         MGg2TQ3o5qLOcPAqpgLhoQ79PV40uVMM1BFfyO01YkoLQPOE/W7kntJjfN1YsbtlVUiV
         HAMMtiq4ga745dq0z/7UVIHUUtdGRQ4VF8YAqdyjTRpz7kCZ9lIJjYRS92RusyFu8kY6
         derToNSSWktWNlc9j5I6/4VCEikH17B70b0jFOvH9WaWJNh8GvXYhKafvN5fc7mXtvvH
         3oM3nursEee9vY2TZXVtDYZKke+h4/c7e8xS1//9MhISOC4jMZ8bO3mCV+bt0oPmDES3
         A9vA==
X-Gm-Message-State: AOJu0Ywabs8oCC+UxNJiBKvC/UJdCPiAcc/MugYmMf6/k7V/azHZ4Ffc
	bVcxXkcr/wQhLhU5XrZZnNevyDkSWSVAR6hDYB9/Ctmnaiisvu80w/Pweg==
X-Google-Smtp-Source: AGHT+IFZgL8tWHgdAW3zZHQCvt8jhTP00S+nus9OfcL0xffDDJ1Q2YAwzSRKUgzne14ofh+HFyrFeQ==
X-Received: by 2002:a05:6808:190f:b0:3d2:1888:94a7 with SMTP id 5614622812f47-3d6b30f56d6mr12235602b6e.21.1719921561631;
        Tue, 02 Jul 2024 04:59:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfbdesm8301633b3a.105.2024.07.02.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:59:21 -0700 (PDT)
Message-ID: <6683eb99.050a0220.62920.bc9a@mx.google.com>
Date: Tue, 02 Jul 2024 04:59:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4577994002070503417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: MediaTek ISO data transmission support
In-Reply-To: <20240702113051.24372-2-chris.lu@mediatek.com>
References: <20240702113051.24372-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4577994002070503417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867501

---Test result---

Test Summary:
CheckPatch                    PASS      7.13 seconds
GitLint                       PASS      1.75 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      36.90 seconds
CheckSparse                   PASS      39.34 seconds
CheckSmatch                   PASS      104.09 seconds
BuildKernel32                 PASS      29.02 seconds
TestRunnerSetup               PASS      523.28 seconds
TestRunner_l2cap-tester       PASS      23.94 seconds
TestRunner_iso-tester         PASS      28.98 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      114.42 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      17.15 seconds
TestRunner_ioctl-tester       PASS      21.21 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      7.39 seconds
IncrementalBuild              PASS      66.99 seconds



---
Regards,
Linux Bluetooth


--===============4577994002070503417==--
