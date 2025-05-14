Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E6276036
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226437; cv=none; b=ZPcXhIgmeVM0M2IeGGKLxMU44aKv5pC99Yms2PJZRD6uj5fk/hdVQbdehzYi0SIgU8qZUZ6X3rnn3rhcqh7Zk1C3r83fuuw+iad84Dngin/IC2Z/NB8tpI7LqObxkc+P5Hrkr3ZhG7Hr7JCQXoTXMRwzEMFtdfMR/pQOOY34O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226437; c=relaxed/simple;
	bh=Al94Yj95hiVH7lp0jUq5iIABCs0L3hqlC56DqjQ4zwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sVPYoKkqq6ub5xF579Qr9zD+xwBVg8zu2qP90BKRe/rJCyaTGcLqflWiVbUyQAwrYfAcqVLibM+uRhSXnSlh8z+mfwyYU04iwTZZwoKJQnHtIlfiI4J9dTPRh9Cc8FXJTVIcdT3K4CIfzI5oFAmK/3hLXrQtBtODmQoi9SsEjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5SqRucy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5SqRucy"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74019695377so5016512b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747226433; x=1747831233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajl0Nk0lkPUI/0nx4bokWhM1GIZT4TvbGHzO7jHpZfA=;
        b=F5SqRucyztiMQ9BBU6hAgXN6pC7O2bi9eDvFaJvHxhmtG1sS7G2waVtzL4NANuCkpd
         E9IWmCDjThqOBM76sLZrZiIWgAmgoTEG2ZskzO9fQsBUekQwy0T/ezVRiu/xy5Wp/CjG
         TmXkf3NkGlQQvm5Q4EeEOLSLEDoh6aGG3TaqEBqrGiQ1kIYRg1664mz42YNBS/By+EOy
         sfCOPSjjul5rKYM4GxDqa46rHHGQZldhVvPDTUxf+iVVduvlBvzZO+GHKjz8AyqCMJ3o
         UJrIH7zb/L6pDLC8YyfzG++/v3VV+1sv1iNrLzPMnNZ/VKJMserVutNPE0V/Kk4h7vku
         Y3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226433; x=1747831233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ajl0Nk0lkPUI/0nx4bokWhM1GIZT4TvbGHzO7jHpZfA=;
        b=rut0RR+Np1SEZTHLHx3wKMHlK+lUKHsSBoxtLzLSrqOD4CmdBCDyX/HRydWMivfnFX
         r57wvOtuSNetmZ5NAph5rVyfkDOovNppk4uiP/Kiqo3hZVM0XvPR/t8rzVvfR5fIg9re
         9C7vXIwZo5mlxoYGxMV/jVY3FOojlXpwS8DRIgVIeM2NjkKinHNBA29jtu4hMwbz5KLj
         sRzTA77VdNnYoVRbpmSFPH9wUnziFy8C+FemEWd2TaxRfyNxeo3KEsSrc07RJ0y4nq//
         tPPeQOcDa5klcIz0Us2GROuSTtM9JqsdDoMrmyOHBv5bmurBEDy7BjCXB27yDIZ2bxLu
         +pWQ==
X-Gm-Message-State: AOJu0Yxe8EyS4Zku2k9HyDeZDqftyEjn4POKCfcjlgrWSl9veEbnNrFU
	MVMg0ywmiCjbWKqxUheJDg5wG8p75LoplxHu13s5KiYtl2dLNKw+wx5eZg==
X-Gm-Gg: ASbGncte25lc4imAPrJz0oLVaZZIidR0vZA1g4TPkeXuwYem32sgkUwYQsQBLgYQbc3
	46iPmuPo9ImnUXDHa/e6u/tSo3kO4wJQf+E9fuZb4TzbDchcE6TkxH2VomxuOYaPQ/PGGdrVstJ
	9Yw3D/svY+3O3b9mTtYh5IqecOeEwRgt1k3DczfjAqf8nhwMSZNtbtawj4Ok/GG/aBSqj+bdMzq
	NE+TUnFqiG0tMehy08AJizC+gFPWv4Yp/Cx+Cl2IvmbX+k1ld4tdenm0J76uowqB2N3g4BnRKJj
	7e21PDbeBKFmxKj844I8j1wKvs8RtjOYqR/G2ENsKkUOQZ2h0S/BAAe0/A==
X-Google-Smtp-Source: AGHT+IEp0taXenoRtXdEHSSrtsF0FekxhEiaQPBu7+rNUVeR5oIBeVXf0X0LOCItaIVOnMCwppAlfg==
X-Received: by 2002:a05:6a20:a10d:b0:215:f3c2:a9a5 with SMTP id adf61e73a8af0-215ff120ed9mr5132612637.24.1747226432886;
        Wed, 14 May 2025 05:40:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.41.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ad3f070sm8696984a12.46.2025.05.14.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:40:32 -0700 (PDT)
Message-ID: <68248f40.630a0220.1ed459.a85e@mx.google.com>
Date: Wed, 14 May 2025 05:40:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8785734699861047468=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] device: Reply br-connection-key-missing on connection bonding error
In-Reply-To: <20250514112050.17438-1-frederic.danis@collabora.com>
References: <20250514112050.17438-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8785734699861047468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962794

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      2631.16 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      198.74 seconds
CheckValgrind                 PASS      275.97 seconds
CheckSmatch                   PASS      302.51 seconds
bluezmakeextell               PASS      128.26 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      907.99 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8785734699861047468==--
