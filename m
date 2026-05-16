Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5923536B
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=2.228.72.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898876; cv=none; b=rHZb0ZfhWs2/xNYSPOXRMRRqvyxcelfkessqrLIh23KPis1SIwhUzafTiTXV+cf+o6YDUWeiqdssS7zsz+gTHYN6CVllYuD/yaXPdOT044oraYoYhAKDfcdwwnV5JTchTGnNT7xk4Uzn8KlIneW2HVoOtwjtnwW5zd1KoyMOrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898876; c=relaxed/simple;
	bh=Sr9LQCNEgyUVSUZQJoAkJM8M2xtysEoGe/O3A32DsXA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HjfFH8xYZOl+hyPUvXgxjnNXh0IvT0rbw2GjePHgMuwEonD3IIRDMOxj3OGdleWcCZkhZuG1zbU4gQvhCNX0eSVW8s0512Kfdn8bMOM8D3mWHiDFpFwp2oi32ndZV/BC9Ddr9FZYQ7J/cEcSaT1NORNQPwKC+qbP/Pd7CfVOF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org; spf=pass smtp.mailfrom=codewiz.org; dkim=pass (1024-bit key) header.d=codewiz.org header.i=@codewiz.org header.b=Uhn4C4NJ; arc=none smtp.client-ip=2.228.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codewiz.org header.i=@codewiz.org header.b="Uhn4C4NJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1778898457; bh=Sr9LQCNEgyUVSUZQJoAkJM8M2xtysEoGe/O3A32DsXA=;
	h=Date:To:Cc:From:Subject:From;
	b=Uhn4C4NJ7/EZStOjtbKjH09nkHS86u+YtCfJRxL2ohMxkO4/N82ZdEd3YuR9NCJR2
	 ISsxprB2MMps3CF5O5XNYnMz8ccIwgQccoXWGMouR6K4xjwsvfd2ALb/hXaX0mw2nD
	 COiUGbX+tfXcNJgrKHuLRlvd55kHjRSlzey0WmWU=
Received: from [IPV6:2404:7a80:ff26:6c00:7853:dba:2963:526b] (unknown [IPv6:2404:7a80:ff26:6c00:7853:dba:2963:526b])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id 72F4124514C;
	Sat, 16 May 2026 04:27:36 +0200 (CEST)
Message-ID: <9f6967e5-c37f-4e21-b0d2-8eea4a0b5809@codewiz.org>
Date: Sat, 16 May 2026 11:27:32 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: regressions@lists.linux.dev
From: Bernie Innocenti <bernie@codewiz.org>
Subject: Bluetooth: btmtk: MT7925 fails "wmt func ctrl" (-EINVAL) since
 634a4408c061
Autocrypt: addr=bernie@codewiz.org; keydata=
 xjMEXxKIihYJKwYBBAHaRw8BAQdAEaAGAHL1d+7jYCkWrJabzd1reJYnxeoh45PTz8+7ERXN
 JUJlcm5pZSBJbm5vY2VudGkgPGJlcm5pZUBjb2Rld2l6Lm9yZz7CkAQTFggAOBYhBGkdgfqR
 5j+13Wxn/QvieBz8fxukBQJfEoiKAhsDBQsJCAcDBRUKCQgLBRYDAgEAAh4BAheAAAoJEAvi
 eBz8fxuk7PEBALTnPaPxYWXvPXxQ7WLcd4BvcfxIh+86O8sfh+OK9M87AP431LAnBx6lLArU
 8sXlHi9kq5Nx0FEeD0iQkl4f+Wk9C844BF8SiIoSCisGAQQBl1UBBQEBB0CyluVyxU6BIr7q
 8dkdVt2C6CHSNE1gcNoIOTD3xcG7AgMBCAfCeAQYFggAIBYhBGkdgfqR5j+13Wxn/QvieBz8
 fxukBQJfEoiKAhsMAAoJEAvieBz8fxukLC0A/jSvI5r8WmvrN7GMalg1PqF5JEruVtMIZaTY
 LD/ARox4AP9mgTyGs+XWQvqdw5FiEcAVQal6BT1xTiLFq48PN/v4Aw==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Since commit 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB 
length before struct access") my MediaTek MT7925 Bluetooth adapter no 
longer initializes. The controller never registers and is absent from 
userspace.

I'm seeing this on a Framework 16 (AMD Ryzen AI 9) with a MediaTek 
MT7925 (USB ID 0e8d:0717) running Fedora Rawhide.

Firmware is BT_RAM_CODE_MT7925_1_1_hdr.bin and loads fine in both, so 
this is not a firmware or kconfig issue.

Bad kernel (7.1.0-0.rc3.260515g70eda68668d1.27.fc45.x86_64):

   Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
   Bluetooth: hci0: Failed to send wmt func ctrl (-22)
   Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is 
advertised, but not supported.

Good kernel (7.0.0-62.fc45.x86_64):

   Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260106153314
   Bluetooth: hci0: Device setup in 296567 usecs
   Bluetooth: hci0: AOSP extensions version v1.00


Bug analysis courtesy of Claude Opus, I haven't verified:

   The failure (-22 = -EINVAL) comes from the new length guard in the
   BTMTK_WMT_FUNC_CTRL branch of btmtk_usb_hci_wmt_sync():

     case BTMTK_WMT_FUNC_CTRL:
         if (!skb_pull_data(data->evt_skb, sizeof(wmt_evt_funcc->status))) {
             err = -EINVAL;
             goto err_free_skb;
         }

   The first skb_pull_data() (base 7-byte WMT event) succeeds — neither
   "WMT event too short" nor "Wrong op" is logged — so it is specifically
   this second 2-byte status pull that returns NULL. The MT7925 FUNC_CTRL
   response is shorter than the full 9-byte struct
   btmtk_hci_wmt_evt_funcc the check assumes, so a valid response is now
   rejected. The pre-commit code tolerated this, hence the regression.
   The commit's bounds-check intent is sound, but the trailing status
   field should be treated as optional for devices that return a short
   event, rather than hard failing.

   The commit was isolated by code inspection: it is the only post-7.0
   btmtk change introducing an -EINVAL in this path.

   The commit is Cc: stable, so affected stable trees likely regress too.


Happy to test patches or provide full dmesg / btmon traces.

#regzbot introduced: 634a4408c061

-- 
_ // Bernie Innocenti
\X/  https://codewiz.org/

