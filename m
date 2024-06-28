Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C01C9ED6
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592730; cv=none; b=Q/BcpiAEWwPTnS9zbZuyixil8uzXQ0YpA1M652DwyiK8ZJZj8CSxodzUMCSPbFeo01TtULmu1joWdG+4iDoqaXJux2JTOBi010FioSY+5/jXT6UFiLR7VCWnHwgzPXoHMuQ39iAF9Ac2GEzYOdMsdD+WgeEK9+kTN0MpHk6yKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592730; c=relaxed/simple;
	bh=NiYjcWk44FlW7gEF7iUczdvFsUMSVydAnGu/GPRQWzw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HAlhEo+r6gdY1eZ+9vzOoVQ/EABiwFseVOqtIHZEyLDsSZSH7mS1gnsVqI5u3JNExIZTazf6GOvYwtmJUs2h/OubX1jTOUDVrGVNUVhXs9Q7v81xiSeIZmuQhh7EvtQnhiFLUnkhdiAjpdS1csvtJsela2W/kQivhIQK+31YfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am7COrvH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7COrvH"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d565deea08so450163b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719592728; x=1720197528; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yDZ2wtxDaZr8cWcxaCyJOLtCKRfjR3NhnWSawARySf0=;
        b=am7COrvHEc4Mmgo/74QfnDEZaIpWMRg+BGzxPa98ExX/JAtjs9I99C1bvEXq+C7Iux
         vR5+unVTwyOi7kLMOsS4ngIS74gAl7ZgNyg9DarLMjbrLOAdrmP+9nwEROPPwjWEQoJA
         onzmKUTnykwndcKyKn30m8Dts6hx9mkWa/f1VbJgTohKiBcWKkT0s+4J6gHx67ANDi40
         gLWH8HbeHoITNTgdB2CrGd+vu4M1CucEf/vRZ6y/kjEd0+jtODP95+V6ujNZEAWtG/+N
         WOLwzEVP9RQBFL0YnXIRZdTC79i1S5ClqzTW4sD/JCallJHEbWSg7mfZyC+ZnXY8+txg
         +hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592728; x=1720197528;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDZ2wtxDaZr8cWcxaCyJOLtCKRfjR3NhnWSawARySf0=;
        b=fYFeq0TyGqzq+FAcR+K8BSkqr89+g70SXb6idYAR1Q7I2rUvGTERWPvrlCywZfV8DM
         Ia+5kRWrziSjWAT6Ye3+6EXSYoGJLp464qRTqmPWOeOlGfySXjLvNHvDGMG0ffduWydh
         SY6BWIKtdZ8e1IQ/vYp9CcMVi4V2rt+HLPhYt3FdchLkBrLC3yaSKBoR0o32DknRtMC7
         nDCEmb8UgQaKxaHBmKjOOyEgWLDsm+wkKFOrPWC6pb/Ttylane+3jJnb6XvJnUJIB0Na
         8UBGa2IR39kbPWWhh21RdTKuW6EC7HFswHJh8uZ4D4aim060ZDgnWEith3DM9Ox3HBOu
         iQug==
X-Gm-Message-State: AOJu0Yw7yMzDe6UtpWJJW3o+uW1Rt0rx7dVH7gJZVd3D3TXdvjcl7W1C
	Q1kT11GfNtxgmoA2ftmkcTr++GYxUBo3rGNl3a0RiNENvuXEf+piHY5D5A==
X-Google-Smtp-Source: AGHT+IFpwuN4h3px47wCo4DIu6HjqzYGQfX4DVmZu6udJznoYI/HAeahQ9LKGhTjRvSY7SLwZVd5AA==
X-Received: by 2002:a05:6808:1282:b0:3d2:4fe3:50ef with SMTP id 5614622812f47-3d545a52d32mr24385263b6e.41.1719592728168;
        Fri, 28 Jun 2024 09:38:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.185])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465144505esm8513381cf.56.2024.06.28.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:38:47 -0700 (PDT)
Message-ID: <667ee717.050a0220.818eb.451e@mx.google.com>
Date: Fri, 28 Jun 2024 09:38:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8169880123861900437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] avdtp: add NULL check to avdtp_has_stream()
In-Reply-To: <20240628150418.563987-1-r.smirnov@omp.ru>
References: <20240628150418.563987-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8169880123861900437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866642

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1644.91 seconds
MakeCheck                     PASS      13.35 seconds
MakeDistcheck                 PASS      175.44 seconds
CheckValgrind                 PASS      250.49 seconds
CheckSmatch                   PASS      350.87 seconds
bluezmakeextell               PASS      118.51 seconds
IncrementalBuild              PASS      1415.10 seconds
ScanBuild                     PASS      979.88 seconds



---
Regards,
Linux Bluetooth


--===============8169880123861900437==--
