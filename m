Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14E1C683
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568029; cv=none; b=s9F1SvPHhKcFnMtWBYtwJsgnXXsPpI/uIURZG4ZsSTjMmgk6mGZFvL1ppLXIBA4OF6iTMmxFD5j98G+r/Z9M4rCYfR594F9ddJ3HKmfZbdeHgdYUF34kvZ5Q0dKtCoi4FvjYP8SizxP1IZE7NKa/hd08ckhqXk9iAVOiFeq4vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568029; c=relaxed/simple;
	bh=5itl+lkY6EP5bHTDxrULV78rC4ysfqX2g7f09+s0DL4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ig266z37VEig/2uKZdTvKD0p2Ef1Z0XPdLtVxYrn3UXA8ShnkLkQxuwPvqCte7HuQefTJzdm7RLh8CTzEt9bySLrrmmDARnyZ//I6B3MOdcfa1JvNFlv7vNvKoNO2PnoAcsYLnQW6WSWGJqHYaHGa3M9HWh2yp7dtc9tYTQhL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFlyxdFS; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFlyxdFS"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d5eed9c62eso244555b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719568027; x=1720172827; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7cJVdQBCK1r6yK30LvPOt4NYupcXvNV71+i7IczAQc=;
        b=DFlyxdFS35qbMgjt2nDjoaSQU/fL2saekZTbUrWGNC0LkIF252qihjICXF0MAcvXXu
         7070J66kp/goTV6vDPHyWSVOWNqJEbm2z4QL39ySlvvHLr0fkxksHsLkrqTzC2diF0NC
         YTANtb6k5zch6uSzCh05wfEgoOMC0kjrL6srmVrG/mvkODD9PAJxe/i48gN7Bc7GUkgy
         gey8nrX9f74OaXXIaVZideC9VJJ3hJRoUvJh76JWh76RuPOE/yC8Rqyg2L+JT40Q44JG
         6h5Vbw9bvZlRd1hvYrxG/Q+P2xpuU87892IL+at8WjGrEs3qeA5+eNXQrpRkRWDAlvI8
         BtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568027; x=1720172827;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7cJVdQBCK1r6yK30LvPOt4NYupcXvNV71+i7IczAQc=;
        b=M/U7qiRxdOcPQLfWkE9MCQx7aswYEY5L3dh2+IgL4IOZ4FJT0W+g6Og2V/Af/bH99M
         KxCGycWR62wUwiOtmAeIEYj7tfIgScmiBq1RoLP+OizEDrF1zrTaETZB/3dNPLnewkC7
         ykdIxA0IM9hFzMELR37SsLG3zb1nTS779NNwkLF53xZEix+nUIPbW+8MLMd4GAbIQK8U
         amiJGHaOHr5yAf7GsIacAH3blDfmzQZnI9zl0xiU+Gbg1wBU5T3G8GkFJXT+tzUL/Ekg
         kkchmGLYRL1h3aEMH/jghFx1zPmCZm+4hWAXC5WkyVza6yU4seCHKn6TmF76uZVjpXU8
         E6QA==
X-Gm-Message-State: AOJu0YxFvgOjEThQpka0s+XNxzJETaj1hI0BIgn1CrZkl/t6Tci4yXL/
	g2Z69JcJiXYo/45jdIxadVBafK7g9NxgfD6B7Lw4JxqPrAB/hSFbh3gLWg==
X-Google-Smtp-Source: AGHT+IE0LCr7ypW2g57j5vL6VGeeULrqYyR4Fxh/jVRRMAasepLKU+tO6dkuIt3btErcUnoYAPpNiA==
X-Received: by 2002:a05:6808:1a01:b0:3d5:60b4:74e with SMTP id 5614622812f47-3d560b40cb6mr10433344b6e.27.1719568026588;
        Fri, 28 Jun 2024 02:47:06 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803fc8b5csm1146938b3a.130.2024.06.28.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:47:06 -0700 (PDT)
Message-ID: <667e869a.050a0220.acd7e.33a0@mx.google.com>
Date: Fri, 28 Jun 2024 02:47:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5613731164243082315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] gatt-server: fix memory leak in bt_gatt_server_send_notification()
In-Reply-To: <20240628075719.42796-1-r.smirnov@omp.ru>
References: <20240628075719.42796-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5613731164243082315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866451

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      25.21 seconds
BluezMake                     PASS      1761.46 seconds
MakeCheck                     PASS      13.72 seconds
MakeDistcheck                 PASS      191.98 seconds
CheckValgrind                 PASS      263.42 seconds
CheckSmatch                   WARNING   365.33 seconds
bluezmakeextell               PASS      125.57 seconds
IncrementalBuild              PASS      1546.59 seconds
ScanBuild                     PASS      1033.94 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============5613731164243082315==--
