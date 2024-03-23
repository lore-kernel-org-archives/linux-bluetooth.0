Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B93168A9
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195490; cv=none; b=CjANiIRUhwfT6xzg2tnZhwbKAbOXAd+1d1JObwt5puFuat/Lp7QhHL2elXKKi5ztgFtF0v4VVc9ZDjOStvlhqJxLEAugIVIWpMMJsQbQtg3q1QaFIlmJJdHwrbQ0efh4bvIbWjlG3c/shmGATvoI8RaDpAoZphaEspZVzsC5bF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195490; c=relaxed/simple;
	bh=yG2zYpMRECYII3Rg+UPk/oUmKqF2oIqwnM45HPfDDWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nNtY5o2s9H+BVDzn+0uP46uqO7XHmqLYW6KSTTLM/eZJPvcuM/g21JYMB5LK2qln/bwSqnO44MgAVobOKkFSTrn1MeWWSOZG5Zwsd5rfN7HO8Q0LZoda+Z3YYc1sx6zfGTHYE4ohtFpZMPpIAklUXKJLimBlP0J3qWsEBiOEgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptwr3H/m; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptwr3H/m"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789f3bbe3d6so218657685a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711195488; x=1711800288; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CpQY4zWTnAaxAUtmJbhsdP9Ci7YUYsPvhs3/peFRyTg=;
        b=Ptwr3H/mQNnBzg+AhRRiSnMMQxZmlFcPMZ/LXG4SlpFa5u149vpuKRLem23tJJlmJy
         xSppZNZg4Q6RnCUZ+4Iv1SfQq1aje7l9vLLbBlAXjLoEVbvbNWktfIksOqW91fUjf/OX
         qxXewycp+FUew5TAABueW4FHkSmBUXacVn2TP4dIfmybYg5HRQypzY2wfF3bo6ji0dvI
         /Ig8s+43s3QWEg9GlI6Psvva5SbP+KOjuuTNyxCIVITMELJmqELWzZzgAdVUJOYvsRD7
         gCDJbtOk38DumfApgWKO8pbeUflvZ527LbdYI6022s8r2hN1CfduK7oUJaNnR1yYhtXX
         ujwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711195488; x=1711800288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpQY4zWTnAaxAUtmJbhsdP9Ci7YUYsPvhs3/peFRyTg=;
        b=NqM9cEYzHZsU0Zk+hxvzTV/yxlODcOsY/t0B9Oz7BDMefMZfd48y8/tjxhq5OG7EMH
         P2JpBRWLwFNmsuS46304Pf3SOEAQ3vuPDaaV7v9semDsKLUx0Y2sHpyzyQ7+0iNsmml0
         LAajvITlMdf6GLWYzobC9qL8uX6jHF20Mpl3cMqUfOndbQXyaYui944ARMF5HR0VkqSL
         nWZ/ZhodyXWYbJGGw49f3hBQwtEUeLodBzxA+omXGXLYrwLQs0Z2P/yLVjEGPzJ3gQYw
         Oph2E4egnocaCFL6ofzCxoF+/fGlFG+dIjtPQjib65conyYjAW++yU0AvhLN9zx4XMMi
         jOvA==
X-Gm-Message-State: AOJu0Yxi5qKpe1y61igkqECB5/v8frOfVMBsdhwM/VcOpga1LV1wmUa5
	/sGnQpyE+9jx/9cCcSdpeXswiXJT8z6pNrXe+hvTpJPi5GKyumclr1wMzPo7
X-Google-Smtp-Source: AGHT+IEtsfq9loBNCb/hgfjkq1Gsi1/9DQmeQ05MH2cNu3bR3ojAl5wa4Wt+R03lVaBP2X1vzVG+tg==
X-Received: by 2002:a05:620a:c12:b0:789:fe83:c601 with SMTP id l18-20020a05620a0c1200b00789fe83c601mr1903740qki.53.1711195487617;
        Sat, 23 Mar 2024 05:04:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.245])
        by smtp.gmail.com with ESMTPSA id wj2-20020a05620a574200b00789f34f225dsm635638qkn.71.2024.03.23.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:04:47 -0700 (PDT)
Message-ID: <65fec55f.050a0220.e1f53.473a@mx.google.com>
Date: Sat, 23 Mar 2024 05:04:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7498279877801067207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] shared/bap: add bt_bap_cancel_select to cancel ongoing pac select
In-Reply-To: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7498279877801067207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837533

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.18 seconds
BluezMake                     PASS      1672.48 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      178.60 seconds
CheckValgrind                 PASS      246.92 seconds
CheckSmatch                   WARNING   348.60 seconds
bluezmakeextell               PASS      118.98 seconds
IncrementalBuild              PASS      3039.28 seconds
ScanBuild                     WARNING   986.96 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1046:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb)
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============7498279877801067207==--
