Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99607344F
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302938; cv=none; b=fPS1sTOnI88X07zK6TMm2mJ1521pCaJiqYuIzE59hjbR5whF0midhPxBGiRNVoJ31CWtpgeoaAQ+q/If7kxJeEja9d870HLWVk/sLn2z0DPQPYOEouBKnfpYGKVS8DC6/yvgYzSaHNwr4CtDv8+neEhKL5F9+WQO6FEbieGuMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302938; c=relaxed/simple;
	bh=AYDI7HNGsEovUR9dCIEgjEUiPCqJJ+pBWpz8iD6CP+k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yjn0EvbXh4EJP+93bprvgZn6yyUak1d9RowLGGEVFtRkiT7OjdWvwFxFhlm6Rd1cT+uZBBdPpoCu9cUNYpPmQfmPoIy3KoD31tJSN1qVJkB5lSKLvgMkL9vL6cjG7lbwuGhCkbLxb/Yn6rrP6aj2NyHpdZ01tAnoxULmTqF8g8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLdUsQtK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLdUsQtK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79c05313ec8so29732785a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719302935; x=1719907735; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AiTQfzZOJXMGlkZR1FUThVZYdD+C1VXVL6vnXtyiteg=;
        b=MLdUsQtKQFqrDWLNdSU/sKvhDqST4vfXe3BnaDSs8EXuCZhHOf0AvQ2iYrHHknD+nN
         OygJu4CmFyWTkn/nKgWae69ek3VMAafoEvj7vjf5yd2fG8HU8LWzii/n2Fl6N84FKQhI
         MWfsSjhZjW4FwPfh9xy3JvfTAHdVa3PvudRdCYIrRauJXR4Du2hhWl6psbE05oRTvoK+
         7rOLaKhaWJTj1FJZtCGxy2Tp/kRt8AcAI/xlcNxk/meKmP4G1O/h3ITCc6pSk/qbilUr
         FIaNpOHY22wWge57bmDiQ+BXQVKZ4G2oNppv+GhTPRKBNxCSxX+y9TLbPKYpy7aYgIPV
         l2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302935; x=1719907735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiTQfzZOJXMGlkZR1FUThVZYdD+C1VXVL6vnXtyiteg=;
        b=pU7kgnmIS7CS6uZxS1HzQVdIRpsV1UddNdqDEPZW0uzUjVYhriYVSMTYyKrnluZW1c
         pOWV1+qM1mp9+ijSvk13yd7idxLh1Ohzwx3aRLsJ91DIZthx3nwoDRb+WpU7FnyUQN3/
         D6brzSCSlDF92LKwYB/hBEhr5fbnC3+jBoBVmffyLwuzPfsEHu/2bTBLNhAjt0JT61Ni
         gpTEph3U4gAo0tiyZ2gbvoKM2jNHuhKJY+1nmFclVAEnXCfzb3IXYq8oFLrkkmTfbt8H
         zMwhe0QvVGbvgJGR6x4XGxQO+fh32qBbcNDljiioqhxDsqpCTZefJxN6QJUW7H1wGffd
         6c0A==
X-Gm-Message-State: AOJu0Yy+JIOXo9TE2s6XZn8i5YDa2EwpNxfuXLXL7+9VOKwjrmhgysAT
	1h04J+XONnLnMcn6CnoB+B3IoihTPArZgmtYdACz7dFwvPAXUjN+1xIXLw==
X-Google-Smtp-Source: AGHT+IGDUfGyAe9WH/A8MFbV9SfqjeJcfpV6vIVSFsm+9MW6X2W/lTw+FT4vxLVnzjVlkcrf9mRgnA==
X-Received: by 2002:a05:620a:4155:b0:795:4d9a:c5d6 with SMTP id af79cd13be357-79be47b6fc2mr866626485a.55.1719302935445;
        Tue, 25 Jun 2024 01:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c0a87c952sm14952785a.134.2024.06.25.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:08:55 -0700 (PDT)
Message-ID: <667a7b17.050a0220.6529b.0399@mx.google.com>
Date: Tue, 25 Jun 2024 01:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3353213955502241073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] Bluetooth : Update the mas session structure
In-Reply-To: <20240625063533.30536-1-quic_amisjain@quicinc.com>
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3353213955502241073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=865178

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      25.02 seconds
BluezMake                     PASS      1702.62 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      183.75 seconds
CheckValgrind                 PASS      258.36 seconds
CheckSmatch                   PASS      361.60 seconds
bluezmakeextell               PASS      123.30 seconds
IncrementalBuild              PASS      1518.10 seconds
ScanBuild                     PASS      1051.15 seconds



---
Regards,
Linux Bluetooth


--===============3353213955502241073==--
