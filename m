Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B1263895
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856729; cv=none; b=dW6HwR6WLYqlqqLvF9Kki1o20zm2RF8asQj3q3HHMxeFL+OHlBbU9nq9tKiUP7KeNn6J8YDSO8YbaO8J3rb+26CBaHRqUO/afuZIE3ZJvyolcTzocFCWcQdXSe08u66PtsEdKs++zhLegidfUFWQmWWNL5/R7w6zuf/FxmIZHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856729; c=relaxed/simple;
	bh=6tDT3LbSPWJq07BT4B1sXM+ZWHEKoTX4DkVugY3ZO2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ozzf5y3Owggf/QN2nFK6hw4Zxvkd7FPVi3Zd7tCSnUYhDbkJI8D++w+j2yq8GBpIodBxnNbV8j3cDyMuQWNoWlUW0hBbNrQ17MswhpqMYcuG8xmTbWZUAnTYBxdwOYmUnw+shk3Yveph5oAxTp4LGjdHO7V+DIPCVfBZSboV+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ADaFjf5M; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ADaFjf5M"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1AFB33F091
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741856720;
	bh=bGEe1nuA3BuabnRyBSn96LQw8uAiI65YpQaEl3Tfgvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ADaFjf5Mac8ioTjdQtU7cUKouEq/qoEqR85gXplhTZbHQOzbkESm8TIfOF/rnIVp8
	 Rdf3YNQNlGWWtZkpn7W/e0Yl+XIUZZU5cGUeaF7jrqHDHlX6RmwUymB7/iltzx+xtM
	 nu1N2Ncoi9nDvyxmhHEix5hhlvayxFWEKiOt9zSE/m3k9uNaqeY7hQJ7NBI0WQfWTz
	 iizNUkjBn+rHPh2EGo4cdLOu7peu9X3uRutzkxDjdYQtkChyxVTvRBldNjsH3Pkxev
	 blUffuUg/8gB40hitV+n4njTJvmqemGbYnmR1UYvmMeKH9d2Uk/DgDTUCnZTNYKu8R
	 uLoyjBMtpSyjQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22410053005so22633375ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 02:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856718; x=1742461518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGEe1nuA3BuabnRyBSn96LQw8uAiI65YpQaEl3Tfgvs=;
        b=dgnSM0B8mhkH+yqwzPyXey6CoRAmDai9DhDjxmLZ+iZ8nIdlZ9Dg5OV9HGLAzGNFAh
         dkgd3LD48Fx2wyuLf9dZvkuez/8vCPjCJo1XWflU+wuB0yX2pXWwxDTepkkxjb69LEpw
         2mOaeNEQ90bZPWBJW5oZ36UQFKzgJTFv6jeqlGjpbXIVhXIKVHWr5d+i6rNR2VY/dWMA
         vsI2vGmLbFsZdnA8d/nNeakBwLgw4ol/kzXavkvslpfLhT3KBTtk0qUJKWzmzveIRWYu
         aOxiaztCjg8YXNKW2/8Uf8ca6gZHsbW7GGOYyxMNQgr8sU/oRgPe+zGwslzAy0PcjjzD
         JMMQ==
X-Gm-Message-State: AOJu0YxGhyMGVZ7dbZ/6Q9R6MqneeUMdHb7klCLI9khH2LzuQ/pvQSJT
	xN/aKJBNr+y6DEb1qizG2PiV9heAPtmnoB6VdOXwQibsw2dJ/a49Mte9aavla/Og/iojK7wpyf6
	0KYZAt+WaL7K44M8rW6tB+Aj1KEZmYXDYFhzBivGHVXM07Gn+sizZrF3cNPGY+UE0rUkwY/iQaZ
	ULmlTZWnpa1pcxRQ==
X-Gm-Gg: ASbGncuHfYi64N5FFE1vKTpOvyROkf+RoPn4lJ/QhtcMcajU6cN1M+mD7ltcYsOrC/K
	FO8UtajSfQgId3rtLegdBYDQ80G8MonMbyJ2q8NQ0ptAlkOe9CLfdKJ1pJRkYJXl5mwvK7FYBPK
	+GBWaAPH03Bd7Rq2HpM8d7XV349SyS9KgRFhgoOmO/gSsa4UMAp7c664ltYE+4hmFYeN2ySzhlr
	l5IleKdC52AEIFE05mk6vXNFKZEjJ4tlgrXbxm4Bs8+7OdZIwqJx5uQ2VzqTnyDI6RlBrji4CHz
	Lfch4v8JHGfbR0Xf6qN39AdBasAfRgBaV9O9E1uIYOhicfufH3M7ApH2ZcjC8exxvRU=
X-Received: by 2002:a05:6a00:987:b0:736:326a:bb3e with SMTP id d2e1a72fcca58-736aaadefccmr33816182b3a.15.1741856718493;
        Thu, 13 Mar 2025 02:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyYeOujyemcT5BkoJCnWo1BAflYsXaxKA3ma+l4DW/ndZH2pffIYAQPrEvfe+nUypOJCPYWw==
X-Received: by 2002:a05:6a00:987:b0:736:326a:bb3e with SMTP id d2e1a72fcca58-736aaadefccmr33816142b3a.15.1741856718160;
        Thu, 13 Mar 2025 02:05:18 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529368sm864040b3a.8.2025.03.13.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:05:17 -0700 (PDT)
From: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
Subject: [PATCH BlueZ 0/1] policy: connect HSP/HFP when A2DP is connected
Date: Thu, 13 Mar 2025 17:05:10 +0800
Message-ID: <20250313090511.57938-1-yao.wei@canonical.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: https://github.com/bluez/bluez/issues/1069

We found that with NVIDIA driver's suspend/resume script, it uses chvt
to switch to tty63 before suspend, and this causes pipewire to
disconnect Bluetooth headphones.  When system resumes, A2DP profile is
reconnected by default, but HSP/HFP is not.

This provides one of the fixes suggested, by reconnecting HSP/HFP when
A2DP is connected.

Yao Wei (魏銘廷) (1):
  policy: connect HSP/HFP when A2DP is connected

 plugins/policy.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

-- 
2.47.2

