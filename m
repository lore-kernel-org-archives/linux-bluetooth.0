Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B1132132
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924387; cv=none; b=CQ3Kshq61hcLNJqYeBu2/vb34ncfCVB0ZxL49xeP5FzvVQ25Dz7KP92yPZSY1cCKX5f3ev3hJb44XTJb3h6aeCurBD82u7avkKIXJu0dohOxVTjWUz0VpfZ09gf5fiwnok+71Qa7/++E039ANwFYVTak4JJdwjetx43+QEVhQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924387; c=relaxed/simple;
	bh=gyfiwBexNhRM7XJnMQ/152ePxQno3s5daBMJaM2PhOU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DWjhc+1AspcBym0W+MX8GAaAUxoNcfjQnP6V5E3Af+i0Kfr1JX3ai9FG1QGNM1v+tgZeROLCcTh92DW9XRvyuof4hI5ZICInlAZtkFg2ubP5HHL2VWL8e3IaUI33uOg5YUv7G4xp5jQzirJlgT67SDD3/sZaHWDC5tQu4HTALao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUBi0njW; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUBi0njW"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5c9295f3aso827861b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728924385; x=1729529185; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gyfiwBexNhRM7XJnMQ/152ePxQno3s5daBMJaM2PhOU=;
        b=CUBi0njWoozdig3w8zjjg26aNRKySUKyhaTBMSERJa8JfnhrUlm2cbPPgTXfQ1pzJP
         jb1Zz5QeVqh0oGeIEyM3WGNEyXlJfgZsC+/RfO9RpfDz36k0sXDMwPQLTx0cL+44lf3n
         9kyJW6xspK8CAgt36RNb8eYGD45DO7J7LREXIULhFnf5UwgqwaoS2VQUVeZNdl2ZASUb
         q8IXjGOOmO8tjoUDJtDl2lR49plLD5FU3cUrd6RBvhLYQMdVRDyRoZj2rSVXGrmYypdV
         KCHYQToXc6glVu0NqehvfNHv3MCP6OOMEHLg0pvJqTDcBJbUv+7O295qi1qc1tB7QXp2
         UVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728924385; x=1729529185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyfiwBexNhRM7XJnMQ/152ePxQno3s5daBMJaM2PhOU=;
        b=AFIm5CkZE4xvo41Ol275z6oDMgZK1GVtB4k/3KNt2hPOYksAkTiDpEweQ4SDNdM6jy
         BA8xVcetdbzdzuDJabUlbXJWmTznyRTlFx71q6AOyr7PgFWu7+rRs0jUJvlKm70KPaIY
         P6r6wBDeJLs6YvnOX8EjMt+IkkRcfCV5fMQ4kIq/A2Xriz/DFr87FsuOX56uOs2UdpUZ
         PLweXVpCr+G1GuCeEjZgNgX5w/ZVwa8XhNYVs08u3zHygA3BhR//JXgMSAp+AfVDL4xZ
         ZD56ZBt3fCXasqMqrBuiV3DFwXnMZ8ujUVGnJupQnqhiN5NgC3rziwgVHk2YXOAhdJaV
         0+Ww==
X-Gm-Message-State: AOJu0Yy3T2Bm97Fu8yZygzmy2DgMrctVkrbKTyMmkXej7Fqd1/fACQYj
	hH+ikVjz4gk8fRMrzA21FCdMD2f8hRY2008x9yBRxcYqI7QdPonkoXlT6A==
X-Google-Smtp-Source: AGHT+IEYqcGsDZSZKWww56yHgBPduZvw+iGeROpmvZ/594gFyP+FEqo6mxg3q5J8z4H9pRihiONPvg==
X-Received: by 2002:a05:6870:9e83:b0:288:6c52:ffab with SMTP id 586e51a60fabf-28887380769mr4721921fac.24.1728924384927;
        Mon, 14 Oct 2024 09:46:24 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495a975sm7099478a12.59.2024.10.14.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:46:24 -0700 (PDT)
Message-ID: <670d4ae0.630a0220.3bf3.44f1@mx.google.com>
Date: Mon, 14 Oct 2024 09:46:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2117662614331957482=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ignat@cloudflare.com
Subject: RE: do not leave dangling sk pointers in pf->create functions
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
References: <20241014153808.51894-2-ignat@cloudflare.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2117662614331957482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/socket.c:1576
error: net/socket.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2117662614331957482==--
