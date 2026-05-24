Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00C3806DC
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664051; cv=none; b=skhfc30re/0jEbM5j+GcQCrQvWmvQMvpNFafwOyRVNOKDEit2Q9aEuoiQOk29OzwO5+x/QwPuSabcbtx5eihlrHwyu6ogjehnQplp3shd4OaQmWAdLHhL5AuXp2zvPYLiD8wg8b+tbI8bxu4PSYm03T+7e7fo8sJgXpc2/OTU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664051; c=relaxed/simple;
	bh=iKds1BmZzF3VaAk0BGcHj5pT0VTSwMMvYyYl1HeR/1k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZgB2GOvj6aFZHEascXbpG/th1t6//+Q27U+A/lGkFQOUfbcdHgDBZvvL7DwrV+WTsUdV6M/Y5ipUdjOOf/krie/ivB406nJZEyr8LTd/ktIPSGJrv2AU+rQ/j4GvIJtthC81Aoofjpn53+qwhsPBnjVKTnSpRBs7I8fj7loC1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8JzVYui; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8JzVYui"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-135e88b8e55so6623069c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779664049; x=1780268849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEJjsNmC5VKDOv2KOpxxcaqITqPF4rFOhcQmdBZGAG4=;
        b=k8JzVYuiBzT/f5lDMcGwvZQur24znn21y9QWAAvmiiq2hBQvhZYWra9IPu/F603cN2
         j3Dhd/TwJlu/pZR4G3rAqPIsjF5C3sFnpMcAOmpS4BUJHFAjK/+4scsOD8KuU4YGJABC
         bU1Stys2woB+GzAtiogVhkslrx6OdX1CNVCs83uTDQ73zz4QhsBnz8RSX4WDG/i6MaHu
         Y22TM6EoxJJPAVUfTwofji18/CCH2mcybgjrpytLUTmjuiDNtUfyqM2XSNZ5QUTLRaOr
         U52bBQnxTndhu4JyuZsTQin9wqzKVuf8sFxZKak6D/KR9C4EnHx7WMjl3eSZXsLow+pf
         2H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779664049; x=1780268849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEJjsNmC5VKDOv2KOpxxcaqITqPF4rFOhcQmdBZGAG4=;
        b=N4kOrwESaow6uWxFM5C+aYWtFCDPURUCarAyyXfaqfkpcOMn030bJgc4KV4u2WmwAs
         PFjW1dtTNhcOTxUXUhczgZbjpjCHhOWO2z+1AEyXxekMQOABNkJ2JqCBU2c020wEShkr
         N08j9GtXhOlN320tYFvwrJuI3JEFOJa2CIvMBQmEQOo0X5O2wuxOpTBjQM3G/HuI9xdm
         JIK39g1e+sZ7sfapQRMS2UosyPZtgln/q0tpw5nnpj+VX80ZRZSqAT2GN7hX064Bg5A+
         8qvpGr6Q2T5eD62kPsLdS8CblQTjMjtBLkuTu0Y4uUXaRSqUeUBP6bpLVvzQs92CiQda
         6+9w==
X-Gm-Message-State: AOJu0YxIq02jGfxS2xc3yaHWendlsErxr8VWPwrssN3ImdQdCxX35ly9
	F7UNxDL07+aXFAppVg33S0121TGBkb7ydazq2dJ9FfTwkbrtCTr9ppxf4Mo3DA==
X-Gm-Gg: Acq92OGZZpq9pHZkIpJWeJfnENzeWCXHf2DX7e1Vr/76UG1rxR8tACzRXhPj6fuMx19
	e0vsqRF3vkZQp/ezAIoKViA5CCdnE3zDrcxYnPRicanqr9AV/T0sBRGlloSvPziWUMzHPe9YSRM
	vPKzB1wzWw7CLwxnxlFoR2isgOY7VzFwwP9j8lCRSYWCF3OhY/lTWqcxo+fWNxNAWIAY70pGTmL
	cZbD6KSsuIzsSOppmH5LxvJnQdnEOVjUWaIZEQIfnfdtScIrkTf1BrRwA8a5RlV54jIiULzVoPp
	xd6L2SyiNJIYliHfPpL4NmlBDVqtUJW85Y6V5fjutIYy5EHFN3Lrd6bM087upOWFWarlhFpOawo
	HVixRw9xDdmT7ckQN/jUtvhPsx+dRo2uZYmZGAjZJ42fVgU8tgY2lEWrAxRmR8o+tX0phC4WpEo
	P4qNco4pDnO3tRlGIvVRzEct4nYJDdCw==
X-Received: by 2002:a05:7022:912:b0:135:6914:87e1 with SMTP id a92af1059eb24-1365f70ad4emr4017956c88.6.1779664048853;
        Sun, 24 May 2026 16:07:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.83.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa9a8b2sm5956977c88.12.2026.05.24.16.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 16:07:28 -0700 (PDT)
Message-ID: <6a1384b0.9652e1b4.2a64de.68da@mx.google.com>
Date: Sun, 24 May 2026 16:07:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3715655250492226172=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tarjeib@gmail.com
Subject: RE: Add configurable default LE PHY policy
In-Reply-To: <20260524221421.258593-2-tarjeib@gmail.com>
References: <20260524221421.258593-2-tarjeib@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3715655250492226172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100107

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      15.83 seconds
BluezMake                     PASS      497.32 seconds
CheckSmatch                   WARNING   252.29 seconds
bluezmakeextell               PASS      127.97 seconds
IncrementalBuild              PASS      492.03 seconds
ScanBuild                     PASS      721.90 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2148

---
Regards,
Linux Bluetooth


--===============3715655250492226172==--
