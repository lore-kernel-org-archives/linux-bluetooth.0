Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817513A40D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309150; cv=none; b=HMog+tb98ROPFWxAFflNPMFvMqH9qy3n1ufJWfiOinK2IwnKEc03AA3d2a8GHz37fXStaOUe/B5zspWZd16exbaDYE0Ce4ThDFJDqfKzTmWzSdiIdCi2kQWn5Tv20NWYIDjIbrAX9dMvrk2SOnoFk2CiC6zZPtVDT8EqaRSRsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309150; c=relaxed/simple;
	bh=6hopH6mNfrtEm/kntEVmPOzaAEd6JYVDK4QkAWSmzBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLKEBlAkuQTU8L9MpXLsDh4qES9C6vXGoaq/CzvStIDhqVFDdeNtVdU168Rz8z86hKDuLhVuVoa1svSPJF9el+WAI3xOpID5k81XaKw6cUxs8qzGtsB0EjC0hyEErYXFoYiWuOKLXewkmXc88Ys1WLlRSq8uxFGQ3aleKOA1s3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=Om0yhfdV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="Om0yhfdV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3558639a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1713309147; x=1713913947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1MSNXVfRIl2iEyThmz4tuqTMDDqHDQI3qdtOz0hRbQ=;
        b=Om0yhfdVezGXnliBWAmvG7Sl/M8zJLLRnVR8I+swY+V1MxpUajExPDPrwJsntQfLMS
         e/LjFlP7M0nbhDJikzgVrylDS4VTqKd2Vfnj+iMhkDBQPDSj5wFu5LTL3TroBeNAYxmA
         xmIiLT68QgURUC0+9Iu2HEiWQZvisWtNV8g+3jGdy3NoWzpHfW/IlIo9Gc1K9a6xxGO5
         tDrJWVhEn8OPFzIztk9pFyI9FAyH42ZSr6rmFjCGRqA2JmMDk7DYhsmHsRFcfRBSirGN
         e40UfsU9jMIRESdy+3DHKJ3rTZCzCNxokhrlDZs86Spe0WtalXVO+lSV0pZqDm/GiAm3
         Ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309147; x=1713913947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1MSNXVfRIl2iEyThmz4tuqTMDDqHDQI3qdtOz0hRbQ=;
        b=KuEMcd/nLlw6XS0L8EvtYalWggP95Z60VKGAYSp9+IuW+B1lT5OouOtS9MEXrcsfIS
         NKZKAB2jUjjmLPwsA6v4pTaxy/oKyiUOkMe45roKnk9LWebaQ2huTqCamMjEiMEp0SvK
         0oMc2uW2QtTTH+IFERY1A47EK1ZiF0kLiFO6/HgIRUKdtfTNL1K5l4SJzJt58I1VaWwZ
         Y71W9EsCnQv2n6HHb8IwrKmybyvBVhkFHlkFxe5LAfISj49PiEGzkSFuxne0qnbiyLac
         PKYzOluZCwusMe6VGJB1Jn4rilmIg20cMNgxVokkvihuSvXGqH5vWSTqwrsqu0LBC47q
         bETA==
X-Gm-Message-State: AOJu0YyjOedoWkjP3y3/KY4dSVFDWV+iu75Dx83ZMdis5OWbTiPN4gVB
	612q5CmJAHPo0h9bgb0qT3DHGVWMIPVLWSE95NKhBmZursNArdgKqcHP55Ihq/szBsdhBsbJ8pU
	5
X-Google-Smtp-Source: AGHT+IFzhS3VVR3IPYEqRMzSNWgoc2qBUg/42VK2bBzE33BEf/iTQKVnyfJpuKJdaLnMTy0uHW+GDw==
X-Received: by 2002:a17:90a:5d14:b0:2a6:500:5b9e with SMTP id s20-20020a17090a5d1400b002a605005b9emr10716479pji.45.1713309147546;
        Tue, 16 Apr 2024 16:12:27 -0700 (PDT)
Received: from localhost.localdomain (97-115-102-176.ptld.qwest.net. [97.115.102.176])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090a010900b002a67079c3absm160081pjb.42.2024.04.16.16.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:12:27 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 0/1] Fix spelling in monitor
Date: Tue, 16 Apr 2024 16:12:04 -0700
Message-ID: <20240416231205.2116175-1-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on TDS today, I noticed a minor spelling error. This patch
corrects it.

Preston Hunt (1):
  monitor: fix spelling typo

 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.42.0

