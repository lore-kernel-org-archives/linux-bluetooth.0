Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6E21FF2A
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785651634; cv=none; b=uFnCEErO92Q9CK8O7dGqiG/bAstQMPDBOfhI9PW66p+ksGZEDT9w69KIKxrEkkzf/o7fcma5YckIAbXgJMlfjDss0+qQX9HQK6TETumzY+kWzv7sD7dZj0NBpYLcdumHJ9E+gpYsr7+F1QxC9el04LQqOlzBJRXC9WAyl72Te2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785651634; c=relaxed/simple;
	bh=z/NjBzez8dV1ifsscRYcKBh+Sx+ZPZrRZiJis6Fr4Dw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EWB2W279VheS+aMoUAAU3dql+kQmRAAgnncOE8/MtmFhBoNFO6XU3Ubgs6RpIQ7CK4AUR1reoFltH1u5QpWU0ZTCSLZsEgzvWfzwiwtzatgfg/etLB8ChaPk4ylk0T/w1iHwgCmg/8QRuDBD0OQnBHKj65+Q5DcT5gnM6o8mjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGmNffGK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGmNffGK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2238701a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785651633; x=1786256433; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z/NjBzez8dV1ifsscRYcKBh+Sx+ZPZrRZiJis6Fr4Dw=;
        b=UGmNffGK+sJxxEUrprxrpt/iqj5xp+UAnDqWul21OyExUViR1QB3TyeOdc0Gc/QNEd
         /3mLfTE+2YF6G/+mBl9xIocqLD9gyRwr4BpQ+O+aQ9P+kS+9sJra9a8U6oVrEGTNC3Gr
         A9GUDO1gdQp9kqrdxK+R/8fuNZHvow18GSd5WpaYVzhv1wfiwoXN1n2oXzZNVSy4nsTi
         Ir5TAMbblUL8/3cNcMDP61GIs6cErEnL0NL9BZ48EAg6bDH020lEMYZobTXPAZb6f+3o
         +DbUo+lLXOcoq8qAM5G7ruLw0veJ2sSWkYBsB5KvrJD5vn+rqgYnr1fi0IXgeMbrwWF/
         8W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785651633; x=1786256433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z/NjBzez8dV1ifsscRYcKBh+Sx+ZPZrRZiJis6Fr4Dw=;
        b=e9wjshaEpHD/KXvcEedP93Bb95VvGMKshA44Fys1h8v6es7tWJ/OeDydlHqIc1fzkj
         VeHKPCbGwphvSufQqI8glf1feSGU657oP7/KYnMOBK2kDIPURNSJC0ImMr+jDdn6zmq1
         NKPtPJZ2fTMZqUjMjneHMW6vxP5HYjHQ07X1JmOUX10e1UOcN8UvGjPiBNwA/PYiS5E5
         eBb3cUBWGnTJDa58sMDr2X5yVDS9B5fdSaskLlDrsL1qoYrbMPG0xkrsEzmIYXQZkLpu
         syinjdqxKMEQ4E6HqatBRmoYvD90AtXgWr9gQATuECMh0UjlznU2Rx+Lb8mw0d+vnAng
         CyIw==
X-Gm-Message-State: AOJu0YwHXnTj7OzVO7NKSmThZPqFHa0ecnAJNy0gknTmxvBjJ/jXgP6r
	iidxryZToBV0/bF2rzqNAred8EJIYR6HIxEte1PswcM5hSTuJZiOAL6LJYALDQ==
X-Gm-Gg: AR+sD11yQC59qyPr5jnv/zEL45VQOu6/GZtpmiL07iIBblg0H+aVe/14aAthaQ+3PnL
	FC57Wzsnj0wJ13mHwjZ/jU8rfngS3S539n2aJhsJKnHdixDL9zZqE4Haa4ylQykXNT7JBO3K9tc
	PaSYIWRmkbwxNAzl0rBr4K6Wal4K36cyTZxFdDhwZHqQYlgUbK09R+/7Tu8X7sjEEGaOxqtEKzz
	AIVLQ4sKo2OU7jUiKKgs/rdf7KgIiGw9cbEOEpD4kG8mTK+rtztby9NIkyNanNUXJ/nkYjAC+LB
	CHaZGII5RcomFhEHooWIi6HQPKY+yPKDYgPZq3y5o6DkjSIDLilF9bTr2FgdazlUP2WsQ6Jj9z5
	Yu3YxGSgtuC/51zCD2hf4Og/Dq0DLB6tWWSu9Q8mawQ+wlLVL/b6x8pSKXyF98J2FNd51fTadVj
	9wrxX0x7SQMVQTKr5EYe5K5mhxuP9etUZ5DzadNnzoFhgB9q/EZKDcIhtT4DHOXTo1nWA=
X-Received: by 2002:a17:90b:5643:b0:38e:2e16:859b with SMTP id 98e67ed59e1d1-38fbc5345f3mr5126132a91.20.1785651633118;
        Sat, 01 Aug 2026 23:20:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.60.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm24493312eec.6.2026.08.01.23.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:20:32 -0700 (PDT)
Message-ID: <6a6ee1b0.a1accbb4.1660b9.1a58@mx.google.com>
Date: Sat, 01 Aug 2026 23:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7274159544532519538=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahbazovelman97@gmail.com
Subject: RE: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
In-Reply-To: <CADE-WFdQ+35ePBX35mQt6o61dyz7tBkKByVe1BnKzXxpb-njAw@mail.gmail.com>
References: <CADE-WFdQ+35ePBX35mQt6o61dyz7tBkKByVe1BnKzXxpb-njAw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7274159544532519538==
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


--===============7274159544532519538==--
