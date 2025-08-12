Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909DA2D63ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985651; cv=none; b=DVlHRuyezM0OwiGgVrcfvyba1pnVjl7Y4rRVocNK0RyBYt03wdfhCzlh80M2Robj4ZmBnWdp3FvYCCKqa7pvkmJFWv60gZsDi/Pv+ki2qThMcnC142J8EevxNdgos+9q4VhSmzxbw1nbFBvceG4mSC75Ot5n4ZmHKulX7jNz/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985651; c=relaxed/simple;
	bh=lgLGUK4QgwrR3dbYJ6XgLB9BY6ySl3kv40iW8o0LTGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmXEQJFQ73yuad9flEUundAFYRxDhLA4TIYq12IjBSmiUbATpGl9sHVbmr+xoIEDJmyPtL8gwUfj16K4XlXMu1YCHr4HmNyg0ksUiCyAHyJYUOaRSpemrl80zfjoqR5foTRVI6tfk39rvIyZ/oTPiWqTR6uAXfk+oNN7alj3J8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbQk/Cbk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbQk/Cbk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2518674f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985647; x=1755590447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4W/dIMGu8Frms9xIxe+BqGAmzD66zthjvR2yEZGZnw=;
        b=bbQk/CbknIaAvt66Gf+hm2gyF9M600lXe1Znlv1Lk9EG3OsyFp+UjzmjJbGXMF2Lch
         qc3yiNtI+6V6REycMLqZgnQb+BtjHkyPQFyI5/aGmLXyMnn5GOdhJI7HPbn0O6WdtKs8
         MRiKEcbvwzh1C10HBbm803KrkgPSJJSIQGFuhJfMLU/XkalQraGxixhwb4ob/NTy2kVb
         LScQNBr3SKYzkSChWi9FCrxcWV0GuasdCqhmEZ0iGoGTOg3m3sQCk56Cyit1Dbav8S8u
         VKVDvM34YQT/KUnYqKZ4uIQS2nP/RZWSYSjJFjqeIQ+cbenO5t8YcHxqmS54gG3Vj8g5
         Mfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985647; x=1755590447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4W/dIMGu8Frms9xIxe+BqGAmzD66zthjvR2yEZGZnw=;
        b=LBsTH4oPn58Bd6AOzuxiwv2Z4ox07ag23iB2AWp3OuYCM+Xtm7kWX80coSNilIcJ2h
         EmnmGHiSKeZSe9ocyURw1gonvcWCfeNDwnriSjvwefmWdDNVcItfjSSV+v8THlezXnla
         jZbwqKgtdYiDFRxSYHVZORCzOX0uN8iI7qQRebF+Nqa5Tl4xe9j80/X8uE2mLPZwVHCb
         ghQh4Pnqcdka1xfVhn2MuQjJZzjUt8FsuQsvxYmS5ngT8/HjHh0JWsFQntQ0t1JF1l+v
         +ukQuC0o0FrpAjrIdNIvC33xHfzxSim60jsZ6M+XCMmSDUZ9e5tiDHJRbYFS9w1upakR
         qEaQ==
X-Gm-Message-State: AOJu0YxlP9NU8lsyT6qNWspTE66GtIoGVB4HRPjibs2CCfUjhfVFtVtX
	BOf6kKi1XgPhKKbVOakPwhd4GsiCegfIAF3UAFdn5y2FFyUGsu7y2wePGYCVEOqzimc=
X-Gm-Gg: ASbGncuawliW6s4EPAO0xCFEP+DAyrZfiH7p/YSlQsWFg9YzmujOZBRsOJpAg85wwJq
	npQDTBiq4t+gkwsW0LcdfSIrZlP5vfwNNJRsTDYG5Xdt0x1c+z151//OsiwUah5VrD2SNzNVaEt
	X+Emtf9UTwzOJmtbw3JochkPVmnssQp+EuiE68d7WUBMp2G9G9UO0QmtYJlL0oku0V0ek9HZ0yW
	HhkspGJOZ78AA3DC46KdGoEFRasEP6NDFMzpuU736kKyBFDhitKFbPZG+wqZ66xxHnCOUeVesF6
	kVsBkNF9ZeIcWXReZGqsDrPAoHwthJELNa2+z7tsFE20mZqy4dUwJ6jlXcXwR9ayWHMcICilbCo
	ijBjwchqUtaMn8aoK9V0z5WLftexe16Rk
X-Google-Smtp-Source: AGHT+IEZ4+QbiVxLlSQw9LmUKy3Q5yy1vstKVUTLyzwAj/vsqwl2/Sk+3ejXrjfrdLWRH8EPHxC7nQ==
X-Received: by 2002:a05:6000:4013:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b910fde4bemr1980894f8f.25.1754985647246;
        Tue, 12 Aug 2025 01:00:47 -0700 (PDT)
Received: from valor-verifone.lan ([195.138.223.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0b2d2fasm32721394f8f.50.2025.08.12.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:00:46 -0700 (PDT)
From: valorcool@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com,
	iulia.tanasescu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	Stanislavs Nilovs <valorcool@gmail.com>
Subject: [PATCH BlueZ v1 0/1] Fix memory leak when adding GATT Characteristic
Date: Tue, 12 Aug 2025 11:00:43 +0300
Message-ID: <20250812080044.131526-1-valorcool@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislavs Nilovs <valorcool@gmail.com>

Hello,

As a self-education of Bluetooth world and future usage at work, I have
written small GATT Server project. It doesn't have a lot of stuff (like
authentication) yet, but basic functionality like read/write was tested
with gatttool on PC and some BLE app on my Android phone.

Recently I started to integrate it into propriatary Bluetooth stack at work.
When I started testing with BlueZ daemon - it segfaulted each time I was
trying to pair over BLE. When pairing over BLE BlueZ is reading GATT
information from remote device. After further debugging turns out I wrongly
assumed it is allowed by the specification for GATT Characteristic Value 
handle to be the same as GATT Characteristic Handle. However, this
didn't change the fact that BlueZ doesn't handle this case
properly and crashes.

Looking at the master code, the 4465c577778d812702d752dfd2812e25a2f69b31
commit has fixed a segfault as it added a check for Characteristic value
to not be NULL. However, there are still problems left after this fix:

First of all, the reason for segfault to appear was the overwrite of the
original attribute pointer with new one, which didn't had value pointer
allocated. With the above commit it may still happen, but we exit early,
before segfault appears in memcmp.

Second, the change of above commit is not freeing memory on error as it
is done in other error checks above in the "service_insert_characteristic"
function.

Bluetoothd address sanitizer backtrace:
=================================================================
==88967==ERROR: LeakSanitizer: detected memory leaks
    
Direct leak of 768 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46
    
Indirect leak of 576 byte(s) in 18 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46
    
Indirect leak of 114 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b4097 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x59f0cac75d6c in new_attribute src/shared/gatt-db.c:222
    
SUMMARY: AddressSanitizer: 1458 byte(s) leaked in 30 allocation(s).

The patch fixes abscent cleanup as well as adds additional check to exit
early if value handle is below or equal to Characteristic handle.

Stanislavs Nilovs (1):
  Fix memory leak when adding GATT Characteristic

 src/shared/gatt-db.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.48.1

