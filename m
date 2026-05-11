Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED63AE6FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486119; cv=none; b=Y8MYNFCIRRVRmSXoBOsWbdtsULRGfszcXpbwC5C+oppCc0/hqZpSBnjN7GBACYQf2QuABn2VAgcPcwikGkmV26wXheXXgTjKLmW8tL0tNosYsEyyHc+nlfRNqdF7T/T/dYJgJz1wN1sGk/Qhs/rMd2gJr0TjTYZDXhBP7lZRcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486119; c=relaxed/simple;
	bh=C9+qXSUgAtfeVPpOx758sUz32pqj5ObFdjawU0xKXO4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rleMqgnrysqgM+SxEoj/uJCjxqoEiMTFV8JBEjMX/OBezSVZLFkvTjps8U6iUxBuSzS52JNO0drJissWpxplnkO7tsulemYGq9E5NKIROIgx9Wr2+vD5Dun3JSDma5OlN5cSNzLErrCMtETrTYEryC9cdeIdMHqTQpYynchZpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTyrVfrX; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTyrVfrX"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so3699727eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486095; x=1779090895; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C9+qXSUgAtfeVPpOx758sUz32pqj5ObFdjawU0xKXO4=;
        b=kTyrVfrX77bDF24RGqt4vwYvU6vtLBO60Q2PdVhfCgFjNHEJJtTAqApNFia+aA9pn8
         D2FUxBrOQtSUigxqHhOwRkdVHs+UV4cALpgCn+BUuvOGEBxGIzerpKXA0Fq91xAkdVjH
         oH//AsGOSSX3AMDfrgRRHTx7kNcIAhzNzYvCjalmkj9To3fQUfru4QgpP4bPqP+Gw5qH
         rFr0mAR12FOG4j2goDFqo6FVdgEtBPTd69/FMWFGnqFfNpA2Ztp8fWGdF3s/0AwA5oym
         BDPhNZtF6/YdCdUXSBKA7JxPW34KnbjiMHVGAENnmHjiOB/MPICGjMOFH/Uh4qNU81w5
         yEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486095; x=1779090895;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9+qXSUgAtfeVPpOx758sUz32pqj5ObFdjawU0xKXO4=;
        b=K1/Bx4go5luW9GRRPOJiYCANp/zZgT+6OqnNkcBNkIm591B5Rhhpc/POU2nnPjaMx4
         oVn28L0VKOOTIBtAJGLRi63WpMmt+PaJNeciagJN6p2+HUDjbOg0x87ghDtuAWEDEetm
         8UTQ89fEXj590U6l+BrRuxjbJbRS1/JuGAsnqoSsRmuIBj+g/90G4K2tuTbrbTE/HwB5
         Iw4lQtwkmeAnQUAGiMED3BM6fPXSe0DNDT4Rh/eKdTrYJvg1pSsbNN6ViurQl4+crg3U
         Vv3IAiiiPza9A5WFZy/zghoXg/6wzfI4lgq2ndXFjCLNZMMSh4Nr9JO7PmpxpiyPogNg
         +oOA==
X-Gm-Message-State: AOJu0YxlTJvA6484U4297l+iVKhyrBpqAjAwG36r1HYGLo8xaut7QKaI
	TcUxqIHvKzfpkDAPrii+qBIOAZcDmEBAWGGjZLojep7im7qJli2LaNTTvfKbZg==
X-Gm-Gg: Acq92OEMmv5d5Nh/jdJeoRqtPTCKGDnDh8NmSLipdFocrnWhrDJpR+7SKHJ//nLidI2
	NEoc/fELRXK8j/fibQXXeaHsCi+JxmKkwdhD9wotDjX1jrS9mm4ZR7YIJxpyLmgq0WCANuxY+tm
	IxHY+d+oLeruX5RBfv2WXZWxnUd8SqPwOMmgLPqX8qmqliH0p0WvkepWEZ0spABx+0yRIj/rgie
	ppMWNV7XnmUYsFJwh7xsRJ3jhg9V2wmF+2fVbhjdPz9saQ+SirA9KN7JHIjV8cckioMb2TW2Scz
	1+LxaonP5HhkIyf0FcdYKyTEvx29+2BRm2h+KhCbvZCHS46TlSVpJacpRp0Xz4TbCN7yGPkL93a
	55cHjYx0rvXv9J6I1JZh0k42WU7FUFePhDrEiFz5sU+C/l3q5mNOSHwCKAOMZXBxEVxFnBLUgeu
	aIZkRSe7vMTlnq9KmreaJ/GurAFLEQ
X-Received: by 2002:a05:7301:6793:b0:2f3:986d:2d01 with SMTP id 5a478bee46e88-2f54d79b94dmr9592951eec.19.1778486095293;
        Mon, 11 May 2026 00:54:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.74.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88914523csm12244713eec.29.2026.05.11.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:54:54 -0700 (PDT)
Message-ID: <6a018b4e.050a0220.2c4c0c.2213@mx.google.com>
Date: Mon, 11 May 2026 00:54:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5908160491547146848=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fundawang@yeah.net
Subject: RE: support libical 4.0
In-Reply-To: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
References: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5908160491547146848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5908160491547146848==--
