Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1007E545
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310769; cv=none; b=EsuWb8qDNzo0KxYO4p+ABOhpjz7IvYUQjRyerTZhMn0DE6B6vyknhpY5GzRyE+3DBU2oev0jkGj9AQ3DJWhlhoCdU6YK9QHPIch1wsZ63/yAT78sznJx37JlMeOmiDnIlTUlOPkLnvevgCfDbDeb8GZu/uxcHUyKVKR4jwFw93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310769; c=relaxed/simple;
	bh=bcpYGhATuRAhFhjEHuKdOTwcuo9maMSbJRbRYf+cnkI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZDiK9loSl/HX6tA6rSH68kgKC9K70XWAh3UJmsYKF+LwOZVgYYBHE8/YB+z8AjsISotHZOelf8J8VTfFl0DqXJKVXYK3DsqMPqEdgtxisWTDO+KTfE0FTHgESLLP4nKYVbQLg7888S+rhrlrIySAltbgRPtiVjv84XXnF39qMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSpy1Tbn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSpy1Tbn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so3036610a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Nov 2024 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731310765; x=1731915565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJS7SELkN70hLPBiDvwCr7Cz4XYhGyHp9b9QIRMYdtI=;
        b=aSpy1TbnEcYGUxqlv7W9KkyHpbVU4qIBDjRNFu+igfuYDaefU532dmcwKvtrxVmofV
         5awiYawJdGzhSHCLJSYm4ikS+my7LmJLtvpmAQZQ7aI5sYqvpVg246zjGzteEsYrfs3Z
         CenSPEv/r+Z3Xjw6dJiA+Ws+Y31Uzo7aEyiOltwoM4w7OuZdofNeAYQD0HOM8HQUmKS9
         rMvhmTn15t+KFR8wzDZfwD9OAisq9W3IhysQw3btrb00AUUOWiEG2buGwB+Uvbqj1zvC
         oVSDQNpv9RjC8I6xQTXNbtYuT0bAjnQgMtzxmet6kBZI4H4SClTnMy+Forzlj3cDXSyU
         3mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731310765; x=1731915565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJS7SELkN70hLPBiDvwCr7Cz4XYhGyHp9b9QIRMYdtI=;
        b=Iyb30Wfif0kgJQSQDXnsbCPQuK/LoopGulkjF9g9Trm2lv3MSL+90y8Ld1PR3pzV1e
         GfMUZtLesktF4dmIq/BzAvlFjhPgb4MgIPhqaxeLa6XpZEnhoI/Jmkvw04op11LU3ET8
         y6v8+vIP3s7iCPAT3oKzDP9dEZg0iT63YAGsY/vCwhJtENOlp2GVbRsIELFXaG6x0DUU
         /JxPBCHCFJzSjx1emBsytYIifGnbWsGM2b8Efc/OmCrqGvZ5vmC7hceL+fxQoG83bt2z
         2/imrZ7jO80yCcBDpKu+Gb95Yr3u+PBmgsg8jPm7lBfHpYgmW8kCth6C9keLLfrmMG2s
         lLKQ==
X-Gm-Message-State: AOJu0Yw46zdEPUzYKqjof+HFz2ZvRnP4CPot4JM23+39x5eQ6+pUq9Eq
	t/ol6lgOK84eIqFK4g7U2ItOzR2i5dQjKRaTi9v0nZnK4HHN/l3i
X-Google-Smtp-Source: AGHT+IHyDGlRh4c54+K24vosN8ktufPDxzliGAzEn2vK4Awdo25eU/GvMSM7msifMuG5JOagPQtTfQ==
X-Received: by 2002:a17:90b:1d50:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e9b178ee2dmr16344182a91.33.1731310764985;
        Sun, 10 Nov 2024 23:39:24 -0800 (PST)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b2b4cd58sm5858002a91.20.2024.11.10.23.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 23:39:24 -0800 (PST)
Message-ID: <6731b4ac.170a0220.1c6739.5561@mx.google.com>
X-Google-Original-Message-ID: <ZzG0qZ2BlzlfOdTR@JUNHO-NEOSTACK.>
Date: Mon, 11 Nov 2024 16:39:21 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: bggixx@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: mesh: Fix segmentation behavior of Lower transport layer
References: <670cce2d.050a0220.14053.42b2@mx.google.com>
 <670cfbcf.050a0220.18e738.ce82@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <670cfbcf.050a0220.18e738.ce82@mx.google.com>

Hello Brian,

Thank you for taking the time to review the patch despite your busy schedule.

The patch I sent over relates to the Segmentation section within BlueZ. Since
it’s been nearly a month without a response, I wanted to follow up as a reminder.
If you encounter any issues during the review or see any areas that need
improvement, please feel free to reach out.

As I mentioned in my previous email, I aimed to keep any refactoring or
optimization changes to a minimum, focusing primarily on the modified logic
itself to ease the review process. However, if additional optimization or
refactoring is required, I’m happy to provide further patches as needed.

Best regards,
Junho Lee

On Mon, Oct 14, 2024 at 04:09:03AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=898733
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      2.12 seconds
> GitLint                       FAIL      1.27 seconds
> BuildEll                      PASS      24.90 seconds
> BluezMake                     PASS      1680.91 seconds
> MakeCheck                     PASS      13.10 seconds
> MakeDistcheck                 PASS      182.16 seconds
> CheckValgrind                 PASS      256.27 seconds
> CheckSmatch                   PASS      361.24 seconds
> bluezmakeextell               PASS      122.15 seconds
> IncrementalBuild              PASS      6303.61 seconds
> ScanBuild                     PASS      1060.98 seconds
> 
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [BlueZ,v3,1/4] mesh: Implement lower transport layer for segmentation and reassembly
> 
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
> 1: T1 Title exceeds max length (84>80): "[BlueZ,v3,1/4] mesh: Implement lower transport layer for segmentation and reassembly"
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

