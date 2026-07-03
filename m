Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAE433E7F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065226; cv=none; b=SkEXSObCLDYCaNOl39aksesFbpsp9aCaUmjTWoO9eJfXjTNs/ZbQZ+wNZ9rG05cToZRpg7HeB8c9fEf67raIKHG1c5kG6FbJSpGT0FE2szciNA4ETLdH7+X/F8GFonQB787/C2dwAc1Ceo7a2tko5cssF3CE89mH6qcDrkQAsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065226; c=relaxed/simple;
	bh=rVQrTfNtCSrSzRnE2zjUHDbZjVKKzHdYv+MvsOQPx28=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LOfQlvusecXCR7HJLN8apQQzEX2NSiVIchI6kbil1vBEoPG4AIi/lW9vqwUL9wU0tgWyEUhz/6p6DdKRxRBOPVKCP4hoiS4ha9QfCoaJCqTadFYnpEZwj5eAw2f9LdtmheXtWSakUMIt3TXo+oxUa9CALmerGUglMnBGH6rc/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fYIBd2wg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fYIBd2wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783065224;
	bh=1HDuy5O5LTFNddUOvm5kpzZIjFCmaolhzfqqSI28InY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fYIBd2wg1dRSKfXVove+ektmCbCiCRkHOB0kobEuvUEGZURmU7pfCH3poqCYJz/lI
	 2nS5hxv1cf0nun4J7VluOssmJ7oV916PeVVrfUeQ6iQSFaSTa2sg3VLmEbxNfuur4R
	 D6LZUBsH93tYNCjHPjbg2cRmzUUBiTbC56YVokmM=
Received: from github.com (hubbernetes-node-ffce894.va3-iad.github.net [10.48.73.64])
	by smtp.github.com (Postfix) with ESMTPA id 8A72E8010D4
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 00:53:44 -0700 (PDT)
Date: Fri, 03 Jul 2026 00:53:44 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120879/000000-5011fd@github.com>
Subject: [bluez/bluez] 5011fd: shared/rap: Add bcs_procedure_data aggregation
 and...
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

  Branch: refs/heads/1120879
  Home:   https://github.com/bluez/bluez
  Commit: 5011fd5fe33884741ddee38f2ee1b664c06c2633
      https://github.com/bluez/bluez/commit/5011fd5fe33884741ddee38f2ee1b664c06c2633
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-03 (Fri, 03 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared/rap: Add bcs_procedure_data aggregation and procedure data API

Define bcs_procedure_data to hold per-procedure CS results from both
the local initiator and remote reflector, including subevent step data,
selected TX powers, procedure enable config, CS config, sw_time values,
and BLE connection interval.

Add cs_proc_state with a 16-entry ring buffer in cstracker to track
procedures keyed by procedure counter, accumulating results
independently from each side until both report all-results-complete.

Update parse_mode_{0,1,2,3}, parse_step, and parse_subevent_steps with
output pointer parameters to capture remote reflector step data.
Introduce parse_cs_local_initiator_data() to store local HCI subevent
results, handling both initial and continuation events. Update
parse_ras_data_segments() to route decoded RAS subevent data into the
matching cs_proc_state as reflector results.

Add bt_rap_set_procedure_data_cb() to register a callback fired once
both local and remote results are complete for a given procedure.
Add bt_rap_set_local_sw_time(), bt_rap_set_remote_sw_time(), and
bt_rap_set_conn_interval() so callers such as rap_hci.c can supply the
CS capability sw_time and connection interval required by upper-layer
distance calculation algorithms.

Remove unwanted function rap_detached , fix for rap profile level
disconnections



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
