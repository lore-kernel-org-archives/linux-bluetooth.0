Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557519D881
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330174; cv=none; b=GTpXDbtud0TWXf9fiQExyj2Biv7PF6yhBSXF/gNbOZLZ+w2UipsCorCb8PxvxIoLfJp2C9WX2ZP3jYmgNm60i8mWiVIfot7b87rbEfIuaF/l/Qfhte8Gw7uNtsoKn1EpZjUfNElNudL7luYSIXDC1+IZQlSuHWcjqbgNioYk+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330174; c=relaxed/simple;
	bh=X85KGziPFwOsHzdjSATT5HtRNHusg4Ls6oRv1KwK0qA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QvlZHdi9pi0lywFB3yJyqGYPK7n8JqgSjyocHUI7jGFSfWrlA8UUKadQoSA8RYEGF7AOWjjqqQdnHmtCUiheSh7trJp1l+6Id2iuX8XN64W/1WPkA+8iwwbGAP3lrKNyr7ujo1HpcntGNitACGSfyiXYeJEo9X/z7i8zGT25K8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6+plZfK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6+plZfK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b157c9ad12so310891385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731330172; x=1731934972; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3iq/S10AQR37MrRsX15xylS582/xLXCjcNgGV3Hy4Uo=;
        b=M6+plZfKdmcaSucb/o8887RVVCmBoKIy+5efBmQmuKFbIYxB81CzKi2oZU2vKs2U1t
         P7+ygNhCtiQaDcsFmO/pjfL1N+wnvGAB7hK6W9J5O4YLut7thhR+ZiO+qr+cjfvu/qvS
         xZGBAon0eWVlVXfHEexyyy0PW0294KMuKY0iHWU9wO7pd9zV9bxVrEKHYBOtO+jEz5eP
         8RDoAjLLUM/ErBq3TpDrEA2x1eLHhe5rMZw+ckBRE1QgOwR9dVtR51nyoOZN2fvvlXy/
         g56x2dIli1PmhLjXiaIuhoFWe/WWweK8JfOGFhH2W4zXrhDPThEL4FRdmzmoWYpJAUua
         NSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330172; x=1731934972;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iq/S10AQR37MrRsX15xylS582/xLXCjcNgGV3Hy4Uo=;
        b=c3Jg/SqEVdcO+Jc+z90czM5zbubOAIyFYIaAc9QgHs2tVw+THOvj6w2/r+YQ0hgc5w
         9yH4mJC+p5YS34DAu9CM1Zxvt5sps2a4mKZyd/pAi5+1V2isrLRCkSx8bhdAprpSneEw
         +xd+d/lB+fNmog72nm2ln8VclXqlWKLv4epvMO/gM9IaDuOCbEZgQdG9L7FCP23SUeI2
         uQ+jlNsLZnBa1sIdV+Xp7fjuBbMgAtKTQu/adXdNrksVvzNyBUJ2AKVzZXz9z9ChLK8v
         dV1ZWtRIoolGoe6JyZyPT9aVy36AqP3oaomFK9R2VgN7nUd34Lme7KQDY9+pfJxdSWnA
         XPRw==
X-Gm-Message-State: AOJu0YxUniE91ngeSTfrct5uB6hL34jKiR+eDmg4stVcfZaYvEDOdnqA
	IONpaT4wVTSB0BF1b7jG9DMmhSylVQK/iQNBhqu1O3MVNRZMaXJHHJseVQ==
X-Google-Smtp-Source: AGHT+IFDwJrhO/YLxdd3cX3rV/0n6RLA/UgYXfOpHF0mXdHS5U/+/lLvIz8anwyT1DdV4JaC779Dkw==
X-Received: by 2002:a05:620a:4608:b0:7b1:8dc0:761e with SMTP id af79cd13be357-7b331ec8e57mr1790591185a.35.1731330171626;
        Mon, 11 Nov 2024 05:02:51 -0800 (PST)
Received: from [172.17.0.2] ([20.109.37.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32accb211sm489671885a.98.2024.11.11.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:02:51 -0800 (PST)
Message-ID: <6732007b.050a0220.3c574f.c96e@mx.google.com>
Date: Mon, 11 Nov 2024 05:02:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1858968710230291109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Fix the PBAP GET request in PTS testing
In-Reply-To: <20241111111625.1887695-1-quic_amisjain@quicinc.com>
References: <20241111111625.1887695-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1858968710230291109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908365

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.95 seconds
BluezMake                     PASS      1688.10 seconds
MakeCheck                     PASS      13.07 seconds
MakeDistcheck                 PASS      183.09 seconds
CheckValgrind                 PASS      255.34 seconds
CheckSmatch                   PASS      362.03 seconds
bluezmakeextell               PASS      123.68 seconds
IncrementalBuild              PASS      1435.02 seconds
ScanBuild                     PASS      1020.19 seconds



---
Regards,
Linux Bluetooth


--===============1858968710230291109==--
