Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B36214A69
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231273; cv=none; b=S4ttrrG2ZfpZstu7+FPj7vksd96B3ojpbQnJGjBpBlXCt6/E5ZgPcXsgcekc/uU23CbehheSCNP8K821F5njQEW9IRZ22r4h8GCaiCtE2jxSbNYbITr32180cHsK1wdxM1PK97GGaMDGXn9/eI4b43Mjbdss9rzKq/oRcUXR6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231273; c=relaxed/simple;
	bh=U+v058kUI15xPN7MJpLhthLooZPdgsgXupDg6egCNW8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KBKLS7G2l/gW6pvO9paKY8D1yNhNFS/Ao5DnKi/t6Q7MNvz/Gwi0pjWwaEh5c9upiR6ULunkbpvOxsQwzc89yI6fXERHKSBqB7W3MOZ8/4JIYFxMhsF9WN4d7QVqPBfOCVfhQIMB1Hy8xbwxC7Af9cV0bTlZcI+2YRp3++w+MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iNEzcKhj; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iNEzcKhj"
Received: from github.com (hubbernetes-node-1b3c1fc.ac4-iad.github.net [10.52.153.31])
	by smtp.github.com (Postfix) with ESMTPA id 02853640925
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744231269;
	bh=gb0rZ7qnuIn1mFmxcy2Oal7k5AxQtR1Qpu0UHxuZvq8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iNEzcKhjyxfdpinkiSp/wZ/YVTMkvvDS8sNVaEunWJ9nBHolyFnKdhdtvkGOWIRLL
	 wErMH0JBQK17HpUTvWChE3fnuA94Gl2KCZC4RGkNpEgUZrNUGPofUPH9ejBBlzv06W
	 LUkuXdTmm8U+4VMZAVXApwoSnU1nPV/qctvX1RUU=
Date: Wed, 09 Apr 2025 13:41:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0b3d49-f8e7bc@github.com>
Subject: [bluez/bluez] f8e7bc: btdev: Fix checking for BR/EDR scan enable
 rather ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f8e7bcfdfb83a6a3becabdba1e4448bf04e32db5
      https://github.com/bluez/bluez/commit/f8e7bcfdfb83a6a3becabdba1e4448bf04e32db5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-09 (Wed, 09 Apr 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix checking for BR/EDR scan enable rather than LE for PA

PA is exclusive to LE so le_scan_enable flag shall be checked not
scan_enable.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
