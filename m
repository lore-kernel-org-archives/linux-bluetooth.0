Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E237998B
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535346; cv=none; b=on78dGVPuBVzxjUIx4qWWKdu9GiUlIy4C72ZZte2980WhjZg0mQiaLj5UsiaOuiFTKubuELbG5h51L6FfDy48gNV+kH0LwFZIvEWzu1XrR4zBrGe95HF/lU6xaqZGErZQGv3mlA8jk1dDxQS4qS9SGxcVvcksGCamuZoBuY1m0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535346; c=relaxed/simple;
	bh=rA/U1s0MqWuCJx4E8JGHhBNhmMpFTIVP5f247KilUQk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jmI74rQTpTXFB3S//TyulZ3GVSoyO8C/LvSP5RXdBPzHKatXLRbk4D9VU8WOOgERoJavLhGdgV+Z7kghVrz5IjYF5rWqTOVXu0iHMSKbn5oX65lbIB0cU36VapmdL9nC+DYf9EeQoW1nsa/645PbhOS5nITULEwEzsWfoY8tXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUt++jO4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUt++jO4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b35f3e489so19976691cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774535343; x=1775140143; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rA/U1s0MqWuCJx4E8JGHhBNhmMpFTIVP5f247KilUQk=;
        b=gUt++jO4nZb3XqFQJd4PhKW6JXxxhNFvmNlyaxRHTdEF/uIfDPaY/vc+iq9xh1ekF5
         Ec0+2IxC6asFW2Nc00/UfAd4Ryz0/sYNdUeYhH4IQMCMis+ewutOc6ZAvWSsaAXKNQzk
         qS900mjo81kYEsP0Cq0HfsIIzzTfRF7izpPad4vaPhqjSrxvDBG1xrB/ky/7k6LEMGzf
         psZj4H+cnVEGiruQvYFBnmJHzCFu+ytUXFCIaQ1YP3hRhXCGBn43CpykUjys4TjcKNT0
         HRCKneiliUChIdtJCYl3O9FpYJMBU/AoWToUsdlT9Vi9RKHEAHDjwgHa1DptB5Wg+7QM
         dqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535343; x=1775140143;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA/U1s0MqWuCJx4E8JGHhBNhmMpFTIVP5f247KilUQk=;
        b=W0yHuvuXwi7a8V0VrFvviry58J7F+qhLXwKPvKeSANMH/g7hdUA7DJBlfjPePDKnaK
         /Wa/ymUcYJq0S1IxRiCKRN5iFXUJsbZw7si1/+e47lF4AvSbqsSQNojM+9JtmU/WOj7k
         29gYIKSjifdeWBweNO4pcGKpo25N8gYdqc4hN4Y1qC9ykmtSJpSVqrheC//pBi5YaJ7F
         X+Wj0CqGORNUfGI0UBKnNEZGb+yRHf8KTwHK0J0IdkqQ9MtxJhmiCbWAbB0kkmHf+zqZ
         Peyrd6vWeNPM7ClEVfIc+o2jiXZ1yC+PyUuXai2U0rwgWG3xYSFfWxHr0Ih7OlZzlfmA
         ma3w==
X-Gm-Message-State: AOJu0YyDRGb1z6qQ0BfpoRflWj1LV5HCK2rIkr7Xp+uvAQARapxmQblN
	bAfIv2UvaJ2osnhRgh0YyZoXSxKpytDVcvs9n4s8Nc/AlQ7yz0Q57g3rkgNpCQ==
X-Gm-Gg: ATEYQzx0TDze0g8egdRUK6elLbHL4qLaJQ6cUmlsVGnnHEAiS/xi15G02TsAK/gvZQo
	FRSjlUgAaZHJdEFsBf9r9E/w6FNukKZcaONc8WGWMsC29Fimdt1Bvy3jtPBmlJZvS9x+LOQBbLZ
	Yqd2MjCh+sixj9WWARya5km/MDQ++LvQYKdpxY3MjV+TEhPRrohXW1QAAULbFdTmZHnV3NDvsHA
	hMzETWp1OwduzKVmXM/mHoc1IrAbuR04Xp1ovxj57C1kbp8dgCB6TkL9o03mzl2ZpKLCEMIj5G0
	U+v8hen19RdoqWhhTmzeTIuHFAgLSeYV9OGrA2s9tPDZwPBcUKLS3FOqm68t4CPgYVaiCzmbgSf
	/oKLfBpUYjYCFqqxx+XvDrSEQQYPNO97/gFsZXMxht1hPYVBI25XFBP9t+PM30mKkDXYfbVUuUZ
	i/FwIb1lOGuOYWwvRYBEUyRSifTW4I
X-Received: by 2002:ac8:7d05:0:b0:506:baf9:5dd9 with SMTP id d75a77b69052e-50b993e4965mr18894571cf.17.1774535343256;
        Thu, 26 Mar 2026 07:29:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a22711sm29620656d6.27.2026.03.26.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:29:02 -0700 (PDT)
Message-ID: <69c542ae.d40a0220.2451f3.5893@mx.google.com>
Date: Thu, 26 Mar 2026 07:29:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3278134518746689903=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: [v3] Bluetooth: hci_event: move wake reason storage into validated event handlers
In-Reply-To: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
References: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3278134518746689903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3278134518746689903==--
