Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D914C5AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119337; cv=none; b=hGYFsKIWfLwgXjtbSAKVSxtzm8aILKuBnE2v9GCzl3u5GqJocFhY1iXipwYkRfaDk/WP0Z2OhkE8wv6ZylRon0Md2WDdrNzB0ZCzTKbdJgyXM7fOizI7/pVZ9+KyQ5jBsA9C+00hDqzO5gX9QlJKtkRJ9jymhqo+KnP/Hpo3rOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119337; c=relaxed/simple;
	bh=popUkvFqwo8tj6shkTXX+OdGcnGv2xPTTnF4kSx8zk4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SYzE4idM/ZkXFqkXRyIyWVHh/q0QDTBzlUstdhqQdHXZTH2XTxlLIMV3xwVybNnh4Hihm+mD9b+xyMYgjeG+IA39L+JitbvGs64XKgW/GM56dZfJ+ukSTt96YEu/r68T5AKfe6I6yMtzdel48+nsx+WGyQ3hafQhZ0JM8lhtWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brwnYSM8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brwnYSM8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460ab1bc2aeso29813751cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732119333; x=1732724133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdSBXUH5oagmX2mMM3jOe815CxP2VjqDqj0dwO7U4wg=;
        b=brwnYSM85ivP/tVXosuJRa+a0wRAFTOUoIjY/kYErL6k7vZtnvt12Fq4d0/oVRkTHi
         O/+21RQ7OkoSRdPeoxp9G4tif+Ky0Xg7BXtIN883fJbhA+8mrmQvB7TgNmzhhGJBQ7uI
         BSoPI+DOM+X8wizHecAEnW4TzZTiIFmZIxMigjK25QyggGrBXXnOXvKe6by/vmiueYJY
         muR2v92eZqgDksLW/LsLnsgPZRhlaVRYttE0TA/2hIpzR37SJIohWiqBcUU2OxQmGMQc
         IbcJUnsImzbZAM55IOykUjZZUvqqqko4qHQ/81EjoZFqp+T2n6ub/aF6B9QeDjSt0GYc
         Fq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119333; x=1732724133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdSBXUH5oagmX2mMM3jOe815CxP2VjqDqj0dwO7U4wg=;
        b=EJZP+Ft3ncgtcrw7dNQxuZZxeQZ2wiJ0n8enZrFo3W1bARqUdZEW+eFfiK4z61TaOD
         5EHE2wrI+w+pZ/i4pdaCcN+ImQM0TtIcy6RJkoibs4gQ9x4XB0I9I+kvPQxeSi2Ompfv
         BzThXEt9SA8Nnk+Ue3aVU+O6tXvoXLgnoA7S+mVGpuEso1sd1wuewVXFngps+b96cHir
         zQG0SrrfimXMvp/tQdfBJhY9HLCuq5z6nlUH0UXJBueShmpYxKoF8dyq9xQXRYN62ZJV
         ZicG/D3qji8I2xrKDTblx7PMfye2RXx9PRg8Sal9ZTqk5wHSDEsK8PPT852spDVQNUVP
         Zd1w==
X-Gm-Message-State: AOJu0YxZ4da87mBU5VGilArXt69Mk/v9G+V8oLypMq/yGFKfUJnKm1Y/
	9Fnk6UMpCX4fga/cUo3OVgMWT2tNd96pRU3T7zivdLSc7VvNPZiFpHnvPQ==
X-Google-Smtp-Source: AGHT+IEw0oLVlX9pbiUjdM5xuaoz7pJuQtYVsGo/5M7/jnCUhrnteOqRvG8CEDoEJFs2D2eJP/BOMg==
X-Received: by 2002:a05:622a:1ba4:b0:463:788e:7912 with SMTP id d75a77b69052e-4647a6e60c3mr40536481cf.56.1732119333364;
        Wed, 20 Nov 2024 08:15:33 -0800 (PST)
Received: from [172.17.0.2] ([20.84.127.105])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646a547613sm11593191cf.62.2024.11.20.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:15:32 -0800 (PST)
Message-ID: <673e0b24.c80a0220.2b5a68.3349@mx.google.com>
Date: Wed, 20 Nov 2024 08:15:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3579162486574737463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Fix for broadcast mode, not to add any AD flags in advertise Data
In-Reply-To: <20241120144918.11991-1-quic_prathm@quicinc.com>
References: <20241120144918.11991-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3579162486574737463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911300

---Test result---

Test Summary:
CheckPatch                    PENDING   0.16 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1738.71 seconds
MakeCheck                     PASS      13.48 seconds
MakeDistcheck                 PASS      162.46 seconds
CheckValgrind                 PASS      217.29 seconds
CheckSmatch                   PASS      276.36 seconds
bluezmakeextell               PASS      101.82 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      865.73 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3579162486574737463==--
