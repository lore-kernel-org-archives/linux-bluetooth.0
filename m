Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9320E323
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308650; cv=none; b=a7Q0HI2DdD0bc4fmvWghLrciEeBAxiAllUHb0rhPOTj13bhATeu+tfnuEpkEfUkUl6LDyr4wWaHNCZ+En8vvP/tL4pkAz0R6+856mzMCFQjxOxxLs1NnR1435h0Cp45FW6vAd5IH+0w92+BnZvopgBBCYbZMzPlr4pzPMkezYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308650; c=relaxed/simple;
	bh=I36fHoSMCwGoTaTot8hnWYO5RwFs+Z8qVvY0BeH+u2w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N4SBALS1k/8WrJqkjUwbZdHxLAZCAeh9HvpgO6oUuDbSgvPocTN7He0lm/eOiirWRgYPrX5YT0tuS4xN4mOaZfv2rIiE7FBUysTLsmNKE7I7BCA7ztLwTFo7PZakTy5C6GdzGPTRmp5qKPr1x6sy/xGb9Y48Z08Ro2IbX1DUBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIPKXYqJ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPKXYqJ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd420f82e2so74965856d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308648; x=1742913448; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ybU9biKgWaJJHm6jmZG+zHdXO5xP3I85tpjwyipWp9Q=;
        b=nIPKXYqJ4RYtPLTvU2B1fhcYYdMJsIqyRAYk0Kt0wFSjIlQpXqD1jTVww6z2FQAiwS
         cPNlPA9PQN7odq0lGlbFY5wzz4Nfrkk7mosqfNeLn+98sAVRRsN+SQzxiJDWPso+tvMM
         +NB+X/ZDB71N38g/MA1C61S/TQiAcTASNVpeR3NX2i7Er4YpizxqY27k6r6+DByG82Ry
         rVimzPRe9PwRoh4psa6t2dfujDcyrZOgNsdVuj3u/awHbGaF4wdZ2YEvg6arpkeMODgT
         q11k72x4we8nx18kS2bRk/NEdm7Y41Iz8C7oLHjlRF2jTaCfq+82R5dr6SozeHF3eY0S
         0AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308648; x=1742913448;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybU9biKgWaJJHm6jmZG+zHdXO5xP3I85tpjwyipWp9Q=;
        b=rrslOownpDev/MwONOAsnmzMQtQNjfyhKCrF+WNv3slFW47WKWrhCwUQD9a89xy3n5
         BHAlgWlCyQl/UMsekWO1MDQJ/u8vYMcbat6wTsOrLJM2zl6bOYjluIYnT3yRnU/+ACBx
         OIM27g7fqrpaFgwt5G00KrTuYBpAxgXtxFOtdmdqaXXlvoJ7nSPJFRoEo9ge4msW/Ty5
         V8OWgj4B71QbtLo0W7dFNpBbswCrmI266eXZHTXu0MA1tqkSTSmFIdHnH4JUKljBTNZE
         wQmxIxJgIUU8x7v2bVzUcZ7W4T16fQ8sPeafLdAZsOw3bc8VzL1GLqEP6iUyGpjxEk06
         1ZDw==
X-Gm-Message-State: AOJu0YxW3tnTcUB15ytlzwY/Rf9CMFrir+twggeDpPl/zUxcD+nztc9c
	NWe85rY3zQ/cVJrmtsAUb4ZoXLzYQHjZK30SvyXb96o8bWmr8v3rGYN/Ng==
X-Gm-Gg: ASbGncsV1GzCY7iiRIk/bkqMQBGR0Z6Id4g/vo1JWa7hj7fYTAec5aBbO8bGENpD00f
	t/it9dv9JspaTH4ZqwJXpYGda2KAjuWaLj5GktCHH3NnEQC7wbDcF792jf52bQgHm5R8OAIKddD
	/lelhuat+CBnprfmkHtZD9mbfUtvh5myfuy4sOf6/QOKB9r2XBz7wj6e17mIXWMo1xGUbO18UwT
	mXqPa/r7GuoreeyCnG8+0ujg8p2Lotq4fEyTmS836O6FyDpQIW1ZosFjqsp/gTvtp3+vBZv1wlF
	G3Z7VRY2yNdj6/ftiy5eUfvVr6hxvRfUH7ecd81XJoySqezAYBuPZHkjYtbwyg==
X-Google-Smtp-Source: AGHT+IFhbtvYbK09PBUYDuQRcqtd3KTzCLtu697QSRdXLxPkpbjV1IVgTFCJS1QAzicpGka5s+YxzA==
X-Received: by 2002:a05:6214:27c9:b0:6e8:f470:2b0d with SMTP id 6a1803df08f44-6eaeaa52367mr313632636d6.19.1742308647814;
        Tue, 18 Mar 2025 07:37:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231256sm68336946d6.32.2025.03.18.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:37:27 -0700 (PDT)
Message-ID: <67d98527.0c0a0220.3c330a.8732@mx.google.com>
Date: Tue, 18 Mar 2025 07:37:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6611200328790235554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] obex: Fix typo
In-Reply-To: <20250318132147.91774-1-frederic.danis@collabora.com>
References: <20250318132147.91774-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6611200328790235554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945150

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      1502.75 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      159.02 seconds
CheckValgrind                 PASS      215.86 seconds
CheckSmatch                   PASS      284.56 seconds
bluezmakeextell               PASS      98.53 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      873.80 seconds

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


--===============6611200328790235554==--
