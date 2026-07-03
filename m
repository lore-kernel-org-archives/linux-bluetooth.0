Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4835E1B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068099; cv=none; b=uG3r3J0ZsA6/G9mu2hSOW5cHZeE8NwyO/EpE3L9G9kN0jnlJkF5m+IcqvcqMZtXV+AxXsJs3I7GzT4scOQMjJekJjYdPloFDsQPZSQ6i9poXV24owGZz8AXnLTtOqjPXgnMAVbZlHKEtV3LhNZlm+WC6L+c3aG8Gr5sMaTbqIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068099; c=relaxed/simple;
	bh=VCpaQ5LE4T9Qi8o+ejHPLKTVrkPjB+GKvjKbH2FTWJs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QrxmVv/yF736nBK8VelHwg0WfeZ+X4hnprWkMJEU8YMMz9tssnOWOg4gehtwfg51e7oVrXHVmlUdG5t5oBlpCn6IfpsKDnxeUppiK60HSiZCL8Z/Bnl+qMaC/HE96387y575YkfbwUPx+8Dx8S3+0YtCgTC1neJatiMr9izli5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cujrt318; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cujrt318"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e855da580so25704385a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783068096; x=1783672896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9j3lyEfEKARYSu+IuXitBhNQR65GrFvwr8YLCG1MXrI=;
        b=Cujrt3181obZFexkPMU5WodMl2QuGHUeVqXbZhNIq6WtIyB4hVFYw0fg6CuYYwYvt0
         CSGl5DVSd+ofQ/1Dg2SJlsW3346q3RwOoCCu+l7DKR+Kef3RQ7NyQKZ5RrJPlSgRMf1W
         12RKw7cTEYc46lXvp3l1oev11VysCreS9yYM1eLsAyai1MkFboqJZzXqm03KW5XjBr8b
         oZdkcydKsS4uN6d6RQzEEwquHrpomRkT0RqIR9uPWiCJv3H36P7C/D9zAGlmhZ7XjdyU
         +cu6O+v/3ZhNOvVrr8dHcE791n8CbzhBl0vUPUfHjLbV6h6jl6NF/mtx9KPoRI1uZvvS
         FDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068096; x=1783672896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j3lyEfEKARYSu+IuXitBhNQR65GrFvwr8YLCG1MXrI=;
        b=QIkuqfiivni7h5XoJ0RkK2aOZy58yC2zkgpxH64z1Sr9FTb1SVy489xOX139jUZ/TF
         BWUWAjw6L2LTIPYSc6B1U+RY2L8vi16byZUoPrmwpx866UzNGeZYdxps3GQBTsa/hqJa
         x9EEUbnG9MUl55ifphBij6SmWcb5YJR1Ok5g+eu9EG6sM9qVOAqO7v3zRgR/e3Gck4Bt
         OepbLuJUTKgpKRmo1iGcXFs67vekVFs88N26jipmj7MnfIeGXBBkJ2opPfngJOks4CT3
         an/c/0Gh3CR2UMU3gAt++200S2EXDBGQncR2g5KB0mv/qLWK+IMbP9fOPiIZzHFNtQ/j
         kxFg==
X-Gm-Message-State: AOJu0YxxbqJe4DDqpvmp33z/K3OsTGnpVuKqvuqUJFb9+1F8fH7cyYGV
	VAkeenvepAiM1V6aHcRMVJFbffrNN/EgKzUoYmZZQ7FuwErU+rWFdPSt3fjJUQ==
X-Gm-Gg: AfdE7cl9XH6yxzRtn1XYym5k1Nd3wH9vH24sOaLYBwlFb7rGpCtt6142IOpPnnpY/H0
	aEx3PuzB4if07V8asfM7Pvku/i2BJdN2S3a02U4aj+P2YKQKEzaZs3yyir+PvpvOjvHEpjrnCjw
	R7nA2sfG/zybPuCQuCb71wGNCpvr13Z4xDn6LQJzLsojhQc+KhzdUGeUZMLadSOYR47in4L0N5r
	CwzIdXHMlldJo/W0DslhpF4tTAujCgzTZqLPwdB0A22BKR7EcjAKjYQQ/3CG3tnNxYghpC0y3BX
	UHhbJsTk7nHHZZPzbWYluZcbbOrwOl5n8r+PHPMbMfzc/ePEcyK8eokz22y16oPayYrPZvNz9ZX
	BsJA9BcLyYmApzxi9nWEU6fdtsalH4MQ0SiAwuJxZO9xWGdWb9ITfdyZm08/+klF+pEOphSJd4t
	H4MkkP2MBdJwek2Ryi
X-Received: by 2002:a05:620a:710c:b0:92e:5b92:98bb with SMTP id af79cd13be357-92e78209b22mr1397621285a.14.1783068096096;
        Fri, 03 Jul 2026 01:41:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b9db95sm112239285a.14.2026.07.03.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:41:35 -0700 (PDT)
Message-ID: <6a4775bf.f0689485.16816.96a7@mx.google.com>
Date: Fri, 03 Jul 2026 01:41:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8913524377744873044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [v1] shared/rap: Add bcs_procedure_data aggregation and procedure data API
In-Reply-To: <20260703052056.3568571-1-prathm@qti.qualcomm.com>
References: <20260703052056.3568571-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8913524377744873044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120879

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.45 seconds
BluezMake                     PASS      549.12 seconds
MakeCheck                     PASS      8.09 seconds
MakeDistcheck                 PASS      156.76 seconds
CheckValgrind                 PASS      153.14 seconds
CheckSmatch                   PASS      308.11 seconds
bluezmakeextell               PASS      101.35 seconds
IncrementalBuild              PASS      547.73 seconds
ScanBuild                     PASS      969.55 seconds



https://github.com/bluez/bluez/pull/2266

---
Regards,
Linux Bluetooth


--===============8913524377744873044==--
