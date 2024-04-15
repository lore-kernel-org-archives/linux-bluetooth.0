Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0A15625E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211662; cv=none; b=pVBd7fbfGvCLC6FhXY6cAv4wpcJb5KiWetWfeaQ3twg8Z5uf6kfSV9w1W8Zso8rAvLWPMMTpBhOZKSiywzzULW99v24aXbPwlfEx/2IX9OoTotRb6nr4CU9ZGpYou8ycViu2FlZNrc8OegF7oFAsXtJqLzGNK7UF1Hf2dCLnZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211662; c=relaxed/simple;
	bh=FGVpr/vOOlGm1I2/bi29eNlpPmgsMglqpB1TxOfAbVc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AQvFkrVukUtIPwojm7dPt6IqwcPXCWaDoTY3a6W7dOqOu2bQINBq4JzwF7z5a/NZ2JxaoYGwW+kCTmhIn7BUFRMTMC3WDVjzoco4qRLvhYEXSUMRdhKPylEZk2Yjm1dXV+VlU5prDt84R15eIuuGstQELXhmj9jBl7D6BUO8F/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b8p6Cn6L; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b8p6Cn6L"
Received: from github.com (hubbernetes-node-36cb194.ash1-iad.github.net [10.56.143.34])
	by smtp.github.com (Postfix) with ESMTPA id 4800C640982
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713211660;
	bh=CnKrDgOCzki/UXQSYb/GRr+yEqbCPTxOuz7USUiISo4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b8p6Cn6LLU2xFAq/XVS7reQhP7rOa0vPegfmRsWv/f5ljFxJKegqCuUehprIXYJMF
	 CeDhNnFz2PGCh//Lo9ViKMDIsefAKTKEJtk0xuPSqY3j+r4Gw7xxNszN8thpjXA/TO
	 pRORd/V427EuhuH3khil1MGaPjGnJ5lBYLEyH5d4=
Date: Mon, 15 Apr 2024 13:07:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/249216-b94f1b@github.com>
Subject: [bluez/bluez] b94f1b: shared/uhid: Fix crash if bt_uhid_destroy free
 rep...
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
  Commit: b94f1be656f34ea1363f5566ef63b847234c6dea
      https://github.com/bluez/bluez/commit/b94f1be656f34ea1363f5566ef63b847234c6dea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-15 (Mon, 15 Apr 2024)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix crash if bt_uhid_destroy free replay structure

Id replay structured has been allocated it shall be set back to NULL
after calling uhid_replay_free otherwise it may cause the following
crash:

Invalid read of size 1
   at 0x1D8FC4: bt_uhid_record (uhid.c:116)
   by 0x1D912C: uhid_read_handler (uhid.c:158)
   by 0x201A64: watch_callback (io-glib.c:157)
   by 0x48D4198: g_main_dispatch.lto_priv.0 (gmain.c:3344)
   by 0x49333BE: UnknownInlinedFun (gmain.c:4152)
   by 0x49333BE: g_main_context_iterate_unlocked.isra.0 (gmain.c:4217)
   by 0x48D4DC6: g_main_loop_run (gmain.c:4419)
   by 0x2020F4: mainloop_run (mainloop-glib.c:66)
   by 0x20254B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x12D6D4: main (main.c:1456)
 Address 0x53ae9c0 is 0 bytes inside a block of size 40 free'd
   at 0x48468CF: free (vg_replace_malloc.c:985)
   by 0x1D8E19: uhid_replay_free (uhid.c:68)
   by 0x1D8E19: uhid_replay_free (uhid.c:59)
   by 0x1D8E19: bt_uhid_destroy (uhid.c:509)
   by 0x1591F5: uhid_disconnect (device.c:183)

Fixes: https://github.com/bluez/bluez/issues/815



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
