Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D383527A
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660396; cv=none; b=T53z9wZOi7Cfmzr6+n2oG7EW7WD+CoaG8F3dffm1W8+oxhigvffl68975jdB1XN5/kEIpvTiBH0jFyrjvmImcnyRzMep1XSOOXhuMTV0lZzSLbnTUJs5bDj1kM9eaNJxP3tNiKxG+eeA7yCScgFrkl0BrUyj5g+ErP6MkAQ7Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660396; c=relaxed/simple;
	bh=iBvw/NOfF42wnPrpyEK/7g9Bz8sFSlmE6w8FZbUt0aQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o3hAQ8ej+6sTlBWDswOfzRN7L8BsmQ8TLwt2h1fOeK/bZ56BVs4m4WlAz+36SOzzI3MrOdXGC/VBC9+Qz18hWKmIoJQaxhwVXA1rDPgKQVNz2LQ5G42K2xdRL91vtvv9CjFVkDHZ2dZKQlDWvvhuv8mZBCpt6LQka7MXr8o09qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFcNx8hs; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFcNx8hs"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc253ca54cdso470834276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705660394; x=1706265194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5QDDtI8La/u05BqXZWFGeBxSvNNYPGrE1NHOZ4ejDIg=;
        b=VFcNx8hsYEV2mNJJxBdzP0KofR5NXzP3I7TnosLblELaOfmEkAQL5iTwwv5wwOdt9/
         s4DsWOIxJdWAvqYmqDSJPnFOEuw6D3IR+LtJ8jyjtDErtmE9Lrxx6yApfDvMK5h5aHo5
         +RDgrB+bIg7Xq3bA1F0iadlZ3aTxQrJ8II0Rwma8zUt00VBt3/7/eRUhr6ude1mVTdk1
         4ex8mnyngakST7zvUyr/7jb//uJohCrX1czpugxUnlZkixOT0SqNX8Gs5rP6qVLBDlbS
         4TaNhxYqwQcVHy62oIU6tOZ1fs+x6dFMf3OFM9Dk6VwsS7h0yrubspMgWo2KZTS6lNj7
         YxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705660394; x=1706265194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QDDtI8La/u05BqXZWFGeBxSvNNYPGrE1NHOZ4ejDIg=;
        b=tWKcv6tGbmHBovTf/0vnJdxBim5BHz6WSp7XdqBsfNEiQFmOdTnhs3OfqlFhbjGsFb
         Q+WbHhuSuGWemwym/AYo1NiLjD71y0i/KOY12TfWnWgFIRSDdvjd9TjDCWuawraIpCsO
         7Oag3atzMqP2TfzF7Rjsw/hp0MwlwvEJ/uWtuJCCrtrin9umkd3wgekc1rQq5Ejn1ZKa
         DkwM3+X5AjB2G+XPSbsEXFnOHSQeHCnFULFIhRrg/l6E94d/JpmBRxqAUcuc4s64NLpD
         juRtZKTwJpfp8X12oLhqPQNCITM7LLNnp0FDrpFFNKi1eCBYHVO2WcL6OJVt/HGGS9u7
         H+iw==
X-Gm-Message-State: AOJu0YyynX/sU4jowRj8bpUtcDkkm3QjrCVTlKcfoIdbGikXTdKfEU6w
	hDVlsQcQxmoHa8DhstAZCGDoxP42GjqL2QAIYclegrRisr4pd90x/LSHHu9x
X-Google-Smtp-Source: AGHT+IGMVRLI60qedPsd0d2yvld3lUuSiOis5idjj7jeOnAsAGuZk0IA7Wd6S93lNRoTFjb6DVtVug==
X-Received: by 2002:a25:2f54:0:b0:dbe:351a:5221 with SMTP id v81-20020a252f54000000b00dbe351a5221mr1581716ybv.123.1705660393954;
        Fri, 19 Jan 2024 02:33:13 -0800 (PST)
Received: from [172.17.0.2] ([74.249.5.177])
        by smtp.gmail.com with ESMTPSA id qd11-20020ad4480b000000b0067f99a564bfsm6700580qvb.91.2024.01.19.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:33:13 -0800 (PST)
Message-ID: <65aa4fe9.d40a0220.d51fc.0a93@mx.google.com>
Date: Fri, 19 Jan 2024 02:33:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4483016900016445273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: qca: Fix wrong event type for patch config command
In-Reply-To: <1705657530-17975-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1705657530-17975-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4483016900016445273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818061

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.39 seconds
CheckAllWarning               PASS      30.22 seconds
CheckSparse                   PASS      35.54 seconds
CheckSmatch                   PASS      98.06 seconds
BuildKernel32                 PASS      26.69 seconds
TestRunnerSetup               PASS      427.49 seconds
TestRunner_l2cap-tester       PASS      22.72 seconds
TestRunner_iso-tester         PASS      44.71 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      151.80 seconds
TestRunner_rfcomm-tester      PASS      10.65 seconds
TestRunner_sco-tester         PASS      14.28 seconds
TestRunner_ioctl-tester       PASS      11.94 seconds
TestRunner_mesh-tester        PASS      9.63 seconds
TestRunner_smp-tester         PASS      9.68 seconds
TestRunner_userchan-tester    PASS      7.08 seconds
IncrementalBuild              PASS      25.44 seconds



---
Regards,
Linux Bluetooth


--===============4483016900016445273==--
