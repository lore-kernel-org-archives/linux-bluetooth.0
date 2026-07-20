Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5B43553D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560319; cv=none; b=GZqkTQdZiM9t+U4BXZbZ0DdSjMwl3leWVRrg2V/G8zv5ud0BootI4pC6QUMwBVCsQwoE9vJfFUGegDT/wKOkCyWsz9LtHU5XHZcTRQC6IITCcdiVJUubY2UQZh8ltVMQKp0KNeaAzW1xUodET9YlCREKkH5uuUpfoa42zm3k504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560319; c=relaxed/simple;
	bh=Wiq3o3NsQuSyBXubArXWAxT8OlPgaGZBaKMof7mdfGk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Znq8cXKbLgqkJP/WYLUgu/YAnJ5hGMGfzeLJeLV1pWzlF6Qp2o4nZDQYRFPuNYLP9kFFoBxPmzIb8tecIeaVxKrnAeWkL4SCBjL9i9eMKq+STCZ3F7bbx93CXrU3ygRvAvM5TcCMBVSOQeU873hePTfefDe7kovjEfnKraCtB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHTx61XO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHTx61XO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486672f03cso10156953b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784560318; x=1785165118; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xChbs12i6cGdrdoR9BIaIw/2Fdu7C+AplSECbZ97pTg=;
        b=YHTx61XOofhOiAQ8IL/jDXTKA+PnOx5m/Q7GUqAZrOemJxjyklX7rXm1YOMqYpF7jn
         8Av2w3ssQzGApEvFgoRadFa9vwol93PU2mrxtIHysuLnHoLAHW3myRxEeiXA8Og3Xs3l
         eJ1ZwxLelo4Lhv8Fr/C+HfGt3CxfC/Fi8kH2CKGb6jhbW+63b/O61iKzdqV4qub7vGg/
         fdhuqE4cJBoqCkWxyZ1FprLG1MvcoPQMeVxjAxko7NyrvUCgBMaa9WSSiZY9ge2o+i8m
         qIW3n5BunA3axaaDiqEDd6/fu1pLMMFZpW6MmyKUM4/EttM1ZE1ShfL0H7bpZtUu4d7+
         OMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560318; x=1785165118;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xChbs12i6cGdrdoR9BIaIw/2Fdu7C+AplSECbZ97pTg=;
        b=oYFcUGkplp4Fd1HwE9th8mYqmYPmfvK6n9uKQKLwHP0Zu938Lmi/wI2mkDmack+nkZ
         7ZIVg4fxyTgBZoh7jZ9QSQZ0u9v9aj/0J4GExxohU0XYuhPLbp5VsdLsGgJNoRoilKm0
         t8KSXRlHC/z3IYfyEu+cd8Rb2Be+/4S/S52LZZh+oR6P80Rg7Rkc2yq+t3G3zMciD2Z1
         qwPHEXMPG9nMRj5WQC4znbhWqAu2oihR6XtfBv8dQexQwAX8Nc4nlQv18NRZQVqR1hh5
         j0m+adAzwyGdN9RBPDJfARP9tcelqLkD/HAyLaFVfpyKJ8fpAyPxbePsWIWUWQGJGh58
         kyow==
X-Gm-Message-State: AOJu0YzeemBELD+M8Y9SfN7zZcIk/jdyh5kNaS+hdPho7V5/zd9Mw9N7
	8lc2lYJtV23DhNxrI9nYytwvF2/hsfFbhJrFejgQ9aeBbdpocnu/+WvB9UFI4w==
X-Gm-Gg: AfdE7cmY3eb1N7QYKnN9TRHIG0qXP148/PeJf51V+qOerazahxVtdGvCnLeZJxUr1ge
	NCs2oC5K18/pwvwaC96u3IiX9Meo7lkoTLW76nrFRLiz5FDvJOSsdQeC5O3xMLzwiFL0oOE/k2m
	E+I9YByELwpExZbmo/okuELg4sGQW3r+oXdQYJPVdmPxAVXHgAjTmn2OkVtQxuxMQghyjtCkZ8D
	4oMx1gH1u1ET4gSz7xO5xTZmhZkBfVnegsiTDzl2TekOMaPx1AMu7XxOSMFiq7War8xq0YDawK4
	pkwDKbpR1d+blduYAmlwfR8I+/qkeLuob0EL9saMjKLcvOLBH03UOlLTmfJVtTz38KPrpWADQEm
	I6P0IEVgaPgFX0j1iDgzl0DF+A+gvWnB/qCsyluhqJIsglvUUwzxpFAU8W5aNs4fZQexIfo5AEx
	QKbPNfgef8kbw15UiP6NA=
X-Received: by 2002:a05:6a21:d8c:b0:3c3:91f5:82cf with SMTP id adf61e73a8af0-3c3ad94bb70mr16002563637.46.1784560317592;
        Mon, 20 Jul 2026 08:11:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.177.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm38083113eec.23.2026.07.20.08.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:11:57 -0700 (PDT)
Message-ID: <6a5e3abd.d681cab9.169270.3576@mx.google.com>
Date: Mon, 20 Jul 2026 08:11:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8754752136780889525=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] test-runner: use virtio for the default kernel console
In-Reply-To: <e71384747c71a2fa0db585acdb727f324161d1b8.1784554811.git.pav@iki.fi>
References: <e71384747c71a2fa0db585acdb727f324161d1b8.1784554811.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8754752136780889525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130938

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      16.62 seconds
BluezMake                     PASS      475.48 seconds
CheckSmatch                   PASS      232.13 seconds
bluezmakeextell               PASS      73.76 seconds
IncrementalBuild              PASS      398.22 seconds
ScanBuild                     PASS      691.41 seconds



https://github.com/bluez/bluez/pull/2333

---
Regards,
Linux Bluetooth


--===============8754752136780889525==--
