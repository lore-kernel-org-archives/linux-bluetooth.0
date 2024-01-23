Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBE5026C
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020487; cv=none; b=N2eeg9Yd9HQL6jzipakQ+l12/x4MdZi+92QtWWdzsA7+YKvcP2TqppT5oZwUtNFtzRVsaadXSqhMt8Xdu1G5OWdQDaavFbSyvj/9sY0IkcTjlq3Sp6DZdB0Rl8BwG9BIQje6UCp8iv/tvxH4iO95Y/32mgVuqSquK6qN/CSyP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020487; c=relaxed/simple;
	bh=uJBp+FlK6WKnQgc2vS75pS2aZzn/nd5DS/pX35tApNc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FUZgVbQ4e+UptNtpuaSKzFV0DRRaE5cRwWYvgg5z+NXs+gbkUBaTqP88MJTpplG1lOdwKH7mmyUHd0tK6LnlN8k/uyYNDGwUl8JFGuVUc5zEo6ZGDasAwgUD8Lthy9iq+DVMF0OI3ePq193k3QtGtjUqjIB+YdHy5RyLJ7nAs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKe16+MO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKe16+MO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746856d85so12648675ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706020485; x=1706625285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KwnQx9Kn/FKr2Y9Yi0CcIfHQ5OkgMS/k8zSzEehgg1Y=;
        b=SKe16+MOxnZT2Jw3l1XsijJ+CK+k28pxXu1ZyPG3WrRwmjhb25uITCq8+gOIaG8fAw
         xps7Z2FvMuiVpsD50eaCn2PwpYE+dLBG7wjyvUZSg+Kt4I5R5U1y8bfhauvaonlkeijW
         HFRvnRRNz81U5vCZhYV5sHyHSC83XK9bsUMcuse45SuNaNy5IyUDgmSPYmzAQ/yzAXWG
         tqrUs149Si6O4YNk0Oe00CgreGQd/SeYBpkAGv6fcWSPnIxXSeuqrsiFmZVJQuU2Sbqy
         QRNql7bzMe3DzM7K7u/ig5FtXeCHtDNRKre1762cFMegw6qSUwOThPEpHiU9SGWa2em1
         f3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020485; x=1706625285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwnQx9Kn/FKr2Y9Yi0CcIfHQ5OkgMS/k8zSzEehgg1Y=;
        b=iaxGKO86p+yXVTehiOA7vaW+uTuUq8jhsmgeqtE03mbnDGd4PBewlbZOAjV/uFJelx
         b0FngOsu8pf1/PaXhoDNuEqvPJxfs6gJ0+/CBfmgFU6JyZMuVzjRaxxKm/z1jNeFBu5b
         6jMRM+GfrwIku3EtADi1mXxCaULdXM5FXZA3WB1xNNbF3+LLgylW0IhbG3A5NGFTGkTD
         6etujdP/nyVyWgnHjaMVpW9ZWtlwtxp8SujLjxXGOr8g0tTTxadvcStLoVgkJMcp/w5B
         p7gWq+YwQt0Z482TKtv6Npf83FNqokO8Expz4Hy71bn/oJnJpBfOxxUcA868FUEjAGLi
         aAoQ==
X-Gm-Message-State: AOJu0YxgV6GPTmCPIk5z6GE+nXjDJ8n3vyKcv+XM5hRFk9BbbJ0nFwyb
	1OHvjHdWuse+RiGj1qHSlv/D4PAVQ3wo6NN65xOPB8q7SJb1zcO6WEbqqRFL
X-Google-Smtp-Source: AGHT+IGZDr0ldCcpTI3NJVjDamE1s9+GYfMrgRZy16nHh0KRj1KDKoKWevcZWJKkPOv6z2cyrC59Pw==
X-Received: by 2002:a17:902:f68f:b0:1d5:8a6e:925d with SMTP id l15-20020a170902f68f00b001d58a6e925dmr4329134plg.3.1706020485514;
        Tue, 23 Jan 2024 06:34:45 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.209])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902f25100b001d70e83f9c3sm8406931plc.242.2024.01.23.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:34:45 -0800 (PST)
Message-ID: <65afce85.170a0220.d78ec.b696@mx.google.com>
Date: Tue, 23 Jan 2024 06:34:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3498986564507348079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add code to support dynamically generated BASE
In-Reply-To: <20240123125145.70371-2-silviu.barbulescu@nxp.com>
References: <20240123125145.70371-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3498986564507348079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819102

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      23.90 seconds
BluezMake                     PASS      714.78 seconds
MakeCheck                     PASS      11.36 seconds
MakeDistcheck                 PASS      163.74 seconds
CheckValgrind                 PASS      223.96 seconds
CheckSmatch                   PASS      326.28 seconds
bluezmakeextell               PASS      105.60 seconds
IncrementalBuild              PASS      2063.35 seconds
ScanBuild                     PASS      965.19 seconds



---
Regards,
Linux Bluetooth


--===============3498986564507348079==--
