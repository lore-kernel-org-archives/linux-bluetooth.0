Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322801A38D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358274; cv=none; b=L7kHO5c99qIuVF3uHiPDUQ234ky3oK7JyMWWu9f+coj03X0T1ec97qp/muxvby3xDVk0/3xgnB81Ah2yodY023yGMPBNdt68lKBqFN5vrw6AMjDTp1CFWXrCMp8+gSncdbI9ZLYAYLFUu9OVfx31uBUc26fjTuwx4ed5BmmpkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358274; c=relaxed/simple;
	bh=r45rcrF3+T877fW+wmdm8FruQ3LjA6h4j6/zzovKIu8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AgY4ygWZuzmqP369wAxw59XHRCqLrOktXiqxVvBVrVwWhuu5A/Gp6K7AEtGlVfuf4tF4td5vNuRcpdzbP7GoaAVTywK8m4bf4m9CNqDTmr01HTC70bbIEBFjHASBKylz1diu6jRRLjGjYPQWQgtCbre2hhO09kqcg8mABoBQIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICSRKvk0; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICSRKvk0"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-221830f6643so143935fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710358272; x=1710963072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yoEg9ibTgUSTd1yAADIUVYxch48Eymhhq7/HUa/lbrk=;
        b=ICSRKvk0FIV+BnApLKb6nU5XWgcowUEsWv5sgZU/XdRr6LbaHWrbrkzCx9ClNoVfY1
         5RZw0uMFUE6eVPXyYxf8rIIU4rKOVoVWFfb0xioFEBYyVHs35becZ0e6Gj8mGZxGZioe
         7Q8oBnLunWDSmCr3awJWfb93ecV72Bdi+RbO3fBkSPrRdQ4Eo/4FTe2xVPU9nOKETXKW
         Cm27mccEulH5eXH4cdt9xbIrNMcKczI/KNXMMlmMH5syv82Zk291mcezcsN+hh2N0JCZ
         dtUg2/vW5VCNCY0zayrZi6jZ8vrLZjZaKMY4s3/2KZO/d7Wr7Ft3Q9/eop8l3QLD8hGv
         gs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710358272; x=1710963072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoEg9ibTgUSTd1yAADIUVYxch48Eymhhq7/HUa/lbrk=;
        b=IWaxTc1N7zufoGWSUIzFDxld9r5YadW39uR3wnLl7sqOGTTd4O5wogXvQejdQlSMMb
         BlRVqd6EMSSjbaVayC0G4usuukzGuiZnspG9CfAQKPBJNtLgMEeWlKn7Hs88xTGyOQGL
         LocECV+wzYu8bK4wj7ln+0Y/l0Q0+SvGKHRAsqrEHoLSI63ZzLbfTmkxtGzZvUZL3K4W
         Cq+8QJYThfwZx8s/nAAcnyTz27h+V+b1qAsHB4tHd7AGsM4u0jpV/qu6flEyOiM4igbB
         w0L01qDWDqSKp2eY7WJGx2VoyYFzgI3P2JoP8y1Ilg9UeEQQKbfAbsJu6nWKCTRZ2sPz
         ARuQ==
X-Gm-Message-State: AOJu0Yx0syqd8ZCb1grssM6eg36fXap0E9Ed2t0iKAbvivuDQPF7rbPM
	CbmPxxeh6Wb3lmKZKlYRW8sSjnzccYVJqbxwtqBZ6b19nhMZ92t7sHzJb2fx
X-Google-Smtp-Source: AGHT+IFdLVEEwaAVUt733taKAzJSMIyL/cXlrre2+bVW+RLhSmiwMry0AF1mza/Yd6GaMIGHEUX+7w==
X-Received: by 2002:a05:6870:7a4:b0:21e:d86c:ddd5 with SMTP id en36-20020a05687007a400b0021ed86cddd5mr6049172oab.41.1710358272094;
        Wed, 13 Mar 2024 12:31:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.207.169])
        by smtp.gmail.com with ESMTPSA id o8-20020a056214180800b0068ff79d8d97sm5034413qvw.41.2024.03.13.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:31:11 -0700 (PDT)
Message-ID: <65f1feff.050a0220.d336f.534b@mx.google.com>
Date: Wed, 13 Mar 2024 12:31:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4833490435958843730=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Broadcast source reconfiguration support
In-Reply-To: <20240313170300.40974-2-silviu.barbulescu@nxp.com>
References: <20240313170300.40974-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4833490435958843730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835028

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      0.95 seconds
BuildEll                      PASS      24.41 seconds
BluezMake                     PASS      1710.09 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      178.16 seconds
CheckValgrind                 PASS      246.37 seconds
CheckSmatch                   PASS      349.25 seconds
bluezmakeextell               PASS      118.39 seconds
IncrementalBuild              PASS      4599.11 seconds
ScanBuild                     PASS      991.87 seconds



---
Regards,
Linux Bluetooth


--===============4833490435958843730==--
