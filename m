Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDE2D045
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525742; cv=none; b=RxK0khjYxAwfiFjKD16+1wa9Whrj8z5UvgPQNYYOLlhbshThprwnYd9OUuRMaaFswxnjJ9tLrYCV0pAIo2o7vtuXY4Iyfm3jUeqAtdRQa7faY9hjj0Ivr+jnSxPKZrd82fiYh2jyylsnILEDVVUBKKbmb/BTKolccyB5O6c6qVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525742; c=relaxed/simple;
	bh=nE9MLeBRzi/rBfdNg1PKyR9/+BtbxgtfKLuZkA/blu4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Aw4cz6hISqQP7GBSNOAE2I/I37FbPz9ImFLRZzzLEIDTqxjvsylNZqLk5b9kBRmZ1MdyO79dI7t30h8InjptsbPFofThEI/ijZQn/OS+JL5BNCVJ34v5CBk7zysy99KzgANkJHfqC0EDTz+799tJn5YoEn9fTP2zGYkZcBZ1yQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHgjsxDl; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHgjsxDl"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bd3bf3b4cso2192302137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726525740; x=1727130540; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6E+O29W4Ujv6zpLm2vyQlgb2ZvY8fyHbuG5mRu1p6X8=;
        b=QHgjsxDlv4+/oriW7bcX+MCA0uZHAIdUwgklh9xyt2m7jNyal+r62p5f9lntqrNLvS
         OiwKeIJRyOcYLNtLs3I1u+/9DvaG6Jd++OGeFERDQuS50lkjOjWAxln5Kme1/Nir86C0
         cD7tpC1ct4fpQ1TD8Er5W0dGfZHIxPFXfiS6/Ve9k7qjboE1QSoBw6LdRzE4NTb2R292
         zDFr2ByUHOECAgW+c74oTGaeXoeqxww2PiH/+zF5ecGLiLpGXNySXUbna30snrDLmxSB
         rg9W/VVwsNXPEjqKo09+wAgMWtVIYnSUgeUC82rUb28c8cla+zjwTJaSfNOKYRh0qC6s
         y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726525740; x=1727130540;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6E+O29W4Ujv6zpLm2vyQlgb2ZvY8fyHbuG5mRu1p6X8=;
        b=UdyIWiIIgaY2qJyif3ZrznbBKucZKPgBG99Xc3Ve0wu1RfWBjf9K1C5JRCB3kRBqba
         q6u3gN5JS5r/vG3sGnJmpBt1R4GLMbgXMP1B3uYDt0fK5E9zAvje4IP99Oycl/xuQHeV
         I/pqUjeStHgGPgLdCfATjIszqH59HtyvQ3LhuYfz4m/x+P89JNbeoxS43mVIocLNlk/g
         6S+l61Xi1nvWCOoNoClQrE/gcx7w6ABVnSDjUnZV+28zkFYlOsIRLKyF/0m5+IbI/p8H
         ip9M8vJAHPh26zBH3KiLWg8pjPjwBVHB+/cUDDjtG4qdV7M+KTCCjqxEmbNYl6WTX7mn
         mKFA==
X-Gm-Message-State: AOJu0YwbOhqskK3xnBC9tFxqK+3P9/Epc+dbWa7yo9VGaXgP3t8w3Pie
	sxckNOWQQFKvZKnXPQP0YUz/N6soAZbNZhUxBZ7YHy4A1IJJDMseYpRbCg==
X-Google-Smtp-Source: AGHT+IHHEQvtb68hMQSlBGp1ub+KzMaJs9+ghwTVLi8tb1O68K+Eb6cslt7IxChtMwZJMSYwkqZK5A==
X-Received: by 2002:a05:6102:38d3:b0:48f:ebc3:a006 with SMTP id ada2fe7eead31-49d414ee39amr14999211137.15.1726525739950;
        Mon, 16 Sep 2024 15:28:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.113.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c633305sm28609936d6.34.2024.09.16.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 15:28:59 -0700 (PDT)
Message-ID: <66e8b12b.d40a0220.2095b4.a6ee@mx.google.com>
Date: Mon, 16 Sep 2024 15:28:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0951879749562467750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/uhid: Fix not crash after bt_uhid_unregister_all
In-Reply-To: <20240916202232.231417-1-luiz.dentz@gmail.com>
References: <20240916202232.231417-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0951879749562467750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890772

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1627.17 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      178.50 seconds
CheckValgrind                 PASS      253.18 seconds
CheckSmatch                   PASS      355.42 seconds
bluezmakeextell               PASS      120.23 seconds
IncrementalBuild              PASS      2955.98 seconds
ScanBuild                     PASS      1053.50 seconds



---
Regards,
Linux Bluetooth


--===============0951879749562467750==--
