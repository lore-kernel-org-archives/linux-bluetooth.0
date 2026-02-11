Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9D36BCE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808897; cv=none; b=cXX9P9TTNu5RlAmy1opD/bC0WuvWx1uz4YjC5tjpbadLQmnIWlJxcWndDTjVfvR7bH83XjMJl8UThjI8XD+qs+s2IZoRm0QYjZ6WF/3IZn/0bcnDW84AWSIbYdzt5ND+nfsgN/q53s8g1cQHaUwi0o0nEVqgToJ+fYD+qDR1GBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808897; c=relaxed/simple;
	bh=ZjY5+D30mGVRtvpz48RpTih282xPldm+6nqMJJiKpCA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XU0tdzUXdv068s9w6BJaO4n1bMIUzSuZ6VuNVXbcfhQkzISl5jXLADbVBeKNo9Rju7qmE47JXb7dYGG5uyXfGsutMzh0CRQ9c6GT+iiAD0CbXyR9X4gzT48yMdKYYcEGGjdpAdjyVH6QR/7HgRwfFd+Qe7vFw7DVgB2qZTQkqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw8g9/Qg; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw8g9/Qg"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8ca01dc7d40so196412485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770808894; x=1771413694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ1UmQeK1czHWJFPsOHgPtl07Wj8Hq0aOIK/uj4SUUU=;
        b=Cw8g9/QgV5flew5D7PnaNkCWXA8+nF7VUGr6RJI8HKoa7pYiav7Alp3GS+qwCsoU1s
         rCJILuAnDrd12hZ7gMAyfgP/Ak8viWs0CFsMNC2BVJL2UdrypUN8eC2bG3Mn0+cXsig0
         TAxPM4GfrsYw9MstkQUgRzZLbARIKMjcWQNTDJfkuEpXq0M1yGNMp3Cn00V6T9QSnm2x
         sctReCY8T0fBe1ySnSqi5VGb3SbwPa+KJRrhABVH+OkMKz82m56hu6JeyjBFDMnJX5ZE
         1TacANWtFoRm/Ejd7QynpJIKYtoZ5kTKXbP+e9v492/Ugvp7RcCIC8Zgjrk8lC5f4v34
         aXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770808894; x=1771413694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ1UmQeK1czHWJFPsOHgPtl07Wj8Hq0aOIK/uj4SUUU=;
        b=fUDAD0GHItGxdsaly/UOaIzLfSntDk9vZPWsqfbgMP9OBzV4d8pzX+D6EHfv0BfPDv
         pnBEb0wXgrlCrptcdGn5sUROs3odJarZ456lUdMJEKhu/VdaIxbYpK6kz9ovQEMUPpnK
         61kJyIBvSPHYVs2KkFjbWXC6ym9YxgeDwPoUTyia0aOUlnr723MAp9XN9kZSG5TRbZ7Q
         Aat6vYESeWKkR+pmIrJBmBBqiMO/suBGAj5j7eW5S7TiRxXKHw+zyK/+oJw5cWAJ/XmJ
         pT5Q6SQziruCx9clZlRtKtxetHwDoGCW2IsJjsvnM65ih1ZRwDyBZGGkTvPuQPWT7eq0
         hnOg==
X-Gm-Message-State: AOJu0YyhTBdUn4HIuBCWtERCqafChwcoejJejMMnZcX6DNAGLqBI+DbI
	Wjb6cur3dUnhNTIfyH7tP1a8XOjvB2f7y5WmtoM8cfYTUENaghH7jDrlDT0AmOxf
X-Gm-Gg: AZuq6aKZTsD/7UJU99Uo2ztIb8pJsjCIFV7LGz+Tf3OiAXlabCpaRlWhJbV3sh2g5TU
	Y8yzAcHq9GMDgsY2n7ydojbsjkEHGz4dZxkeYSeotJmF28cGTJlGj74DXAQB3BnPEtk0EZDQngH
	/qsu15gLFwM7ETj/JDne/oGCon8PD2QeHlRWmzj9MRUcd9id0fxnszDAAXY/RqwVTup2NqnLSlI
	zeexkOgkuXvBMgI1YcX7X8x5dEOY+5Ynz5qtF856jdQ/1yLGwzZ3Qg0qYabtdzP5Vx4Du94iKdy
	83pjaP4RTY4+TT0DYb2Oo14WRHJkdKNHeYJ4sFdJko5bzFckzNaVP54yzfyMvdB8PVhGlCuCYmp
	bv/u/EFg0Gkggr2ZEwMCE6vqz+ZGmrl8pAEUsbt23lqGpgl4ajl+2r5zUDdHO/Gon9vP7f2QAz9
	pCvddVVHBp+jfXlJ1n6XEZV6MCveGshLU=
X-Received: by 2002:a05:620a:3953:b0:8b2:eae0:bbf4 with SMTP id af79cd13be357-8caf0487af1mr2147181285a.19.1770808894594;
        Wed, 11 Feb 2026 03:21:34 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7ff1csm12488646d6.3.2026.02.11.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 03:21:34 -0800 (PST)
Message-ID: <698c663e.d40a0220.9aaea.5a14@mx.google.com>
Date: Wed, 11 Feb 2026 03:21:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5489971740746234956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] tools/btpclient: Add GATT support to get Device name
In-Reply-To: <20260211094726.198317-1-frederic.danis@collabora.com>
References: <20260211094726.198317-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5489971740746234956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053057

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.46 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      639.90 seconds
MakeCheck                     PASS      18.53 seconds
MakeDistcheck                 PASS      242.00 seconds
CheckValgrind                 PASS      293.99 seconds
CheckSmatch                   PASS      349.38 seconds
bluezmakeextell               PASS      182.90 seconds
IncrementalBuild              PENDING   0.44 seconds
ScanBuild                     PASS      1015.19 seconds

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


--===============5489971740746234956==--
