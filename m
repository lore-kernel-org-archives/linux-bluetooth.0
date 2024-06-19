Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06F13DDC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798830; cv=none; b=VpauJ10j3lABsaZMUypL5ZGjrGOj10qdRV1R/KTQMDNou4z6KKRL97/39Mhn2Nt2qhezVJ3ZpFHRAT3BLAiL/8c5QZISeOfboKMAwq5dL2rfmnNlT9l6wZpRL2vluScbXJonoheBuNdooDykd7ve+zcCoopBrsCbyIhIFH9TgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798830; c=relaxed/simple;
	bh=cyTFl68Zubi+DpRIB47DxXnU7QLS9LHEeo8OAqSFb5s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nLTKRdxo4voa4o8K6Ftlqv1prshw9XnBbFmoPjzoLeBwFcPVkE60WL+0McKWiSY2JQhKw73Ine+ddb7I7CWLOBemUUouAPGTrECkD9oyPIXk3S1+/zzg1i307Bd8nYU+ZDHc0VBjPhYpwD6MStSpnGoPJp5dMBA+ih1jslcT7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGzuk/nu; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGzuk/nu"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b9706c84e5so3744108eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798828; x=1719403628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oer+a1l0AD8uIZdtQU2ZOcs//EUlgDYnuxOSX8e97jM=;
        b=JGzuk/nuXqjYNveWcTkIxEiz0iETQl4t6Z26b09dNAriIwcC89UltAMAniQxQzVCXJ
         c7BgI77bHE+zZ3ozz6HCqkeIjQvhSSdpRPMlO5mCXWoXcVTqWvw/aZ1EP5DrxrwQ+PqE
         DxsmEm7iIWzQiuz90x6XYq7ZnEFJq0CXgzDHmtbx6rn0jFJ23pUOkEEKrWxwxH5jfL5p
         0fUAfNOudylE4OCNZjY+YVnHNwVSm71+CsQzRUHCNzOYyABysi3gRUIt5wOLx+ElbPM5
         0iqOTvXnXb0WhsAPK5pps8RO7fNMXEFP2P90c61P1GF+ktdc/aAFJAamlbjdvCYa9R8Q
         5Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798828; x=1719403628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oer+a1l0AD8uIZdtQU2ZOcs//EUlgDYnuxOSX8e97jM=;
        b=pQY9r8jkUzpM8liE+hQlszbsC1SOxEasTP9X9Kn8Gzws9h/lxoquu+1sEiVK2VWvkA
         H3ZvW7GysqKzSNfJ+0vS2a3P8A/MDujo/9M4wgSzzftjhexXNXMQ4QoUBsTPzfM9DVxk
         FA2/Zz6Caj60Jsy5oTGq4AIaI5+MzGQT6V8sVatpjhcK6NYIfcd1ygxs08IcC223JFAX
         s5xvWy6A76aQsklxItXSrOdeOsFEcWc3MKdt4vQvVG3fAv0mpTrbbFCxzTy+55BGz402
         /jdg7saRyDycs+LHtlhmnunhYmGE51oX4ST6CNk1gPAD0IvqLo3dfu8cymRkvyXlew24
         EOdA==
X-Gm-Message-State: AOJu0Yykj3pCJSvsZcdKWLwql1EioMa8v0C+nXGOXczs8AKG89xn3ZKt
	qUJ9uozYzOUYORayR2kwhoxdD6DgDtIELUJ3XxkZjW1W12sEHfOlHFc2AQ==
X-Google-Smtp-Source: AGHT+IEo7TqwXGZNwmTzq6Bn0oWwuFLOaOdiqYee/FlmpwVfBZWwp3J50i4+3Rd3FCXbsw0EyrAY1Q==
X-Received: by 2002:a4a:804f:0:b0:5ba:ffcb:c760 with SMTP id 006d021491bc7-5c1adc049d3mr2411949eaf.5.1718798827939;
        Wed, 19 Jun 2024 05:07:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb498bsm76747096d6.76.2024.06.19.05.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:07:07 -0700 (PDT)
Message-ID: <6672c9eb.050a0220.d24dc.868c@mx.google.com>
Date: Wed, 19 Jun 2024 05:07:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4400845777731887347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Allocate memory for broadcast code
In-Reply-To: <20240619095119.167652-2-vlad.pruteanu@nxp.com>
References: <20240619095119.167652-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4400845777731887347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=863362

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      24.51 seconds
BluezMake                     PASS      1675.31 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      176.61 seconds
CheckValgrind                 PASS      250.75 seconds
CheckSmatch                   PASS      352.42 seconds
bluezmakeextell               PASS      119.14 seconds
IncrementalBuild              PASS      2986.68 seconds
ScanBuild                     WARNING   1020.79 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:240:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:250:9: warning: 1st function call argument is an uninitialized value
        return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
#define be64_to_cpu(val) bswap_64(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
#define bswap_64(x) __bswap_64 (x)
                    ^~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============4400845777731887347==--
