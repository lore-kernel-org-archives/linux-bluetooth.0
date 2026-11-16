Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820585;
	b=0bWva+gWSATwawkU1rGxkuCaYDuuexcFNbOkzVnRrbIz8k253947H53nu3J7EAoKkLyf
	 k1Ep+AvY00/DveukmwKIJiOcEaSv8HdlMKlD+dM7VRLwslWhON19IzzUArA5ldr/jxPRt
	 0Sbjj3w0LVzBe3KNA/PovbauNAXNYBvGQsTcxWvwAYzaWTQS4ILt/Sk7f2RjsDUuPMz4/
	 ex+cYoYJvYyuI9tQyv4Oo93Ry64wP82ERq2ldpdw1s6XJ/n6TVUpgCIz6dmFjhQL+fEw+
	 QCayhNEPAYAYBKratvQOdj7Ob9Wt6jBtmXqVsAe5wKG3GSK1Iy+AbhqgDWwOaEiNr2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6A8N90rIxTEsumCnAetfajGzl0XdZcQQskuugN+IV2g=;
	b=e5fVuZPrmZ6+rs4/WnaurEyZFYcaFNUjfTrfyl/aODtdZUPTk/Mgt0SxPXh6rdo+8TPD
	 mteFe1AR6zz8ZrZCikKuWwi0caTnVm/jueJBNhW2QJ/qqqqhuqECi3/RwK510rMyNkuej
	 XQaty/3aZedG+I/PaQ2O4lK5VduTLrzz+UcAqaJ5qT5lzb6ihTDWB7cxkyGyLTB2DvVPT
	 GB56/MJqEduLyDBg7Lp7RbxjTCGc6rOwa290DGyr7SxQN8VjLngxdFS35wICBKeQrYLnT
	 /TMO7X4sCjPxpa3/QSsBto/CknN5kk2TULJZpk3fGq1cIEJ2S3QShPjqVFOBSd2knAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4Ue6gDq;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD95606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i4Ue6gDq
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so4179330eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794820584; x=1795425384; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6A8N90rIxTEsumCnAetfajGzl0XdZcQQskuugN+IV2g=;
        b=i4Ue6gDqxkOrPiVIroPZx4an8hS/F4kqr9ydUVQ4GlO+OyuhCrEI/nGZDsLV64HvVI
         DZd+iTwo40F2jr84jQDyw5GUcm3lDjaIaIE1Hckqgg2/5EF5AiHfvUcFsbxe3KQIsNHR
         TGUE0KQpCWNL7UBFYtXU1QhYVbfMrWyS6XDVZq9uCpl0UO/RWvWcs8Rri4rVEkPylDzi
         AL/6C+DWPM/yVfOHSdxoRx1dzpvorU58fF82mkQWx8q4M2iTXXUKet7FLZzl2sGAK2K1
         PRCjvZMgj0peXrP92KkQZa09MjcOd0jI/CZp7W1Uo0hrbXQf+qfCsGkrmiG5O1zTlLdL
         kiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820584; x=1795425384;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6A8N90rIxTEsumCnAetfajGzl0XdZcQQskuugN+IV2g=;
        b=iwQyRVPl8l2uk7DW0a71CbfHdd93whkJiYose6Si6FYM5bCV7c7FQvzJFg/Z1yzj1+
         x1FJT1EUugKYi/OdEGq3uOwRm9rKOeQbvYsXlePn089sH5f6rFBndijTTYdFQTwY4h2w
         geDkXktcT5VFjGrV8eGcky59fJuE1x9YWxWtXYDM7wKNwekpmpkEriBknWUbul+AFjyj
         pNEJG2gaColihPMOfIVbdfCFgAxuuGLpkf1Vcwzu7AgXXz08BqVeumL+KzLX/cw0P/Nu
         Nn6fpKnqfq2bvaUdVM7wdJ135OcGFzVqKTCBrq2MxwHc0ONQqD/4DcFEmCLpg9LSwdGy
         3A8w==
X-Gm-Message-State: APuU4Z/rtiREpOnL7cuqawRAAl5j90ZJX+QTcEuVXg3+euMgs/SHZGdk
	esf3z/zQn6n6eX2z77u/95AEDGXpC07Y+amFYf/CmIUWoSjHAG4WsEYcBZEONA==
X-Gm-Gg: AZFdTZcF7U/OVHsEqrbXeW9cgC+mlGHm1ioFb3u4ZtRuV4aga7DzP3i0aqL1biXUiGZ
	YtARc7d1/TqpVJT3qoNOt1f7BBdHD4qPP4i89e1iA3qdRRoAkeqpqJEjModHVobBKrKN9YYB9/h
	PTn7DaaH4M/DrTTJQKWKZ5f4N9A02lPKbbVdhKNRjMaE7DAt5YjTuDg5JaF99ROFr3hoK2Mm3jA
	E8nTJOrUx9ItovNY6ivNxvhebM9SD1RhDfHWYc3FtjGbsqmfWeS6d/aqdlxTKtD8XkXYMzR4VNw
	FVHj5xFIH7IKPS6eh5dNXBioQEE3tSqnBQVNVKsZQh59f8Ax9yFYy4HDIP/9uTaPf9vDXnODxNh
	2vX7WklisN3s52pLTCL7tjuRxKtLcInNxDzxCaw3doyRwQ6BQn9bjhhrDzlMPS9RtoWGDS7Zqmf
	rJacZkign2JUBhOpvWcDjulskp3hFbGR2JTmhwbIccwf3BzynfFtT2Hf8XOCDo3aMRADKCZ+6nP
	Kd9D3NHiqYXJcIuFmOdCLnmMIT6U6jZvEMNjwyfK3eE1ISwE6/yB/LCOcBEgJUBUE0B6Y3TBMPC
	EdIUjbA=
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id 5a478bee46e88-37967dd4c20mr9960001eec.25.1794820584351;
        Mon, 16 Nov 2026 01:16:24 -0800 (PST)
Received: from [172.17.0.2] ([52.161.51.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm43694974eec.19.2026.11.16.01.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:16:23 -0800 (PST)
Message-ID: <6afac9e7.453d2d35.f339d.09e3@mx.google.com>
Date: Mon, 16 Nov 2026 01:16:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0149300446326769951=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: Bluetooth: hci_serdev: serialize flush with transmit work
In-Reply-To: <20261116080538.66575-1-enderaoelyther@gmail.com>
References: <20261116080538.66575-1-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0149300446326769951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212408/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      22.83 seconds
CheckAllWarning               PASS      26.23 seconds
CheckSparse                   PASS      28.24 seconds
BuildKernel32                 PASS      23.16 seconds
CheckKernelLLVM               PASS      23.92 seconds
TestRunnerSetup               PASS      544.36 seconds
IncrementalBuild              PASS      21.55 seconds



https://github.com/bluez/bluetooth-next/pull/1139

---
Regards,
Linux Bluetooth


--===============0149300446326769951==--
