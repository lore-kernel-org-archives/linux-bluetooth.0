Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAE43B6C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447239; cv=none; b=SNaeIhdsfyJRjMDQ9wtBtrmQ4N5PnSk3G0X+HOIoQzyfWeEd5R8JD5IC4yuisqIUpr/keXy8WE68ksauiqkkr5cESyjH3CcyeMCZHABvzE3ZdctH3P/bNoOw/Z+ueF4+CfEsqKt/hatZqIz4fOINhgCMSwNE8beOLO7X5M4OKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447239; c=relaxed/simple;
	bh=diSfBZYlFqzLreA4hwWlwJNybLo1PEze7Rdr0LMxpBw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Fx6TL9JBsts8tEuQX4HnOHgXJEVjxTe4ilsuH6i8QZNPM+j3jT/xZsp9KqyEb8RcUqYcaClBX3BWGn0mqdybUaFHGnurrjoLREByhOB1uFXSY0SXH5BbzYQIiW7zriIhb723BEPmyWA5hYR3Ts9xHoITpN24wgE/AtX0fsEFtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jA2Yx7Xy; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jA2Yx7Xy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783447237;
	bh=CdVOZ44O6rDr5KsVYvTVBaIifq/hNhFHzeek6e0C9E8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jA2Yx7XyCN/KJNSlLu96RRw6XxaZfDkCngi9bkpwheawrngOCbtZP4R9KHNwoKGQ0
	 sm3LIa8b0LRZyRahQVcfX7kBcEjMpD9Hur3hW1NwZXWXLGIDpek8F3Ay+C8g7WKFYe
	 HQmzC//Gm2utzA+JYVfsvEcVFMkeSsx7QBfCmvYU=
Received: from github.com (hubbernetes-node-6fe77ff.ac4-iad.github.net [10.52.159.11])
	by smtp.github.com (Postfix) with ESMTPA id 0475B4C9D3
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 11:00:37 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:00:37 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123273/000000-445547@github.com>
Subject: [bluez/bluez] 445547: shared/rap: Add bcs_procedure_data aggregation
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

  Branch: refs/heads/1123273
  Home:   https://github.com/bluez/bluez
  Commit: 4455472ee060dacc309d4191349217b0fe6ebb53
      https://github.com/bluez/bluez/commit/4455472ee060dacc309d4191349217b0fe6ebb53
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

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
