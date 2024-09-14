Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29071D017F
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329989; cv=none; b=t85pvuLaeWXfCGUifRjdGgJeOxGEx7VkLJy806VQL2upUPxOOI7ahE2tNPocOu5eTCdnt2/oIETR/qm0hh2zldNxfFtP046uzdJwxGMdsVXgNskX9G4HWNRtcMNI2Divi39vW9/J0nUD7dnAJnSYWH/xM89hwURl5anHakDowzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329989; c=relaxed/simple;
	bh=z2v/wwNkqxsNQcQZfF5OIoj3Jn+9Br3TDBeIIbvYiMI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C6OmsDUS2xq2kF8NI27OEYR4IeMxIzmELuU/pZr3cX05lOwxvDvsirW2RKuWd8fFcvM4cfdA6oxvosM7LHwRfL147YeEOBWOt1gifYVuJ1G3MV26z6IVvwKubr4AD8PSEaOJYNqPQYAiEX7XVTWebcAVFQJgFihnDnJWVhfuBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPkBGTgW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPkBGTgW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4585e250f9dso20648881cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726329986; x=1726934786; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qQ3y0vCAdfcf/WFWwd7KB8euPDnrWw21WLs6TgGio=;
        b=bPkBGTgWw9TSEEgqI1sUnE6tZe2LUzU4Hcwv9Hqp5Yh+9SCGn2j3uptw03x+3P9xOe
         wG4vPzif2tTYQ/d06OujdLhRhY3cLrYqe+AS7WZ+CwLYtS/colnEkBCMvQ0Ic/XqY7xd
         8jmUCFpdpQ9AslEWyftQgY2bkfe8C9fq5ZEOSSpiNz1u2fpHuP2xTB54hp97xubfFK3i
         ed+RwNXHeLcIZggH/K3oh4Gi8w5scME7+HttV6usFdJmlkZPyIo8UAJOQhlFfHUtBJmm
         YfzxCpbDJ93fKyXnvrMdH0AuoJBqqGBdOh2G5iaJnUGUCB73nxaw6rnmcYq/CGKL0ZcD
         OEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726329986; x=1726934786;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6qQ3y0vCAdfcf/WFWwd7KB8euPDnrWw21WLs6TgGio=;
        b=THrNfFc5txesd/7jv7d2l8BZW9LPu31JEZP5j7wI44r1pxTbMO75hD3EfoajkXIChc
         87ncXr2Y9PuwzsDy69dzE9PfpsZa4qG1s4X1JG8ExNyL+7QoAqiyDGG+TIKxWKf6Z+qi
         ccbSmMOMp2GR+Wnpm+MRwdrSP1/okE8rfaiGA2CofIzycKQ6QDh3VspMiGxvMBJsfpzo
         ZMmbAU+MxOzFI+15TG/R17YSBsU3jlxpnQe6BNANd6pzrJOBT7dOfmWdXnMGgim0eFHO
         O4XSi7HkXQJ/ewh8IeJAxJ2Kkx8p7KkNNgM+vgat1JUs1FnKH5HcgYcE+oB7ub24DuFJ
         cDKA==
X-Gm-Message-State: AOJu0YwvTI7qgzfNE0ud6XJxjs3GQ6ooGqqoF/5/DbcySwaHfNqwMGaA
	SF7TYDaTjtJvlb0ub5SDnQkd/T+CfbzMaOV2gldfy6iiXwC3Nn84UABioA==
X-Google-Smtp-Source: AGHT+IF9OgIizQXGW2xIArFcPwt7s5oKHl2xoeNLI7LghLdR9rOTLW78ND6IpB1datFJvpekd6eVnA==
X-Received: by 2002:a05:622a:15d1:b0:456:4655:34e6 with SMTP id d75a77b69052e-458602dda71mr128095521cf.23.1726329986256;
        Sat, 14 Sep 2024 09:06:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm9120891cf.21.2024.09.14.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 09:06:25 -0700 (PDT)
Message-ID: <66e5b481.050a0220.3429a2.20c9@mx.google.com>
Date: Sat, 14 Sep 2024 09:06:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8837496670998304541=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, coelacanthushex@gmail.com
Subject: RE: [bluez] contribution: add b4 config
In-Reply-To: <20240914-add-b4-config-v1-1-ed57b7ed6eae@gmail.com>
References: <20240914-add-b4-config-v1-1-ed57b7ed6eae@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8837496670998304541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890397

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.42 seconds
BluezMake                     PASS      1768.84 seconds
MakeCheck                     PASS      14.09 seconds
MakeDistcheck                 PASS      179.96 seconds
CheckValgrind                 PASS      253.04 seconds
CheckSmatch                   PASS      353.99 seconds
bluezmakeextell               PASS      119.62 seconds
IncrementalBuild              PASS      1528.58 seconds
ScanBuild                     PASS      1057.61 seconds



---
Regards,
Linux Bluetooth


--===============8837496670998304541==--
