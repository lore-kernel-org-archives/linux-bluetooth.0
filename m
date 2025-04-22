Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB4197A68
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300766; cv=none; b=cOsIF4gFjYA/koGgdV3jILc/uTq3mdhjxm8z+vQxT9N5PCI0+3sHp95nGuo60V+VAUMf9HtmZQEoFQIXSvTb4spM5LQllDI8ARUshvZCXVLG7JkcW9i+Asj6kRLujdmMiXYltev8J9ghEI1LqRM4venzBdoO0m0IwHC1rhazmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300766; c=relaxed/simple;
	bh=raqnODiJ0rpV5OHci6zIG1da/SZgHkKHtMQN9LQcNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upUED2jXRzCpYrI1t0AGIH9PvLOGpeRUowVx3iKuxjw69QuNRCnNU9t2vM5JCMIlvweh10l3PTOqQgQQ+1dPZylNG8jCR2FAkMyd7lCztb4cfyxSY4EJuIAOxcO742v/hcdpVDFzAe9qdpo7ydlrg2d/DG8UcDqBDJsjlpDeaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=yOZaoNSD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="yOZaoNSD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736aaeed234so3828772b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745300762; x=1745905562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUJ5WAinO3wfS97mOonrS6V7WIWzlQtIrSxWdx6Coxs=;
        b=yOZaoNSDnDvsJkL+vS5B3v0f6OvPjgEs6NNjd7uyxVs8mYOLgO5qtsLfZZsceBDjpe
         rjnaa5GUsbG14FLJ5MHCEACOfye+agEArRmzY7X2jj+AjaQtv9TAJVh7E7/RgYa2Sx93
         0Z8HPGu9AYMDq6t7El8iAS4cMEAfebhuZIUYPf1i4/zt/8UA/uo8TICA8UoBC+tUmF6b
         Dg/+6w6gu4TO5gcZgz7GvxRn8+A2P2l4ilZvNiqmX2PLz7IHQRZExi5Z3eBJLtImjbf+
         jhOuCusL8TMq4Le79UX2ebq7k7qBlfUNRcuHMwVqFDdHXeZipc6cJY7CPvRH1xxvCUu9
         SI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745300762; x=1745905562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUJ5WAinO3wfS97mOonrS6V7WIWzlQtIrSxWdx6Coxs=;
        b=MUMZ5hTw0iolLUzn1H12UFVGq8i49DQPepavFgLo6AUoWyIkQQ8Vozrkpx/QwKYj7B
         2bT42EJRzrTVFy87nDUpxsjq0lxrwFDD0E0JmgoHIZgI4WeSRVeWVjFMP+UcAAxsiSl3
         cR96zu3il7YirW6qhVxta3Pr0YSXVd2qafyYJi/pqvhEShOpLupFDlBs5CBuE2NOEG1P
         3E9Ft6VuT3VFd8mIOm+T2qRSYnRXS+OxYeQHL3y2GfcFKZcIxHzREv3WdFX70eLr/sPW
         +Yh0cdnJ3qe5vqYBA9WqEOwgEfhJRNIphrgd8JmXMMNy5Egpgc0LjwxzylXw9+t5WIsI
         fKcA==
X-Gm-Message-State: AOJu0YzCG1UKKXwvb3xdfvViBlBgY6glDDgiNZCLxE5+nJZKSSqswshx
	tEPruAlWJ0oDhaWdYmiC35ld2IBG5k4oObeRJOfuzPqzEzfL6XV7mCrdcISExQFUxtqs0IkxmXJ
	U
X-Gm-Gg: ASbGncuD4dtRzsq6fO0jTw56eEmZ/EPX6QNhlawPtBi1+Sw4SlXisIX5IyTNr2y8HW6
	aoPYUdz+1+NCzRH1Mm9PMRcsPvWvF5V1d22rQlHHJWWHq/KOktyZh4OierIOuc4g4XPoNh2o0IC
	Xmgku81XpqFK9EBNnfJYWMCLY7JpvIP5CVQkoyv5qqD6Qj1HMkTSdi7JzTzkEx+6JWkGKxKwoeu
	E4aAf80Eze0yaK7FBgc5FFZaJRjfTxmhRiWtfF8UMolfv0bC2qAL+tVljWlCRH6eW5WrQsInMb9
	ml2ggykLgqLs+p3KrssYpfYB1NPtYhNOPA0ApFXTsZLJ3A==
X-Google-Smtp-Source: AGHT+IHAUyh4LXuZ9geWtD3VSINrIU7deJWl98eOrTRWatX8FlA4MHb4lnVH6wlCT6VNdVZEwd+PFg==
X-Received: by 2002:a05:6a20:c707:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-203cbc2715bmr23487488637.1.1745300761746;
        Mon, 21 Apr 2025 22:46:01 -0700 (PDT)
Received: from localhost ([2401:4900:1cba:4d5f:668:74ff:fe9f:7991])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b0db157d243sm6616584a12.73.2025.04.21.22.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 22:46:01 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ 0/2] Fixes for re-connection issues with ASHA profile
Date: Tue, 22 Apr 2025 11:15:45 +0530
Message-ID: <20250422054547.132400-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of two patches fixes re-connection issues for the ASHA profile.

Arun Raghavan (1):
  profiles/audio: asha: Only expose device after we have attributes

Sanchayan Maity (1):
  profiles/audio: asha: Reset state on disconnect

 profiles/audio/asha.c |  7 ++++---
 src/shared/asha.c     | 30 +++++++++++++++++++++++++++++-
 src/shared/asha.h     |  7 ++++++-
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.49.0

