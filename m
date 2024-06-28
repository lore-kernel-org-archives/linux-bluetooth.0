Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5A1C0053
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587093; cv=none; b=hN2OYDD5lR0tdWgxDPP2RxOS4p6WFis30Fo998eKNzCDbCW1mxLGWMPYqFNgtNliSJVk3SWnuLXLPsdjhnPkTnbw16loHe6cUON145a7eBJdWzy4p1VjfbLxP6OO2XD0up0Sn8gLU2ERnYGla9cZTydi99bm/mYRtRTXii+5s3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587093; c=relaxed/simple;
	bh=HK97YNOltpN/DpsS4wqTNGYEd2HF8bSsb/M/nUWornw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J74HlGl6hHqNY4Yl0ZWRV2c1ZERw9pNtCvW67Ixf37GA8FflaGjYcM7Fd0pbPzwvxZORjiRG92Kd9APY32k7FExvWQ/Yrmhc5s5TUo6Ca806pD+fvZTmILhIG3AaD5sE+vCfnjdUNTaXKauiCUnPDfujtM1VR4dS8w4W/9I74hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGdJ9uJb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGdJ9uJb"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44637e13866so5036681cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587091; x=1720191891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SV+xLWeuNcPd6Vtl+znBZDZvtwkPtzyWexK8hKCXmWM=;
        b=mGdJ9uJbrJzBKXWoSKFIkV6erzD8UpMcBhtvAAdh4sLBmQXF4dAbKuvitATMuEasfJ
         nHB+I7mPbboSKVOzBVHPmEMLo2H+BKqddCJjFC9S1sBuqzlXno+yD/huy7I1rHRUVuwS
         pwbHnCh5Av/2ZQqp9x1TfitRWCHKzcVuWuPFNjG3Ll6PkZEMLG/Zu0R96DgLpIwL0Jlh
         Xr7u6kGP/CHG8QtjfVYi5u3W4bUqHtqVJXOHbYsuBtR30pzpbsFmuclXF9780RiyZMNb
         /ZogbUJWFOYU9t0do0ZgRDe9YyVDlr60ClDLCmF/xW/mpCA7YnjxEPxQvb0mwjmlqXVF
         EdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587091; x=1720191891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV+xLWeuNcPd6Vtl+znBZDZvtwkPtzyWexK8hKCXmWM=;
        b=fvNePnw3zH2pQ/DLVHIBoaXYELwoAxPCYx7bXgHY1C+dlki63jswGFm9sauNCZ+Ipj
         v3JDBRv1isN9YkanAp2rckd81KwY+xnBjKk3uQQcNbGheO3AK6mjLMJp/Nj9pKL9cOuv
         cn9bXILh9SzZabiBKBJ/TgGhAeRFqpY1ZI120WSmjPgNo+brAjGTAqRXTTHMT4YsMhAm
         dncsBZ7vrDHDmC2h2SoYub9o47NmpSTclsRORgBnZPLAAsUncUZKw2tAEC4+BB9sCLBj
         b6esK6v5jx8cgLThqr/QPPP44ikMxbrwfK/763iBv6X8WhBSuBgDV7Ej+jxuD+u5W9Mb
         VhNw==
X-Gm-Message-State: AOJu0Yx1uhfQn+IyJO/minvYCsc7O+vPV/9WkEcvt7gBILG1f9Jbiroi
	T/A3N5DIVQN9FRMOMkFGdS0AW831wkU8LlqkdlOK1UhbCNcQ7X/pThpEDA==
X-Google-Smtp-Source: AGHT+IGLNbkQBjWOiOsnrR0kB1ogTEpVLKccp56DJxCIhhzWclXDKJ+80wgug5ldDs0Ru1/LvEJf4Q==
X-Received: by 2002:a05:622a:1b90:b0:446:33dc:7e3f with SMTP id d75a77b69052e-44633dc81a0mr80352231cf.58.1719587090687;
        Fri, 28 Jun 2024 08:04:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b4e2sm7763081cf.76.2024.06.28.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:04:50 -0700 (PDT)
Message-ID: <667ed112.c80a0220.59d9a.3b59@mx.google.com>
Date: Fri, 28 Jun 2024 08:04:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5207632905469269440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] rctest: replace sprintf() with snprintf() in recv_mode()
In-Reply-To: <20240628131531.551699-1-r.smirnov@omp.ru>
References: <20240628131531.551699-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5207632905469269440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866591

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.95 seconds
BluezMake                     PASS      1760.44 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      181.46 seconds
CheckValgrind                 PASS      255.22 seconds
CheckSmatch                   WARNING   358.53 seconds
bluezmakeextell               PASS      121.47 seconds
IncrementalBuild              PASS      1520.73 seconds
ScanBuild                     PASS      1023.90 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/rctest.c:625:33: warning: non-ANSI function declaration of function 'automated_send_recv'


---
Regards,
Linux Bluetooth


--===============5207632905469269440==--
