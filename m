Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7FC133
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743188; cv=none; b=msYdiSjfvgdzV84bqUraKdry/TUjBB8zOhAB2vrBeFxcVxzv6vKL9vwQHOr6SCurea6UuA+VdibUXsmuSpwBaEBMi/4dxll0JTwksW8g1ApTDZIDqEiJLgn/mDlRHwRO3n/Pt5cS1y57INZ2TtgCihOy2BDgHIzXlFM7JBuEq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743188; c=relaxed/simple;
	bh=HRMBdVRIv7uebRCwMPC8GZglmXaEVEHyK9weJKDSmRQ=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=if3Dz/sH/FuF0ri4LbsMIU3M5T0TSwGbyMDgIOxtaq8+hcLwSFmAiacv6TW6oHnjCDNbY0SZE89Nx+UD+33rQrDbTjOrCGhDOdlgP5cTUfkeI92T9F7pFSHdxlq/B5LF7phiyAHRiqQgteMUsfSty8Ku3bIssVFIiEh5kreWKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFPlNNy5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFPlNNy5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fec34f94abso51419435ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724743185; x=1725347985; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRMBdVRIv7uebRCwMPC8GZglmXaEVEHyK9weJKDSmRQ=;
        b=nFPlNNy5D5JZN7a29FugaC8vy7DbVVlddWR8bXZSVBK0qXR7827wXeCN5sW6dX8NPM
         PZcUk8Br+geZ31kMcw0OprBbu1UYpCOMItTT+P/0OVIVEFDc72obH+a/6nZgtoWaoHLQ
         IlQfbFGSC+Rv6XHDlwmkmEM8H28ymIS9uT4klVrDlaWaYlURadctUyJKplvpii/xehLQ
         nZKSejhpbgSzIbkMUGzt6AQLPvpivYF/dvoeHBMnQVa4u+Rj2QpmCXerG/Yb2vKCZuc+
         EQr0UvbUz/xpW/28S6uKuLmRtho4m/hT39G8rmto0rtuMruPGgtzI0Hf+M7ZrMs6gkDB
         i/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724743185; x=1725347985;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRMBdVRIv7uebRCwMPC8GZglmXaEVEHyK9weJKDSmRQ=;
        b=IbuKznMD94tmyea10xGhXJtZVwr/7mM7K8fiHjC40XlOXTHV+LAlxEb8srCbtuhUKe
         4v2hwCCYLJZwf78LZGLGd3VOvYPtqGLjT2hNolEGabR/R7BVfziFnBZqSHAjgc6WxGCN
         tnjON+kZ2MGiXLZ7jsOMd/uRycN86MNFZdjQBJ3ic1g8WP5Kf296cdW1pmnxwgLEc5pY
         QTKPGQwo/PJxawVes5pa7dgASD9R4rlJQlnQhrMFTRPTYHnKKqQ8D8Rnr2lzjC3aYLde
         MhB7yDKih7c6NKB1EY0djeGUrgQuTMr1644z+lysZRj3IYXvcUK2Ua2L143ebKEYJ70c
         YEaQ==
X-Gm-Message-State: AOJu0Yx1Q1cEL/bY66gmw/R78SLK+4U3qIFpXKNdhpnEYS2qcwue9tlj
	gKVIEcECpD5mGQL2HhwA7tUXJ4LHXRL88Za9wqdYsPSDX340pkcKgngPOw==
X-Google-Smtp-Source: AGHT+IEv3f23b1DN1KsbN72xIBgt6B7b3WJNwWzdEnFVI7nS5388/FF27Sy2J037oB7Lo7kzQ3itLA==
X-Received: by 2002:a17:903:2301:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-2039e515956mr152921655ad.57.1724743185174;
        Tue, 27 Aug 2024 00:19:45 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560fad1sm77597365ad.209.2024.08.27.00.19.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:19:44 -0700 (PDT)
Message-ID: <66cd7e10.170a0220.c4108.dd07@mx.google.com>
X-Google-Original-Message-ID: <Zs1+D3tTL9fv8D7w@JUNHO-NEOSTACK.>
Date: Tue, 27 Aug 2024 16:19:43 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Sharing functions that parse configs in src/main.c to the mesh module
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
While reviewing the code to add new Mesh States to mesh/mesh-main.conf,
I noticed the following issues:

The parse_settings() function in mesh/mesh.c, the existing configs
parsing function, has many duplicate lines and is not well separated.
On the other hand, the parse-related functions in src/main.c are well
separated in the same structure. I think this code could be reused to
improve the mesh conf parsing function.
Rather than duplicate implementations of similar code, I would like to
ask for feedback on whether it would be better to isolate the reusable
lines in the src/shared/ directory and make them available in
mesh/mesh.c as well. It would not be necessary to move all the prefix
parse_ functions in src/main.c, just the prefix prase_config_ that
parses the data type. I would like to ask if this would break the bluez
semantics.

Regards,
Junho Lee
