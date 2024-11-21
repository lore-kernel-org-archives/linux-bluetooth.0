Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A21D0DEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187656; cv=none; b=TcPWheqj8tWxXid0OtDn903CTBm62Ad/31tHLs9Nv6TmTsFCXGEWO0DLu2R+mzztDH1sHVSrYNOgLqLtrVWT8d6dPuEW6Q/sbBw97EsXEb1rwhdfJ7Qv3Z2+LPNNg+hI5zePXCQy2QkR63bnlb1JwsaoyyKDsdAVQGXqXD+U1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187656; c=relaxed/simple;
	bh=CtjOa9ZS+XmLt1NGpOnp5hd0eiTRO8uO1b2vcffAXYQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EM9XBrUVAyJbiJuXSZSvUUThicfpLbWQIZYXQ+axkRGhpz6cObFChfF0FzSd7pq5vLbaZGq5aOLOCPXPtHy60ZdxLLRLAwa2L/FqQTrsPGrrISE89PRchNturOMy0cGjqJBwZ1gDTD64ZzpZAszFmA1ljOueESXagR+AcJs1VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFlH+j++; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFlH+j++"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eeac3535baso7222767b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 03:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732187654; x=1732792454; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ckp+vghIpL7A5kP8WPnsERUSXvi8D9Vn3gfOCpiG7F4=;
        b=LFlH+j++VMmLd7rP1KRBUGx8FzdhA6Vbi/xAXLBury+w12/+boquJCDW8LZmnD31qV
         vnk/3V6SskYQP+rl64WodThpzRDAwvqXx3udBr47kkQ2IqM1jcd0IyD8IR46cbzTYtIB
         OuyYy8cFgAncsTp0iXnJx9VJrf0xwTybdfCuwl84b68GM8xlKOg4YVVqrMzIESkdRBIi
         Do39ZwuIJGPRVZQG9Tw6iqdBAWhXDPY2xxGWy9id9sK3UdqcKWzQUJObyypVwA80DtYm
         QNS6yHelNUTo+nX2J2sDRwJUVKbDjQqXAdwr4kTyHwPyBeEQGea4oB2r6GXHiPshXv0D
         Y3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732187654; x=1732792454;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ckp+vghIpL7A5kP8WPnsERUSXvi8D9Vn3gfOCpiG7F4=;
        b=DaLqf2eNN9UyXQSBi7vdCCWR/BG+tRmi7c03X7sm+rQhpkdPY1S8y15vG+Nm/eCHKJ
         W5y0IHSe0PaHqYGtven3mVuq8HsymT0dOmf1b2IUNptbB2gqMs24A85nNT+BD7LRR+PJ
         Fq8UJjLj9B6uQkNgwNf7vuDpfsW6h3COf8gk8XABE+6P4u8hhcX5zWUzCimrPrx/0FKG
         1UhWpgmrHQ5ikl5GgRsv2NbUiO+hAHxL9aGZ8hyVRH1P/Xj6ECYucqkVhORPt6b/9lOF
         YxZWA/qNECIUL8sGsMtyqz7/mBY8JlMblc0NOi8+FlyfyFd6qkH/y/ZluyiwqxqFGLFl
         P29A==
X-Gm-Message-State: AOJu0YzgY4eD+cj8s3NGKLRsKZV8doMHPfuYlmgl+Dml7A25exC/w22K
	GDTOZTPDkfEzAu8ptY7p4o8NGnvZZ1IZ+35mbrgQGkVtuIrA20dZFTcT+Q==
X-Gm-Gg: ASbGncu7HUHwL+msShFY1wQnXQN5duOKZDhQrEIX1HT4IswBYyjA7BEOj0SiYfnWAXF
	p2DbqFt1SOx9lw2wTGD0kL+dhGmVfbX9CiacgQunKUWPAH3xmf1VRT+I084Xl9QO/HwQF9t4rX2
	Eex930PNZX1KcgjQ6yMYNjHarKWRdE20KLRlxWokdLKj+d4y2yCDgujX5cDRA0OoVBA3THOPnXY
	q3ZsvYTt1JS/uI4xBRePpuZQOZMQOcWhzd9ITSVJ/SMLCnoAmr4PRnwVh0=
X-Google-Smtp-Source: AGHT+IG+crwSbCfGxICmB0Daj0HRoFtqaEuttnZjaOucggIubIDx2DIYf8uUKkc7mIGvpZQsL77opg==
X-Received: by 2002:a05:690c:46c4:b0:6ea:8a73:c0b with SMTP id 00721157ae682-6eebd0f2be3mr67818827b3.7.1732187653965;
        Thu, 21 Nov 2024 03:14:13 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380f55bdsm21549626d6.59.2024.11.21.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 03:14:13 -0800 (PST)
Message-ID: <673f1605.0c0a0220.11852f.65be@mx.google.com>
Date: Thu, 21 Nov 2024 03:14:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2760647095343752062=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v5] tools/obexctl: Add support for system/session bus
In-Reply-To: <20241121094852.2666939-1-quic_dgangire@quicinc.com>
References: <20241121094852.2666939-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2760647095343752062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911469

---Test result---

Test Summary:
CheckPatch                    PENDING   0.16 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      21.20 seconds
BluezMake                     PASS      1631.79 seconds
MakeCheck                     PASS      13.89 seconds
MakeDistcheck                 PASS      161.44 seconds
CheckValgrind                 PASS      216.19 seconds
CheckSmatch                   PASS      276.31 seconds
bluezmakeextell               PASS      100.75 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      863.14 seconds

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


--===============2760647095343752062==--
