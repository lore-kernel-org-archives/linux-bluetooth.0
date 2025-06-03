Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A468BE8
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945929; cv=none; b=lcg+lZYqtpJIa76vSJRO6pFPiQQoPG6Eoke1dkD6deDtSsZS89YozZwykhWZ84iMgbrHcC/OS8OqgxhcIcME7L2golaa1Y2IvN49YhwmcZ47eSAsUi/k+YipusUAGWecNwdwvCd1mhPQreSsxG0u+Lyydun/jRgjyPGfyOPM7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945929; c=relaxed/simple;
	bh=zxlWfSz8+NRVP+9DFz9C8LXtSjb6tdM9yKjEPURbpUk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fN/0y6wjTJiAwI05H3smgTc+LwwkVSPmvqUwSVVBzZg5hK1jW3hPkLKzph5ofPhoagvJeT6YCiOKsvb1zzBmOkz0fyiFCHCusY+3kZAN34BLVEbW+ArQ8mjHd0XyC4s11weQVzmLK8ZHljrVDzOfUMe48gPx9FmrQpBq7xx/Csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtY1wYvE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtY1wYvE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a3db0666f2so110421391cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945927; x=1749550727; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxlWfSz8+NRVP+9DFz9C8LXtSjb6tdM9yKjEPURbpUk=;
        b=JtY1wYvEL6LddT55Qpemg0zD+LZ9iKZk+BtZgW9vDUld33gyk7xA5u0vv5CGMw06eS
         UaI7Bar+oovW/ByzpNpVB70fV9AVfqeGJ1GNiVavwnq8T6tYLiov/uQ5UwrIiSj5JJm3
         ZRkVMtwNA3FqojyyUyWm4Clc8jEekVKsG+L+ZABBmhkZIzqG/SAIe/WgX3ANuN1ZYSCs
         om8yTYGJ3iRV+o2E4o39FcLyle/1L32GqwIo2GvDydpPRSV4QtOopSj4uJ9ahsQtaess
         g8BkxNVLhM5hc5xa3d756fsWenUwnzh+vKqNZbMEcj4qLBbcRSr4bFF8jHxe62TSjyaz
         +ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945927; x=1749550727;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxlWfSz8+NRVP+9DFz9C8LXtSjb6tdM9yKjEPURbpUk=;
        b=w7lsmCH+41Fkp3MOgl84MmEU4ylerSY+O+wFSR+E6pjxUOYS6ovDdbs4OadoI3DR8H
         QUFVdewDL1pqI5y536zJhtp3+iQKY4QSewY/iD7YYJ3fo/No40/YhQ56lWJUbQT8K2wY
         juMqYXeMu+PtOnKRKFNrxP38halFc2svfNXCiUR3fedmY3iL8BlX+07/9vw6Wcx+5Ome
         oP0shHzQKYWGZvqoFap8TLVga0ghoO6N7FwOME4nmb959XSc4vb0ihpUyFamc26lEkbJ
         8+fdmq31AhkXMLxGWYgEDaIYvlUtHTebGcOXD7nG5LgyFFCWwtcc1OwiDHlXfujQH6U6
         omrQ==
X-Gm-Message-State: AOJu0YwPV1PZCsPn+d9OihtuBwGAQnKRH1HzmnMis2bvPzahabC062Fn
	2Lx5e5QeSX3REK2A/DpY5Fp5DuKr7SD7LFYcKkODlNaNeBhSP1V3V5irMRkeXA==
X-Gm-Gg: ASbGncv3nWTXSUIwM3F0VpEGzpx07q15pg1cHxNieNJvDyGmNsAF20gQUMbb0zEZixt
	jBfMuBwxtaxxKeUoEsTj/K5FNKce6DsWBV5YoYFVF++9j2F1RqzbS6JIjTJyxs+4FAWNsKwX4lR
	+jSQ5DyHCN3DxZMl3Ykke835KDX1T7nOMUEJzDtcdJqLL4iSvRBnt9wZxdS+f8CGbF8f6xGg0A2
	FSzkJ7WF2bPCJowO7OI6JiyAcc7KoAYm7YckZTmZOVWEn64yHG8/WXOcBHBV186WswEcz1OWeeY
	r9u1VoWuipP2QBga0yzAKYCC4AxNVZH8okPY9HWBlcn0ukxbAFEXtCI9i4Ro57Z/Wmz9
X-Google-Smtp-Source: AGHT+IFd0SsVz0jGfumAlOy85r0XgXBPkqcDtASlSRNRjOoKNb/3m0e45cTZbn5rA0KIOh6o1Wibhw==
X-Received: by 2002:a05:622a:260a:b0:4a3:5ba8:4978 with SMTP id d75a77b69052e-4a443c8fa12mr263772481cf.21.1748945926641;
        Tue, 03 Jun 2025 03:18:46 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.31.195])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358cef79sm71202221cf.35.2025.06.03.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:18:45 -0700 (PDT)
Message-ID: <683ecc05.050a0220.b9199.71be@mx.google.com>
Date: Tue, 03 Jun 2025 03:18:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5579126391913072985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
In-Reply-To: <20250603100440.600346-3-kiran.k@intel.com>
References: <20250603100440.600346-3-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5579126391913072985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:398
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5579126391913072985==--
