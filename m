Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A53376E7
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689676; cv=none; b=aCwVynbBmtTVf8ORRkcTILViN7V1PLZYTAoeizlO9LJpNwDKl7YjjXhtxiA8lzYTR+C98u+KLTVE+2dcxIsoQBxDYcm3wB+8AujQbYZRz8MDPz44/pNl/unslK1KshZAZ2M5ykpzH6daFeg0ufmCAOtRnIBW9yWBQSEWP5cxg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689676; c=relaxed/simple;
	bh=GpKlnQFBDW84ZbUDYlvAWVJXtGDzBEBVmNvbO20LjlI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fLtEanYkEENJk3rH9uvuvEAD8VDsHL73U3KFi13Tkz8OFp6N0KvtF/RVP+LAHLu0035L88lby6iHLEjOlNqeqHVzbPpqjt+rG0RPwSm+kcsex8pkkmoTe6PU02GOeUQ08q8jfHCziJlHwlZuQXAPhmf+xgae5p3iIV5DWdtwW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW4XSRcQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW4XSRcQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd69e44596so1697665ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721689674; x=1722294474; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NCCIsO11oOfNujVcRXzsyNE/B6HUg9ToT+yDh6r3WzE=;
        b=QW4XSRcQ/VlKcnaumg/0zt+n2CAjpYFOg301gpraocTjBcO0UApU+LDMXzHU1X7zt1
         QY8xqr2fpYDzPtZhlHI1KCjaH5wGq78WOVUssapwQs7M7O5MaXTXezBxR0KSGupvCFmo
         rENGAIlkSDrW4vFtNmLvwKldQ9tKy8CGerCsCX5H8Pk/rJoD7AdjQNu4fFHAppPFlMQb
         8OCtDREljH+nUEnnAepNqyT3UoSV9YD2Z77gTOzMY9aqobvQKLodjrXkOnItQSiXc9jB
         z9cfpd3UygPAGzxntdUW0rY2v29pGYtC3tBvbBLq8WvGx0m8lLJQD/kPu0VdwSwJFsVR
         ZdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689674; x=1722294474;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCCIsO11oOfNujVcRXzsyNE/B6HUg9ToT+yDh6r3WzE=;
        b=qcm4UP1A71W+MWYzcEekfTP/hOeE97Ea5eJzQG/8TxyAW8zdiYQH0UOjl/BHtJCzTP
         Ut/1GkT+hebxIDljBh/2n52sgRGkWunDt6aGcWGJ/uUxK+5JSYpqLxDL4A9ORbd6oS0g
         0Dr/43fcaah/f+Hd0sY55AzgudVlx2Csr9rCQ9qPq+5kg5ZXQ5FyR/0pjWgb4x6yijnf
         +gYlHkNmMaNCICucILh2/GVz7MJH7ywnwqpWYbDzPARmXMB8i7RWWh7Clt0zJ1YSA4iC
         Vq5S/jM8jNS9xKRlRjGVz8BfbIrYb1zbLfY1cDpwRifjg4jHvvtqvaztfF8jGZruPAUL
         A2dg==
X-Gm-Message-State: AOJu0YwdsCBqerDm5UMQM6Qn05BUGzOkY5pUmY20YkHhdc9RptpG7qgZ
	iCAQb8nQBDH+FQk8T/cgcUPDmxD/iam91eMCrQPZZYatfl/PZTETFEFLcQ==
X-Google-Smtp-Source: AGHT+IESUMr2l4A6S4efZ/qZSKq3Je3V38KNanSyts8qeO+iukdQU4N3+W03Oi7pzo96dmrTDyCH2Q==
X-Received: by 2002:a17:902:fa84:b0:1fd:a3c4:25eb with SMTP id d9443c01a7336-1fdb952e8a4mr4412465ad.17.1721689674140;
        Mon, 22 Jul 2024 16:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.137.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25bfc0sm60882785ad.42.2024.07.22.16.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:07:53 -0700 (PDT)
Message-ID: <669ee649.170a0220.3ad950.04a3@mx.google.com>
Date: Mon, 22 Jul 2024 16:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4261959958492973082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/player: Set number of channels based on locations
In-Reply-To: <20240722205148.2273531-1-luiz.dentz@gmail.com>
References: <20240722205148.2273531-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4261959958492973082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873055

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.43 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      1682.46 seconds
MakeCheck                     PASS      13.35 seconds
MakeDistcheck                 PASS      180.74 seconds
CheckValgrind                 PASS      254.55 seconds
CheckSmatch                   WARNING   358.83 seconds
bluezmakeextell               PASS      120.76 seconds
IncrementalBuild              PASS      3061.50 seconds
ScanBuild                     PASS      1051.04 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4261959958492973082==--
