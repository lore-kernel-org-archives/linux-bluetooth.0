Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815B42CB0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214697; cv=none; b=rEYSzkVr/bvtHyhCXFwzkJ7Wjt8zVvTUC3ALqmMRvmdNlQv+R09VCXb577YpJ8Mh/j8g2C31eqS4bba55MrUj6tboUNpfxyq8KqkzKk4iEJjddrZ7B/quxhlWnFHQmpHDApgQVRqZzCwVWoPphhpTymf4YRlUL1DSn44PGCT5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214697; c=relaxed/simple;
	bh=+eBrwGYombE1mTXdw8sllcPXX068fyLM/Gbi2FoYjus=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H+mOMSA78e1BA+Dbs6x34AlgjZHcd4ywk7A6+W5lfTxvD7JIu5QMjqQdnmEmmOa0/9zr1h+gkW9ukS296gT3/VVOOI5piKIqjgpYcwYvidG8bJ+lG7vBOleqdh232FbKJJF/5RiBVluTllqtx8Oj9ECaRh7l1UH66ikkWvgcdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R2/wuv6Q; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R2/wuv6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784214695;
	bh=gAG7ieWnoXMPxLi2v4RSRX+GbTm7qWKSVimKXPQS1QU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R2/wuv6QNHqezAOCAW5RDlHniJTd+3BarD7RCQmLObVkYOXvajwpFJa3Z7kOw1Vg0
	 M9LvLMw6RIxqfloAajBOSF+hzIJ6SXTV39X/LBSRZnMtrxF2gw62Mx5uaDicXYIYFz
	 NvZ7B2ygjmqgducQj+eSkUXt/q7XpU1Afw1wJBmI=
Received: from github.com (hubbernetes-node-c5996dd.va3-iad.github.net [10.48.176.49])
	by smtp.github.com (Postfix) with ESMTPA id 35206280B6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:11:35 -0700 (PDT)
Date: Thu, 16 Jul 2026 08:11:35 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128884/000000-6588df@github.com>
Subject: [bluez/bluez] 6588df: shared/rap: Add bcs_procedure_data aggregation
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

  Branch: refs/heads/1128884
  Home:   https://github.com/bluez/bluez
  Commit: 6588df1c087aa8f1a865396eb65e8c64f5bd8c92
      https://github.com/bluez/bluez/commit/6588df1c087aa8f1a865396eb65e8c64f5bd8c92
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

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

Changes in V2:
 Removed the block-scoped variable inside find_or_create_proc_state()
 Replaced the fixed 16-entry proc_states[] array with a struct queue *
  of heap-allocated cs_proc_state entries



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
