Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F7EF
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120709; cv=none; b=Mx5yvF+Kp/giEXKQ8CziCu7IWXJD17s+N23LP8XedhJhyt9hwgu41zcjNrAbA2bC97qePCJJlvwXqeHkCB/9EY6j840jWZTj3eLHAsz/oYGiYflrpCEXAUNc8Iprt+NJ28Et2UHMNFq8bu8ByEbNwf8UVIRBqOFkdzTKfMAx9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120709; c=relaxed/simple;
	bh=JL8/SdncCW1OeZLyzlW04gJBD0EBQ8SPiAubj77Oq5E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sMJTdeNqNtX0nlQqj+XIxjrNfOYon/Z5vt/h/T1btLHmlwpQ0e3q/sQlyuCRsHhXZ/WumxGJbYwsXOi+KLGgIGCVrUdLRiNQ1UPfuY+2L3Vz3o4dz9THtrhbfN4oHo/DJddZ84bXocX+B0yRrIq4KuXM5HmVJ5kjxKHDZxfwhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgduNMMO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgduNMMO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a06b12027cso26939356d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714120707; x=1714725507; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JL8/SdncCW1OeZLyzlW04gJBD0EBQ8SPiAubj77Oq5E=;
        b=lgduNMMOd9cDrT2Z1O9rxQRGaycWsNIYpXhvXuNkChxFxe3UkZpalbaxgc9waZetsu
         wN1m4ok+e6lEIvVqXhrUuohoQxc9Nisgv4obZmB2qok2IZOvvaRfR6cOswC109J9iiGd
         TkwfpgcVWT+bKHedX0S5E2bxle3XOObHID7T2sv3vUVl//8DOFb9Cqvoui3VIMEQ+vnN
         Olm/rMgxKBfpMYpmsWiZE/rmufl1E6etB6p1kP+vN/fK/d75ZE1vnej/DBBEDOzuhZUN
         ZfxbjWgz7INM0VTSOJQHUQbl+4QExmNaT+1R7flto0JUI1DYRw01mmLZP8jVL5yBJgke
         pbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120707; x=1714725507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL8/SdncCW1OeZLyzlW04gJBD0EBQ8SPiAubj77Oq5E=;
        b=jynUD6UmDIf3YlnQmFtf+YEfqvYN/gYBTB+avOIm//CN57FYdI6sL6+mxqC+lUglMl
         HpmT147+gs/neiX8u1ewmYbNoiZ00F2bJIaiFGTUyxbN5CTt0FZQN9nU/mIn68Bxe38C
         ZotCf+TqLilv18mutg7+SXKUpwbE/h8VL6zs38XtFq4dG7vQQvKjqpW5o0FIUUcmjNe/
         OO4pKJj9AOljrOD4ZYypW5E40OO9mHEUycunTZ8Dg0VUTWDTiAs6yo4QTy9QkOQP066H
         prSKyRtlrtJ6F4E9q+GsvM7Glg9xDbrwddSHUWG97NHaUW+nhVT1Yu+YGBu6ScHrWrM9
         DKPg==
X-Gm-Message-State: AOJu0YzlDcWOy937qUJ9UPJkNXA+UfPh17LYZp2B+5i/+jpy466K845X
	DbksCrmaO0rZxSSwj2DfC8oQ6HuUtssYuiIOzH6gp+c2QwvUqoZGE8GmGQ==
X-Google-Smtp-Source: AGHT+IH9NuJjRclgUPyFquWFUvkz8XrhY1NIe6cisGRd8SuVkriEIeEsFJlS6chNQKEuDnQm0LYiXQ==
X-Received: by 2002:a05:6214:300f:b0:6a0:4571:e0c8 with SMTP id ke15-20020a056214300f00b006a04571e0c8mr3484891qvb.18.1714120706818;
        Fri, 26 Apr 2024 01:38:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.247])
        by smtp.gmail.com with ESMTPSA id w16-20020a0cfc50000000b0069b69c5f077sm6806670qvp.102.2024.04.26.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:38:26 -0700 (PDT)
Message-ID: <662b6802.0c0a0220.28329.2d32@mx.google.com>
Date: Fri, 26 Apr 2024 01:38:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3335916149019238172=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: A2MP: fix slab-use-after-free in l2cap_chan_del
In-Reply-To: <20240426082852.555905-1-iam@sung-woo.kim>
References: <20240426082852.555905-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3335916149019238172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1175
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3335916149019238172==--
