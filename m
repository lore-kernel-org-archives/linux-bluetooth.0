Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0736D4F0
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931662; cv=none; b=IKLgDhbPtu+TjroBpAb5NNMdzic1pcLkQVN9ssaVUJMC8tHtGRdGlibspdOCAv1ENdmrPQ3AE+5Mc2NfKDXTl6ozeysQeWoaf9CIFhbUf+uPqXj8YtFX7OrPpNuaNuBalIwpUgivQrYMAxTK2ACxVN55dEw8DlCMgxBJpfN6m4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931662; c=relaxed/simple;
	bh=oXqT7chW4gwJOXjqphGpx+rcK+tX+1zMqqwPxnai7Z4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hyjHrQymYJ3jZ5+S2/Xd0pHvErdXaOGlK1IiFE1UVOioxrmb6iWK/ztONUIF6qdcWIG3lBMEfE7Q0dAkw5K8+e7bd3XS7OBMnaO1Asj3kwtAEgQKnqrx6PWgGXV/1l1vU9IGly0W2j5SZR0v1ed1XKT+QIEzU2CaI2oMMTWziTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9J/I8G7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9J/I8G7"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b28f983333so371089285a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763931658; x=1764536458; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hUpwYZb8FwI4PMzSx92sdewjHs3fu8C4Z9oNA4pPARk=;
        b=h9J/I8G7qlvkiPh2mDRMEYHiFrCrGpfsUYsQBXH1LaJWOAagWxivgNdo5UqEYjANxY
         MA3hkzSHV8vwYBZ2wS/0IpMqxX7IKQ6KAwJU4AHRfGsniDVdyUNhNAT6mimRmMLLYKPG
         XPxj30/mrU5CVMGqwOXGmz7ggGo00SaYtcqfxe69MNE4Ud6DFYWQA8tJXwhVSfaX2mZ4
         j9QkRfbHjaccUaW+5uEXNKISk3yi7pD+kvNY9GZTxY91dIR/JYL+Xcyj0+ThAjf2I+I0
         0UPWK+XCdSPZKLB2Qhfv7WeL22lmcs/K0rU2PjMoYoQv/i0jngezhUOeXzrahBVSX+No
         QPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763931658; x=1764536458;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUpwYZb8FwI4PMzSx92sdewjHs3fu8C4Z9oNA4pPARk=;
        b=on0n8VTqmFtKV7MbrUEd1M8m1vTXUZ7gl9pZs0KMP6lTOgInRmQuO5uM8zI/rBmu2V
         ALwnfwLZgOx967PkHx9jplZ/MnW3/0WObuy6DXL5P7ca4BU9gwJ9vyvaxgnH8Vq5qWaH
         K93Pvmwoxq9kpuo0xaWJwXKGGtqGLgqO5B6EAq6QUD6AjIXgdlp0/i+3Kb/kbtrBDZIj
         nl8A4XDzQeRhljIPCL02Twq6XCGtnPP+fwHMB9G+EV3ND0ialCJlyHGkEq/Lta4l7s0l
         5L1PyS/k6S2eqlYQIODUeWLailtafvSHuTyj+spvufQfzlMf1FXb4sM/W2B7x4h25nj0
         MHyg==
X-Gm-Message-State: AOJu0YzLmNsnQAAWYfcLrc+a+iU5v3GtGy1yUEsrdcKvyvcm0TPeJhWU
	X898AKSiO6fScIKIu/MTaGnElIgytMrYKPgE6k/VPGkp+pA8FQsM3It0MAPw2Q==
X-Gm-Gg: ASbGncuNubHqTZfYg6sGqEX3Y8Ki8+x9M9tyN4zQU+nXAYr7behvxG/hjygnwDLoKDD
	dowAisJjxZqOK8NpmM5a5bO/aX6F4Bzr+y9jpWJSrdnhxcdsxkNkjpq5ZU/gGWqhuwn/6RKtCBH
	zcZ+lVFLji8pY3kwI65nOoU4mfXd8AE73lK7z8J20dm1Muuh14xNhsYZlZHsztmmsVFlYm+dGxY
	vPn6681zIK0rdAMb4EhnaFeNyhDittShiBkm2pOFnHvf3QitVlbCx/pHszRzU6M/AmJIq3bWrjh
	4wSJJurFDYgFcqnZZ99GFU3roMHBkqxgmDpcCALt+kU8xN3sOMio3u/AtIQKCYbfaJEgHRS+7Rk
	Tt0Ogzme7VZWi8SMP8j69JXA5TKtOkRU4d+mn+Y15v8iH45dVNK5ggTfUF6hl8GI6MIJVpNf+G2
	JNQhnPbv6P/uQXONqB1oiwN4+JQBWN5w==
X-Google-Smtp-Source: AGHT+IEfWjyMi/nDvL4Ix+62iWmSHBhlyc0jx1uA9qhauU3mGidmpXAdohR4VrK4RVTu4uh9dzBIgg==
X-Received: by 2002:a05:622a:143:b0:4ec:fa43:4d58 with SMTP id d75a77b69052e-4ee589103c1mr116859821cf.50.1763931658412;
        Sun, 23 Nov 2025 13:00:58 -0800 (PST)
Received: from [172.17.0.2] ([135.119.238.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e65f59sm73674631cf.27.2025.11.23.13.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 13:00:57 -0800 (PST)
Message-ID: <69237609.c80a0220.724ab.3202@mx.google.com>
Date: Sun, 23 Nov 2025 13:00:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6913584910821623726=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] sco-tester: add timeout / close during connection tests
In-Reply-To: <d4a840b0d5c6bde1c6e5a5da6e2479bb2aaad7d3.1763928580.git.pav@iki.fi>
References: <d4a840b0d5c6bde1c6e5a5da6e2479bb2aaad7d3.1763928580.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6913584910821623726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026741

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      632.41 seconds
MakeCheck                     PASS      21.81 seconds
MakeDistcheck                 PASS      238.19 seconds
CheckValgrind                 PASS      295.20 seconds
CheckSmatch                   WARNING   342.21 seconds
bluezmakeextell               PASS      180.04 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      964.89 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6913584910821623726==--
