Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1339AF1
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573112; cv=none; b=f9WGqd+9KpIOeLkoWIouZ40csJfVjEDCzF0o3to7EBxwxuK32Rd0+9iVISB6xayQ8kj6l3dXwxVAJXYwlaLi6OHxVCxBl1Cl7zR2L0Rw1JSSwlGOBuXuOyIbp5Qhp4WL6a1vV0wqqCesCyzK3rHiUb/xiSDZs8IFIV78Gfw1hJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573112; c=relaxed/simple;
	bh=8+YmQoixj7zMvoEiOMARxdp3oi/x+YS8bvn+uiL5d6U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J5xlHNgijg/WLjEuCi6ckjGkSKzWbCTiIfSMc4WInLJORzlhA9l24whjdT5C+ss9yrVywzshd9RU9msn6oNBSz7lUR08QASjA7agsEYUPx6kmsOhTLV+/aYI2k6imOy6X9giRFCfoCMxj8o0YEs3BM215EAaG1FP78KVuHbSJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdtGAkL5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdtGAkL5"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd72353d9fso3248868b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573110; x=1710177910; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vhsVIHlkr8sUSg5A2dYLyiB9JtUWNSsPJu7DA9NzOqA=;
        b=EdtGAkL5z60PRaXKXXvhHp75RUugosRPwVYE9t/feNMpV7LazqIub7QcWYX3k+NW4N
         +a1heFzn20/vJhsueGTazF6/Rgum9fCnLYhOLEpj9jHp0YM6/1L+LWsvr9DJu45ERCmI
         qfB/0jEsGSmEkpe1sU5r6Xxk4JMRUoDCU7+KnFJIsKUeQ1CkbK0Yc1cN9BlRGeuHymg1
         xh51cCH+04icqHujzvoJp4wTX2BuhsK/rrAgAnEYNO5lyRfG0Ie9P6GRxEFiGiBTgPsA
         mfwF95SBumhZ7lIbCenlmB1+U+lQiZmqX+9E+vrtGBYncLyHIb5KfC4E1c4Dhf0ym40s
         Wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573110; x=1710177910;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhsVIHlkr8sUSg5A2dYLyiB9JtUWNSsPJu7DA9NzOqA=;
        b=kXZE6tyBNg6InEHVezInK8CBdghxnlX2TQX5yZKYuYWYJ3ykM/GxfJIOqthMGrzEtZ
         cGDMVd0AHiEOCZ/VcqsauQ6zlnBjKt1Er7W2ecxhnjS21y6Z/JMJ8dBK/xs+xvrfZ/rs
         R+5z8QJQ1p904v6HGEOfhL8r1cuGWXxCuBS27JN5ISi2wlJneV/VmvYjLj2GpSfV6GO0
         rFm3Wee/jsaNVAvsQqUqNhtY67NZonXwSBBkwYVYF8Qf7ekGrvsGrX+9e6mM3YsKSH7y
         4O1e/ZH5eqPHGsZw4SrzQABNvKL+ozonWjYbIO/JUmbq/76AdYgpEF0EOqU3J0CvdLtw
         /7eA==
X-Gm-Message-State: AOJu0Ywt82zzwIaly68dBtzeI2MmgHjQlvd+UcP6vfg4xSfJO1ZKfRUU
	9sHW6hr0oqyofOg68N6zRNLdEQ0c9igcu6Gx0TDdQHG8vKZe7WLd/rrtNQx0
X-Google-Smtp-Source: AGHT+IGVasfyd2CEhAHCMGGEACVFwj9NcQfakxxmgZIyFIS6DlUgHbXieYZ4HkVn47IW0enfEfwDIg==
X-Received: by 2002:a05:6358:6485:b0:17b:304f:b2b with SMTP id g5-20020a056358648500b0017b304f0b2bmr13219837rwh.26.1709573109695;
        Mon, 04 Mar 2024 09:25:09 -0800 (PST)
Received: from [172.17.0.2] ([20.81.46.157])
        by smtp.gmail.com with ESMTPSA id ng8-20020a0562143bc800b0068fa4534070sm5304125qvb.83.2024.03.04.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:25:09 -0800 (PST)
Message-ID: <65e603f5.050a0220.5c29.4cae@mx.google.com>
Date: Mon, 04 Mar 2024 09:25:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2518321367368478078=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add support for signed write command
In-Reply-To: <20240304155839.48888-2-frederic.danis@collabora.com>
References: <20240304155839.48888-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2518321367368478078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832144

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      24.22 seconds
BluezMake                     PASS      738.03 seconds
MakeCheck                     PASS      12.39 seconds
MakeDistcheck                 PASS      168.23 seconds
CheckValgrind                 PASS      230.84 seconds
CheckSmatch                   WARNING   339.18 seconds
bluezmakeextell               PASS      109.50 seconds
IncrementalBuild              PASS      1388.86 seconds
ScanBuild                     PASS      991.91 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============2518321367368478078==--
