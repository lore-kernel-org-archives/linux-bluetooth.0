Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCCA26D4F1
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Sep 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805433; cv=none; b=h6umk/7FojSOSV3zOmLNK/XJ8734EweO7rfSMCNO1Ahsel9Ih9k7+DTKBr9KN6HMfSom17EQ/wu8hT1oGhiO7kpPHsgF3jxaIB43RbIFYS9WmbErN7Zws8JryOU9+RfdPDh3uMJiFyydQqRMtY8XmgzhcKux6y8Xh7RFCbugWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805433; c=relaxed/simple;
	bh=dM/J4EWSRWSIxbOj5OAlxBlqKOA6FNTaQsCA4gH91BM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ehVJ2HTUnZJyf9SI6vazLMxNfYXYRO3loBSqXJ23sN99AmLShneYZTzTW9AAdkg9i24aErPzu78vACk8A9dOnZ2+W9ssFduLtemY6DwdCJMdsNbxXVzxBOBFGd7098Q+DJbD/LoEEHj0eWPzTdf9LrJKlQgMImu6n9EGsD0T3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kziQq71v; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kziQq71v"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7722bcb989aso2744444b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Sep 2025 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756805431; x=1757410231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7OKt9F9u3JGw8Hji9kO63gaBin4yVJprAEpigams7g=;
        b=kziQq71vyFdvPeTP7Na9ku3lbbMN3u1U8uMlg4yjjKa5SfBXh2uezSgF9Hr8aRflTC
         GAPS/Ah8xfigujbh8ndtL4wfMdDycu7hfW6YAsSV6qFqMkbh6dBZoWqQnJhO1zjrveNG
         tV/qBT6yKXroezc9w/JfHuYOC02lh3F5v8IF/RowbIyEonUJtDc74gUh3XFdv8YEoPdK
         SultCJ7ox/qi33BngZEkfzAO9YQUJrUTPH30LNZNCp4JJfhSHqMAJO2Xteu2i3fCZZJ1
         PcBhho+NCRuHkSIMzsrJmBmARDl4Q+7BZTyeWO3TfZDzYmWhKKw/wZrwFGz7DEsDJ52o
         SKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805431; x=1757410231;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7OKt9F9u3JGw8Hji9kO63gaBin4yVJprAEpigams7g=;
        b=V8+8ZAntqgNhzqo7pTIWVQ2ON2IczD1YH8yWoJ+OIY/dcRb9JneizJ6pKW12hXclRV
         W4rhF8OQ1ISZRyQgy17hJ+Vlt04GIZKBfK+zcI+vEy1SDb9ZOL/tjRuM1AFQDgATMrMN
         NyRoNJIQ3lLtjF4OzvyAoruLVBMr6vjTl+OmtRo7AFzI7Fkl+998FN4lHkiLPMlXwY9v
         KobjQNvmFpYMb2bxTUYRkVc28y3bNM2K6JNSyZiGiOaEa7guY8ZfTmV09Dv//rqwKOGF
         w71nci1kdwayqRJr35wpVZS5o5/+WGAXWo743Suw/XXHz+4cM2ePx27nBwcss/MfiCuo
         z37Q==
X-Gm-Message-State: AOJu0YwmUK5rbC0P93R802/RjjkPw9KecHtH0WInnXgvrkpAR/glvBRv
	RzodvTe/F3HaYUGxS7Ddz7PlRE1OJh6Ut+ROpfJwPploxwKkwJLdGDExTsn4lrL7qvX0qzIz769
	+SjZDED1JbMO1ezs2SJbIG6eo45T382eYifpXyJ/ao3wQYEQE7YEFbLM=
X-Gm-Gg: ASbGncvOZrKy24MX5aBrYAaqnztWBb8/eFpU5K9rMjRWSmB+vUJZ3mFei99u8tkJj0Q
	laf2NlvhN5QVMtMK0R8GN2vWi7awSsKxwd2rtLLcnAyNbHEM9u/2taYFrkfPTKkFbb9fNSjIour
	ZmkjwBgpi806EfoXp2DFeT+UJVB1UcWiZvMn3mnWCACe6fi4R4e2JTxajJ2ChkTwEePbGi7w0eo
	NsGg5E2t3A9ImP3vw75H6UE0ofqibAGIzcB5Oul
X-Google-Smtp-Source: AGHT+IE8Yrx7PIEHWr7GBuT6CR6OOXizH5auPXW+y/+V0FBm3oCtap+/O+brH9ArwbKXJtHKdi5XLNVxxZpQhJ6oyCI=
X-Received: by 2002:a05:6a20:1595:b0:243:d26c:4802 with SMTP id
 adf61e73a8af0-243d6e00a3cmr14965979637.16.1756805430855; Tue, 02 Sep 2025
 02:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Sep 2025 15:00:19 +0530
X-Gm-Features: Ac12FXx1zyo6Or4T4_OK4vkNL4SKnoNS4plyRwcQt4YbOf4Pp4VblMYRHeLcvTI
Message-ID: <CA+G9fYsgiqTo7t3e36P5cysc+jEX5Fub1quTj+fuKGM8jkxbFA@mail.gmail.com>
Subject: next-20250901 drivers bluetooth bpa10x.c:77:33: error: array type has
 incomplete element type 'struct h4_recv_pkt'
To: linux-bluetooth@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Calvin Owens <calvin@wbinvd.org>, pmenzel@molgen.mpg.de, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed on powerpc ppc6xx_defconfig
with gcc-13 toolchain running on Linux next-20250901 and next-20250902.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250901
Bad: next-20250901 and next-20250902
Good: next-20250829

Build regression: next-20250901 drivers bluetooth bpa10x.c:77:33:
error: array type has incomplete element type 'struct h4_recv_pkt'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Powerpc:
  build:
    * gcc-13-ppc6xx_defconfig
    * gcc-8-ppc6xx_defconfig

Build error:
drivers/bluetooth/bpa10x.c:77:33: error: array type has incomplete
element type 'struct h4_recv_pkt'
   77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
      |                                 ^~~~~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c:78:11: error: 'H4_RECV_ACL' undeclared here
(not in a function)
   78 |         { H4_RECV_ACL,     .recv = hci_recv_frame },
      |           ^~~~~~~~~~~
drivers/bluetooth/bpa10x.c:79:11: error: 'H4_RECV_SCO' undeclared here
(not in a function)
   79 |         { H4_RECV_SCO,     .recv = hci_recv_frame },
      |           ^~~~~~~~~~~
drivers/bluetooth/bpa10x.c:80:11: error: 'H4_RECV_EVENT' undeclared
here (not in a function)
   80 |         { H4_RECV_EVENT,   .recv = hci_recv_frame },
      |           ^~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c: In function 'bpa10x_rx_complete':
drivers/bluetooth/bpa10x.c:99:37: error: implicit declaration of
function 'h4_recv_buf' [-Werror=implicit-function-declaration]
   99 |                 data->rx_skb[idx] = h4_recv_buf(hdev, data->rx_skb[idx],
      |                                     ^~~~~~~~~~~
In file included from include/linux/array_size.h:5,
                 from include/linux/kernel.h:16,
                 from drivers/bluetooth/bpa10x.c:9:
include/linux/compiler.h:197:82: error: expression in static assertion
is not an integer
  197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...)
((int)sizeof(struct {_Static_assert(!(e), msg);}))
      |
                  ^
include/linux/compiler.h:202:33: note: in expansion of macro
'__BUILD_BUG_ON_ZERO_MSG'
  202 | #define __must_be_array(a)
__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
   11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
__must_be_array(arr))
      |
^~~~~~~~~~~~~~~
drivers/bluetooth/bpa10x.c:103:49: note: in expansion of macro 'ARRAY_SIZE'
  103 |
ARRAY_SIZE(bpa10x_recv_pkts));
      |                                                 ^~~~~~~~~~
drivers/bluetooth/bpa10x.c: At top level:
drivers/bluetooth/bpa10x.c:77:33: warning: 'bpa10x_recv_pkts' defined
but not used [-Wunused-variable]
   77 | static const struct h4_recv_pkt bpa10x_recv_pkts[] = {
      |                                 ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


## Source
* Kernel version: 6.17.0-rc4
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250902
* Git commit: 3db46a82d467bd23d9ebc473d872a865785299d8
* Architectures: powerpc
* Toolchains: gcc-13
* Kconfigs: ppc6xx_defconfig

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250902/testrun/29725581/suite/build/test/gcc-13-ppc6xx_defconfig/log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250901/log-parser-build-gcc/gcc-compiler-drivers_bluetooth_bpax_c-error-array-type-has-incomplete-element-type-struct-h_recv_pkt/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/328DwMMwNOpSAj0qnRpJavgtz9C/config

--
Linaro LKFT
https://lkft.linaro.org
