Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DB17E45B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357326; cv=none; b=iew2PGbLecIQzh3k3ImqWWF8/7298MAIPm93AK9AT3MP1AysEOyBZX5xRX/+5/g2iVVJj+HpmjhuMvCDjZPqFmFx/bLJhZuN3tsg80X44BPzYcm6uMoSgop8gg1sS/BfxTFmrKVDirT/k/tlBbwIJQumVM9mxX0vvUOB/Vtum6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357326; c=relaxed/simple;
	bh=uDplRNJCvM8ZGmv0NxgyRVOWV/9aEtL2Dh1AUuKn1BI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dszgh/pcydc3FqKpkky6DH0vNeC/XOAwcbIy5udMd9vCElfIe19fSmml+cUhJzx4ydIrEIERtvPxXCi8nFGKIzkWCAxVf2zn3pKthjUM2mRX+uLTemvKaKz1HhvhGP6U7BPK7ccb4kZPPmTmgSWDTIs34vyBhbdXJJksdUMh7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLafPMq8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLafPMq8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46901d01355so43024141cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jan 2025 23:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737357323; x=1737962123; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDplRNJCvM8ZGmv0NxgyRVOWV/9aEtL2Dh1AUuKn1BI=;
        b=OLafPMq8czbABocVwM42SfYfsIBalNhHiDKeM7Opng324/d6A4uONp3cJgaZoDGPBE
         4xnPKhXTTaEHT3TjHgz7g/Zy0ONUfycGveFzcodPfua17GHgQd/d+7RVII+hNvb2i3PK
         h3mByIEb0zB33CTGryco25vetnxbQKE5LHWsJsMkjJpBxZ9gL29mLxn61pc2+RiJnQ3R
         c7gW40Ecral1OwC6CCFJg13prElKpyqRKNyNmuNW4+Dnqh+5pTOY0Vbj0zE8x0JMnCyg
         BrTufpWwlqnxlLFBiNvxCPSyrsaz9Wd4vTvFKN7xXBKD37z/merVLz69UI4FDQssuoVT
         q33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737357323; x=1737962123;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDplRNJCvM8ZGmv0NxgyRVOWV/9aEtL2Dh1AUuKn1BI=;
        b=IXL+voymP233qd0Mgg+4a/MBA5NgDRRv17TpGR8YtSAIIazdWdBRgFn+Dzzgy9Qgb2
         mwQIaNZSCDIdQHpxByZPThgGbRjqYFjgdJTVPW64YI2XZ2bY7WLWq3PG+OjGTQNuHQMC
         dLX/mCls72cwAiTNF60BsmCt6DqF/+jmaRjtqHJ66ULHxYbE2x0BBHzaggEj1zi/Sf/L
         IgDgttjg2EibFON8rdlWt2mhoVjRpRFqHo2gBPLV15IJHai98gsAp7esWL8nUWllCufD
         nmsHRkgnk7Fl5OvMR5BHHibMj9KghEickTWptud+UNbcU9v+OFtwI9quAwi0BoX7KuOx
         CjcA==
X-Gm-Message-State: AOJu0YxfB2iYciDpM4N6mdb6F6t2w/Yy1CHO30G87NsgeqKBaoXubyKR
	A9j+E7Oo0Oumj1eQyWvhjjM70v39dsZ4oLryEML/kkQxJp7eOS+O+MJNhQ==
X-Gm-Gg: ASbGncsDfQXQObDcmC2VCuPJOQU6v7xdERkCAxEI23AxPj63r1Dg9MBgA3Sf1KkoHEw
	sCpJoRRTI31Iu0XIQg56KCVK7xeVuxDj0A6hp6SEMiZd93XHUc7KRoY/4YLy0Cp5lvNeUllcqhP
	Q3YncFtbKeJ799vWjgpDxR1Ly7PnvtaS+VBEJAcR3T+wVZH19HdjTweqfPuvJJDSlAtq0mNGfS2
	X8voGRFiFfGH/hYfJd+QVkCcvS0rrFgkq3sArmBcJG9yK7RVUXdLIQ52a4mp1HdeuaC1nIo2g==
X-Google-Smtp-Source: AGHT+IHJrIQbDujk5kUiJXDRjVy5To5i5peV3DRdOPl2/JAkv2fm+GfopwaCsRkSb7PbIS10HQK83w==
X-Received: by 2002:a05:622a:1344:b0:46c:74a2:3492 with SMTP id d75a77b69052e-46e12b90c44mr171470751cf.41.1737357323271;
        Sun, 19 Jan 2025 23:15:23 -0800 (PST)
Received: from [172.17.0.2] ([20.55.47.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afbf3dffsm39095426d6.25.2025.01.19.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 23:15:22 -0800 (PST)
Message-ID: <678df80a.d40a0220.3b4386.ef26@mx.google.com>
Date: Sun, 19 Jan 2025 23:15:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2768415551994471922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keerthana.kalyanasundaram@broadcom.com
Subject: RE: [v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating setsockopt user input
In-Reply-To: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
References: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2768415551994471922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/rfcomm/sock.c:631
error: net/bluetooth/rfcomm/sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2768415551994471922==--
