Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC751C34
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569473; cv=none; b=l23qBI9YKdsaY/NY9s5TgS5EQbxKMsW8XECvc9m9nZ8OY56PUOCBvIn7VkxNw9GzqpRSuB8Q2CM+VpL/YHVOsXgtQZMrvm/i1m67EyMlyD9rR/CL6xlgRBgvyKL5thTj/66wKXdMV6utUah+qzjwLMcioETGeEVVElNvaK8Nx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569473; c=relaxed/simple;
	bh=q4TmBhZWLvZyUnNhTaHM4Ubk2/mSHvXS0xUBGl5wbb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nzzjYJFcpvhz/zoLvThhSgLlE29XHafgnqm46qKtG7taNmd+DMUxUuZbfavlAR+f1y/9sTue7M1z6oaE1BsJeqDzyBt18of4wuoi5dtpgt1OEzloZEdOSq6KDeGGUw9PgwCrWoiGxKnK6Sjz+YoxbRp58oWLJ0emNkJIPrlVMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G44BnhfG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G44BnhfG"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6860ff3951aso24323076d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706569470; x=1707174270; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FA6JLEOZqdhfmiD2IIGhKib4lEDwGDYbzKaYt0BtdOg=;
        b=G44BnhfGg7GitFSQjKENAnlsWSR7+FUrtw/cWZ7acDI1QUJfuKDqeALPBIRl6FUuGQ
         ex9ueu4Qc+YqvQmwXN/7KfJQteWvXSuu6x6QkEb1mHXDyS+VKuSt9yHBkFxvqycAYFuJ
         A6ic5gOEMcPgGoWSwFCCSALm9N/C5P6wK6YJt3RggqtT+Iwt5+i4YM7gMjMZ0EVypRKQ
         c2ncY24YZ6aFYPFHsy4m5ZsltVF8yvFwMnO4SickuauLr3zx+igPR4sniBIUInQBta3O
         ry1JyfIPnzOhPibGMIaEpM/07xntijO8d8oFC7vll3YlzFJ7rGQT/BzrFWPurBxDeKWm
         dRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569470; x=1707174270;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA6JLEOZqdhfmiD2IIGhKib4lEDwGDYbzKaYt0BtdOg=;
        b=p206xiq3+pqbqjuy+/AqbBevss5Zh3TG5FVSFzYVPdisOwvjGBIqJVawKyvX7w/pO3
         NVgVbrQI1/hFvZPt9YB6HW9bw70vH/erhsS0t4ggAF6o/ajaBitqmk+BVu2iqLeuZ7pc
         UnncoizfA+K4+JtWuAyROJ44ZGlbRC3IQFgHSdr2EWG+t2Qc47G2FP6z6bDDo/XboLAL
         VNSlhcVTnDXKZYPCLTq2EgnZduGcGrcTTKmmezOyD8AFBGlN3JLzbEqpqfRDujrwuP3C
         L7qrBc3piD1LuxYcjV9b4cEAeVG80zkAnUAZehnd3L0uqjwDRgF6Pgx6JLZ2vc/qvHXm
         TUMw==
X-Gm-Message-State: AOJu0YzDGuiQ2dV+IfutZ84FCke0XG/hdG8ZK+rbhpibmpHQVEbpZW6A
	OHylzvPtjzLOElyLQIRnuSNtOul9KpffQAxVfTOGHik6aJpDCLosvVuFOL/H
X-Google-Smtp-Source: AGHT+IGrIN5S70yJxrOeROLPRi27OtmDktFcnEuR3yKJBQ/mbaXj7fkPyKo2fbCCkuSdsWzyPVXI1g==
X-Received: by 2002:ad4:5804:0:b0:68c:3c13:b5d6 with SMTP id dd4-20020ad45804000000b0068c3c13b5d6mr6089043qvb.46.1706569470070;
        Mon, 29 Jan 2024 15:04:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVexe+TL0GKAEyOMj6udkUkD+9yg08bJ7eQI1gsXCn3eWEoWqMZqOS1TFigNsEJWvG65h5tQn3sZGeSH7/l03ap/Tqew==
Received: from [172.17.0.2] ([40.76.106.54])
        by smtp.gmail.com with ESMTPSA id lr7-20020a0562145bc700b00680c25f5f06sm3883214qvb.86.2024.01.29.15.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:04:29 -0800 (PST)
Message-ID: <65b82efd.050a0220.1196e.f8cc@mx.google.com>
Date: Mon, 29 Jan 2024 15:04:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4617968910563909480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] util: Add UTIL_IOV_INIT
In-Reply-To: <20240129212036.163298-1-luiz.dentz@gmail.com>
References: <20240129212036.163298-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4617968910563909480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821071

---Test result---

Test Summary:
CheckPatch                    PASS      6.40 seconds
GitLint                       PASS      1.31 seconds
BuildEll                      PASS      23.90 seconds
BluezMake                     PASS      705.38 seconds
MakeCheck                     PASS      11.31 seconds
MakeDistcheck                 PASS      166.06 seconds
CheckValgrind                 PASS      226.45 seconds
CheckSmatch                   PASS      332.44 seconds
bluezmakeextell               PASS      107.91 seconds
IncrementalBuild              PASS      2677.89 seconds
ScanBuild                     WARNING   963.25 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:236:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:246:9: warning: 1st function call argument is an uninitialized value
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


--===============4617968910563909480==--
