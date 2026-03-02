Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10E3254A3
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432027; cv=none; b=QRZsTzJjTbpuz8h+Cn0S0Z76F4sg6xSm3LOrlzZGNgvtoWniVog8KqpVIWx9QTaEM0mkrDNuN5Bf9OcvvdRytAjX7IdJ/zwGSCfaEkHjqVSOcxA8j+LIQ4/XiL12emOL7O60RS5SlwMlKinYyj4TiLRnHD74U7D5eij2wEq00N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432027; c=relaxed/simple;
	bh=pvWxCTrzGi+V+n8txeluoFyZsoXHdZegxxmFwZNnhx0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T7GE/L5pwK9TZreZ11oUWIWd38kCkkFfrIFCoj8LXh+2JuNxNwQEyj+Gpy1E/w5qhbJYdvDKnPkpqdSkr5vZK5PxxZwFttG/HwP/LPKV8gpJ84DhNVe5Sk5SVB94q8brZ+v0isvQolRgPz8OidJrGGQKqN/pHVNDUroMaojc45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgqeTNVX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgqeTNVX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fb2b94c1so10592466d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 22:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772432022; x=1773036822; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pvWxCTrzGi+V+n8txeluoFyZsoXHdZegxxmFwZNnhx0=;
        b=fgqeTNVXkii4ILSjUwOBkubMlfFCaiGkNd0vriWBeB77uFz24bUYwoIh9RsZfLckCz
         tGhKvn6oyljVyit9kuXhTP5kBnYfZj6G31k+y2sm6COqiDp27z5QEH+nHAwvtKlHAYa2
         RBV1Yb1L3roOMYrPVI9DIOqnZFmEnS0acdSFpjinKjSYiB0O1kCFPWLZF47u6EsB78jn
         7Fl63cAdaAdicAJb/3Wm0S3Ph7TU4rLGLcredZTYMFLbxARfP9yX9YXHJgnX4MGm47L8
         qhyhRUAYs0MBGREjXdRvLQM2AoF6mcs9gTK2cgUHfHHeC+x/kR1hlmA2rO3Jb9c8VqsQ
         M2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772432022; x=1773036822;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvWxCTrzGi+V+n8txeluoFyZsoXHdZegxxmFwZNnhx0=;
        b=dSCnvn52sfDLEZ0nEaSzai3an2lsyHgW6LJ6E6miv4mixLjpOfM5sehaBQ9eC9b/qg
         4eD7ogWuEMFA0XvFVOiaDmEjISRNT18jTUW8IefoQN+l/RwqszTLdcuXfSDZP7C+//0K
         Nh6TWPjNkI07REUXnxZ6B1r27lLYYPoOqeehq109lyL+y/G521+8azdlb+SHkKdTzAhB
         CPNJfenQhPa1L1rW1oq13hTCoPuEIkcVUZGM10X67GOFVDFKgRbh7ylRns+U57V0U8dE
         X4SDaTfXQGPqpry1kGa8Y2HB4tBbndvBZndtnO/BhKunZlqRAHP07MB4yNxTg0DaIvdQ
         9dIw==
X-Gm-Message-State: AOJu0Yw6u3c0FCOCuYGcVg2McWqVPyetnHY2VlTCJgI+XUbCaldK8p6v
	K1ocFYi1uHl/BBYa0WKDOsdWFeDa0r6fmnnyI7I0VMMe+BggjvBoEmRqK2LlbA==
X-Gm-Gg: ATEYQzxfmExwyijzPvFXTIsmkWXn+78gm/b5pOn+ZtVFjKIbRYx8buTcYgmf9Ah4pFY
	+SioayPNY7zhlormM0J8w+eznmM5FAVjqaKeDds1ZkI7IVdbnmJZKa/zieXJFxc/b4KqPuzwkGW
	VTr4GPm3a7nVt7fV869Gv6p+4vVCdmwlUtCN4JwV+KdCTocdFA5ZyD7HRhs7OKNsZW5uxragCG/
	BeoqMn0uQALX2ViXybKL7JiyZfOsxwSD+douO+wqkAxs0P5fBw+B+1P0Xq3v/jAuLQh2ugQedco
	UDXJaLkMP2s383Uo3f2fVvEMfbGzvCluPBWwBEz8vEiQR7E5TRQd4sFrZfg2u38YzzqP9s4ckhC
	obUlGPpE1o4RT9htVds6VTs6bTKrPiNWwbFSQGykby4ORUaMAyNLM8JJ/OSyJzG1nk349JYFqHA
	qLYW4b/hH0ZQaVfQqRurx59ZGGK0NlYw==
X-Received: by 2002:a05:6214:400d:b0:894:470f:677c with SMTP id 6a1803df08f44-899d1e8b1a9mr164246716d6.51.1772432022409;
        Sun, 01 Mar 2026 22:13:42 -0800 (PST)
Received: from [172.17.0.2] ([172.214.44.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c739000fsm98622986d6.44.2026.03.01.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 22:13:42 -0800 (PST)
Message-ID: <69a52a96.d40a0220.2019ef.bdf5@mx.google.com>
Date: Sun, 01 Mar 2026 22:13:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8859394589680869833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Bluetooth: Add Vendor Chip Support
In-Reply-To: <CACrSQ4GfZJCBCONtT44myPR63pA7_kJ=LU-b32zGVMPE+pvrFg@mail.gmail.com>
References: <CACrSQ4GfZJCBCONtT44myPR63pA7_kJ=LU-b32zGVMPE+pvrFg@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8859394589680869833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8859394589680869833==--
