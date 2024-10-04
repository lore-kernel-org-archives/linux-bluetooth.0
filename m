Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07A1798C
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062906; cv=none; b=q2SuTAuoxE6KvI4KtYkUr9C6S8RT+gpbZbhMGAaFErhiakuzVGiQLgpUws3Vj17YJpiZV+HKZtz17hJ31U+ZYJO9DrND1mSIwkfCV+jgT494xfC3vf03cMLmByFRARUQYnNmU3aQJNOXfBlYG4u4EJlpHV/NGuF5L+UiVA+Ukng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062906; c=relaxed/simple;
	bh=uV5/akRxL7DEfXjgHWoV3SAyOhK4mg19WSl5Vy5+WmE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cYeCNnPnstbEhhILEQC36tZgiiZuCWbqJRZHhvYMk83BhED2oUCYSCwnIeQk7rdQUuEo2SxTGP6XpqOGiNwediPCCxW/nIQ6Q4OUJVIgY3OXjYz1hrHVsETgptZIV2uuDhIuwk1wZu0fEM3t8pO+OqMjDbtlyurUyJrD19GRyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwCuoswR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwCuoswR"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582760b79cso11545291cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728062904; x=1728667704; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xQTpw5yNuvFKHLT/pIvNHXqFa5PGWeZNWICRIw9GoMk=;
        b=KwCuoswRAxBcvBdrakkCjmWdIU6UuU8MQMVwdOhpDeoyTKtt3xKGDtnV2AQQLbh9ij
         jFRXhsDmO9iZu+bNngK8qoqXOO5qoInq3VbCuH+sQImE4PuTYCyPsibKJ0+GUqnjqMb1
         UB5haNQs9vzJe/fLjqx+vKEbMFS27FAxcCz34o/KfFNsjgHn5n+aNlv6xtj6wNm42EUL
         ZPu2XZAm4i+QM1TrTi+jvjTDg6buqahGNBZV3nsJRmTk7iosvtL2prsi/wTrXjewkI1G
         HFB8vnMnThdBm05ADzIdWpFQcQFeqNobTEU7v4Mb7QQpcUlGSF/rBcuaGCmnX2BRqLNC
         7lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062904; x=1728667704;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQTpw5yNuvFKHLT/pIvNHXqFa5PGWeZNWICRIw9GoMk=;
        b=eg5pcz+EUxJkxlRbl0M/S2kEPh2016/jxVjEVOkN0DPOkb5paM+kWs03leI1n81O2L
         dw6w5oPCJBGABThwVIIHzYnpSxiSepkstqDCoMzGBzhlLUsCVRmPFuNJVz5ToHclsQZ+
         T9NlBy7jeXeWNg1PTaa0yBvOvv8EThOcsgnpD6OvsxK179C1m9PZtoLUMYcATF9MS0Fv
         DPA6fqxDGaJ3p1gfo7t6Cfn9xswRo957eQaNSEcf5RIkurRow+/qgQ3q+shJJpbErjli
         Tp6xOlfk+Jbc7GP/Z08X3LMy+82cfQmTsHGTVQoSA/s49ugKwGQocnoWTO620NZ5XWlg
         uDcg==
X-Gm-Message-State: AOJu0YwHkQ6zLbN1YAeI669/UZ3rl7ubO0iVNFlq/rGgjMgIbar5rH2j
	9b7TB5HIsPdHocplpnTAT7QXLIgqih51+s1lQtauWIhX4dOxR4cSZONMFA==
X-Google-Smtp-Source: AGHT+IFNsCFOSmDXl35PEHfKxsmJkmNpaQgtg8lfrLzn7TwMWtTBZ5aYbZVpMRgx6GtEHeQd+trntA==
X-Received: by 2002:a05:622a:1a2a:b0:454:ec22:dd79 with SMTP id d75a77b69052e-45d9ba55c1bmr56967781cf.24.1728062903623;
        Fri, 04 Oct 2024 10:28:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75ed3ddsm947911cf.73.2024.10.04.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:28:22 -0700 (PDT)
Message-ID: <670025b6.050a0220.1534ad.0ab1@mx.google.com>
Date: Fri, 04 Oct 2024 10:28:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8543579395972594668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Fix now playing list on playlist change
In-Reply-To: <20241004144043.419832-2-frederic.danis@collabora.com>
References: <20241004144043.419832-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8543579395972594668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=895618

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.25 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     PASS      1588.13 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      182.09 seconds
CheckValgrind                 PASS      250.48 seconds
CheckSmatch                   PASS      349.91 seconds
bluezmakeextell               PASS      117.60 seconds
IncrementalBuild              PASS      4269.75 seconds
ScanBuild                     PASS      1023.16 seconds



---
Regards,
Linux Bluetooth


--===============8543579395972594668==--
