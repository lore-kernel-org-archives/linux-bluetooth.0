Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF228F5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418043; cv=none; b=EYF4fcaXA1Pf6EXV05SLujZgRWyvBacvSMrTdTmJ1pEkeTfEIcFiEUzZH4HJoSZbY24637S+m2o2xKO9/ZmsbhmHy33kng8JcApMQwcFuZdfq2fj7hgyoQP46v76l6cb/zLNaOI6hAlmGGLlo07pRDGNyEIVEShgY4XbSoq2XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418043; c=relaxed/simple;
	bh=r2Ee5wREtyqf3fB99i6F59D0GVURw4m+0JQaiulbkMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HmnvMSStJEyaxogVuWRe9hwQYpgFl0aTq0IXIhiWhi8QTWrb9Al6pkPuEJVeaY3BDGzcsCav450B9XYVScQkWfsCvE7Fd5G+eE2tOSZry+/wHoIv4LnefIiKuR3/cDzBQ8xXusIEyn/nGPQk/D96RUWcOuIqsBMOKybJ5MoCea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfczWStf; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfczWStf"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso748659eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791418042; x=1792022842; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dnoXo5ZSEqHFgg4on9HjICA4fSyW024BCryLJMAfw5Q=;
        b=cfczWStfPwQT1iCmT48s6WLRaGbOMhLDVEUH4HVULtCkTivfkPBq4lNYbVLJXsioAm
         9CzZ8PZJbwzxDXX0WRR2FNeJXuYJGkOtPPucLfBFK7Uu14uOx33oo2kS1Pw8A463PLUm
         /7b2wUmKxD02k8Rox8SVsH6OU7Mkk07p0GJuigZiztLt7iW7WG4htMYm3J+aQ7q5AsO8
         jfgMnSok7iy/Po3eCe0Q4LMcXRpGQkL/R5uRyqd+/sEOaEfEjSOMjECHcL/p2aoRcdfL
         JM0ftuEJBkCsWkzYKYCQZtWlqUDtOpkLbqe9svJRDJ9SbgZVKRlV7oq0iJLKftCY+47c
         uNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791418042; x=1792022842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dnoXo5ZSEqHFgg4on9HjICA4fSyW024BCryLJMAfw5Q=;
        b=MFGE74g782hQQs8DjZpIKU4xEjUFnAqgMCnJlo0mY9oT19C+efHWbUwA4jSuN34j1F
         w58W0hWW0QVn43G9jsRdiE0Hjcdf07KYd1tMC03B+lSdLS17r4/pPA3rRKeejJIGgfGZ
         nm7Rq4QFYK8cFUjjZYlZPW5sN1eaImqCYpiSw+Na+TRRtWQwWL94iCX5YUafuZE/d+Xv
         kAjneHIEJfjB75ZdmngP3k709PhJSwI0V49tnO1kIxKEAbv5AcwCq07v+qrQPgtisOZ3
         Z6eymlppgLXmjOAIvsETO+ACu3eKs6pEe2i8Hf2ODtAIgWD0G2ODQS+OFt+nq4IVHVyg
         BxYQ==
X-Gm-Message-State: AFuF++nB4lArpjMWyGcSVvR+UHOpFeGW0OlGeMQ9Br9uzg0HuBW01Ylp
	W9mfsHedbZ6jRcbFkWKdK4DWkzTqdVT+3IpiJzcyZr3MJKu5uwhP8XuByAhafQ==
X-Gm-Gg: AYBFou2E20u/+d3Mkn2y6MEQC4iOepSCgYsBtYLBHGzd30KAtihlraUyk23AicHE8h/
	+TrMdDzQbmL0jf5MApKlAO1cSWGM87MFh5hrqMU1ce29XA5Zl9A9BOsy4kI5mSSjgsRslwou2jd
	pUgfua6gzduJpTZxRr39INEx/SomwUUdmpqRD9yPc5HtxpqKjB/4Quac2jSQVVS4T1rFZWbjTkd
	Ad6CrYBOJk8ZXWn4tRNg4A6OifMqNJpe1Q/ZWc7L/9F6lNeQ7loldsRWzaLlMqXefz68Zz1yvU/
	ZqA8eu+3t/QppAvozm/sCaWZE9zOyc0p6BaGxjeWvq/Vy3RU/1t2BJ7IdWwfnKBbQwt/dAjGuN2
	Ui79mgc6IMAjqqHtVo+9RJbzOoG7snSilk0Roj1E3507Gx6rIZ5rU3hLeJCucCtH6XWgNTFVhn4
	9aKVqgdre3VKYC8SdGrllG/JYd84//Cv2xec4eevy8VSrV3F6BzQY85owNpWlQ/vPYRh7xeJIn9
	7w=
X-Received: by 2002:a05:701b:2519:b0:150:1cea:319d with SMTP id a92af1059eb24-162047a166amr5070114c88.13.1791418041396;
        Wed, 07 Oct 2026 17:07:21 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.197.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616727976csm9828272c88.8.2026.10.07.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 17:07:20 -0700 (PDT)
Message-ID: <6ac6deb8.45417901.364a97.5f5d@mx.google.com>
Date: Wed, 07 Oct 2026 17:07:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0332352726436831490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] a2dp: Fix UAF after rejected SetConfiguration
In-Reply-To: <20261007195206.350586-1-luiz.dentz@gmail.com>
References: <20261007195206.350586-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0332352726436831490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181105/

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      13.67 seconds
BluezMake                     PASS      213.68 seconds
MakeCheck                     PASS      13.06 seconds
MakeDistcheck                 PASS      94.41 seconds
CheckValgrind                 PASS      142.41 seconds
CheckSmatch                   PASS      180.59 seconds
bluezmakeextell               PASS      66.42 seconds
TestFunctional                PASS      813.30 seconds
IncrementalBuild              PASS      220.31 seconds
ScanBuild                     PASS      594.43 seconds



https://github.com/bluez/bluez/pull/2633

---
Regards,
Linux Bluetooth


--===============0332352726436831490==--
