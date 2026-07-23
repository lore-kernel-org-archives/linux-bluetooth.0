Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287C4F798A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821330; cv=none; b=rnxZp1xxljA2novl0mYeU2HyUyFA0+QS75/6y8zKMK2ffva0bACbL8QD3pvIq5x05EueUXh6sGJSjbhvCvNrhlr+DUNDzcaLzChpfyKPtQfDoSZlZw9svyrBdhl5NQtqB0NDHa8jTjrSKII2lEOpGSlU3IrVR1c7y45vnH9GncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821330; c=relaxed/simple;
	bh=M3xz22uAH2562Jw611I9NnUIGMzMO/Gl7l694H2ow3A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mZkGZacg5vf6lW1k+HgBx7jrqbZeE5Y+7LFS9FhmIXjBuH8B0DSIjanMmQ/p865awYwil7hyVDXaAgK/4mHOeKY0LpdCmUl9fAAEwLQmPW97mDryarUq6YMZRoHXlzXoybLv3KQcuJUqKqAfOqaXpcAAG4VUooHjC55xjTtKcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r76w3k+o; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r76w3k+o"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso542406a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821323; x=1785426123; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tK1nENVlF2EaWJmu9OblubR0Keb2Y9klKmr6GGfgTz8=;
        b=r76w3k+o8H4cajUIFU3YgF6y77ue16jIRx/9RyIiDxUwXjAD+TAX/UmW/1nMzjzCOq
         29oUcSQklq3SUjR71EUhvqE7hYYyAUSIEe8r8sX9qfAW3KGSl5prPPE/UsqC8eddJzZ+
         6Kl1Zuh3daOzMrL5MukH2/lXIJw9Xuqnq4mBi+H85lalMjX9u/VcEBvCXu7nzB2HT1It
         MUjC1pIeF4UfxRpVmh9D1K0CEFmrmBQI6wjJncPiupqIx1Fiw/cnMqznmEaOdKKHmNOI
         ZKJpFqT9qAO8QsNWhZ64BvrWsMkwL1KHOKUX7BZPYhGhFA+dWTwVvEAoalIvSfofbX9O
         XCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821323; x=1785426123;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tK1nENVlF2EaWJmu9OblubR0Keb2Y9klKmr6GGfgTz8=;
        b=mjJiGv7434CTH2WUq+pXZyEzk8ds+rNGBW8fRLak9pv+lqj1iSeY6SWjmJZGFsFAbo
         8y9Y5D5s1AbWjKhuK2439Zm+ptbDJ444otI50RQq5rjZdyg+LQTULt1/oZNMG5MNoX0v
         cpgNu1e4fnl9Q7oxdjklJ2lAlSEr/bJx82tERcerfsPNPUdqYw0S1Hh8yYUnL310PLdH
         eYhOUTbTOLv1TiAA2PCNoJIOUh2nIcWqj5gU82YyuwPkVw0YjWycwgcQLidYJ1EgHfVt
         sKjqNQ4WiPjz6+JiqZ9SYn+3I8TsI84yluPtbBxOD7REkn0NIZx9y3H/BilHmrvKXQ1C
         GskQ==
X-Gm-Message-State: AOJu0YxNLyCcc2nHj4HDXE9UPvqKYk7dy7VkliAFE00oII18S3651640
	bt3X7uTLSIN+ZZEJz4T6nDYBEghdZsTK6Ky5SdJk91FN5zQa/oto0mTJFaJTXA==
X-Gm-Gg: AR+sD12TKZ4d/9QdiHEYw44D0/MuvcUPxsqBRHmc1Uyzh4PT1yMMZvPb8Hvb7B3cAhr
	LV1auW7WZxnYa1Sapa4CBNP3yPW6xFSJJVkouHYHG5htyhn8HkqhZIN3QAL9OJwVSRVhzU3SvCi
	bKg//WS18xxb/5nr88ED1XxEk/MBwQJCZzt939kqVS864l5HhRsgyokStBqymQAC8qEvFW5z9di
	M9BWm0JfKxrxIPfa/eS7oba7cqmSE2NYNXhe8H0ObOjsm8vqNdaF6L94UomoaVZmSA7jbVQv5/Z
	AtUKAr4QynjN6GcjqUPxdEzbEEPtzGfrdvCaPn2ObTd3OJrdnxnhDZ+WOdAaVXA80yJvWUVq6/Q
	R9VUuUIGczABth2iUuAWRwFN6I70Y/1CSZRRMHDXwETbNf+voggvEeuFY+NxsxqRoZNpWEpSflz
	4lKpagfErH2A==
X-Received: by 2002:a05:6a21:b8b:b0:3bf:f795:f0f3 with SMTP id adf61e73a8af0-3c44b202e19mr4028795637.54.1784821322715;
        Thu, 23 Jul 2026 08:42:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.154.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm21421217eec.17.2026.07.23.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:42:02 -0700 (PDT)
Message-ID: <6a62364a.1905e68e.25404.888c@mx.google.com>
Date: Thu, 23 Jul 2026 08:42:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7098175667323865234=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v5] shared/rap: Add bcs_procedure_data aggregation and procedure data API
In-Reply-To: <20260723095440.2524972-1-prathm@qti.qualcomm.com>
References: <20260723095440.2524972-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7098175667323865234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133205

---Test result---

Test Summary:
CheckPatch                    PASS      2.50 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      17.93 seconds
BluezMake                     PASS      601.45 seconds
MakeCheck                     PASS      0.96 seconds
MakeDistcheck                 PASS      143.87 seconds
CheckValgrind                 PASS      142.81 seconds
CheckSmatch                   PASS      266.22 seconds
bluezmakeextell               PASS      93.19 seconds
IncrementalBuild              PASS      592.77 seconds
ScanBuild                     PASS      853.19 seconds



https://github.com/bluez/bluez/pull/2344

---
Regards,
Linux Bluetooth


--===============7098175667323865234==--
