Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEE3BD63B
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401307; cv=none; b=oSTX56HhzWP5qF/ie8X6cHgXi7lJ26MtJVH0ZiPp0NA+Rz7yxTpcNxFhT67hekeLd8xqjoTFC9DPxqRuxDuOLYJ/ghIlarskpyIvzKORzT81Fr2u4ycBV7qgD8Y9DG3tk21JYJV99V+Fvnre8R6ceWDnBQcBBNU2DQKfe6ZqeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401307; c=relaxed/simple;
	bh=fRyPFCeBsaeWFJo7w0rkbtwfNFLVVkukBnW9aiYXuFM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c37iS9ZxiboqUKhFMpKc5MNGzMScFZ1Y6kJUKJITcnfvTRvkN7zZTzBhuOnlsqPL4yLKmtn/9uJRRhpLZRWfHGFNLuU09bn4ime4COenzMusY50F22xMRG63o/xiEomGdGODVWxLEbRjs6IGCIKeDklr/bQDQyvRmLlb1LslyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MNLT26sH; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MNLT26sH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785401304;
	bh=EbGvTEmgR/nvwA0eQ/h4oH1+5HDD+QxjGIDfJZbISK8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MNLT26sH2w12R9iRFgoRbzyPJYkfGUP30wL9wpzDXwebzDBOH3HZXW4PUepLWZmHQ
	 Tk3GZS+5XgqFaCEwp1odhXdDyvJ3AI47fRABdYz52jMrNUPQdxLRJnJVWs4gLsuqDH
	 oGCNfEpuT6ywvizl0gPEyub1nVzkzDGJ48UFxmfk=
Received: from github.com (hubbernetes-node-6e95ebd.ac4-iad.github.net [10.52.222.38])
	by smtp.github.com (Postfix) with ESMTPA id C80C632131D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 01:48:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 01:48:24 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137145/000000-6ecaf0@github.com>
Subject: [bluez/bluez] 2f99aa: shared: Add bcs_procedure_data aggregation and
 pro...
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

  Branch: refs/heads/1137145
  Home:   https://github.com/bluez/bluez
  Commit: 2f99aa35b5320beae87aae14df920d6fcac0a425
      https://github.com/bluez/bluez/commit/2f99aa35b5320beae87aae14df920d6fcac0a425
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: Add bcs_procedure_data aggregation and procedure data API

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


  Commit: 173499d06a5017bb13a60da62199e9a41e15936f
      https://github.com/bluez/bluez/commit/173499d06a5017bb13a60da62199e9a41e15936f
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Emit CS ProcedureData signal over D-Bus

Serialize completed BCS procedure data (subevent/step results,
CS config, and procedure-enable parameters) into a byte blob and
emit it via a new ProcedureData D-Bus signal on the CS interface,
so an external ranging estimation daemon can consume raw controller
measurements


  Commit: 6ecaf0d248adb8c5f1c9ac90c9d5ef2afb4fcd31
      https://github.com/bluez/bluez/commit/6ecaf0d248adb8c5f1c9ac90c9d5ef2afb4fcd31
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc: Update ProcedureData signal doc for byte-blob format

Document the create_context CS configuration parameter added
alongside the CS Create Config command.

Update the ProcedureData signal signature from dict to array{byte},
matching the byte-blob serialization now used in rap.c, and drop
the per-field dict documentation (procedureCounter, subevent
results, csConfigParam, etc.) that no longer applies since the
signal now carries an opaque binary blob instead of a structured
dict.


Compare: https://github.com/bluez/bluez/compare/2f99aa35b532%5E...6ecaf0d248ad

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
