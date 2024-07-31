Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28D1AA3EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427305; cv=none; b=bdlxCctXrvAhBUdHB/ATY/7Bz+//5he+pISjuv+1iKHIyo+qJ2tZKrQ0D2wfaoTBq/BCE+bbqfcd2HgJR3rTVcciKyQQMlfLZvBUoqu5RsNVEBVYSL+gmEtQ/VPB9AMGD6GL+r+RSuITOzZXN4sBwMmxWHiHWpCeRcs/Ri6q7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427305; c=relaxed/simple;
	bh=BaEOnCxxZbBuKt1ot7V8OICwjxmceaCKoyLukbReujU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NJMnvgwhfMAp2YTrCQ9cDTXSMMJBFdOkHtAPH3pqL2o3WRqvz9beF6gXpE4E0oMeUc5KFrKbDCiafQW40guWz+Nt7DVswg1ksC0gekSfrF7tPOTLuYibdCc17CpMJVsNyCE1wBMZtHy9yM6ZzpBYxAMY/E43dLTSicKAJtEppMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLDtZVJn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLDtZVJn"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db2315d7ceso3132510b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427303; x=1723032103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FeiEw8xVphE67t7BQMGnCs26DK9KromU0a6TUOnco38=;
        b=OLDtZVJnzmlRbAAExeedhOIhrbcZrTe6AHBDar1obNneT4Jst/y/BzUv8qUADBhveG
         EROI7a+mAJFMMF0S5+y25JbIDmWhqjupoV7CK1lo/kHIvEWpCxk0fa0/fQjyEOqXKNnu
         b2atQjK9upLc5ZGz1VeDp6EBAZzmCE0Vob6JtQPnyA+QCXLZa3ca7XLvQRA8nFAeQK5w
         UF0YiNPBRw2nDd7TY38jl9xDBYeVV2YtDoN6dYf/qp1gTdRAf9GKXlQOVTAt+yh9H4g1
         WPTINOMUTDPHMz/oQe31umOf83TljbohEATUvsxA5GgArz9OboPjEhF6mfVPbktfbxjo
         3kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427303; x=1723032103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeiEw8xVphE67t7BQMGnCs26DK9KromU0a6TUOnco38=;
        b=Ovec0dMZt+w8O1pQ/VK2u52kw9HQ6PJsQDMS+fGm1MF3mkw6CV5sobRcvYp93GB7R9
         hq7yreu/2EjLgmw3dL/sflcv5vdnBlI5Efjnv4lC6ZN4cNsDi4KZMcbJ3g9hfYpsmYQP
         A4PAP/55FJg/dTZ5yCDv0A+6uxTTkrwhfijq9rHej4kewmXJftthfSYWY/FRxpBYcm7j
         ndD6PHGJzz82mcBMirJENGKU1ZUqAZs9ze7ON4nb0fOLoHvf/iuMYk0drwmJTHZ7TvtB
         whJBZshAY186k4qkXINXN2OyAM70WLY6ofZsaEvYWEIbqZYnKh+yywTs7CeTHcFRHvrB
         Mpaw==
X-Gm-Message-State: AOJu0YyvMRKskLVXhRcCG/BDO96tMD1yVskV60BqHiYq4mytR5i+opg8
	Z0lwiDZbAEnUpib0q7f6PyNoFYUmSBoUXuASM4dfu+QcmLmani+vkUoVYQ==
X-Google-Smtp-Source: AGHT+IHCUO1w/8pB/bZi1irevFShK7cHMP+CJPTwTDCpKpe40R7v0drRGavumZX2MSfvQBOFaC+aQA==
X-Received: by 2002:a05:6808:148f:b0:3d9:38ec:3d42 with SMTP id 5614622812f47-3db413c82dcmr5307661b6e.49.1722427302193;
        Wed, 31 Jul 2024 05:01:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe841326fsm58843121cf.90.2024.07.31.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:01:41 -0700 (PDT)
Message-ID: <66aa27a5.c80a0220.257b84.3340@mx.google.com>
Date: Wed, 31 Jul 2024 05:01:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8914454875902344627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alexander.ganslandt@axis.com
Subject: RE: [BlueZ] client/gatt: Set handle before calling print functions
In-Reply-To: <20240731102321.700398-1-alexander.ganslandt@axis.com>
References: <20240731102321.700398-1-alexander.ganslandt@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8914454875902344627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875408

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      1623.04 seconds
MakeCheck                     PASS      13.71 seconds
MakeDistcheck                 PASS      176.88 seconds
CheckValgrind                 PASS      251.74 seconds
CheckSmatch                   PASS      355.19 seconds
bluezmakeextell               PASS      119.72 seconds
IncrementalBuild              PASS      1420.21 seconds
ScanBuild                     PASS      1051.12 seconds



---
Regards,
Linux Bluetooth


--===============8914454875902344627==--
