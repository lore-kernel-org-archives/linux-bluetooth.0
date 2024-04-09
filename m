Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04650263
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673497; cv=none; b=LaHgXKUHYx54Zy9XO4QcTrCdA00jbkFIUutlCcyhzu5XkN8qxlXPF17OqcGTFTInqciX62u9pYA4eJk1zfHZBBLYOxay24+B/57PPZBgQ0sodSLy4NA2L8W8SeMAPLL+OlwYGcxQUhRa2I6kX/5EaKkqnOqar+d+FaUcv1dq1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673497; c=relaxed/simple;
	bh=rDQ/ae96c7hAc1TYsr3WFvPAx6SQ5wISG/YsEaMFFS0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CWRG9FwryvlpoKSg0equzVQwGacLSX2QifKUnm6KNajfv0Gg4kiwUuBExwldvcjj+ssH5TmnfFv3cQsMlBIxyad28V/Fb0SzzQ7yh0wODAiEpkdPCTGtS03SXrLLquPnXLNUR9p3slVEWZB6t2VDiaEXxx0H0wKGt1vn0xO4TXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxWSxm60; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxWSxm60"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61149e50602so37969627b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673495; x=1713278295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rDQ/ae96c7hAc1TYsr3WFvPAx6SQ5wISG/YsEaMFFS0=;
        b=QxWSxm60pxqmaSLNmExI+KU6nrJd6glBUw225a1ZcYCC+mv/IyDUl5K4AzZ+LtCydN
         kngRu+UdC8z6WaHSJDOjJhXRot0f/uPmAabtCmMmNX6xa2cor5fLqDQgUI36eQSlAmhH
         SoKzQA0HXKtug31IB/BGaY88R9ZUCz+Zl6UXxlS1FRE4skQ0Q5SbJJVHcPFYDUNSZXKD
         GTD713XLiKil8Bva0WzUU4QQ8zy0EsHowaxK7/ThOUBvNQYinAru97pdPzjimijxaSOv
         eB8K8KNako26x4NiNoeLNc6leiqyQX1gCuxp8WOVMZaJdTpAstGLRXSJqvrtEqpRV30k
         yzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673495; x=1713278295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDQ/ae96c7hAc1TYsr3WFvPAx6SQ5wISG/YsEaMFFS0=;
        b=TF+KhEl6FwUXN9v82I90csgyvxaBQGfprPv/zmeun9cTM4b/i0xTXIVolSfkM4JrCo
         2BjHJooi8A/ahy4Dm3upnNLx1SBWMkdCXHtzswNeUim5sYKYUqtyoFAqiorzCMOWTbdb
         Wv+J38/IeXM3CoL4gP9YS391SL87jG95A9r/ILiy7khW39ue6RURCBQNG0ltTuFcdT1J
         44tLuqOjs/bRFvtdDXLjZsPBeem5ysrWSkMzqnZQmrs276eHADAVSUhDhnFrkwasylVn
         7ogURylbQ54Fb3S9TmxAYsHsxr9pisKOMzFr3nPdD1ixKDCob7+NWXVh/naGTNkdt7yV
         mAfw==
X-Gm-Message-State: AOJu0Yz3JOUscFWuSRNwF8XqmzCgbZGj+Fb8yLxwFU5LMNi3JMzAPdbb
	IfPpqHSDoDP4egttdP3OQhI303vo1aezaN9tgNR/npIBqCQkk+sCPHangWKN
X-Google-Smtp-Source: AGHT+IHJpE/CwDS2rsS4MckHjL96sr8jkxbOvyNqh/W7d722AdJAYuun2ZOY3getvhqQmmRJ0eVXgQ==
X-Received: by 2002:a81:8406:0:b0:618:fab:cd23 with SMTP id u6-20020a818406000000b006180fabcd23mr1767222ywf.15.1712673494887;
        Tue, 09 Apr 2024 07:38:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.214.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a81ae0b000000b006181e899300sm629820ywh.67.2024.04.09.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:38:14 -0700 (PDT)
Message-ID: <661552d6.810a0220.1bc7a.3428@mx.google.com>
Date: Tue, 09 Apr 2024 07:38:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6373072224035265182=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: fix oob in sco_sock_setsockopt
In-Reply-To: <tencent_D423A78448F764177A26CAB3716365096705@qq.com>
References: <tencent_D423A78448F764177A26CAB3716365096705@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6373072224035265182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/sco.c:890
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6373072224035265182==--
