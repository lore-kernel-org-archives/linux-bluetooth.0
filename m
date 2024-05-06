Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFB745D9
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026170; cv=none; b=YAAYyhN5XRQs8CTfWJVU860P4sx9w6f7veGxZOmqbeWZ25oMJvTEF4XYnUreF0ifkxX+Hy5nPdxYKRN2kHdfdvbi7uNAoYw7itrcZbrXyWjDFmpFOEyzn4Uk45QCq7cgCXxBLwAMLteTn7ozaFahMmlsnNHDo2qrimykzjuU8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026170; c=relaxed/simple;
	bh=wnvE9lVTcxmtjs0bXkBXPVP+pko2GOK1G2o4KkxnBLY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wy9peuSsNtqibxOmCDS/PQsiC4Ml/l9YCH5plKmsndT1JfIDJMm1hPu0hHL+oQaVlvf8n1vAa3lZu0XkgLZwe6aoudlCY4tj/SWStN/Ho++L3ZNDLLkTVijds69cy41yok0qKXffQwb9eggu98mshd9oi8JM+GU+F/xNcTkd5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpJpybFR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpJpybFR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7928c351c6bso220656985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715026168; x=1715630968; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IAnhwjaqHpl8z/qPsIWlEcSv8m5WeSJbfEW/3kNdtS4=;
        b=TpJpybFR7yBcoYufy6gJM835N/3a6rJSQQPWbC7ngpY8Be6jlWhIdNkXZAx3j62Paf
         H3Ja9JLBz6/I+bycQpMWGBvrkoSH1sW55wsEQRyYALZM2dfDfSZmNSFXWZ+8eKyXV+fn
         /BpjUv1iNUls9EuDKeS/fmbgwgowDENEsyokYhZKf/cDNdhpxYShe5nqkSCGUdW56GSt
         0r7e6kRyZoYDEgUtbsDBjWd+/JIbXGSTosJPlrWDmtKiwg7ZfkvwcR3AhbLZn0Jrb2ci
         SMRsJfR0dPPvgICPPRca2Ub90sOEVopyR49Cf+ysOUNG6xda1zPZD2ImeSu0koVwcviu
         lrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026168; x=1715630968;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAnhwjaqHpl8z/qPsIWlEcSv8m5WeSJbfEW/3kNdtS4=;
        b=Isi8gUkXfVFjqP2KqLVOCfZ4R4cQyvKzBzi4u4448PEcvYu3w3dSQOP6+AOQyXsKMK
         Ck0/EEyMDcFYZOBrffljPxvG8SS69fX4q+/pzbnjKreXJi1r4LXtgH6uEiZsApmFvRhg
         NBT/KkkBRRD4/EvRUs7iwS71KRvx10qli0FBsJkgS+Mo26wmdGvCHv+z18KsPoboKxzj
         3yX0N5+Pb7zM1K5Vb1orWsDrNrUP5rypx3JRBJu29Er5XFtYZ44oHYlKWWlG5KwCFYzw
         9OGLAP8/m0F8iTla6wYp6iL4zLu0+s8dswfNhZREVUKKI2OZ/XrvmGFVEaRwpwhmqlK0
         R4iw==
X-Gm-Message-State: AOJu0Ywb1Ykct8PN+R4lgRQxQNGesODbRY7kNatdXNkBOGqhj/x/vqs/
	7a0BSACvIl83Y4MWAmirR7pTpTp2q27k4D72exZ4XBDOHdKgw9io6Tjt8Q==
X-Google-Smtp-Source: AGHT+IHnDDGx8fN0OxC3jmOJubAjpBWRCoauYfG2aJyfBcCjQ2wbAylx+2guGiEdgLsuAaECcE7qXQ==
X-Received: by 2002:a05:620a:831d:b0:790:a573:4fdf with SMTP id pa29-20020a05620a831d00b00790a5734fdfmr10464316qkn.2.1715026167570;
        Mon, 06 May 2024 13:09:27 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.184])
        by smtp.gmail.com with ESMTPSA id vk21-20020a05620a70d500b00792938d0f02sm1834788qkn.39.2024.05.06.13.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:09:27 -0700 (PDT)
Message-ID: <663938f7.050a0220.78f59.5f6b@mx.google.com>
Date: Mon, 06 May 2024 13:09:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8184112343395976745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [BlueZ,v2] bluetoothctl: Add submenu for Call control profile testing
In-Reply-To: <20240506235643.114778-1-ajay.k.v@intel.com>
References: <20240506235643.114778-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8184112343395976745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850909

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      25.39 seconds
BluezMake                     PASS      1809.33 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      183.34 seconds
CheckValgrind                 PASS      253.37 seconds
CheckSmatch                   PASS      361.75 seconds
bluezmakeextell               PASS      124.48 seconds
IncrementalBuild              PASS      1652.82 seconds
ScanBuild                     PASS      1063.08 seconds



---
Regards,
Linux Bluetooth


--===============8184112343395976745==--
