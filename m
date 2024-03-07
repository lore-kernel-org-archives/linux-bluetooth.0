Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E81B94D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821969; cv=none; b=BSLCTewcwRAEdEHUwwbnfcNASDIKjRRByoUd8FCvAcSb6WjBgh92S+uV9fCzfSFH+sYQd3Ms83xaN4a/8X5UI3Phy3r/dXNL2L8WbOlD0MyeWGzPJZRThNFeVhkMI2npSA4Ee4UZnoaSI8LEj0ZbBJKSz2v0bqhxXJYJuZy2jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821969; c=relaxed/simple;
	bh=+IHvEsHMb64NksohRLdnGLQh8BXZtm5OuOXj6uI5cQM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GED91V9sqDr6zxtK8cD0ZqA0VMvD1uqiVZ1c9sMjHFn3Xk6OuCfLq9hMwxSpRtJ6T+SToN5j4NXqiUm36fA90i98TL2yTt4Ct7+58WfyPLtVxFBUykjNBITOzygCTMcOUw1rNyA7D7XCsKTGxVQWo0gl4v6bi7fkFiBY9pr+9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2N9Qy6J; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2N9Qy6J"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f571be9ddso7070996d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709821966; x=1710426766; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g1M9O1aFY6NfU5Ur3JNnh1AbTROz0YLEN8NVRXkC3Ig=;
        b=M2N9Qy6JSb7ei5vqA/QyNdd06MPrGlpRgSceemb7zmGbuZpp1+BlmBXkkmMxeLsEev
         mQq2CcZ66Pn37hJe4TlODRbI6I1vZumTWa16AD4s5x601fe9OiDnsb4eM/eWOwfkgtG8
         BZ5x62KnRdQe4CC98RlWUc3zjqMnvJWnYEfSgCakXKI7brqG/jW0aSPeJPEOjrkCTsNf
         Jcnp9dgsekFFpxjPCUbLc6ZmPvkBeAJ6I5e/XTrpcqNrmRchjK0No95Eh/Evn/NLwxCh
         BqRJeCHkpVrKoGerwoKzAa7x1NxaGq4Z7cpFFKjjD6w+/mX9L+hv07N+cGNUx8f9M0M4
         BSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821966; x=1710426766;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1M9O1aFY6NfU5Ur3JNnh1AbTROz0YLEN8NVRXkC3Ig=;
        b=vnH4jn3Zz+U5/B2NT9DlupLBKzlzZ/FOZe+TOz+feVgepBjb19TlW/h1rceFk3aP0S
         2O8qnUok9J38yphgmECRp+2h+DUyPdanLssPRQ5nT01kXWiOSmX4HCgK27v+yqBRU8aD
         DXMe4jb/tCjzp6qeV43dZ5R8btj7otB8soLMTaMwTjT+7xrsVbXPC1IEwPwMdp6Inwe+
         yn+fZ0z8UXDP1BO7kapnHDV+MP7eP1MQuMgNlUwJ3iKxb3DMYUG2N+qTjEGbfSDiiXb4
         9EQKMQU5EW6Evu9LDHaCy7We+XALv4i9tbN/lLxV2LkkEADEqwSrvAW2S52rj4dLOxwj
         vzEA==
X-Gm-Message-State: AOJu0YwKjhRC+sqiQx3PU2GS3RFQfWoJp6AF53jItmIfFGfHGXx/b05Y
	zx35FRZs4/fEUJoW9FCVdWkRqOj68rBTeyINDnEM07X+wky/uTh2/lUAmwK3
X-Google-Smtp-Source: AGHT+IG91Q6GwNq984hPNduhPasCO6fn7BzbYmsDWRdeS+v0WkdSKrNFgB2KgUePzf9tMHoWKjKXpQ==
X-Received: by 2002:a0c:db8f:0:b0:690:897f:a5a3 with SMTP id m15-20020a0cdb8f000000b00690897fa5a3mr8012762qvk.6.1709821966252;
        Thu, 07 Mar 2024 06:32:46 -0800 (PST)
Received: from [172.17.0.2] ([13.90.174.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a056214118d00b00690ad9dbd6dsm169758qvv.12.2024.03.07.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:32:46 -0800 (PST)
Message-ID: <65e9d00e.050a0220.d9a37.10c3@mx.google.com>
Date: Thu, 07 Mar 2024 06:32:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6947967498678949182=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: iso_listen_bis fixes
In-Reply-To: <20240307135834.3941-2-iulia.tanasescu@nxp.com>
References: <20240307135834.3941-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6947967498678949182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833415

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      27.93 seconds
CheckAllWarning               PASS      30.81 seconds
CheckSparse                   PASS      36.29 seconds
CheckSmatch                   PASS      99.01 seconds
BuildKernel32                 PASS      27.04 seconds
TestRunnerSetup               PASS      499.86 seconds
TestRunner_l2cap-tester       PASS      19.96 seconds
TestRunner_iso-tester         PASS      31.12 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      109.98 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      30.87 seconds



---
Regards,
Linux Bluetooth


--===============6947967498678949182==--
