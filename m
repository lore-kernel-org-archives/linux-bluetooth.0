Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860F101;
	Mon, 27 Nov 2023 03:51:23 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E026161E5FE01;
	Mon, 27 Nov 2023 12:50:20 +0100 (CET)
Message-ID: <e2f67283-90ea-4f74-977d-dde8bdd0a8ea@molgen.mpg.de>
Date: Mon, 27 Nov 2023 12:50:20 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-firmware: update firmware for mediatek bluetooth
 chip (MT7922)
Content-Language: en-US
To: Chris Lu <chris.lu@mediatek.com>
Cc: Josh Boyer <jwboyer@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Ben Hutchings <ben@decadent.org.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
 KM Lin <km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-firmware@kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20231127085827.13060-1-chris.lu@mediatek.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231127085827.13060-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for the patch.

Am 27.11.23 um 09:58 schrieb Chris Lu:
> Update binary firmware for MT7922 BT devices.
> 
> File: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
> Version: 20231120183620

It’d be great if you added the version in the git commit message 
summary/title too. The `linux-firmware` prefix is probably redundant. No 
idea if a tag exists for it. So, maybe:

mediatek: Update BT MT7921 fw from 20230627144220 to 20231120183620

or

Update Mediatek BT MT7921 fw to 20231120183620

Also, it would be great if you added the change-log to the commit 
message, so people have an idea, what improved.

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>   WHENCE                                  |   2 +-
>   mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin | Bin 512022 -> 513878 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)

[…]


Kind regards,

Paul
