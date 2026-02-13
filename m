Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8F21C16A
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965712; cv=none; b=rDWtK67K/iA25Fa+WdrJr9pMWgS4YhRgVgfjLWjkRWcq/EBGBYMV1wd80bybKe16uX8/89BEebvA72PfMpiNqtyrKN91jM/wWLYosKjEw7HFAkJJDNVvq3Cj/5nOdakNZOxDrHg6OoJFuH0REf9MEgp+gNNkLVrjSSYrg11H2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965712; c=relaxed/simple;
	bh=RcZ2fR+Zc0hlFbCEM6LVXhpG84KIbpoIhQ/vh7jF/dA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AvNlgIaFJNBsl8iHqhhTW2jztT+3i5FbksXx0UEk5avBy8/IbUzNMiC3PQkqs40ZJwuSnTvvd/skKa+MKzU8cZmuEtOaW4zWr4Affp524Mc8XneR2f06ZN/sD+3cUynZhFnp20DCRyrYAogtEr2jFEOvOt3nt3d+3fD725AhEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNUngkQB; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNUngkQB"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2bab70f8c8aso622843eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 22:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770965711; x=1771570511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RcZ2fR+Zc0hlFbCEM6LVXhpG84KIbpoIhQ/vh7jF/dA=;
        b=BNUngkQByb1E0QaHeK7MZzdFIQ2ZesMxByQuf3mFwLQIPFVdL1cnPM/m8W9bR0nk1d
         kqHv9GorsGIdsusC67WWAd9fJ+TaG81Kgu3oNGwz+YqSRUS9whCLbE7ExN99tCDihzBO
         JpCtR3lVZB7x3Qf0EDX3pbCtnyv2PIeyLzGpWPMafFcJA5O/PfYxggYVMBEvzRCmx8D2
         v1b20utSRcdzdX/4wYighen3PRWGMFoQVeyINpobFXg4QyCmmtPst0//5o+rrcnyRmqw
         YO2VpQ81FvV7CS8vz0EcOPQSKzhe7nbXnGH30lBqtckSjptuDO9f2WCmKlpKivFbHuOG
         pqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965711; x=1771570511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcZ2fR+Zc0hlFbCEM6LVXhpG84KIbpoIhQ/vh7jF/dA=;
        b=O6yyer+Mh5bgB+qH0YNErvzc5bDTdGFBjF1l9iAuhbbE5e/BxoM/AXS4p/EXpaaayj
         MwTEyqpTnUTU6U4S+NAlmTkrJt+iBa2PBC95CSMmr1kxKcIqR3+FMMBf7AIO6EUJ4wHY
         VXSCIDnj1+almN+LoNHlZKwI0spqRDxaAyq0rnLz/yRD6UJ5mH1RHncaIWONzmFXNVrr
         k0r5rZxTgYNw2NT9AqLPXpdhkvR1Lc+osU4LyMnydHlEgBOcl0ic3/OCndGEqtGYSO6b
         814n+3dQ98XEENwpVJ6W9ZZqBqRwTnlZ+dxyVi1lMMFJ7iO7gxggq3pQNBj2s/W384cu
         f3cw==
X-Gm-Message-State: AOJu0Yxdgt8BkxSTG8YqZV1GKZq5Sagk7yTtuppliCOvHfQ9ZeszUeS7
	brhCGNobOa179hVZucx4mcoZgTJll+PGPqK7U7K+TCX6W9F8XAolDz7zlkH1jEZz
X-Gm-Gg: AZuq6aKGK/caqPScj8F5iBZv3o72zmJpIDDfKte4eMipAFFu65VrxH2nXz1eedUbwst
	o992S4vKuQC2eWfFNocdmckEBpTIero30Uq1NvXYDzD7D62ASkznlA8HAPTpn2VQhscZDLtI5jJ
	9IpiPYOf2AOceDZSqxIMtOYrWCjuLy60Nf8sYNr+0J73QQYwTdFFi5dwgmvaM4qX2IbjMhm7q3v
	0WNuz33TICQPqi3sTY1z+C4ZkB7b8FLSMiYTcPVB3YO8NDCuZlnt5Pej7PSc8RitMP7dE7jbhCN
	ev7zmp/596frQem7KHuI/IHfiI/Dyif7Aqev8ELKRGoJlFdzSemhRoLqItgK6m19rpvhYHaN79o
	Q0SxXyMUbFmtT1x9bY55XYGjRfvw/fr5tl2JoASY80ZLNGa028C3Zgrx8ljk3D6Evjn5lnHQmql
	8smqoP6JGMrgAQcW1xoL/agWtv6qFpBiAPP7jtZn5M7g==
X-Received: by 2002:a05:7301:4085:b0:2ba:6e6e:d8ef with SMTP id 5a478bee46e88-2babc53a802mr305186eec.28.1770965710581;
        Thu, 12 Feb 2026 22:55:10 -0800 (PST)
Received: from [172.17.0.2] ([172.182.226.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcea9b7sm4921812eec.25.2026.02.12.22.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:55:09 -0800 (PST)
Message-ID: <698ecacd.050a0220.16ce32.461c@mx.google.com>
Date: Thu, 12 Feb 2026 22:55:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6522662160739546455=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213060401.14200-2-maiquelpaiva@gmail.com>
References: <20260213060401.14200-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6522662160739546455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt_util.c:413
error: net/bluetooth/mgmt_util.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6522662160739546455==--
