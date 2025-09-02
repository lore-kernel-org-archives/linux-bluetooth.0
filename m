Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E1208CA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Sep 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825021; cv=none; b=rTe0KOhiIYKkwKOKVdQb5o9Zdha8vRYGD1amchTGjID5HbsmcVF+ANMp6UqZMkCa+GlOdsvEblfneHT0wRAmJy+buHgdEhZdS7grv+96XIkMWtyKd6dqW8FQ4NF0qQVm+P/8scYOG1ZKiQws8dY/N23L/eq97luMa4kLAk9nZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825021; c=relaxed/simple;
	bh=cLHPa43mBD+5VmDy96O+60RyAyaQhs1VVN82mXol668=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRuOsD8mxx9R7inINT7xYI5gqgHiudWyGQjIc/snHYrHqdtNi2tIiBreCmavtqPw2TUdf5U3u/60IH97HkDN8QUGh283bAWq2hpQ3c8tU9YhT7JP5O2uN/HXQ/EzOnTTEeFyIjjhsYl1XY70KKS81A9hn6ZAb/VbEdnY6ui16GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=JbZ17kxS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="JbZ17kxS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1982000b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Sep 2025 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756825019; x=1757429819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQAoY+64PekjTVVz5Aci7Us6O8LqMJNZMBqivTa7EXM=;
        b=JbZ17kxSmWqbf/pXzPjmWnbIloE0ShLmh2q3o0U0YWI9RsHOyJ51GWToX44fjHhRC5
         +F2tsW16pEDPFKLelAzVFWIVB+Gfn0Br7Cv/S6/iVtICS3Z66QQQQaNqHOPyojxvcEjJ
         jojVx2hInEoBFcyQvfRjzGeO/sCdA97wGJfwmNvlUmpe+6CpfD4D+Sjfiy4quL1bP++5
         3v9/8NbC30rGX8pM7Lfco7qqtHd9JatAcCgPyeqpHAQhT/rkACHSjuGoPvgKe81o0ZrX
         PgqN0vL7fJqHeDmAgaGlgFQpUPN+jl5ipPVP81/zkyaoVOgmtT5e3bXP97t7gS3ypZhh
         fIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825019; x=1757429819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQAoY+64PekjTVVz5Aci7Us6O8LqMJNZMBqivTa7EXM=;
        b=vyRg1kMutAvKcqaANsGoBbM9RP0QrxpbzeqwBwDUZU4rf85ARkKdChOSgrR28cgcu0
         Syr/ygh736PmtWjINLL3WGBx0fi44zinv+azDvyZ7O/9gyTVl9xA47eISYvfJJMKysav
         J97b+axs10YhF3XeFgts9DUiKyxl70y2nl12uVNFAhDhz+VcDAVSaGqULzs86WnchSSO
         RfxzUnl6nGKjEMk4ywJL+o/38i4BlAU70+a0mIfkBRldhr+/Y2dohaJ0KVyBwSkF0sw4
         NSX96uasqi6pjMxjnWIoQQ7McXaAjPqQJtEf7OXZv3UyEN3Z4KV/eTAGO1moVfGy7aZZ
         0SAQ==
X-Gm-Message-State: AOJu0YytetqxV7WIDU+1WyHBLHhyld1So/e/zL+f/NFz7YjxGOv0EjRs
	cepAF4diyUAAYLiAMsFscmzMkMAJuqC7bG/H2E9tqxiGmgVxson4xft9tegwp6LrVCc=
X-Gm-Gg: ASbGncuYFGgpSogtv7Vq73LPYNGEsTCpoQ7lbqUGINoFues6VL4EQkgjsxqUGoO18ZS
	vBJQM1r1bVcIQnf6UR9iYCVfqXp16uTPF6slZDZZt7lbuLISmjanVDdNzGCStXwt9hwCFwoeRAj
	WO0z89NqwSPRgSLPJ0Om/zpmSiX9hziOO7YGxfbl+Fu4wyClcadEqhHV25uugbJlepwy1hU5ogE
	T9duqb81iptC/0Tw2KhPWGeJ9OkQLmywQC/fiIKBC+5L+y2YY6AtD0373cTRCbFNOc2xjGBbrIp
	7oGMyVY9TwS4mG1Ty9sefFcKzj8vlhbhYJ5G+aok4JLiS/5sqmv8vT3A8D3MrZy3+/BNBG/YcbB
	FhFeGe975VFZ1vFMIgw9AXjCc
X-Google-Smtp-Source: AGHT+IG4NJOSwfNOiJPCZCADKuS/Hi0VsrUQ00UwdvcAjo/IiTHURdMNRbeFN9pERyT8kiit7L+DiA==
X-Received: by 2002:a05:6a00:1748:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7723e3fcb56mr15007816b3a.29.1756825018957;
        Tue, 02 Sep 2025 07:56:58 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bfe2sm14027937b3a.14.2025.09.02.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:56:58 -0700 (PDT)
Date: Tue, 2 Sep 2025 07:56:58 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, pmenzel@molgen.mpg.de,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250901 drivers bluetooth bpa10x.c:77:33: error: array
 type has incomplete element type 'struct h4_recv_pkt'
Message-ID: <aLcFuqRuB2NFu-ZE@mozart.vkv.me>
References: <CA+G9fYsgiqTo7t3e36P5cysc+jEX5Fub1quTj+fuKGM8jkxbFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYsgiqTo7t3e36P5cysc+jEX5Fub1quTj+fuKGM8jkxbFA@mail.gmail.com>

On Tuesday 09/02 at 15:00 +0530, Naresh Kamboju wrote:
> The following build warnings / errors are noticed on powerpc ppc6xx_defconfig
> with gcc-13 toolchain running on Linux next-20250901 and next-20250902.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> First seen on next-20250901
> Bad: next-20250901 and next-20250902
> Good: next-20250829
> 
> Build regression: next-20250901 drivers bluetooth bpa10x.c:77:33:
> error: array type has incomplete element type 'struct h4_recv_pkt'
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Powerpc:
>   build:
>     * gcc-13-ppc6xx_defconfig
>     * gcc-8-ppc6xx_defconfig

Hi Naresh,

This should fix it:
https://lore.kernel.org/all/aLNRvzXE4O9dKZoN@mozart.vkv.me/

Thanks,
Calvin

> Build error:
> drivers/bluetooth/bpa10x.c:77:33: error: array type has incomplete
> element type 'struct h4_recv_pkt'
>    77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
>       |                                 ^~~~~~~~~~~~~~~~
> drivers/bluetooth/bpa10x.c:78:11: error: 'H4_RECV_ACL' undeclared here
> (not in a function)
>    78 |         { H4_RECV_ACL,     .recv = hci_recv_frame },
>       |           ^~~~~~~~~~~
> drivers/bluetooth/bpa10x.c:79:11: error: 'H4_RECV_SCO' undeclared here
> (not in a function)
>    79 |         { H4_RECV_SCO,     .recv = hci_recv_frame },
>       |           ^~~~~~~~~~~
> drivers/bluetooth/bpa10x.c:80:11: error: 'H4_RECV_EVENT' undeclared
> here (not in a function)
>    80 |         { H4_RECV_EVENT,   .recv = hci_recv_frame },
>       |           ^~~~~~~~~~~~~
> drivers/bluetooth/bpa10x.c: In function 'bpa10x_rx_complete':
> drivers/bluetooth/bpa10x.c:99:37: error: implicit declaration of
> function 'h4_recv_buf' [-Werror=implicit-function-declaration]
>    99 |                 data->rx_skb[idx] = h4_recv_buf(hdev, data->rx_skb[idx],
>       |                                     ^~~~~~~~~~~
> In file included from include/linux/array_size.h:5,
>                  from include/linux/kernel.h:16,
>                  from drivers/bluetooth/bpa10x.c:9:
> include/linux/compiler.h:197:82: error: expression in static assertion
> is not an integer
>   197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...)
> ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>       |
>                   ^
> include/linux/compiler.h:202:33: note: in expansion of macro
> '__BUILD_BUG_ON_ZERO_MSG'
>   202 | #define __must_be_array(a)
> __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
>    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))
>       |
> ^~~~~~~~~~~~~~~
> drivers/bluetooth/bpa10x.c:103:49: note: in expansion of macro 'ARRAY_SIZE'
>   103 |
> ARRAY_SIZE(bpa10x_recv_pkts));
>       |                                                 ^~~~~~~~~~
> drivers/bluetooth/bpa10x.c: At top level:
> drivers/bluetooth/bpa10x.c:77:33: warning: 'bpa10x_recv_pkts' defined
> but not used [-Wunused-variable]
>    77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
>       |                                 ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> 
> ## Source
> * Kernel version: 6.17.0-rc4
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250902
> * Git commit: 3db46a82d467bd23d9ebc473d872a865785299d8
> * Architectures: powerpc
> * Toolchains: gcc-13
> * Kconfigs: ppc6xx_defconfig
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250902/testrun/29725581/suite/build/test/gcc-13-ppc6xx_defconfig/log
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250901/log-parser-build-gcc/gcc-compiler-drivers_bluetooth_bpax_c-error-array-type-has-incomplete-element-type-struct-h_recv_pkt/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
