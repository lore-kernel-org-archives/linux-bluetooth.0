Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64B1B4C51
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928454; cv=none; b=Ig+sFFxFi+44z/6l8uSJ4ZJdBLoPu7d0pkT2CfeyTL+FnTTHUJVsFjg3J40Mb+JZiybsIacvYbfTl/FMIGedX6c3vNWKuLRIDCj9ghb0mbavTIOecqgHTB4YVeDcG4oG0tf4TB2GE15uLRgyde2GAllrJiWmltwap9Tmcdswrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928454; c=relaxed/simple;
	bh=rjpgYao7XueEz0LIYhdcC+NEWTbhIkocctUkoHFsS6Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GT7mGGMF0eBXM+MgaM7JUy73WuKzzaVUtR8MEy5DvUZHSJ/FTMBniv1ugmeix1DTCxnyjFEKwLhc2/iisOsKsLCZjpY2rEYKvhTbtESArPkXz/miYD6m1XeA3ZSvLLFJRCm+0fiJQ7oHk7q6ygOG96TrM00zgW3jOjCIUMzsKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHxOzO1Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHxOzO1Y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-630640c1e14so41197777b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719928452; x=1720533252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq7D/8LFCegu9Jagw7yfMTiNqagTClzP73883SzzpRw=;
        b=LHxOzO1YwNctyZY35i1DSfo8w9JN2DkGS7FMFaxAx3knQdFmjPhjvzSGU2PYQYsznT
         QeeVLxmHMUQmC955a11lUr71HhsGM3wTI8rwz0eTZDQE+9YuTpa8+sdwrmA4a+lhonuB
         AXbdFHGlD8VCTKwjya5jNAnkHM6ZYryJAogv2aFSof1VzeoIKGJ4hqKksWZjtN8ZlaZI
         9KTu0DyE3HkDl1VAvDzz7pdeEYni6jEmlNAmntomC44sg1AcBwGldv8so6eBAQB1f8rh
         UASWmOW30vMk5cD0iL5l349g7dAk2CGbvXWh6PNAUMf3me9QnF/9InPL3IxSYi2GbauP
         HqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928452; x=1720533252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq7D/8LFCegu9Jagw7yfMTiNqagTClzP73883SzzpRw=;
        b=hcuvbOMB0TauFtaMhXvx2zJ3PyMcCaRKSmsG0fhnNvVaDawokXGO4nFU2xOsh+oOHb
         vueTXmD5P3NvtgPwvGlznp6f0/cpZOXINtuhrAVOhx8iNTyezeCz9NK713edZrtgpVtN
         bQ67FcWBvck9bxWfwghUeEnDxcq9qUw0rGDqo1Waiau80SzPucTjM1Mdx2cLv5m3FFl/
         MF6WmPiemF7CJeGwlBpXcf6K++ZKb0GnkqyJGZMvhiLbM0D4veoRTDILpn9/r8cy+7Cf
         hpSfAzsACd8RvsCEqT+x0PYp7ChB0AUpbzZcBTXlq/c79BQqIELV99tNc5xP236BqieX
         OONw==
X-Gm-Message-State: AOJu0YzmvrxPkX5Zfx4iwrfduqWF+18C2kF4e7OJDdT1QJGXxQO2G8Yy
	zaN1zfBLcvsv891UrgSOYIq1jGj6fVtjEOBTnkWKAEbZLmz0cXsRzJcSoA==
X-Google-Smtp-Source: AGHT+IGjnHxWgia/87KSbDeccTvMBMKQqaxqZI8s/fhrtR0edwst2zW355NMZeQQRsoKGWqOxZSECA==
X-Received: by 2002:a05:690c:a9b:b0:647:eaea:f4de with SMTP id 00721157ae682-64c72d48331mr104880847b3.47.1719928452024;
        Tue, 02 Jul 2024 06:54:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.214.34])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9c21a6b4sm17544247b3.126.2024.07.02.06.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:54:11 -0700 (PDT)
Message-ID: <66840683.050a0220.77625.af26@mx.google.com>
Date: Tue, 02 Jul 2024 06:54:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0288449568251068960=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] client/player: add return value check of io_get_fd() to transport_recv()
In-Reply-To: <20240702115138.70500-1-r.smirnov@omp.ru>
References: <20240702115138.70500-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0288449568251068960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867513

---Test result---

Test Summary:
CheckPatch                    PASS      10.17 seconds
GitLint                       FAIL      2.19 seconds
BuildEll                      PASS      24.83 seconds
BluezMake                     PASS      1732.88 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      178.96 seconds
CheckValgrind                 PASS      254.56 seconds
CheckSmatch                   PASS      361.49 seconds
bluezmakeextell               PASS      121.59 seconds
IncrementalBuild              PASS      1498.74 seconds
ScanBuild                     PASS      1034.92 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client/player: add return value check of io_get_fd() to transport_recv()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v1] client/player: add return value check of io_get_fd() to transport_recv()"


---
Regards,
Linux Bluetooth


--===============0288449568251068960==--
