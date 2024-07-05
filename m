Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DB149E13
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187402; cv=none; b=UaZiQqM9oZhjhXBu9CXQF1yshXlWvAYoRT2PX8ZBw3FV6IjQSd9Qo/DIRRwQo19ImeC+2l3mZWq5UaLPalM86U7BoPfG1xpVAqrrJby9WDLpsvMptx0JnUAcUqk9P7MRcETYe1ZElL7F2I2cJhXjGEcc44Ko7UShFB5SKmfV+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187402; c=relaxed/simple;
	bh=nEtmUGKdsysw2EfVG4wXi2JSslKA1sIEA4Fy9CVTqo0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e9Zid27UUxsMRy/qBrg4hbzKGBdhGrvE3N8ewoT7yDkUxxZybBIIWdvTbvlOIxBNN9/Bd6Y74Fpc0Dq0aJ41a1/oXFkpNrO7uPHZzU1RUoKDkTI61GnsZEKNeUw7dSbe/8lay4aUiDRuK4uDptGhJxXxOCrdEwa4AIPqgtaU5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc8Phzsn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc8Phzsn"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79eff64a06aso2171785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720187400; x=1720792200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dgd/P/YvSPXr8EcS8Wy0SMtXUe4DGH+QIBry4dOrGUA=;
        b=Uc8Phzsn02bsPpOvlhxl+zwT/itNh/Vx16f3FAT5ROIRigGN4e0O9oDy2Jnr4LpqhQ
         k9FrVPT7uZb53YR8IEyoYxOvCo9VqrRQ6+GGd9qpIrkxh/7moNQ6VSvmPdgWkFKXaKzg
         B8qtUl69O4twWI8JOnr9g7q6/PfN0i8LMmkqPtYm0zf32m5TXKQg6ktIP1Wh07OUD8vH
         i01GZf8WDZf1vgXOZsLR78b2iazphKvH8VJ9jLk3tcsIsl/hpnqjZqp03pPUVWZKQcHT
         fIIfiPl6+lwez/W9SG1V3CRD2eqRJO7Zp06jHPhtkorxv1Cad+d5MsuSs8az/81mZ2+X
         NodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720187400; x=1720792200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgd/P/YvSPXr8EcS8Wy0SMtXUe4DGH+QIBry4dOrGUA=;
        b=IWyUfNGMqe+MqQyj1/xjoGNhOLsj+sRv1bCQexs1f2cuU4xW0XPRlCl7WvPt+MrsT1
         MiEorHIjgDYeWWHHqYxqmalBKochzYjaolrr79bNPjqkcOAnFd4P31lCa2Pd9OT6sc4Q
         PisF38dSaFVYJl8qs59eCpj91I0y8ifi8p/xOtRitu4a+zFDkydiDHo7sPGTSjysfOzR
         BFoP5eUOx2Tws4c2EAgbCBiwBQoOU+yVxtYintsdWNIifZDmG79wzR3u9lhZdASbUnwk
         moPEEJZ8ZLNZUkAHbqQLZ6w8/m+MHe95Ga5jD57wX5fJ0zC9Yohsa0G3gJtEo6XrgOJw
         gj0w==
X-Gm-Message-State: AOJu0YxePJ3PFNuYCNkvIuuX4uCgg4YFjNSW85qtlSbRmO8+fuWzjwuG
	6nwjXN+0fMsA2q4mlU80MZ2zxux16LcsU9OPILMvzt6p55CxlQY7TA+q9A==
X-Google-Smtp-Source: AGHT+IFNZ69AH93Xk2yHfDjXr/bUEcNGuUdBQ30qAcX1S43PISMQSgFqvDFKQsWxFs++/Zrvbf8rUQ==
X-Received: by 2002:a05:620a:387:b0:79e:fb4f:f600 with SMTP id af79cd13be357-79efb4ff713mr100050485a.18.1720187400079;
        Fri, 05 Jul 2024 06:50:00 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d8896291asm552204485a.50.2024.07.05.06.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:49:59 -0700 (PDT)
Message-ID: <6687fa07.050a0220.82020.5480@mx.google.com>
Date: Fri, 05 Jul 2024 06:49:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5926490263411059695=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gudni.m.g@gmail.com
Subject: RE: [BlueZ,v2] configure.ac: Fix --disable-cups
In-Reply-To: <20240705114235.553566-1-gudni.m.g@gmail.com>
References: <20240705114235.553566-1-gudni.m.g@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5926490263411059695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868786

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      1675.55 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      181.72 seconds
CheckValgrind                 PASS      252.54 seconds
CheckSmatch                   PASS      355.39 seconds
bluezmakeextell               PASS      119.53 seconds
IncrementalBuild              PASS      1377.58 seconds
ScanBuild                     PASS      993.72 seconds



---
Regards,
Linux Bluetooth


--===============5926490263411059695==--
