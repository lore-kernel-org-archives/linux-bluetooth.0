Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3D158DA0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796480; cv=none; b=pJT0cVCK3Ej5neS0EzMkAatnHN/4Sr1qrXwoZYiVoFe9RnZK0eQnEDwGiGYmEVMpi4aGduZZW7czYWkqyO1LGPDFVmi9iuG3qaMkcLhH1L8JE7zUQi8CcCoAuS+eBtMieQXaCJ+Uen+uKRoZ9MKJ20ptImuTWWi1+6bGW9EgK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796480; c=relaxed/simple;
	bh=myA6WNQ2TFzmolEXQqcTwjcz3WbtPAVr+l0XPiaqxn0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Hu7SvX4ypFoACltS3efXkoaYfHIJ61wB/x0hhu7CuaYOl+QgB1BYgNXPJWAai6GsQUvaO1/nlpikdndDml5OGD1aNImaQabdqAuGIGnuYao32RX02074OJrlGm9MPMMEya1paRoN1dEr5GZ8EN7yY2LjfaPLnZZCmEFL0Qbf2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2fkm01k; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2fkm01k"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e23ce7b07so15154671cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715796477; x=1716401277; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8uItHYb0YoGuvyHeQ5tSwhqtJfLDVnpvV3g6KBefrd0=;
        b=P2fkm01k/MHHi7eJzKxBBWGpOqhgVDvxF6WrDhN+eUiUpRafBx6/ch/Pfa6griEsez
         hD/IYb7LHxm6mlcLMcaR4FfXZHwNOD6VOXeMt4FPYqSLTH3PDsw+QtKA6oqeFUsTpkYS
         e40qW20czVtdq1tVpDPcGWRuJCWDq8ouqo1fzBb45zUvdv8q7JvHAmYw/HVB9sEcbLR+
         1DtHJP37UPAl5NI3Q3rS9nkrhnWq3wDJyKVgkd39qZUmeRvQ1kdx8dqscFwlCERxFIed
         RDctWMDZQp3h+75iLSeBRSkQB2fVVhtxnT3OaQpcZveEBsuvl+rb/nAt4mDvptSSPpmj
         eCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715796477; x=1716401277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uItHYb0YoGuvyHeQ5tSwhqtJfLDVnpvV3g6KBefrd0=;
        b=cUWqGNVRzeHpvjR7vWQTyqANFY25icMCXY3WY7Vnt/275q/Xc8jH0M02o7v79qOEpy
         U/fYiZUNVuH71m6RXDYVk+c9wrxCKZoXqo13zEnAC6f6JRCC2CdWRIrs3Fdhj5OBl1M8
         577AmXh6NhZywapa+UdSxhHKu495WHwNEhJV9xXD+F3UG1g1mw4A8LSguogTtf6YpzMF
         CXiW8IIpwICcstSOvzQXz86ueWCKoFfaEyyV8eCiwXwSxw3qBWrjibOcVNYtz3Qko3JI
         kO1wJQ4qD78lu07tCqOSjHA/EPFDTkZUQ8VgBJraz4Km2hAeRifAzCOEKVo18WVX9hk3
         Qjcw==
X-Gm-Message-State: AOJu0YwonP2NghusTSkiwHbgj1buRO+NLOFE2ychSVT4olwB7v9YjTyT
	+RJ+w3tWCZJN8QNTh0dWnbo5u8CdbpvRMy/YBMoZpIzIP0+0YDPGGIL4hQ==
X-Google-Smtp-Source: AGHT+IEMapgOVopu4jfzUCYJR0vekQzYVE/Lk/LqvUVT9iZMHlQK+XSrOAlHa3VTYovghn1jlRIb2Q==
X-Received: by 2002:ac8:5d0e:0:b0:43d:dee6:812a with SMTP id d75a77b69052e-43dfdd0d327mr193828631cf.61.1715796477501;
        Wed, 15 May 2024 11:07:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e16c5485fsm45797011cf.2.2024.05.15.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:07:57 -0700 (PDT)
Message-ID: <6644f9fd.050a0220.52f4.fc22@mx.google.com>
Date: Wed, 15 May 2024 11:07:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0980542157905522357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/ad: Add bt_ad_length
In-Reply-To: <20240515161250.1714375-1-luiz.dentz@gmail.com>
References: <20240515161250.1714375-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0980542157905522357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853469

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      26.76 seconds
BluezMake                     PASS      1686.82 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      178.64 seconds
CheckValgrind                 PASS      247.58 seconds
CheckSmatch                   PASS      350.63 seconds
bluezmakeextell               PASS      118.55 seconds
IncrementalBuild              PASS      2981.30 seconds
ScanBuild                     PASS      982.69 seconds



---
Regards,
Linux Bluetooth


--===============0980542157905522357==--
