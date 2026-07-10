Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08A3DB325
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675631; cv=none; b=WcFjjNOp/BXRTpSinpOxzvTq7IR6MZj56K4pved6hhHsOh0+f6uIIMGwAER9XU+kJnkC4GD7m2oCyLKkarkd9OMN5GxMMnD94Ss7f+nzfFTvfrp1k4R7Rr7N6gVESI6eTRdppWzCZaLpwFGEsLZ2zZqgUY0R4QRqcGKRt2ZMoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675631; c=relaxed/simple;
	bh=FKt+F4hdnMkH1a2tZS1ColJoYgzDUF2VnjIVIdrY0ww=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IwnlYrpWXVqHnMBpWwRDeF30wVgtG0w+srCoBFvCxh+Nox8JZSMQphy1WVCYMrWmzo5o7wrTVPhLKQGDNXtXgS8A5Pby1/4wl0fnRaeW+XPRa8jSkNUS/yNAf/I6goyWcN7edld9W8FXaALK/FTL36O+skd3wpDMLgPrdCOJbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZSWAMl9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZSWAMl9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0c68aa31so4527461cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783675629; x=1784280429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s5uV0j5VLZlevjt4TJbazuLdG8eGAM5Y/FgItzn1I7w=;
        b=RZSWAMl9ACsYVI49RFvLGlLYP0Upc6WVUCZATVcTFHZ7I5kpyDtzuIOFa/xwRG68Pw
         FtOxW8TE3LgsIhEkf8FM8l+poAvKPDgTfzRY45onqSjCjbyZ1rZeSRk0ZyuGNTGyifyK
         wwtIOaE8OJuxrTqlHa3K07bfF9UAGwkcjKlhmqbOi3D0jof8s6qqdXnPk+ZwquQqf3CI
         Ymn1G5Iq5cshhw4u32UEajHkQ+RYvRhwL3rj7X7u0eIgvHlh4uHvsYJx3OqqnmYkfGT1
         115IqqlLZcIAxcSOA3PR7b/FdjImiFWJ/StQ9IKhoCZdUYKaxa/RWUurin6uYyHX9xg3
         FkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675629; x=1784280429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s5uV0j5VLZlevjt4TJbazuLdG8eGAM5Y/FgItzn1I7w=;
        b=T/BBKF3II0/rK51clxs2agWouVvxLU9OBAbWhyT4c+6nfchAYx4jyh1SgDxsHRkgMw
         4Q7YiJopP5ejzn/UUhx0/JqUuVtx51a7IQx6Uw6l7SMn7NXlDruI3tA0awR9pxvjcQ8F
         27R+f28eDyvKr4xWZmwx6uANAkQSi6eFUeLidedDGtDro8jOYJZnNqDngnEEUUuvl5nt
         Bi+qKyew51bhdCk1w3w9aLdY7PcnZtJ/+VVGD4cOzYkXMwUTx/xaGwBusp23JkLnWBrD
         1MvfR29oe5B6LHWJsM8OsoqQ+1aIl0KVwLzpwv9WgL4DZrx//3TyezVJBOaNotpUb0GY
         Im3w==
X-Gm-Message-State: AOJu0YyfYuDE5lj5r8N5TfWBun8tKU3Q0AZ9zQ4H3qA2VaKGUDk6YLZY
	k5ONnd8PG08aJGp77rjvGxaksqvcsriv5JLbLEgsVg5LQl/X0aernt5+91HBmQ==
X-Gm-Gg: AfdE7cnolfn+NeNtYx6RGrfB7c+Zg8Jq26PwyUVNeO6G1AJh1aSgJdaUfjg4LGoVRaD
	rxrucfqBVNCxvt1p5zeiyt/SvjoiRkQJZhYwAU0yEeUj4rQEYACKoOa2VR71aNmEJ9sBBlD4bHA
	bdTw2+565U/YCT3JKi2GfjnDj/JImLwAuFxd6Uy0qVfVojBQq0JfJc7mWjs1oB5MzgazlFzOKmN
	JWIHZMKWKnCKrChYR/LFiLIXZ7XBMRMreIuI60LkCNs5VeN/ACsf7khPUWtio0+C6rnK7H2K7lg
	+y4YUP8of6z1etlppIEGXYvUPVfVWyyoBrWXgOSphmxAe/xN5QkFl9wueA44pwt0YwBK7bUtGdY
	FhwP1mY+XXXqKN4c9q1MJb1VxuE6xTEktAwUoOkMOTDja1kj0ccLCGUZr519EnVxidjU/DgcAYM
	FP4UYPPq9agWVkvA9O80U=
X-Received: by 2002:a05:622a:d2:b0:51c:7b12:5ffb with SMTP id d75a77b69052e-51c8b4406e2mr119318471cf.87.1783675629292;
        Fri, 10 Jul 2026 02:27:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.238.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm11918811cf.4.2026.07.10.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:27:08 -0700 (PDT)
Message-ID: <6a50baec.3c73b1f2.34e4e6.591b@mx.google.com>
Date: Fri, 10 Jul 2026 02:27:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1360234577770350758=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Channel Sounding reflector GATT registration and
In-Reply-To: <20260710070820.3793624-2-naga.akella@oss.qualcomm.com>
References: <20260710070820.3793624-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1360234577770350758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125185

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      21.32 seconds
BluezMake                     PASS      555.55 seconds
MakeCheck                     PASS      19.32 seconds
MakeDistcheck                 PASS      163.46 seconds
CheckValgrind                 PASS      234.71 seconds
CheckSmatch                   PASS      319.88 seconds
bluezmakeextell               PASS      104.26 seconds
IncrementalBuild              PASS      577.10 seconds
ScanBuild                     PASS      1019.13 seconds



https://github.com/bluez/bluez/pull/2289

---
Regards,
Linux Bluetooth


--===============1360234577770350758==--
