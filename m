Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B41A2853
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990514; cv=none; b=n26Aaq47PRKiNSPHemHJ2TGvnMQLJJvetSlm7VR1DbXUrOx1UHhplSGvwsRz3+ATsVv7sZm5zIbZ1BRhi25uTsJxO9sF0pV27iVZ/La7RyCQ+7B0tVe/SeE28JGyWn6JkOS1Sd1x9iszmrENQ7INiyKDS4v8vu1FO/PpHcpSIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990514; c=relaxed/simple;
	bh=uyiRTo7la1WcnjMQWx24xJH0fz6Zk5Ihn0TRR3BAkwM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=egneJ42x53vc493sBSbMlFnV60fKxRUAp5TriTyPIhMVOZFIGUpmbhxP/HsBZXb8I7cM0a7XpFOdJmqESwZF3lf7NCEEC+0zlwoLmkHt8qJ9L91S62MwR4wWMjQiDv/0sUlNaFKSi5xQFKfc3zaZWtdHRDytN8N9KiceFxw5rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF45ugK+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF45ugK+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4583083d019so15077261cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990511; x=1726595311; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TlAodoAKTT45w2z87Jj/8+oc4GDMfittClGxCQD+3Qc=;
        b=iF45ugK+zUgbUvtzws1SRZzIeuQiP1tbvIgZwvtRO5+5ufjrc4Q1T4FELCIwMsTSG9
         +QkqQXM2GXwNG+tuFT9zk5PQTetqkqZCvW9pSARNb649Sy8nHFB7rYF7yU238Ui9CfUz
         a/gAmLZ13tI+2xxJIPVYlNdFJJ01Zx+NDnU961PHuWsIObL4pn2UDzorc+rdDkbaGirx
         Jvyei9FCarseJjO/VjiyCt4opqX5LmhJIkWxRtXVwNRwmCTDgFsabNZP7V+zW7pDshET
         UIscZ5b5Mi/VPpj9HPZ6uMDO309L5+seG096SZXMb72+GADrAZQKXtEkTN+diO354enB
         MQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990511; x=1726595311;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlAodoAKTT45w2z87Jj/8+oc4GDMfittClGxCQD+3Qc=;
        b=vH3xkjk9Hzw7M+771Ijna6i1KR8MjUVhCiDITeT1kaGlsz5IS7xH3f6eBUVvFqkSS4
         eWmLIjXQEvJix+jbMMPK9JSGZDSZggVCIWqS2pove17LnlzOUtnGnnlNZY8WL65iWZYr
         gf2UtjAHxYwbqDGnIjZbgxkiJXu8M7SX8cZ+Q/Rfq3QbltquOLAhyt32Wvkw2OlSnHIT
         eeQpFxNNr8QtBwbhMjfYoVUEB+ErJ07oziLcMOvop/9NZeF030lESl9ja+lsZMV3Qb0B
         lyrwiq7VKuagCi4lU4BQ+jTfraJZ+y4Wuqd5JN7h+N5mGxwTD9KNEJue7gfvRrdZZIzt
         mJ3Q==
X-Gm-Message-State: AOJu0YzYLQtw5W1BlWwm+DZeqctoe5UrzntwftYJRQKtNJXnnoJueT6C
	8VGMZrKt9gl0HyFgFhYvAbe3s19vdWx/PMu55tA5zmbz1Y8KRAtDpT/jog==
X-Google-Smtp-Source: AGHT+IF3xWiL9PCuiZJkAK31hIAd/ltpx2IgknOFWRzEdl8xm3Uv31Ts1gn6XJAPhnH608/SNxjN4w==
X-Received: by 2002:ac8:5dd0:0:b0:458:3be2:d2d5 with SMTP id d75a77b69052e-4583be2d5d2mr70599111cf.41.1725990510989;
        Tue, 10 Sep 2024 10:48:30 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822eafc81sm31100831cf.52.2024.09.10.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:48:30 -0700 (PDT)
Message-ID: <66e0866e.050a0220.1d07ca.c35b@mx.google.com>
Date: Tue, 10 Sep 2024 10:48:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2952236933198086619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v4] gobex: Replace g_convert by utf16_to_utf8
In-Reply-To: <20240910154450.164911-1-frederic.danis@collabora.com>
References: <20240910154450.164911-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2952236933198086619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=888969

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      25.50 seconds
BluezMake                     PASS      1772.77 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      189.95 seconds
CheckValgrind                 PASS      265.31 seconds
CheckSmatch                   PASS      369.44 seconds
bluezmakeextell               PASS      124.73 seconds
IncrementalBuild              PASS      1528.22 seconds
ScanBuild                     WARNING   1049.82 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
gobex/gobex-header.c:95:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(to, from, count);
        ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2952236933198086619==--
