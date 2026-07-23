Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD81360EEE
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800907; cv=none; b=LyMh7Ha3H0haG9YPrw2C+LSsG8ILP61nYEDYxgUWfvqYGYK9bRhOrrhMt9quETIRuoMeFvdnFWpKUzx8E2FaMa5YFLeVtS4IWai/nDlUG/kzlnEqtLN2WFvYp9ROfX4LumPinkpCRqCIZ/3NZinVw/SKNwhMvakx3hKPPp21oPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800907; c=relaxed/simple;
	bh=YrNwPOUaN/D/xIGIS8Wrq1Vja45hkotvnkB8WrmRm9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m1i31Q9gYqzJb/NgisqvSYu/Pn/23eGGkMuNhecFLe8TtfekCe+qP8jX/5Y8UlBAybS93eW/6wFJnfofYlTXUs0tzXhHUWOkytN38cBP1wEdRUsQFMvboT0h756uniNg9CHZxab1A5e1Rp/XF6pG1zPHhgbSI6Xxi1kEPWc6QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLdIqyyC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLdIqyyC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cace91f112so5484805ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800905; x=1785405705; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PxzE/E2fxiOOGnrPVjy/0qL7DPf9N4aD+fJO7qmlGwQ=;
        b=mLdIqyyCskplj3KTNOxXYBD9GKLyJNSuzKfXWy+iR5qnmMkN4U+rzJZ1b2NgcbRaOP
         npAtfcI7J79+knJoC822k8r16liCjpV/yzNZVvBANuEcDOXbFvWvy1JMjX73Mzz+LXkF
         TpxI8KPW/Xi+AGPxTsc4hQ6uXAEZHQzg1/2UjLr5sw8wYq/7rc/lvYBnNff4wZy7kppy
         unjixNvgVnm9vGrWMs/vASxJHgJP4mL2ZvFqjkezhTCCdd4K8OIg23BsFT8hENbKaRX8
         gX8u4niQ0s8vY8wA+jT0ztvDBAFLgSKn4tpGO0SgLKRENV5Q3MKBwYjk2XCvYvVR7QLC
         2Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800905; x=1785405705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PxzE/E2fxiOOGnrPVjy/0qL7DPf9N4aD+fJO7qmlGwQ=;
        b=aJr/iI9vm6BNEqudWxTs5YZ0sSWAhhDL3le9BXWpyX2gWIyf/D6PgmZpLsq4gymFFH
         fpuRiSLnIteUFxAiRVGnHOoHoS1zgdN6JcXiWVYY3MfRorI459EkcbOcDuRe0sjH++vk
         hDmNK3HMiXT2lLVniceVxgtyTizRot+FFBhlrKipENRMIAAlxrJVim6qLMXj/Sj4eqwY
         QO2gh0f4vFfXOCxBwSq0GP3Xy+mw6BNFZ8Ljcl8uX9HeWHieWm1HGLdrq1QETl49ZNbh
         e7Ih9PfcLGjPpL7dzYfHGZ2SZWIc2v6cXurEus5HZaXMtDWN9P4wyxk5orYVUoRCRxVt
         kqgw==
X-Gm-Message-State: AOJu0YxkPrsSV5CUq8b3KjgcJSEvd3GO/eXAQp3B091Pwu+FQ1YzmsNG
	fkSds9L/1RP/HvJHa4V6VEfX7NzFzmIeVTV2I9nfhm3yNT1ONllcD4goFj4W+w==
X-Gm-Gg: AR+sD10DaUkJoJuIS+cM+4lvLMRTz29BEZp2Kzc1eu6ihXg3fcEofljUeA28J5KOn6S
	DYnXxYcQQRqYyF/oSyFL83tK3xqi1n50frHC8wIioGHiCz2otEAhW+OM/Rm8XXzcFHUWAQKoLMS
	s9JJlso5/Evecx+Is5AUKnjaDeCOc2AHfZCExvANHNMWcqZM/BxeL2oJkRmP5jG9ICoih0DEfsy
	NPVxxSR0XJdheFStfw3H80M8eRNd0YVpimWpA56oAqeNueMzWUgVLtpJw9mxvpNQhxQYjmbH4aK
	7SRdKquy8O0LffDUDsMvF2RQOeraiszGWsew2UTIpdJp+swWs53JMUu82j4um70taazX0gz689n
	4WE/skVsMyyTbK4HnKLJeM/FqpKjNPyzbvCuAhcSfOALKin/dXXY4QLPlu867MWTOGs7ckzbvz4
	AM08n8zjKhZA==
X-Received: by 2002:a17:902:ea10:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2cfa6a4b3d0mr27057865ad.9.1784800905373;
        Thu, 23 Jul 2026 03:01:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.241.147.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd828asm30804415ad.19.2026.07.23.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:01:44 -0700 (PDT)
Message-ID: <6a61e688.05c456d6.216f46.b430@mx.google.com>
Date: Thu, 23 Jul 2026 03:01:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2901761814741484997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [BlueZ] sdpd-request: Fix unchecked malloc
In-Reply-To: <20260723081952.92162-1-zuohongsheng@kylinos.cn>
References: <20260723081952.92162-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2901761814741484997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133038

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      534.20 seconds
MakeCheck                     PASS      1.01 seconds
MakeDistcheck                 PASS      157.95 seconds
CheckValgrind                 PASS      156.42 seconds
CheckSmatch                   PASS      310.09 seconds
bluezmakeextell               PASS      101.11 seconds
IncrementalBuild              PASS      543.65 seconds
ScanBuild                     PASS      956.99 seconds



https://github.com/bluez/bluez/pull/2341

---
Regards,
Linux Bluetooth


--===============2901761814741484997==--
