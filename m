Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45113446BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944970; cv=none; b=vC2BQdijF/zEczwXJ3wfJr4WMOTkxyuPKFGt2QlCwHgsVXzNpnVfrq0Wn5FBOZ9nquwgFhl9kzYlTmxzeuR6jS/vSaNoFZJF+HBKWhyIwQe+A6dreZ63KDhCsCWpugRNlj9PuiwqLX4tbTOzLMAYEDSd4IDrfTNUHoccyREc94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944970; c=relaxed/simple;
	bh=i28sqdNPFNvR6+Shlha+z4EyjegkA53fx26XDVGe3nU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kxv5DvG06Qu1yvEopqnjNCPh97+QtKV9wsAO5kz7bVZ/xKXhT7AFxxCgzldJmNwFEckKeBuASFGMhWW3AqEECsftFGrXWf+/gQxcDaa4wrTolhTiBU4I0YsXKCgAF3CtUJKgwa1he5IQr/3E2LEcmJQSGykIysuAIXe1/GUVx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoLZHZdX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoLZHZdX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d777d7d1fso70610885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712944968; x=1713549768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IRDtev+Y0u4xq+22itZDIFh6wSNKMk8KOpVuStXPqYA=;
        b=OoLZHZdXDRtOQ7GLVqowramd7cd224PDqBgFvRMAoPC15uBfjw5cg8qFjqTvuDJv0b
         ITTpjwmQV1an23D0JvzBi8U7isQMNSwZy1UXSQbrDSZZ0YK5btMDhxGoVWGokpOdCsUJ
         TCdZjTp4qF/s6V6OSWskFg7/InWGqATff9bcZgXJpbYBtV6xHmCGyUUdZI7/e91nLerG
         31MwVXtgQ0s46ZVSUdqX/vDbhs94Bba8AXQeFPhtltQ8Cjl0d+NcEp8Z/otQf/oqkW7c
         o6OPdPVxf9keQ1Q+7X/E2WT1YyHXOuCsfUoYT5Cwtg5t1lb/Wg5bRnJavvHfoR31VIYg
         bj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712944968; x=1713549768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRDtev+Y0u4xq+22itZDIFh6wSNKMk8KOpVuStXPqYA=;
        b=cjbybCc5nFWs2I2cFhxd35M8ZG55zQZcgd1o3LWLX8onRtLSEMpVSOnZW5F3+g3bvK
         1lsTJgJvhDSow6FV3cF9MyIRVT27u6Joa89zEgzEUXJzoL2/mhhz1X5d6f7NPEoRHFfN
         d1xELV787PrJtu5iewUK22uZS35elvvVUGlVij66QqvoR3NW5KuxF/HzqKEFaQ+GzYqe
         ZTotenSf0OLMHaCYp6+wiqTHmRRStR0ku88ZgBkSOxyGOZOSxRNyfM5imbiOYd9UbFZp
         3jS/YylFQoXmKnOaNeqJvLQ8wowZu3LSmpExhL+hDpZ9Ami2raFL3/eu7CmiUtx6atA+
         zu4g==
X-Gm-Message-State: AOJu0Ywhjdr0v3eZfMTkLgJHufOOyV9VtXxcoFPQKQsWIU/oNjFvO4AG
	zvXOAV6vQjcUG9+Iw37UAiVDZOuK2F7unmPnLIdSxfCVrGFrubItXa2iew==
X-Google-Smtp-Source: AGHT+IE32URV1bLQHEiy83W2ADyNCfzFxeliMZiayGLH5+a65p0e1ldwLCAxhbWQgdYcpbqn0K/AEQ==
X-Received: by 2002:a05:620a:f92:b0:78b:c9f0:9c26 with SMTP id b18-20020a05620a0f9200b0078bc9f09c26mr3397499qkn.50.1712944968033;
        Fri, 12 Apr 2024 11:02:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.208])
        by smtp.gmail.com with ESMTPSA id wh3-20020a05620a56c300b0078eba6089d8sm2659385qkn.127.2024.04.12.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:02:47 -0700 (PDT)
Message-ID: <66197747.050a0220.a7405.6dcb@mx.google.com>
Date: Fri, 12 Apr 2024 11:02:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5462451169482818634=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [BlueZ,v1] tools/btattach: Add support for more QCA soc types
In-Reply-To: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
References: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5462451169482818634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844121

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.16 seconds
BluezMake                     PASS      1661.75 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      177.85 seconds
CheckValgrind                 PASS      248.58 seconds
CheckSmatch                   PASS      355.23 seconds
bluezmakeextell               PASS      120.37 seconds
IncrementalBuild              PASS      1459.70 seconds
ScanBuild                     PASS      1035.21 seconds



---
Regards,
Linux Bluetooth


--===============5462451169482818634==--
