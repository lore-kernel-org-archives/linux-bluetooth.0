Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B7440625
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287605; cv=none; b=VOWZeHaaWdSh5Z3ZnPqbr3AdUOUj93Q4/4AVKWPkKplXUhf+klS2kE6Ek6oGHj/YljOju3UYDI/g3VbUZymYPowP/lCMzl5x3WIB9LyF7qXXgIOM9ciH1s7zS/FJ35DGc5jFuXMGJbQFjKrgA/0NkvPzu4XAUNzWwjeZBzaFvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287605; c=relaxed/simple;
	bh=15W6aNgIpRLYBcSMLh4xzdss16RejQYQDo52C71Jl/g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WpKsN0O3WKFzU6kRWCEv+4uUOgIgkOVoAJUp4ugtHT8w9Y4ufKRXnVF117A9I+sMEaMLJz+/OhBcjy+0ZYQSWIfL636+i/TamUXDg/7JZgZdVE5Dwh0lOXXA5YsGiiOejk8nO9YMbaVDV3Rw2Ep1jpZA5gUw7o6JvdICQ/dWGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+u4hmgE; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+u4hmgE"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so596256a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787287602; x=1787892402; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TioCe14kMaIly6soEvUVwfXwpj6tdzyxVyTLq2ZeF6w=;
        b=a+u4hmgEs5JEnrA8lBbhbzqLV7/a3n64lWIrT8+5X+Oeno2bFo7b1g4FuYFvmb5XAq
         7k+JoIaItWL+WicPC29S9gm4rZXMYmdZO7fh0VzQdKXKtKrSiDcVvuBjoBni1Z3PN+mi
         X9CTxIKCbabo5I9uOYKLlELwx+L8pfKPDN7kWeygX0NX/Uo9/YyP+FEY94oUn/Zu4Vr0
         wDU1zMKKOzF1ZsR+Wfjmt13oToiq5XWCz8QuS1rsI5Wjf/03KK6CcOhVm0gs+j2cDAsv
         PlaI0CSLKVIm5c+9bx3BbtZWexTgT+ShBUZPrlPfcjWEx0FXBc+3aPQIiUcAeytQYMQB
         oL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787287602; x=1787892402;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TioCe14kMaIly6soEvUVwfXwpj6tdzyxVyTLq2ZeF6w=;
        b=Mjg0+QW5PImu8XCS6hzG3QZn7i+tswdzmuP85r2MtqyTeLh9UeHNWTjMqXo/CSMpUn
         THxoiyNhlTelN1uRX2OF7KWr71FSEyFSUXvZeb5NbXMipoAzdirXD4BFqhnuqfcx5E8N
         sEodueFMiP3xDqP+MLmW4sFJqvhlYoEIwsN/f2ykqA74kUL13xLK97SdCP1xNLuNUm1B
         Py7qxYxMbS6i2kP2FqXGew8ec2ZOcI25azQzPD8Pc52pImTiurJhhnsm5eTmZWEoR6xh
         b23dd6wL/CbxjY58hOK3rIxphCBgjPI274zsvhRrUY2FN3IDDzL4yqomU859+4D1Tu7s
         tikw==
X-Gm-Message-State: AOJu0YwJT8VZbnKbLxDJPlqFDVhFz0va9/56yNDfZy3s+KFKyrotMUWT
	621ZJn/F3FBO+5Mzd3TfSeVNVwLF5ca7FwX8c58A3dOzoSQxkgZPZqZXCzS4SA==
X-Gm-Gg: AR+sD1340Sb9HnVKUuZoJWT7uuJmZIObSS6VCYn7qqEQXdYbohnLV5hCTGPWsvToZPl
	ThlKgnouMHNag1jFQ5w6p+O99jLeRJkMV6k6mUDEXPIO/xclIgMpiPhwbCAclJ/Se6LLD/p+lcK
	PP16+pJzuNVIf8ptYvJ/8uELAaMql5kOIpu5lfQriEThWkFagwrfL45tYzGjfclxUgbcQ91VLg0
	wJMaJrq1VKBOF8F/3KOPQGoW+41OKdLnSDh0e6E6srtQrOaCwnGVlZv4Do5khH5hY75IJQXjeRZ
	pTGCtK5LxEflOK8uNRPBse5Zx/1j7Fw3MiUuXJGYj1k/WOZ8ZiitKa6WXMuIzYGrtBhl43DCpcW
	hA+Qp9A5YDyRDVyES96peDKWhJ63uF389Lr6COEpn37V64X0yEwx7KHxGm2j/fSXurUQE+jv8Km
	Hl4tKb6DypdIHm04+o4SM250aEcTPnaTHMyR+j70cBwpAtywsB454IIU9RTk/EkWN8Xiaj
X-Received: by 2002:a05:6820:4385:b0:6aa:2fbf:bf60 with SMTP id 006d021491bc7-6b159470ad9mr3879471eaf.34.1787287602452;
        Thu, 20 Aug 2026 21:46:42 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.146.212])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf498cfsm7300499eaf.15.2026.08.20.21.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 21:46:41 -0700 (PDT)
Message-ID: <6a87d831.de89bd77.362314.3ace@mx.google.com>
Date: Thu, 20 Aug 2026 21:46:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4993179355753639398=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [v2] gatt-server: Fix integer overflow
In-Reply-To: <20260821033214.82863-1-zuohongsheng@kylinos.cn>
References: <20260821033214.82863-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4993179355753639398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149440

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      16.56 seconds
BluezMake                     PASS      467.83 seconds
MakeCheck                     PASS      0.87 seconds
MakeDistcheck                 PASS      125.66 seconds
CheckValgrind                 PASS      120.13 seconds
CheckSmatch                   WARNING   234.02 seconds
bluezmakeextell               PASS      76.32 seconds
IncrementalBuild              PASS      495.77 seconds
ScanBuild                     PASS      704.75 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2422

---
Regards,
Linux Bluetooth


--===============4993179355753639398==--
