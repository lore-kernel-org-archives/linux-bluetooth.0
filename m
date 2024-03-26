Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62561BC57
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471180; cv=none; b=BWIc/G5JjP/wr61MrLQjz/wamGt1aOfwb8J7M4/VVqwwwedgWSf8fn09riBRBx8J+EyZBBGRnm55ASbMkytFe0yC/7/XTJvKjm7v/YXUYOdD4UQ4G1Tmc3/+pfuPBfrUpObympYPFTVpoMSBVc/GYBYqwqPZhamLfdyQMZYoRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471180; c=relaxed/simple;
	bh=qJY03vycFuDGN42Vhk4NWQci1uwoqFlmqVIZhR3NZpw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ln96rkj0m+7qVGDZ+X85U33SXK9EwbsdE1klVlfY0znupd2fPnEVxGbem/bsvPgHEgwUALKQqp7G7oew4TIncKA32LKBz5sUaXBThExUM4pTmFI4O3aY8NP76aqc7jK/SRtIzrD/qg2RicGyQRFfRHvm5NRZaljZ9PBuqCbOiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNhkzX+t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNhkzX+t"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4427256b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711471178; x=1712075978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qJY03vycFuDGN42Vhk4NWQci1uwoqFlmqVIZhR3NZpw=;
        b=LNhkzX+tDq9HQ5pTZiM3h2BAHpuVDUsF/ei03Ia6zRTBoXb+PU7+NmcbG/wdvgFcas
         SVLtqkuIn2VVzaIejVCYJeyAeFdbL6cGu+QEe0DTNDFqQopzQIJS5Y0Ca3hV5h9+OgHa
         iDxpsLoHIHWz6A4C33vs0NaE6LbkT+AA9Ar8lg58GRqi1ErdiwV1NOYmkct9nHG23cxf
         AFVmHmo+Ds5GC0jOUGMWEAzObB/pQnWGKduYLLVTf/XofCQBk7oRoZ+YvH/iuHuqVOGN
         4mw3nsciy5cbh4n2WpQZHJWTsStAa/6k0yQEMBYEQgAwu0h9YSAgWOBSt++9AKn5jWX2
         FFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471178; x=1712075978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJY03vycFuDGN42Vhk4NWQci1uwoqFlmqVIZhR3NZpw=;
        b=IrR3pvkhDVAPdg5/pcPIcs83Y6UkEv/tIfjlFhXxbGbKzaxeH+SI7C8ox6Sd+9r+mJ
         SntRE1nbtpiy5VaLRKkLAkWDgwhWfNjZ2jDNbnmpGtEYwIdSeVGix9S/irqFZKxwo4cc
         8epqU9UHe1lUrz6bKZ2rhNZMCwDxoHyRsgLwT3YqWUPB9T8ZYqJhhjguInSFqB4mEQ0d
         IbV0mH5qSvuuIayTHlxytHTyOiHGwbqjEg8F//1j3O75ljz9VvR0ZCpMmdipQrfEMaWS
         Pxr+R9OD0n7XKcw0Lxa2AjQTIVfVJeZtz6GyaDiKzPfjcp2sBwkIU6tuGZUt/14VfBwm
         l3Kw==
X-Gm-Message-State: AOJu0YxjMlSZur1Fi6tLtc7wKyLM5SdhVP1q5MkJZiOCLUoV9v7HRpK1
	AdWeZC/7KDp7QMeKA0/QX4ldqEJUV3Y6tkKaKihhT2seWxfmveHvFErq5hnd
X-Google-Smtp-Source: AGHT+IHBPROpqxYLICQtRrg/XoKNqHRQdu9kXTEbOJQyasj0pEq/nRk/hOpK/R6PU7Y4h/au2g2f0g==
X-Received: by 2002:a05:6a20:9c8a:b0:1a3:3cc3:b251 with SMTP id mj10-20020a056a209c8a00b001a33cc3b251mr2189691pzb.26.1711471177695;
        Tue, 26 Mar 2024 09:39:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.142.196])
        by smtp.gmail.com with ESMTPSA id n25-20020a62e519000000b006e6c6a50e5esm3302400pff.34.2024.03.26.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:39:37 -0700 (PDT)
Message-ID: <6602fa49.620a0220.b31c0.950b@mx.google.com>
Date: Tue, 26 Mar 2024 09:39:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7172836074397603156=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
In-Reply-To: <20240326162642.1459442-1-luiz.dentz@gmail.com>
References: <20240326162642.1459442-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7172836074397603156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/iso.c:1451
error: net/bluetooth/iso.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7172836074397603156==--
