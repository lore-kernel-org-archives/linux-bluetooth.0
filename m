Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF51EB5F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545833; cv=none; b=bRM9ICQixCBtqJPfLrXLqXxlZeBqFL4uXETwjsBOIEtbEjyhqiAeUpkIitaEdn2JvCdUlA3D1ZunNLk83lLizlznRm1O3mViJhhpf2hRDfNUlmupPY8DtdizZFYNC7c34OxHcsNDFYj55wRitbuObGfxIOpHGv0PJ4LGSnnbxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545833; c=relaxed/simple;
	bh=3IPfIEahUO+v91xZ3u6ZoQbPgvlQvPSFFoDYK8dNFk4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mNNIDo44Q2mVtINbWqytPSIIhTL+0o4NJ456GxuDa7pJm5tqT3+Ep/1LRmtykS9pNOEu/E1ab4DGV663t15U5yYrxJCZheOQRQYEoIMs7ON425tQ/QA4NOY/Q7LDRvkG6n6r9wtJY2yxGBt0oYfUSDw1ilPmMlu1VBVEv+a1IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eelFj0dP; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eelFj0dP"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11beb0a7bd6so9126478c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 19:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766545831; x=1767150631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPfIEahUO+v91xZ3u6ZoQbPgvlQvPSFFoDYK8dNFk4=;
        b=eelFj0dPE0sqSrtJeNE57Oj0P0wUFwesQOULllVFoYXdhNv7Vj/rMFKDET72NZiXRH
         rGEhXvirqkq0eogxFzEjaQAl7vJzh5o3uwzhDtht0/gq9hf2KzZE55WN8Pf3ku7GSSld
         wwktVWI6rK5vQvF9foYn7crYB1ZFyl/7vBlzBbiqQxWOK3ruFPwxu3KBWQ1n8uh6hFlW
         51eGx35UK55TArSBoprxhIVx5SS5nSvqy7T09Nds2tOJXSHY1qxa4Q7ojWTHLeWP6BCf
         ZIqAbW9a8LN6s2m9V5qZy2phDsHbK156LF0fbUlqfaZjghHjlmmHyc6nBvY1SFWpqiHu
         RREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766545831; x=1767150631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IPfIEahUO+v91xZ3u6ZoQbPgvlQvPSFFoDYK8dNFk4=;
        b=Op+qONGbCLUWG/aqxK3LeBmLHsI8i6Q/uX4oR5IzS5sU1gvybisI1L3sVfBz+UNufj
         GrnbvdaTbSOZpzVCht/Hv0D220t1osR647v27b0hHjyKosWsZwckZ35EnegyI31ciUtH
         qxVzRPuECjkQlqDUucwppC30pv0xnco3mEKsTCEJ0UtCpSAgfwsBXl+q96sSfbBwcRXO
         UOZM2Oa/zNO59qjxnXiiGHSuW6kAPZyAqSmA01maSPBjD8gUGzTUZGCY1iE1VPgEG0NP
         1o0wvYBZb9leJdcICliuiEvzXz4JTmk8COmCOnIUpTW/layN4A+mVMpxlC83wYOdTwLU
         odUQ==
X-Gm-Message-State: AOJu0YwHW5xrO/aKevdG6YDWsatXIttG8ONVEg7nrXiFgV6/PGefpTGD
	AF3XXzpyVtPzpkMLcubc4lXf6F5NbGhKVhKk6qpGGTrgotLKoedp1L2Vlmid07wJ
X-Gm-Gg: AY/fxX5XplXyZzekPIqqJo083EP1SEstJzDqN16kwtWgN60k2KUwFaDCq8oH7TYxys5
	0wUzum1AhjxNJiyWB1iFWS0/ljTvNhde3LHfvNpFFVyepNkSo++ehlpfOqUX+yiHj7AIL8E8ji2
	1nffCby9McbF7KNNKnUO8rp5pZDqJU//7mPVWGwDCkkhtngCN4yl2A1R7AXlX8edsyBFfDKfLNd
	EGEpH8rtILavRihlAoxgqYkQV1va5CBqYVVe9S/0IMRvr+cCpLg7NHC3tU/aP4f8N5yJu/M13MW
	x2TKk7/YemQ4TXK13qsRk5mrwlxDWlVTeEKlmlwT+fEVdfDBE5Q657PFOzZbLmkQ2cSQzjkYX2w
	CRGLyFxTICYCWFHcLdzHsFLfIALhr+ctYgzxXXfFw4rxFVbViE7wjNykyMukbbNwJ+hy/1IkXoL
	SsJz9qf8rH55LOGxDkmg==
X-Google-Smtp-Source: AGHT+IHvim1Bs89skjiWIL6Q+LqQ3jeEILkcV0Puj2ItpBFz4t0zXg+K6+qFjnWD5Bh/HAUye3LL3A==
X-Received: by 2002:a05:7022:f401:b0:11f:2c69:3b with SMTP id a92af1059eb24-12061942691mr21328624c88.10.1766545830619;
        Tue, 23 Dec 2025 19:10:30 -0800 (PST)
Received: from [172.17.0.2] ([52.190.182.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm64924412c88.0.2025.12.23.19.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 19:10:30 -0800 (PST)
Message-ID: <694b59a6.050a0220.d1924.2d1c@mx.google.com>
Date: Tue, 23 Dec 2025 19:10:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2946564190823496505=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, techieernie@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add Realtek 8851BE USB ID (0489:e112)
In-Reply-To: <20251224012558.47877-1-techieernie@gmail.com>
References: <20251224012558.47877-1-techieernie@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2946564190823496505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:521
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2946564190823496505==--
