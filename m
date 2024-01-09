Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA833CDF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6HnQcTj"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78315243c11so211107585a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704799857; x=1705404657; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNIabEZQMrproOfFTsF5Rmv0Y7qPzgqjk+ayRRGBnQ=;
        b=I6HnQcTjx+VlzWy9LtcZXdXoUph85joOnANGI0fCdWDQ1Bqt5rccfkDqFdj60vPG5N
         FQjekOicdNrFNIzvcOtRU2ExCwOIxv5tnh/0pp1Kom55u0qx7/NgBauasV5gJ/j7A1sp
         RVvWmP1fY278P8lBRToibxp0cBfFXoy1Rg8G3BgS4GJgSUAW/i8MeOqB4WQB54rqlL2U
         CnOyZp6GB107tKEsOISAlcXciSTJ1/g5vwTSuf56MpQQYq9C7jq2avthh9YdeSTzt4UH
         nasc5karxHDnJ6QmFpFUgmhKNN7a8ksh/GkPn58edjJ/k49LE8qGFEnqspf6PQ9dl4B+
         sv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799857; x=1705404657;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpNIabEZQMrproOfFTsF5Rmv0Y7qPzgqjk+ayRRGBnQ=;
        b=iAYy5UzhCc95+la3IqcZtki3Jg34vhYPhasaaSmKdm+CbCGcIpTK2x5vmaLssHfYU4
         6HHXQ18j47gqClRi6HdL6w6fIybuA7wiHGMVxizOKsQe6ZcGPxpAvBwwIMR5nSVAWj9m
         cZdOvgUZDAD7+OpyalgkpjRHFKbFOUTsbGAEhktXu36iKqI+GDeB9FJDJl8P97qs1tZE
         B0Lir2r1VdJuGI7mm8eoQUk992EvA+TUAaJ/YCxUwYhDk/99RQcHzxyuPobwU+Gy5xvJ
         y6nwR1YCqnzTO2qIO7DhVTob9VD1dialns42WEb7CY5gwX6RwYbiTZTvC88HJAxdqljy
         XW/g==
X-Gm-Message-State: AOJu0YwRHO3MYI2wCICSeTxwyyRYlIN9z6pJZnrc8o12DEbVMk+zYfWp
	u0/x2MYK3ilkiT/gfit2tW9lhPas5Nk=
X-Google-Smtp-Source: AGHT+IERzOnRuwnwgOBmpMoGPlvMw/ZRQPHWznL9VqEZVaRI1g9U0/xnU2Qtxt62P+RgZntNQdMymg==
X-Received: by 2002:a05:622a:170c:b0:429:a826:5bb with SMTP id h12-20020a05622a170c00b00429a82605bbmr513499qtk.74.1704799857263;
        Tue, 09 Jan 2024 03:30:57 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.25])
        by smtp.gmail.com with ESMTPSA id vv19-20020a05620a563300b0078324cfbb70sm722222qkn.97.2024.01.09.03.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:30:57 -0800 (PST)
Message-ID: <659d2e71.050a0220.1dc2d.2ec6@mx.google.com>
Date: Tue, 09 Jan 2024 03:30:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7035629330384169409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,1/1] Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
In-Reply-To: <1704798203-20887-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704798203-20887-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7035629330384169409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815358

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      30.25 seconds
CheckSparse                   WARNING   35.68 seconds
CheckSmatch                   WARNING   98.22 seconds
BuildKernel32                 PASS      26.63 seconds
TestRunnerSetup               PASS      426.80 seconds
TestRunner_l2cap-tester       PASS      22.73 seconds
TestRunner_iso-tester         PASS      44.83 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      160.15 seconds
TestRunner_rfcomm-tester      PASS      10.78 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      11.87 seconds
TestRunner_mesh-tester        PASS      8.68 seconds
TestRunner_smp-tester         PASS      9.63 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.91 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7035629330384169409==--
