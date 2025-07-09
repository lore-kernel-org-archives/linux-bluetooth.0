Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E022B8D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068455; cv=none; b=YzMe19tkkIXDJTUqganAw9PwrHKLlSmeIcQT/yLYC2czDKOT4eNGF7z3Rd+Z11qYIghR3wHn8oFCwXtccvrxLhie82xhX0AZ2lZGql72Obe3OfpkJR9H3vR6vKufYLwIwLZk6V1f6Zt1Mvv9o6cqIsgUj9JuGcd2nuoe2mJZ9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068455; c=relaxed/simple;
	bh=SlFwh5Yor8Tf3cB+TQeJvEDAYu8g2gbhdar+CgBbj3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VOTJJ8UemMM0YQylmmC1s1HW0c7mHsbQO3ap+7YTpfUhFBPVdiUhuUEUFo3R0P5MQ2g9kvKaQOk006ilBVthfsazyY8apDmeSs2knxHnWCiUCAGDCG6mFqTqCORTujxHfXvh1N0AN6V+JZw77JI1ckQgGis4Yc2ybcwrYXXG3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg3wOiqu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg3wOiqu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a774209cf0so60269501cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752068452; x=1752673252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1BqdRLr73D1+mT2K+rOG3XWlAjO4gatYgum5Uk6/XYw=;
        b=mg3wOiqubAEyZt2K6z0FuS1Mo7XBP4XWlljXzG4GFkI06ASrIuHtuurb+kkJGOTmoX
         yQTRqvJK6645b/ufatvx0smt+OItIrgA1aLJ/eVpStmU2+eyichRVyit9u1FvEv7Q8Y/
         TmtW6E8zWmv0+pbr1uh46RA5cvqj/tSmTRXwi9vV5wOIykSccSkZkO4Q5P6W178zbzVm
         m1mPeOA90yL9gHBTQgqjJnZbwTUJ3RzG5vZjSYGx9ghRjdPSW5kWWfICxBJxV9tmkP/c
         N5bBrvcDScnrLZqeOlK9H/zStV6+pS7tt/ZbTY+M8GYPm0p9fsG0Q9MxklfBwJf9fsdI
         DamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068452; x=1752673252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BqdRLr73D1+mT2K+rOG3XWlAjO4gatYgum5Uk6/XYw=;
        b=JyJ52lyJPE/1scxuZ5fiGaqMWop1X162CxP25wI3xsnHrs642UED2fbPjlj/N0Q1U7
         oo1p+PvSi7L5rdsZyV8wGzYVE8zKBUQkuB/A0084+dg7zEZub/aVl6DEpKK4jDonDrFj
         VN+8ELAvBlvnn8wFBo0brqM9laj+82fLwHfByQ0UtRl2DcJDhg6MuxYGPTf10eWo+gtd
         YyfTy/jsMI4LzmuGI1b1On1zlEB84XBHNmJMKbxDyavQ7i5IBudyxidJ6eqB66PKllqt
         NK3/yu+MdbA1PPnkcdvww8dmuMAij3VAD46iqYHN22wbKuUh0Xk9Z6okVv9N65sgwAE5
         jUTw==
X-Gm-Message-State: AOJu0YwFZeQYE0VE4roYEERJ7uDAGy2sX88hk5BIR4emqiDJYwYEKDUZ
	JWyxdf28SQM8owqoV+u1UVnQN06GFw/9YJ6VeF3l30T4Rwe5En+TJiYYkkCodw==
X-Gm-Gg: ASbGncs+KMrj4J1pGzLptqciXAOTDW6v8lPeZQt3ejm4a5caXQ/97jRgi+5T/5C4FI7
	DMP18G1HTeFDEO7OJ0lWQmLIYxLao664FPqVdbUqkc2rvuNeO0knotwFZ9Uw56RqDBvUPcygOoQ
	U9B5iRoL9N+AzzKm9+5jfrAO8sRm3kQ7UaNsnfmJpnEE7VqFKqzVLWtXMx/lUQQhniRs0DMsy48
	lbH9nQqwzuK1JO8cQw4VIGxqNgFarELs8gVp5QPQMPI1UwhdK9RLoiVTYP/MUaCKUvTve3Pgbqb
	iv1bIOKAGD2HrHC/k1vWq2JwccQ7EICGtihIOOH9y9jXXdqTbeJZR6A63FIJluOXQdPjKSNAtlD
	AwzE=
X-Google-Smtp-Source: AGHT+IG66vWwv94Ygslvs3zK1SlivtQRFsAiCmiqHpVntgwfbLmJ/WBkbmJwU/EYkSKRiRE7FwW5Ng==
X-Received: by 2002:a05:622a:2d1:b0:4a4:2fad:7cdd with SMTP id d75a77b69052e-4a9ded015e0mr28554791cf.24.1752068452351;
        Wed, 09 Jul 2025 06:40:52 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.140.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a785b4sm99557501cf.44.2025.07.09.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:40:51 -0700 (PDT)
Message-ID: <686e7163.050a0220.1051b8.4b75@mx.google.com>
Date: Wed, 09 Jul 2025 06:40:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6496189321174121015=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i.iskakov@omp.ru
Subject: RE: Fix bugs found by static analysis
In-Reply-To: <20250709121852.2811885-2-i.iskakov@omp.ru>
References: <20250709121852.2811885-2-i.iskakov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6496189321174121015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980500

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      2771.19 seconds
MakeCheck                     PASS      20.05 seconds
MakeDistcheck                 PASS      184.73 seconds
CheckValgrind                 PASS      235.29 seconds
CheckSmatch                   WARNING   307.39 seconds
bluezmakeextell               PASS      129.11 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      934.68 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6496189321174121015==--
