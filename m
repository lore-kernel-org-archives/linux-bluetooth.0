Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56B3009CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730501; cv=none; b=ZjxpD7kgQEo77P4Z4ngVI2s1jH6Lty/dJkLiczPQ4OrTyBF+tMYacDPgw3wlUZVcie2IyE+a916NwGAxTXPcxl8NFSbBxXeWnlTlTo1//nRQTBj+s4ZBxyuxHmK3pHQmIRqBFi1VrOoPgdNSElQ6FkmuPEpb2CqF43IvnZG1Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730501; c=relaxed/simple;
	bh=DgSYo1NCGQTdzAsT6Ma2dejB1MxlUSREwGiEv2rNj4A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RuTjYvZlWt5ZWGFve4AhQVXcsxWD3czYNO5MYvv39LgVM5T8hL88j+iggsZTO1u5kA3JLNDKNyKxGE7g+ThbTH8KmLNy+cZk+4ScZgnyW+5NebzGucn8odxNYX8N2UALrMyZWH2v5wf6pbtotDN+WXcG2nePm5EACJEuBBO+OiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBDiOrHb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBDiOrHb"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9063b380982so14079636d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730499; x=1787335299; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DgSYo1NCGQTdzAsT6Ma2dejB1MxlUSREwGiEv2rNj4A=;
        b=TBDiOrHb2qoULVuCr1+ltYC6akb8Bn2Mc+3tSOaqBU/2SjBANCUzMU3qZ19mOyryo0
         XaIz0fQ9ThWX0J37zBH7Y2Klg+s3MmsivmpE+ebolPB8XVkEj2C04IeByZW5tnYH0An2
         7xIvO5lnrn/J4eghMNPNDCVO/15iKt3qgI3mFzGZM0EpRpWVSAoRBsNEJIXMDFedOeKy
         woFD0PIRACYC4VhJY+k7zMsU0QNBnoszfYT7lbzSMzaMWjd+wnh1Rm5LoWS7UOWfEdkk
         1yjZPdOplwsBNe4MipfZ4ywDO5ffLYSjzkx1Nb5nonVounp7ckKvycQT5EJkpTqtfvkl
         AnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730499; x=1787335299;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DgSYo1NCGQTdzAsT6Ma2dejB1MxlUSREwGiEv2rNj4A=;
        b=VKhNZxIZpLZxZ2wCN2M4op39+IiRjywnr4ZZe6VU82e1QHZ8XyxpXEl4WezNfrTBap
         0tK53msKjWXcRrzG3h/Dnhma3GLWeadCuFj5dJPe6Qf1ghgANS9bbFJ4O8xAUMv3Pbox
         SZnIFBLdgQRiDJ+zDG8lTaC+aCd5cbxumqzRoN/2CusKbnBIanuft3q1uQUOENtHkzWd
         YFd1+Twin+Ktq2sdF1D3QjqJXOYI3KuF9zjHwNM4PZVIb16rAohRIs3HedESNFby2lg0
         O0goKRvKX35PmvOK6RQ5A/615hgm7lnzjs7CGL7rjwpunVR2aG1QFiBweOfOG1L018a5
         AlpQ==
X-Gm-Message-State: AOJu0YxDJONjlP5pqKDZl1YdCZDoYRIkAqR6ndhB89MakBnH1Uhy1xRO
	IG4sONZB48gsUFUgi2MbONkPlmMUn7Dg5IHPfuL+aOQcqejmVKzLLkTy/gIVIQ==
X-Gm-Gg: AR+sD13oYEXbOcByvULTy3qQ8vg5v+VupMJpjuhi4jjExxGeaoiItQiDAkqADIh9CyM
	kDm/G2R9wDs9RLvhHUYNUyv1BfgbsrvI5BhH8iP2R67VdWECKc3/Mmfy5k+xyOBAgYCKTdIQOSu
	hsT4dOtP7NeKKCnmz6FlCc8gLhBcFkRwtwSrS2oWoxnOdpWrQ3rKIJHgvQ+uU6G5nSbVfqJI51c
	krpPCRBxQfETr+VcQy+1CTSyNJizrVR3YTldzkSadLBugCBIHEdMo+ajFTJYT8ryCzwSS22u/Iq
	L6sSVS847p8rHon1EssJoYOJZtQvnac51nK+moVAT+HYw9BWP/i2E4S3h+cKysVWWnFLvfadAGb
	hV3QCDalnNXeynLiEqylDYNxbl5bwQruF5QO+8GUffpJJ6NpIdwjGvdUByl5C0TD6rizJoH5iGL
	Q3l5B66oK0AfQqt1nR2rYzUAdrEbRxdsvDyG6Jsdy4/FSVJ/g+KXq+IKwxGnG2vvBcjG96
X-Received: by 2002:a05:6214:4599:b0:907:840e:bf0d with SMTP id 6a1803df08f44-90a91e36e9bmr89875506d6.27.1786730498884;
        Fri, 14 Aug 2026 11:01:38 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a93508b13sm23856066d6.28.2026.08.14.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:01:38 -0700 (PDT)
Message-ID: <6a7f5802.c404bc25.3509cb.2fc5@mx.google.com>
Date: Fri, 14 Aug 2026 11:01:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7080919296309271605=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] sdp-xml: Use a queue to collect sequence members
In-Reply-To: <20260814173225.1410500-1-luiz.dentz@gmail.com>
References: <20260814173225.1410500-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7080919296309271605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/sdp-xml.c:44
error: src/sdp-xml.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7080919296309271605==--
