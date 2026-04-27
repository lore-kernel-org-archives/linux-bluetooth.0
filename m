Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4934252B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262568; cv=none; b=dcYnl1LcMgh6FXsBh6lmQ50ZStfTc3fEKK3ATqAgz9STx4jFIJZlsiMEW7rQh+zPAKmtLCafALwpw4/3o9DnURCDk+C7CZ6z72ttA2AsSFiX0r1gxzHSMkvhFzPbOeraL1YbbxJ8Ac/J1pPdZdGKmfL+Me/uyfyFJ5Kh0RIs88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262568; c=relaxed/simple;
	bh=PhcSNJLZPNup8n1VQwty0LFegcyTBwA91eupOEiQ+kw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PCc+PRhxBBb5fyEE1YivmtJ4DUMoldNY6hBc5KsEJMhxsrjkC016kqAXYMiT58hqoI8A84iWVrn8KlfUP1hh3Wku7ek+wtLab4ti6h7MlO4b22U34w79OUA/ag7mVCjNw+yWnMc7/jF6d/ZKr48STYo+Yhqj9Okc5Kz8Z+z2g0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcEZtAPc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcEZtAPc"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so2860362eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Apr 2026 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777262566; x=1777867366; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PhcSNJLZPNup8n1VQwty0LFegcyTBwA91eupOEiQ+kw=;
        b=EcEZtAPcHNzDbBwt/nvkQfqNktGIQxXaZYbr0abrmmGnJzJf2eXk1p6pqDYe4wQ7a3
         Si3x5bsQ7Jegas5Nh7f4eyw9L33gW1XeYNf+YVdZju60z0tJO1kJiO2DTa1AAAQl7ath
         JCPZuBlQmMutQr2coMrCDQAtMcPl04LPHT1sqvieVcRL5QpUoA4YnxgRcmz3d2lLbLrH
         Fr2Q4A1B/XQbnCxnx71i+P4EMdZrJJ6zbM+PYbk1Og7PejnYDd4iAsjoe53ctd+dbMdE
         KUBQ3545c0T26a9QFpcvax9nLb2Nu+xVPo+8PHnypQ8+1Aqflh9i4WoS8vDQo4u7b4ZH
         LqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777262566; x=1777867366;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhcSNJLZPNup8n1VQwty0LFegcyTBwA91eupOEiQ+kw=;
        b=p/5kwUygP+Vlao4M7qRDQkJwJ/nm2gsHFf5+51jqMHl5N0myZTyffmllLlhwI7GkBH
         rY+CYStc+XkBcNNdmbNHiJxYg10hD2jYoxW6lE8ViC7tuQ+t87u95uoQ3E3OHPUbKGhC
         cZKgXgwoZRw1eP+at9OmmHgmgKoi6r2Ny+HhqDz3uTHJEhat5xVr6dan5BZVt+uaPkVS
         sT/7LOY1yu9cFawE2wlFRjRwXdyuLVmX7VOcIYsecs7aOG9NqH6FRa9OE7pINjb6ruJc
         EouYVUPiSKyl20IOoRKh1lbbw+OBvPIq2w1TxvIE4xnnsVZtSdCk7McL/gJmKJLxb9FT
         narw==
X-Gm-Message-State: AOJu0YyBDZk/3BeZZMQqbl096XlI33pVuJmTUla10FYWrwquwV8IDNIy
	6wGHiOKW6HbvWr+n7bXifRV12jqSpBcjf1nmbKb591B4kr7GjDPU4/8Chny1zw==
X-Gm-Gg: AeBDieuS4l/Is6/rqMy1NJINtAYF9Tpm1vQ4HrjQj3c6LsAUIW+ftU96SZS1Kv2UgF5
	hv9PekNhmlKcp6p6VvHv+bxv4FMoQb/dG4NDmYAfdP3c+gc0CjZySc+HnYJ3rI3ERGJxaJ3ajIC
	jjyURahsMT3RdvEBycVbnFpT2vLx3q5CzjE0FKH+d240ec4bsg3IG8823zC9h8Rz/tMWFc4Kd1l
	i+z79D0+kcKfe8I0IKgH+SXkg1VxWGMH2fOtKTocGRnA4q3sgcOcvSYo0Nz7bwx2eUv4MNIztV/
	t8uHgUZx7X+udqtlbCFdxHAMiNMjLs8fzkDmJZsQNJHC10+pAec7jadR9Z42BTVClIOnvRQbpKk
	pmF9W/VhtMOwGuIlOxPhhlaBsduAtOSQ5Jj8iZy0HJxW7TS+kuiRrSEaRB97UFlQKXztmpdIwE8
	RVIzxF8fzcoeT6lJX4FIurMbNmJ4+Tc/GB3cinhsL3
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1682 with SMTP id 5a478bee46e88-2e4786460f9mr21801194eec.16.1777262566138;
        Sun, 26 Apr 2026 21:02:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.60.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2ce98csm40455416eec.20.2026.04.26.21.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 21:02:45 -0700 (PDT)
Message-ID: <69eedfe5.050a0220.101ddb.0571@mx.google.com>
Date: Sun, 26 Apr 2026 21:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5081241945146557832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com
Subject: RE: [SECURITY] Use-after-free in l2cap_sock_alloc_skb_cb (net/bluetooth)
In-Reply-To: <DB4P250MB08058DC86977A3A6F25207CDEB362@DB4P250MB0805.EURP250.PROD.OUTLOOK.COM>
References: <DB4P250MB08058DC86977A3A6F25207CDEB362@DB4P250MB0805.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5081241945146557832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 21
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5081241945146557832==--
