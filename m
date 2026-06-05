Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C2393DE9;
	Fri,  5 Jun 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691542; cv=none; b=La54mmOvO55yu2dcvC4WHoNBpOEeLiXQdFzF13VKrSRRi/Q7y5/BsVtq8j5X0rNVDQsdCATVoCS2ji+8FSowDjZUzCkaJdsB9o6but71VsHUbC9Gtof7FTnM838XcA2i3oSbd9WVI60AxFnCevk3du8NYrxlpoaLAvaomb7oGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691542; c=relaxed/simple;
	bh=2oZiocPdi+jrNMrS6v7AkJa47u/nBgjm2SFH7RMGMDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmfXF5U2BxFE5DdLBZgsa7515DQnCobhem8dM7gbaKBkdB+vKXv/raiBMGVDkpho5NCzILUpZZM4zrsBfij/Ia4ccGH2C90NwfkERlez38AZwjteyG2H1T1hpbCWFaZ6M+5u4FkVU6Y3PecaLf1r/Nt23uQnykCW+qs3NPVdPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.55.104] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ED5564C2C37BB7;
	Fri, 05 Jun 2026 22:31:30 +0200 (CEST)
Message-ID: <83528dfc-55c1-4ef0-9b1c-de66b8558aa4@molgen.mpg.de>
Date: Fri, 5 Jun 2026 22:31:28 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
To: Tim Bird <Tim.Bird@sony.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 "jannh@google.com" <jannh@google.com>, kuba@kernel.org,
 "kiran.k@intel.com" <kiran.k@intel.com>, chharry@chromium.org,
 gustavo@padovan.org, prameela.j04cs@gmail.com, maxk@qualcomm.com,
 linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604170633.730139-1-tim.bird@sony.com>
 <8def22a9-85bb-493c-bd37-a299285a8f79@molgen.mpg.de>
 <MW5PR13MB5632F713AE9A9C87F131E28DFD112@MW5PR13MB5632.namprd13.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <MW5PR13MB5632F713AE9A9C87F131E28DFD112@MW5PR13MB5632.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Tim,


Am 05.06.26 um 18:25 schrieb Bird, Tim:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>

>> Am 04.06.26 um 19:06 schrieb Tim Bird:
>>> Many bluetooth source files are missing SPDX-License-Identifier
>>> lines. Add appropriate IDs to these files, and remove other
>>> license lines from the headers.
>>>
>>> Leave the warranty disclaimer in files where the license ID is
>>> GPL-2.0 but the wording of the disclaimer is slightly different
>>> from that of the GPL v2 disclaimer.
>>>
>>> It is not different enough to cause licensing conflicts, but is
>>> kept to honor the original contributors' legal intent.
>>
>> Could you please add a note, why you use /* */ in header files (suffix
>> `.h`) and // in files ending with `.c`?
> 
> This is documented in the kernel policies for applying SPDX license identifier
> lines.  See Documentation/process/license-rules.rst, Section 2.
> 
> The reason is that some old tools that parse .h files do not (or at least did
> not at one time) correctly handle the '//' style comments.

Thank you for enlightening me, and sorry for my ignorance.

> Did you want me to repeat this policy in the commit message?  I'm not
> familiar with any other places where the official coding style is explicitly mentioned
> in the commit message, when the style is used in a contribution.

I think only a few will have read the license rules and just the coding 
style, so I’d appreciated at least a reference to license-rules, Section 2.

>>> Signed-off-by: Tim Bird <tim.bird@sony.com>
>>> ---
>>> V2 -> V3:
>>>    - move Signed-off-by above changlog
>>> V1 -> V2:
>>>    - Leave different warranty disclaimers (which is most them)
>>>    - Remove files recently removed from drivers/bluetooth from the patch
>>> ---
>>>    drivers/bluetooth/btrsi.c         | 12 +-----------
>>>    include/net/bluetooth/bluetooth.h |  5 +----
>>>    include/net/bluetooth/hci.h       |  5 +----
>>>    include/net/bluetooth/hci_core.h  |  5 +----
>>>    include/net/bluetooth/hci_mon.h   |  5 +----
>>>    include/net/bluetooth/hci_sock.h  |  5 +----
>>>    include/net/bluetooth/l2cap.h     |  5 +----
>>>    include/net/bluetooth/mgmt.h      |  5 +----
>>>    include/net/bluetooth/rfcomm.h    |  5 +----
>>>    include/net/bluetooth/sco.h       |  5 +----
>>>    net/bluetooth/af_bluetooth.c      |  5 +----
>>>    net/bluetooth/bnep/core.c         |  5 +----
>>>    net/bluetooth/bnep/netdev.c       |  5 +----
>>>    net/bluetooth/bnep/sock.c         |  5 +----
>>>    net/bluetooth/ecdh_helper.c       |  5 +----
>>>    net/bluetooth/ecdh_helper.h       |  5 +----
>>>    net/bluetooth/hci_conn.c          |  5 +----
>>>    net/bluetooth/hci_core.c          |  5 +----
>>>    net/bluetooth/hci_debugfs.c       |  5 +----
>>>    net/bluetooth/hci_debugfs.h       |  5 +----
>>>    net/bluetooth/hci_event.c         |  5 +----
>>>    net/bluetooth/hci_sock.c          |  5 +----
>>>    net/bluetooth/hidp/core.c         |  5 +----
>>>    net/bluetooth/hidp/hidp.h         |  5 +----
>>>    net/bluetooth/hidp/sock.c         |  5 +----
>>>    net/bluetooth/l2cap_core.c        |  5 +----
>>>    net/bluetooth/l2cap_sock.c        |  5 +----
>>>    net/bluetooth/lib.c               |  5 +----
>>>    net/bluetooth/mgmt.c              |  5 +----
>>>    net/bluetooth/mgmt_util.c         |  5 +----
>>>    net/bluetooth/mgmt_util.h         |  5 +----
>>>    net/bluetooth/rfcomm/core.c       |  5 +----
>>>    net/bluetooth/rfcomm/sock.c       |  5 +----
>>>    net/bluetooth/rfcomm/tty.c        |  5 +----
>>>    net/bluetooth/sco.c               |  5 +----
>>>    net/bluetooth/selftest.c          |  5 +----
>>>    net/bluetooth/selftest.h          |  5 +----
>>>    net/bluetooth/smp.c               |  5 +----
>>>    net/bluetooth/smp.h               |  5 +----
>>>    39 files changed, 39 insertions(+), 163 deletions(-)
>>
>> […]
With the amended commit message, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
