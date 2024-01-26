Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E211CBC
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253111; cv=none; b=DVUED1QVHmmFTP3GFVcT36XHbq4SRXbIIcAJEvqNmA50qUcrUtjyjEjDuEU7PqrWLyI19L/zkJA0p2f+OMPNGsonhELG2stMDmaJ3p+Lotss4DZOUK0Ku21J3j/3refqyV43lTwlKJK05KI6z1vqyeWn1ZGeu6E5ExgjA7okVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253111; c=relaxed/simple;
	bh=SaGWrZWvltV0gdiUj50TJE0/utgFVAQ5Z2h3i2E1YG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UFuA13LDNm9z624o+kU316i72M3djNs+YmXwQFbfUrxI5g6zgIiZB1g5tG7jpj3C6cCcHrT2vXnZhQQ4n/utl0vdOWWSD8i4GhtaYdqcSynYqlMSeHRlnTGpAtz/irz7OBkm3W4helPwm+0f2tA9645P0tyAkOb2hnO4VZOe4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EycZNIkc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EycZNIkc"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68873473ce6so2280136d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 23:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706253109; x=1706857909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SaGWrZWvltV0gdiUj50TJE0/utgFVAQ5Z2h3i2E1YG8=;
        b=EycZNIkcNRCZvcCAYZNdqjkXwUldImr4JHNIt0LIdx5e4/ShyW5K4m68Hr5/Gen53L
         dDMzInhhx6zoeywqzqnYEOkx7yy5AmvR8wY9KCCzVtXeZ7CMz6ozLI2JiIGQfYK4F2kz
         Rrds8jrPkYr5wcO6W6QqmsrNJhgSAkiI0JfHJGiQVMdxF1bZVS1CTmulHig+dBDeBBe0
         IQRBobPrMkhvIf9xj+3uKenNhUCzO7VHL6AD0jp2bkFl95AMLc1ACMee78Uz0z/EIyVW
         anRR4TwkeDEbiUaterra4OYxSiedyTbJ+oVs7dXtEC3Q7jwyvsiMY/+meY8ppbTb/crW
         5LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706253109; x=1706857909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaGWrZWvltV0gdiUj50TJE0/utgFVAQ5Z2h3i2E1YG8=;
        b=Tnm25/PWKOHnYTy8N4SKhg5wjQhzp6heE2ZemrRy1Q4+LCGCCrbLa9CnCea29ZIk5G
         XKPU2g0jViHghRp89WwU8S2qBO8FnjGFivq69z9WMC8JFt+Fuo+SB9mJB7oGd5jgk/jP
         fnVfCQJLgjG+TwHNAsm5b2fAS1YWVUCYgvcAhybRBt6Zp8sigHMW0x3tCFhOfefskxpk
         +zB4RXr39lMY1SGUGh5n1jMSaHyU7gUJ+nA9US1cReMIWOrO4jFravdtA1U2Xca+uQb5
         M9v3qxCrQHz19/r9wBw4lyHrV7RlngwgaWAe35FyvAriqf4QlnGw6ubtbhuOlkm/qyEQ
         r43Q==
X-Gm-Message-State: AOJu0YxTEAoL6bBQ/jKJgMaj6itWxUunnG7nlS2anFMVKweRUYSXhSEL
	w896J15xzJv4snK10eyfwJhyLN5LySrEUkJ4PELUGzdb3AkCSeMyH6Se/v/1
X-Google-Smtp-Source: AGHT+IF26faSys13ztux3UFaTnfu99t0MieyMVHv6LmE9APWLRZk+Cs7p8fL+RqpVu1kp9ZJem9D/A==
X-Received: by 2002:a05:6214:e48:b0:681:59c7:7b5e with SMTP id o8-20020a0562140e4800b0068159c77b5emr932983qvc.113.1706253108993;
        Thu, 25 Jan 2024 23:11:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgkAaAZbZJOP0O0u5KkLT6WR45ZiL9DU9jyzJBRx8yWjb7iCXK4TgXefDduykTptKXr4ORNHK0O8hppkpy44wRvSk=
Received: from [172.17.0.2] ([172.183.50.147])
        by smtp.gmail.com with ESMTPSA id nf6-20020a0562143b8600b0067cd5c86936sm285803qvb.79.2024.01.25.23.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 23:11:48 -0800 (PST)
Message-ID: <65b35b34.050a0220.92543.0d9c@mx.google.com>
Date: Thu, 25 Jan 2024 23:11:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6349227954728531265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wenst@chromium.org
Subject: RE: bluetooth: mt7921s: Add binding and fixup existing dts
In-Reply-To: <20240126063500.2684087-2-wenst@chromium.org>
References: <20240126063500.2684087-2-wenst@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6349227954728531265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6349227954728531265==--
