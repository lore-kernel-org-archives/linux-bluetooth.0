Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B954FA3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193957; cv=none; b=cEI4GsOMdh69/o6uKAYEdu9Ov2YxZxVfmE3XnGlHWztBC+sAjbMbIS1cJwBpI5H2hkbfst0fw5htSdhyJvvtNf1+a4lzJxutnZBQAsAyZLzNfVP5WyklMRlx0bOfG7d+/RUv8PgxEyfTF/k7q56Dz0if3apyWJfOGwrmjRjk5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193957; c=relaxed/simple;
	bh=k65c4jiPa4gX0wNiVZpUE3NspB/un96zmzHQppkfhPU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eQQR8vBuIAk1PMDLquXaAbVfNPpk3oRLH5ebmbH+k0mrfjBB9JJxVXN11vck/30mGgKVg7VffujmGaxx+pUTxyOAXA8tQmNVsLStQGaVivDzPAae35QTE37n1q8SE1HdL4gxgFzLCs9/jiAdxe1vOrqr/l0BtJo48lO2IeJHY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCQ+LiZG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCQ+LiZG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e66e8fcc2dso3412846b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710193955; x=1710798755; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tcQeUXK+fAoATEimfKNengwMoye6VXMrk0moYk4wz6Q=;
        b=TCQ+LiZGF3lgD1xsZlT1kuG0L6iyXHIBqVHSF5Qs8qJrc2ucHKqIYEoE1m6X9hIxde
         gLCuzOJ6DxixGzm2FXaJUiSKEreQlupeK/OXkFvJ/o9hpbLK7mZ8TLtMS1UVI8bcv3Fr
         J5j0RfDmxWZUCEYEWyQg/TCcSaSQzSpzBT6cte9pTPc3lFPZPWbFBUsNiag/fQPtiyPy
         LqlB6xLYmZ4hJQq/1RBta1fQowad4U7yrzPyT11HUw82rug5Jcvg5zFlTxnfwmS6i08S
         PDArW54EnOwDuttf86r79WvpaXB8aXi+aBg2XYe4Zez/v0LBfsm/EiAGZoJB3bVo71YG
         Y22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710193955; x=1710798755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcQeUXK+fAoATEimfKNengwMoye6VXMrk0moYk4wz6Q=;
        b=CBpHlPik5kGikBb4BAXoMushzn+uX3eBOwNQrJ3jnR25Y7CoiHDCvpaLjeTmh5yT5u
         AcP3WG6YCLdvxJ+inwwjv8s/GDqFwMlyXHkuK70rt02gWgVTlkJiye2yc3x/pdfB9Qq+
         HlhOtbWbYfq5NKtsNjSZ3Nas+OA6A90cMszoDBoxCB/OCEqiKPTxCpy6jTY17NziuxB9
         9L3U1iz17kldUX5waosVxnJbiCpDz32XF1oeNvO4GnAaFC3xDVokx1zftuoLzgY/wr50
         2590D6lT6uIFECcRdj+23uNZpeF5A2JPhXYczUEwAu6PUAcCcw1Oj66p3RyZ3fmumFre
         nA+g==
X-Gm-Message-State: AOJu0Yy4lpziLRg8jc/XCI2lg0/7sd1pq4KyRNDT9vofpPPVVz+8OfXB
	tm7dnBdusvQr5cXRzb+BFilvJbdYVMs0uxWbyz75ZxGlZw+asiMQxJYFpfqY
X-Google-Smtp-Source: AGHT+IFvROAssa57Bmcm4xo1ZD7X1/y1/mbkpzskqcBWr2+AaNyKa98qArjqkLmASVbCXTMykrW5Bw==
X-Received: by 2002:a05:6a00:4fce:b0:6e6:9ac7:8024 with SMTP id le14-20020a056a004fce00b006e69ac78024mr2934096pfb.14.1710193955114;
        Mon, 11 Mar 2024 14:52:35 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.11])
        by smtp.gmail.com with ESMTPSA id gr26-20020a056a004d1a00b006e535131c52sm4996892pfb.146.2024.03.11.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:52:34 -0700 (PDT)
Message-ID: <65ef7d22.050a0220.863cf.e436@mx.google.com>
Date: Mon, 11 Mar 2024 14:52:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8396208546142650821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] shared/uhid: Add dedicated functions for each UHID opcode
In-Reply-To: <20240311184456.890351-1-luiz.dentz@gmail.com>
References: <20240311184456.890351-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8396208546142650821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834419

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.82 seconds
BuildEll                      PASS      23.96 seconds
BluezMake                     PASS      1616.78 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      175.40 seconds
CheckValgrind                 PASS      244.90 seconds
CheckSmatch                   PASS      347.14 seconds
bluezmakeextell               PASS      118.36 seconds
IncrementalBuild              PASS      6031.14 seconds
ScanBuild                     PASS      1006.01 seconds



---
Regards,
Linux Bluetooth


--===============8396208546142650821==--
