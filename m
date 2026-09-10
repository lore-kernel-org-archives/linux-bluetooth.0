Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0F4AA41B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062165; cv=none; b=qBtK1x+kg6biCYAfRSKZNqnICU/5rxcvcDxUSlMfQJUTdhlk6msxeioWwLs6woPYTQEDnXQgchDwth0Qx4hipys/uhPn59rktYvXgwYKNQrDPeuoojVGkqCHQrNsNde8bk2ttXYd45tKElou8JtRJwrh9EUXiujz9ruTioV2T/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062165; c=relaxed/simple;
	bh=ecczfQSFI0sucpwH5Y4RlsJsg6cfUMVc8O80Wij/i4E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iZjcH7L2vAoz3xLhO7XLPC6Od3/HrWwRLYi+Al0liQFFvNrrKLXBBAAzJBTpvvKMAHue47ff8vtDnnQSW4aZkKZr7cHYJaF2HElV5K/UxlmpFUfmcBss4kiwiDsm1tteUEWt6WuCfaivCvthzxe+IDG86apHyRnJZeRinStJenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbRys+NF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbRys+NF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so78555a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062149; x=1789666949; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mKMWVJzy3mdUjZzitPCNATobpyJInqL1NQoun1ri/Uw=;
        b=XbRys+NFAHq/U1HZAsjzJa9F/SDXZJT1UKUMRgsob3DuASb21aJcIAwlA/B8vDaLkZ
         QU44YH237IiXiusdwKeA/NTyw/sVGgxsehJO/+qLuDtHzFd1+Eskzgk7dK4ty8uC7wZR
         xeOi/Qndf+DLl4xKm8AGTQ0g0RYIdc8VPPf3aycTws52ngLlVQh1PZiqVmKRRabTZChX
         +cjWwNOV3ZfgXHz6TWxKIsH+g8CWivEHerVKEiiaB/gCfDuQbjoHB8gTEJ+xSZYHy8in
         +RvA9pR7C3JthUip81lbOx7w9xENeQ9W54NatTPk/P8G0RsGIRUokW6WfKt2NBH8+Zc1
         jQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062149; x=1789666949;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mKMWVJzy3mdUjZzitPCNATobpyJInqL1NQoun1ri/Uw=;
        b=iTirRpwaiTQPUV/MhLWhQWnYFAJsl39k9CUbHzVi0zmcJVDX5iLLsql5LkKt/yQ60c
         DvzVqQS4LeBpPQCsdh2HqWeV1vTRDF4zydf0GZQvto6dSWTfPdqEn9bFfXvlpUWLy6Qz
         9+IxsNR8StAIg25jFSvYQH0WZD6QVCjKG6ZoAKPv3DHOTygx4s9Q2IRMes8etA35uOLO
         trH9Nx+rmNHBj2zCRejPjrCpL5Zc1mFlScwXB3zVnRS/CyQCDdr+5J0SHwYnOB95Ohpj
         +bBbwOLZkckAn2gyOrVbjOq/R1hKNWneUOmG2Nb+/MzGqv3vxQsB6koPM61qsTRYrGn+
         dHSw==
X-Gm-Message-State: AFuF++nNIDlAPpz3plXNyQxy2O56hk5CJ640LWGsfBlGDwMJDJEKovo5
	aMae2B5E5l3off9aqptXbI5aMWlB5rDVQbBT6g552R9Aq5YX3loboXV5wzUZ2g==
X-Gm-Gg: AYBFou1Z8S4bt+1oT8yuoV1h0w7R+uCx1ub1CUDLcMJOW1s8uKJRw/5ArpCkvVxEBZg
	avaqjzmAAj+G/7yKZrFM5BHy0ED6+qChBUqflr73AhD2YNK3S3pCbKx9m1IPjxsGYP0HNQx3CnR
	zq1mJXja93hZVHvA57Ui2dGzHKZ714oYEJK2rJ57NYr4SUY4kd303o1HB8erNFQue3kyCH6wUlU
	M/zFP7sV7H2mArBcYmkRJ5Veg8Q1LCboKfFVkVV2/T+LizyCoD5Ai01IBm4isunY8nowSeazZbI
	DYF5DwLjPS8Vy1HJ1bCofRG7UW0TuIKnSVkm5YdggYnNRQWFDK9riGhfrfRel7eu7n8NUt4hche
	plXKcygo/DV5Fkb4azV1DSTO8CJbbaOt3qrshGa25fB4QRW3N+CCL/xgiJ8ed4y0JnkDvqHrZjO
	kOT46rTTxJ2flJvs7r6+nAlhwXRGU4lDoJoQYTnRsHThcuNNbYn+h4MlvlYVLzK6ZHrsUfEOv5u
	KCVbK4wDnjS6Q2/
X-Received: by 2002:a17:90b:3b81:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-39d77b1d173mr7648004a91.16.1789062149377;
        Thu, 10 Sep 2026 10:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm83294495eec.16.2026.09.10.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:27 -0700 (PDT)
Message-ID: <6aa2ec03.ec67c18b.17c264.6774@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3590231019594858168=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] sdp-xml: Fix leaking the parse stack on malformed input
In-Reply-To: <20260814174731.1441738-1-luiz.dentz@gmail.com>
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3590231019594858168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v1,1/3] sdp-xml: Fix leaking the parse stack on malformed input
   Pull Request: https://github.com/bluez/bluez/pull/2403
   Created:      2026-08-14 18:54:58+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3590231019594858168==--
