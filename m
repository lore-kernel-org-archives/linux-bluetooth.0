Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E042086C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397218; cv=pass; b=aMTGy9LoifIlWJqVqodT5zgtkkl4tYvSA+ibmfBSfPqOlh58n3LgCuyvKSoOuqYCsrlDIcgadqmiHam9P3s0WC+djQVUaZoldPqRDZhwud9AIxjUPmVo9zIsm1++7D0bv8ylgr6QXYJcIakixwETCDmr/5rim5cq9Oq3ixQ9OJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397218; c=relaxed/simple;
	bh=yoLoLn7VlwiKXgZNsyKoCmjQqAZ3USFvRCDT5z3vrpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRlrsVfs6kzolwdx2CzB6PGwwTWlfQDfR6Oxa6eiwC4mK1ua0cIkEmeZaGLNzZ6iVrd1FP//2SxkW/y2rQde6Xezv1SRfOdTeeLOA1sXffNTe2hrko1/4Mv9F8rIBiNIGd92mVv2mswe4RMqqWCGp2YKPy4ZxU1oLPs1fnTPBGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4sHgp4A; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4sHgp4A"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80bab6cf5ebso2960577b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 21:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783397216; cv=none;
        d=google.com; s=arc-20260327;
        b=jatkLfwMjk/afiUsYEuRQna0l/VQh69GT9zs58NI3KLUjbd0CqUqK4JW36k2NgfXX1
         6iuokFw+pW6+UfvcVEH8Gatqe8jd2zz/rDgTqA+/ldV2sK7LuUHnM2lG/qEU+MFuZLQk
         0cMW8tr2e/SXE8Ykb6tzUeECoBpdCgjQAeQf+20d+VuPBFdDlMFdmCHCq3zrKX8mFiPL
         K9bLGjQl7MFeiZZZOa264tB7NTAhbCqEdCheNbHEvn//9SfNCS0y/qYwZU4HGYjU2YcR
         /NaDOiYZlfSpEXVPvI6Xw6EE9KX+26ZrPgwJQ4rmHuhqNx6+1V9Io5NasM7YjwxPxtFg
         YM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yoLoLn7VlwiKXgZNsyKoCmjQqAZ3USFvRCDT5z3vrpA=;
        fh=Lqwz03XgEy2+61mKN8i9eXgIafMm23/nT47hnw+gOy8=;
        b=UFBdO8qRoDaXRzJCqmU0A5ojjLX6z8HUdC/NQFCDTnDkaIgIzIV8FgAOAb6T3qgo3Q
         Qmx/0jFJSxQbS7CgFcoaSBqpPw5WvsEb9QUxmgbdcfIjD1Iv1OBGHiZXMfDbgU2iE63c
         XunRlC/wVUgESAZ4rdERhgf7S5Q7gKbVBGptO3P5nBFfuieMuH4OCBNbFqfySfbA69pa
         INhLy1yaAOEnvgSct4jiDL3/fJRgiyNEMvqheaedpWt+hUy4vSk3vrZPUEetxyVP539y
         iDJINHTV4KcBUtOyb8VwNeAFhCzNRQazVjV24lGqjwFFjX/PHBvEsBJSv5T91rb1XaNj
         uePA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783397216; x=1784002016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yoLoLn7VlwiKXgZNsyKoCmjQqAZ3USFvRCDT5z3vrpA=;
        b=S4sHgp4AHKY8z9f79UfD56bLCdIfT+PuAAacJPBrHSy8bXMp+3Inr5S52hj1rXeJc0
         JTeJJStjVlO55xEN2FNaG4cQhTaGCoy/eJRVpwZe6Mjwv+026XgqXPF275vePZOIbCdI
         +LatCLzAf/e+UpjCqgths6fKDNbZJdkBLeTaM4zGn2SYWJjcRFPjlewMaDIpI+2GyPmP
         1Bjv3eGdjPQLoeapASFLKzlr+h5norTiQH1l7KE3IDifYRtsreVtMWPRVzWrhg3TtV2T
         YkmNt9QdIVjh1lLJhsUQv+whuEL5cidXWm08DCvnGQBTfyu/5ze9sCv8flH7Ihgux8gP
         YSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783397216; x=1784002016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoLoLn7VlwiKXgZNsyKoCmjQqAZ3USFvRCDT5z3vrpA=;
        b=RDcLlNBIszd8+w7SaGtOUb0tvaatLJAicgNSJuFYd65suShlwxoEZ/eSqYzXQL4yGv
         aquE5jBQWcXtCCgmVUhMyJ8ghtey+VSM5TEHejlIHhB+lRLX/0oNn3FvrFt926F6zs7+
         ry5yobFG/sSC8ZdOo5D6cz9egF+iFC2oq8KUkA8vEYeRvor86qCm2E05tlqHbN+p1QZX
         YbW10dzbiufUsp/Qdi3VSPI3E4LW6RFTCJMgmbOj80HV3KJeVKYcsn4gzg+H+BzEym93
         bIzSGJzEiCDu8Z2wTf0IRWAQxVUwhjhIvyUc10jCSykPARsWPBqZTGfF+d0VONMFtycr
         SSxg==
X-Forwarded-Encrypted: i=1; AHgh+RpRaipuYgTRFa4L9t+iPKm7hVArg2HFqNxtjtEgFCZ4azISgMPhlcL4DAz62DPfGixGUq2oGhSqWYrhqFcogiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ngD2n3ILkiFAJ2jgaw8lZDhiKWkMv6m8z/mth7R79unTPiMj
	MSwr6KC+mLrhzhlXND4jDbnMZFNfEQq3mk7VyUAKDs1bRJ+9cJ1Hw5sxMkBxwmNeQ1G8fA3HEJm
	oS/5s60dYpGkodd1apepmDtUk6KWBpJ8=
X-Gm-Gg: AfdE7cnHs1hBjb5XYBobo/yLSVPVELZ4TWI9BAvvZNfyjJCCu1J/xmrBwbRzd1LdaPC
	xX/qTwzZvpBsCbT6R+aEY30q7idg+Xi+TJxHfrka2vSpAbq0elT2XNluNpOtm3UlAYmNLTOtLH+
	XKDxRITEjuJKaYGAo6KX6+qEcxnlpgeAa4fLiWyaYMTkbx9853E0TsRGJEznvO1LpmTyjzdbZ1u
	ZnseVkY8j8uzJghT+pT4LpWCk64GbQw68SWEVeqhGfKjgCXmKppWYCquE1YvJsow49FMVHUV90=
X-Received: by 2002:a05:690c:6a01:b0:80a:a005:80fb with SMTP id
 00721157ae682-81c5df0cba7mr10141287b3.29.1783397216143; Mon, 06 Jul 2026
 21:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703172455.2363611-1-zzzccc427@gmail.com> <CABBYNZJjpt7cQFnevKo=wYbo3h0Z1=8iHUqjuDSZYWWU5jeLkQ@mail.gmail.com>
In-Reply-To: <CABBYNZJjpt7cQFnevKo=wYbo3h0Z1=8iHUqjuDSZYWWU5jeLkQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 7 Jul 2026 12:06:42 +0800
X-Gm-Features: AVVi8Cc2Xs1Tw-jb8VhGhpPvYtr1lSrj-Kp7MiMlWVG6MqBF_EF6_2dXK0TaPE0
Message-ID: <CAFRLqsW1u6XCVL3uB4rfJ5os__Ti3mtgpEu_=a=SV7UE2jr3Hw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: validate LOAD_CONN_PARAM entry before update
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for the review and suggestions.

> Don't really like where this is going, we shouldn't need to open code
> hci_le_conn_update_sync

Agreed. In v3 I kept using hci_le_conn_update_sync() instead of
open-coding the HCI command in mgmt.c.

> It would probably be a lot simpler to just pass the connection here
> rather than allocating another object just to carry the address and
> address type.

I reworked the queued data that way as well. The queue side now passes
the hci_conn directly and holds it with hci_conn_get(). The destroy
callback drops that reference with hci_conn_put().

conn_update_sync() now revalidates the connection with hci_conn_valid(),
looks up the current hci_conn_params under hdev->lock, copies the four
interval fields to a stack-local params object, drops the lock, and then
calls hci_le_conn_update_sync().

Regarding RCU: I agree there is a wider question around protecting
hci_conn_params_lookup() users. I left that out of v3 to keep this fix
focused, since this queued-work bug cannot be fixed by holding an RCU
read-side section across the work lifetime. I can look into that as a
separate follow-up if useful.

Best regards
Cen Zhang
