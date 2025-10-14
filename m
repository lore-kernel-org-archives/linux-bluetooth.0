Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FF2E1F02
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478526; cv=none; b=h2ByHZUgt4iA/qMXS4IIYjn3ombKHKVJx6i2hNapwqqLQ2r+Qs1LbFMvjNzoz5OUnjDhxoNYvLv9Qjec9Mak5TRqChAUoJzPx7+YQxTGN7AAc6gM8Lo+jzkmZgJNNWuqOE0dVvazKIZGkCHXEx4V2+cC2ZX9+lAFbjfoNL1aNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478526; c=relaxed/simple;
	bh=TnOvv/+ob+x1inI5SxH/sbOKpns7z0ZCO+IdEfFRMe4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CIH1mUfyn1ecmsbCvpMGEmeY3nP78h1m77xpApsiKpt+TLz5IdwB0iQlKysOfq0Uu3OCjJKX2Q/sRSEP9gjAyAGyYVdwplvqIKhoAbRUGZaZPA5emPSRPKSX1ETWyGXGLki2hjxtv/b+rz6eJxyA2qhvwjn3ZnB9SuvVC/DuZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEwxHO+P; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEwxHO+P"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b593def09e3so3977222a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760478524; x=1761083324; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vKP8lXkKxjqCFFjKZSxEskorpAPIqbApYQSBu/ni1mg=;
        b=KEwxHO+PS5Gz1OpzVjKpbJNNbbw0xgaXPSKHetdR7S4MMTBATCWizJxvOGTxbcH8Bg
         FCIIw7xGuJonrJgJk28wy/k9vVpzNta7ATqVp5X/3izXhs8e/d1DeJAPaxIbbDdMOAAD
         xIG/boUvUJ/Egi9GT6XPknH7PRSr93byhhkfpnzT0RACxwuTZmR5nlQgEG65nM54NXoM
         7/O7HoJJPyMGVKaKQnz/9LLCaSQaB4P2rH3Z3hLjdKbxmucPxrGQCwtMOapmIRY7vkzc
         MYK7naE+oGmuOFXiEDa7irrNz4xJrIIY3ZRhb+9W2EoCE8hNdwQp9HgearoehZ/bmHRF
         ibUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760478524; x=1761083324;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKP8lXkKxjqCFFjKZSxEskorpAPIqbApYQSBu/ni1mg=;
        b=Co7Q1xfwbX7xxk7d1wHWO1YauccBLZAaMHroY43RSo6mR5wHXBZx8K29K11DLItAXr
         hPZaFdwwRLiKIz9MUa8KccstapAcGRIAjJlEeTMvbU96sjPZ5peHTJ6cBKviVZ0QMUw6
         Aevbd79apUIKtr2QCiW2CUg/ErLxY8c0wEa5XyNsoNR10H6nbrbRiYbCvJb6aAkIJOra
         mXS+1uVprrwzRggEGJJhznhMU46rlPqf5gNv4+G9Fwi3YyETTo9TC89ZabbqhBwgHkd4
         cN6ZfbW1a2j3AKBr0Lfm8INvqX20Sr7QwhW4hMJz2nxlEuQoF3P3hfHQWn1cAoHoKPpY
         sZqQ==
X-Gm-Message-State: AOJu0YwkP0Mo72InbIF/LfiwPMgdHAbxBNXZMrifYrE3v4lWCNox8pmT
	j+Z4BVqMW9gc930bBNWjCH59dT0RIrdENBhwGR76iufRWw8y1dvsv4m98TmPcA==
X-Gm-Gg: ASbGncuzzRGowzCmggCz3jReurtAUTnYox7obYgfW3kfMPPGzMos5Vy81ce2eYUzLxm
	nYNiGSPhkK7+LaWFTwzpdsIO2F5Cq1OMQqOmMcwYD/UQOp6GlIzzjWWXrNrorcCyDl7v+cFCtkr
	bA9LO4Z2XDK/DtNadS2PuH+ug+ZyZ2q2Nxq/9fQbkVQMS1ABgh8W5XV46QPrVPh2dbwlgu08vZ0
	9v687zrfJp6xHgFNSKF7BR7jVzksfGdE/Yyx7JAbm6rNeHkhrlxKzNgjeVynx5R3jg41Ca2X+WH
	TL2j3B2n2/edIYfwGiZSvJFBfdw3q+hsMesl3tymXiSc8l1pWhs1BOL4s1anojB4XGTPPkFuGra
	YX4a40gqCeMaa9eQqAwd3tiw6qW68ZboEWTGuJOE3VbpfBEmagSEYxF+pRS0=
X-Google-Smtp-Source: AGHT+IEVfzmwKqK5cv799MOoNugdwWGacAM6a19i3sYhOmFmEHbC3VWXX2CYmf4suv74MKUqBAKjGA==
X-Received: by 2002:a17:902:e851:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-2902729031cmr370905835ad.12.1760478523712;
        Tue, 14 Oct 2025 14:48:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f837dcsm173445685ad.111.2025.10.14.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 14:48:43 -0700 (PDT)
Message-ID: <68eec53b.170a0220.1323a7.d99a@mx.google.com>
Date: Tue, 14 Oct 2025 14:48:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3879081446620163213=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] transport: Attempt to reuse object paths whenever possible
In-Reply-To: <20251014202551.423660-1-luiz.dentz@gmail.com>
References: <20251014202551.423660-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3879081446620163213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011517

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2691.70 seconds
MakeCheck                     PASS      19.76 seconds
MakeDistcheck                 PASS      185.60 seconds
CheckValgrind                 PASS      236.80 seconds
CheckSmatch                   PASS      308.80 seconds
bluezmakeextell               PASS      128.20 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      911.17 seconds

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


--===============3879081446620163213==--
