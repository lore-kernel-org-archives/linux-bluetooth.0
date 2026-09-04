Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF051F0E34
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482812; cv=none; b=EgBvGGrN/77W6bMgnP6BKJyKllYTov/vGzyxweBVZ9MpsUe3ZixPgXb3o8S8MdjgL/4sT9pBwWgC8BtXAFXmXEXZ4uQ0LxRV6LhYq3UsIpyiAU35pd1jOA17Zmyrn6BstOlg8ME+arcpg0jTQ4o0qaynQWQjEa5mVsPlAF5eNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482812; c=relaxed/simple;
	bh=UYklCzMJW1Fa+wQ+R+J5dhTgSAbLHY+162KDaIr5DKY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WZExO8HnlMcG2FvBFiui3m37kQHQEdOGaZDsZQflPQ1f4yTjc60BKwdBImULgW5gNDpF8Zw0ncxyBtYCYigaGbQIsaiO+goRP+Ks8LTPSW+ivfI+SCLXCv0QiogtSLJpQUDwyAiYej0LbUIvsl63a0eo6MW9+UPDgYBFzn19+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3VnhqRx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3VnhqRx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e8e70fa02so6236386d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788482810; x=1789087610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UYklCzMJW1Fa+wQ+R+J5dhTgSAbLHY+162KDaIr5DKY=;
        b=K3VnhqRxo1jzFnIqYj8YkTVOewC9x7Wl33zNqlbd0mbHfucxjVau/Cm8um5w18DDGm
         mikfRJPy8xdXwB1yFUUXCNFQyg8OnVW5A3uadmPYxilKzTKGlEdYNkGZzAHffePo0NXF
         nXz195c03qyqN9OBxLepwIeQObU6wLpUF7vkxl0IQ/Jh1bB3F+P+vsdhSEm+n1vc1WFb
         PzTOfwnDUVI1ixANpfqNGS3oO4ZvRyOEdwYoqQUoo551y4fm2vxYez4iwHJ63DG/rQtH
         TCIsAEpN7CyxToD9+GSZB/c1jhP9dhaNV8e0ycN7ZDkIIWfKm+P0yC6DvC3gE1uGa36E
         s1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482810; x=1789087610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UYklCzMJW1Fa+wQ+R+J5dhTgSAbLHY+162KDaIr5DKY=;
        b=cI2ED3wHFK+f8Xehf+OBaXeRQ5MbEYGNLURoyniLr2TmDVPTd1LzSSp+BWVP2LWjrz
         yEgC4Ma4ZULMIZiPJ68c6Dy8z47coxcfntTdxBq27RQdo93C2hPGBtMOTAV0QLTu8sMU
         bT9AluR6TlmOl0tZmO50aHXXLJqzuANj/XkKygYW+EtxtYzEByRvnXnAKqY8c1fG/fmV
         94bJngCGHeQuIW2TgL3Hj7/yLeSISPTZODmU0nCZxhCeie4GE4VyyEbmkRz9PFIxhjpD
         PYmYtIwEByk+NglpifZV8Lc4vlVPH4NhobfEm743zb3a9NYZg+UtclJZ7Gwzzfi/81j0
         d0Hw==
X-Gm-Message-State: AFuF++kgR3PDlOjyQSaXh5IQMpbGxQpcRkrvBZZ0CeT+TTm6bb6wrrOI
	cfiyW20V971DYPQ4lRw+EqrYi/n/3wKb/g9G/JmIGAbUH+v2Z/OvJgwApDNa+Q==
X-Gm-Gg: AYBFou2rsyrlyHkT5PR5g3Q2mGfl2DZkSr/bu/oQ3SxHtZyB06ta4CmzHA0TEHfht/f
	lOkoWqrf3hgBHDiPlz6FWfu/1V5I0DtPN6Frzn4pWH384BiMcdqf3f/8nrPRngQZrTZxjJQ/qvj
	+/1WuTkkEXYVoyVlDq9AHcYrGDpuiAM1igxArJmvaKdNlGF2jw6Kxl1X8CITnsprvBXjfN8yjC4
	SCpHOS7pm3XK5i/l97sJ/PrrdOgF3v4asKBiAf4NIeSOEkQ9xEOnnFzHNalxNUyZtoWC3avB85h
	4qYIuDdacuo7C4vznIRYVZQ0rCGfQb+KTN/wU6b0tQXZHQoMj0aFmKdRdGZKYvpmBWkBBWto8nv
	O2Wz0XV3y19pQpXhqF+HyPWMRNQn6mnGYhETMoCdNjIk4sRvVZ6Ck96DHHksDyX5DmbQjjWxIuX
	TX0REryYsDpeLvGraOBeWEn7aEDaY2dhjyooSOFFSow3zlfdmbDw9Hug0qy5KafwUS4Ac=
X-Received: by 2002:a05:6214:5bc4:b0:90e:7e0b:5d0e with SMTP id 6a1803df08f44-9103eef80damr43559576d6.4.1788482809786;
        Thu, 03 Sep 2026 17:46:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.30.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040596315sm7742906d6.7.2026.09.03.17.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 17:46:49 -0700 (PDT)
Message-ID: <6a9a14f9.ccbd8c9f.297f9e.c6b6@mx.google.com>
Date: Thu, 03 Sep 2026 17:46:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1716491097812994523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2,3/3] Bluetooth: btintel_pcie: unified decoder coredump format
In-Reply-To: <20260904002939.622659-3-chandrashekar.devegowda@intel.com>
References: <20260904002939.622659-3-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1716491097812994523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:198
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1716491097812994523==--
