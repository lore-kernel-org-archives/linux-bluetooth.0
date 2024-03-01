Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F13A1A7
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312582; cv=none; b=TD6Iovm6zpYqHrojE65HuXynQ6fz/GR/APpFm+rHidpRTEYvWpozH8JI9Rj9hLheVUPQoCsKoFbWTDnu6ZfY/jy5IKgugpxlWBbriQNEVi2SebYD+YHUM+1rbgr0ZjlgU9/J4F7n+IGAIozaDZUc5O5alws5QJ+9Ui5+0V4lz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312582; c=relaxed/simple;
	bh=+YHX9FtTI9rLqRViKA8ilasvR2/Oz/tp373nlUDGT3k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JVpggNT0Jw6QS5pAeKCTD3qVdDe7Z1zrBfGzklLddBUjrW12/SpHNJErITDJrX1T3tWnufqbhrqcXXek+uBiboXuENLgmkYf9fCP5+DFQd0kCIZ6Yf0CN36J9sE5j43eL8tFX9Ewc8tqEnZYtKRmOdt3J48ZOcYstfvPifLXU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI0Nspzz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI0Nspzz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a35c720b8so8651971cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709312580; x=1709917380; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MIt1/vnX6qKXjMyX2UhiOlaFznwOq2X/oMO5R668mXY=;
        b=JI0NspzzLLMKK1NRki4zxG+Tg3hS7WWC/yE4LPUMGMT6SKNUS5YXT/kqBRo488JmC9
         I2NAFr1YMVYrg8hjco6N677CJa3TBDyKaoCL+1v5r1YX8KNP+GkE2IZA0MdJboo0m5Va
         K7/7GglZV+aTI96KKfU7hXxmQ0v8kKedEwRyoHcewrADxbrb5eUhzz1bRTUL5JgRUBlq
         9ayL/P5U7fMSfuw3pBtnU/3EUsN2dw7E0hHZ57Bdd4ODAdrCFISL0XhOStIhi0/YuzjK
         bJvKElV9Morm7MSk7MtwoY5Iy1qRse7Xe3ugYInbzB4BuSc6pgI+oR3O8s6Ei8rlTIpE
         IcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312580; x=1709917380;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIt1/vnX6qKXjMyX2UhiOlaFznwOq2X/oMO5R668mXY=;
        b=KUNoURGZEuw+SC9numacN9pY+3lakgqDrlnGOUO3XXfqbNrO0Ff5fWEPwUI46eA0Mh
         ZQs/TR8RQHdzoFQUzbQYQncDlc9BSg1aEnxle8b8aY3y+DIzBs05iClK6ypDiJdCBeZK
         066JQZZXE8Mr1NGkaB7qlrpeCQjCfiAYc0ULMcvPSCKVnfOogjlYO3+pbyTP03JS4NXZ
         YBcnKfe0sPREen07lpqENb0tlEJAfkXl56w6UeS85puUFM+N4qIoTQDfdhEhKE44pA7N
         bvt0opKUtqtjeV2Uy550bY2z9xS/tS7Cc42icpximt5Hre2sAOSv3KiCYxqaXJjMe4Do
         yCnQ==
X-Gm-Message-State: AOJu0YwHVsmKrj4dyIuHnVDh4c4JjbP018xy442Uxtx6YeFu0BGiuY5C
	lixSc0yhCv3Gbyy9+mW5hCd6XHWviL/Juna00V1AJlGMDrIUcpPPC3HKJEj0
X-Google-Smtp-Source: AGHT+IFG8MIAQtnEs6kNiTC9kWJpJ3ZIZm9byArBkudnqHf8P9mdd5k44QKS1gxzZxJT3s25Nw6uYA==
X-Received: by 2002:a05:622a:613:b0:42e:bcd9:df0 with SMTP id z19-20020a05622a061300b0042ebcd90df0mr2172202qta.62.1709312579918;
        Fri, 01 Mar 2024 09:02:59 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.196])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85685000000b0042e495a126bsm1859216qta.36.2024.03.01.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:02:59 -0800 (PST)
Message-ID: <65e20a43.c80a0220.f2c3c.9710@mx.google.com>
Date: Fri, 01 Mar 2024 09:02:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1419332967453157269=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Update Sink BASE management
In-Reply-To: <20240301150029.14386-2-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1419332967453157269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831555

---Test result---

Test Summary:
CheckPatch                    PASS      3.17 seconds
GitLint                       PASS      1.86 seconds
BuildEll                      PASS      23.87 seconds
BluezMake                     PASS      698.28 seconds
MakeCheck                     PASS      11.97 seconds
MakeDistcheck                 PASS      162.56 seconds
CheckValgrind                 PASS      226.73 seconds
CheckSmatch                   PASS      330.56 seconds
bluezmakeextell               PASS      106.97 seconds
IncrementalBuild              PASS      3956.07 seconds
ScanBuild                     WARNING   936.82 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1156:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:238:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:248:9: warning: 1st function call argument is an uninitialized value
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


--===============1419332967453157269==--
