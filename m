Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC133D506
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312494; cv=none; b=XhJpmaU7vBeOS+U2dpwzucWhma1N+gl1f58wB/ZlFDrQUmxJfP3k/7dbtlR1nHjLOE0/6/KSrkJ+MNXYVtJLiRSV/jziZpPBJDEk59lArvygho8tgnSeNnkYI+8AaA8xiiBIu7u1kepzhO4UB7cVKHUwqbjhLEBnf3SYuhbDeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312494; c=relaxed/simple;
	bh=dHnOxhgpDUhhrijNcb9PO6g8RInWVDOd+3jUAysZvYw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rVS4ganA8kMDsnSmUL8wqv5LTeDx3TlpaMVtFncAxIdoTEvCM6K7B0jInuu8Vp82Aib4UMul+9vJTZ9fIXq9nhEo+BtGiJBHGcoA6y+XD+voxjDeinHhx1L56nfstKEQXJNUeJOFrdxezDPqbk0Wt9hB4FBsd1jRO2KQuWuNxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct+sTLKH; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct+sTLKH"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304106b1204so1854236eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779312491; x=1779917291; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dHnOxhgpDUhhrijNcb9PO6g8RInWVDOd+3jUAysZvYw=;
        b=ct+sTLKH7258gubxdVSN3S3mlFEIsZoVJ8/QmQEwBnXfFDsKhL3CNQF1OVH4XqSItJ
         znRyOSiiXg8Owrt5Fl5aJovLC4lqwB37d6doCSxPK8U3DL4D9+yy1CTU+BwLLp0he+X+
         aBGYLBhdBAx5n82eOlDdQNMT0YA0L9Q8seVQRfv9nOLiGaHj1ttTXqJYUBMsJjFPsQxi
         ezar5GkxdFtwKPwJqm2DQOCrBtZVVAUizkSxnValySD0Bdm60HU5lpDGUNMQ7vCcLeHt
         1jSV6LDwis+OnPB5GgCnAXpHD0I95c3xnmjQeSOk1PYV0Fy+sOEuZHAa/y0cDkcHAH6M
         7tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312491; x=1779917291;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHnOxhgpDUhhrijNcb9PO6g8RInWVDOd+3jUAysZvYw=;
        b=Olc3I7rckcU/KyBqNsvYdDWcRWmYlvUue3xjihs2Dl3ErAiL5/+pImeAD+vTnEWx+8
         KNmolQgdpQHNf4qoAWgLL77ryOm+7qi8aTW9WGEutBGZSlKgkbfpxNV0xItmv+KbWrPp
         ziR+XfQqqsoeZNVco9AtGoKB5A8wBw7E5So7M2kMOL+Wm6LUk7I+ydOXLZXzP20p+RH0
         RpeY9NEpo5zIFDaMKHZMOhfePQRz+bPVzjsZlSn/DD7AveWoj2pEvNezMGXXlYSYPKwi
         baTpZofPMCyBg13bOMO7mKTVOveDLhhoBfKHSIuj6K30GZpCTo+/QaxSumZ7cx2BNNvd
         /GDw==
X-Gm-Message-State: AOJu0YyRHNcARMpfmdKc3Xv+swyM9ZbnHx0HNmMxpDP/Nd8TT2hPHNRS
	r9RidXzp15oQC7GnJioNpERB4yY+Xs6eZtPhWSTN+oMDo0+GkcB0pF95FcI0yw==
X-Gm-Gg: Acq92OETXTEPkUX11eBa3/P28C21FCCIFL29ZcfXxHSepjXjNhtkiSRi7Exi0zZYD4N
	ApbTmiilnKpM5fA+zJ3AiHwThXl42hzQOtF5ra/1ORf9UcgbsqTiWTzvULzjoTnzK5GyB7UwabY
	lkIO7K+4vmXjLAKWY2cNQVTtvduqA1YvvlF7gSeUtqEqljK1M084YkhZcJNtKrPUQGIXRYBIydC
	nN2v3b2Gc0Yinsoza+xR49m7n2VZ22wEMQ+bah/FNd5c750lVcDXKYUrz3u1DLAH5gHrV9p8J96
	aM8Xj6QNkZhBsfmz4xeC8oORH0u3zm5ct6FRhgGI3OZSlK+pjQpGjE9UbIh5kmlxUOueeB/mE/F
	7tYgAu3KlnmJ9fsyqIFxUhWY9H6DmNfNOYDSGYytRda8dEYzsDXpVolGAS1JI9wkapaX1XzAZKV
	lvXQG7LxM/Ex5nmlpFmOL1pI7Nq3brokoW
X-Received: by 2002:a05:693c:2c93:b0:304:b14:ec53 with SMTP id 5a478bee46e88-3042f9a2ee5mr184807eec.27.1779312490625;
        Wed, 20 May 2026 14:28:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm19535148eec.22.2026.05.20.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:28:10 -0700 (PDT)
Message-ID: <6a0e276a.fb1bf61a.3bbfe1.5709@mx.google.com>
Date: Wed, 20 May 2026 14:28:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4637644056349138752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
In-Reply-To: <20260520200611.3033410-1-oss@fourdim.xyz>
References: <20260520200611.3033410-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4637644056349138752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_sock.c:1512
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4637644056349138752==--
