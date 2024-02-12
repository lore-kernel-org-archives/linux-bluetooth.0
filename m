Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E753A1A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740614; cv=none; b=ujg5NN4kYtjVvlBhSTeR8ZnjbcEbWbcxBxKVfemsZ86ERvNvnN9oDH/kuyQQfDt+2iZPjr7/C6EjVHltbUXvfbpZvh11WJW4IvaIdTq1D2eJpp3sf+p4uxLhC35ag27QprfGHmV8HgI7SfJxK+I8HTPWnhji915PvnRR/Bmsml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740614; c=relaxed/simple;
	bh=6HmaCkYcP8SpvyF0IaA/N/cdIoS8RdsoJc5cp7sJuD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw/zPGh3r61KFxcTrjHZ47q9Pym1YJ8LYAoglCmx668uumTRYWu2fz/p1q+K5cvkkOxtQwtzrEbGaAwqihRF0fSEa7zpMYvZn1KwUs6fLHxLJzf/oqJuV0AIRy/oH7ERzGRmTAlvOUTarbaq7QL3HxY59h584jclzLGu0nthAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 65AFC61E5FE04;
	Mon, 12 Feb 2024 13:23:09 +0100 (CET)
Message-ID: <1a81650e-4d60-4177-bed3-e8f466336ed4@molgen.mpg.de>
Date: Mon, 12 Feb 2024 13:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 3/3] shared/ccp: Add initial code for Call Control
 Profile for Client Role.
To: Ajay KV <ajay.k.v@intel.com>
Cc: ravishankar.sriv@intel.com, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20240212161726.3097145-1-ajay.k.v@intel.com>
 <20240212161726.3097145-3-ajay.k.v@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240212161726.3097145-3-ajay.k.v@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ajay,


Thank you very much for the patches.


Am 12.02.24 um 17:17 schrieb Ajay KV:

It’d be great, if you wrote a commit message with information about CCP 
and how this is implemented and can be tested.

(Also, I’d remove the dot/period from the end of the commit message 
summary (also in patch 2/3).

> ---
>   Makefile.am      |    1 +
>   src/shared/ccp.c | 1147 ++++++++++++++++++++++++++++++++++++++++++++++
>   src/shared/ccp.h |   45 ++
>   3 files changed, 1193 insertions(+)
>   create mode 100644 src/shared/ccp.c
>   create mode 100644 src/shared/ccp.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 2b1b9acdf825..fdffdc478a16 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -230,6 +230,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
>   			src/shared/micp.c src/shared/micp.h \
>   			src/shared/csip.c src/shared/csip.h \
>   			src/shared/bass.h src/shared/bass.c \
> +			src/shared/ccp.h src/shared/ccp.c \
>   			src/shared/lc3.h src/shared/tty.h
>   
>   if READLINE
> diff --git a/src/shared/ccp.c b/src/shared/ccp.c
> new file mode 100644
> index 000000000000..9089779603bf
> --- /dev/null
> +++ b/src/shared/ccp.c
> @@ -0,0 +1,1147 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2022  Intel Corporation. All rights reserved.

Was this just copied, or was it really written in 2022?

> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <inttypes.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>

[…]

> diff --git a/src/shared/ccp.h b/src/shared/ccp.h
> new file mode 100644
> index 000000000000..809986c2601a
> --- /dev/null
> +++ b/src/shared/ccp.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020  Intel Corporation. All rights reserved.
> + *
> + */

Ditto.

[…]


Kind regards,

Paul
