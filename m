Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2303E022E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276739; cv=none; b=FUL0Jg5tka1kLx7xb0smi6Kik3ovjPeba+D6qLlzTUgKCzW62qctxr0xp8t6Pr+JjDYSd67LzfeoMi7xTcdUkucLPXbPYHD9Spife1QS5x4FIfzTh4RVJDNlZoiZLLcaE0wT2wBb1HGw/eKWXi21NKk5j/dcl5CqP7UccbFccpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276739; c=relaxed/simple;
	bh=YTpO4ddtqREy2CO45d6yYZo8QLGFfaWq8w2kZZTFC9c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iTYbRTB0MB8TnIp/eCA49KdiowlbKVUib8jy8GQVxKWZQcLb2rPmPsqcbzzZ+qF0tEYum+fkvrFUyW/nypmGWc4iG3i3h78gkx60/yh00QcATtSJTxS7ENLF19kO3D/b1Bp3vC3VPE1+ZjQb/nbqPFBWspAsd4OnqVJdeEktDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Bsz6nKJt; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Bsz6nKJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784276737;
	bh=MDSd4Hyo4Z8xOlqtMb6SbfPI7W4KPMU/IgTAweV+DvU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Bsz6nKJto5vNJGn7q/RGNlZerlB5xUL42WyvtsOywFiKwQdJaAiUHaP7Xgyg2xML0
	 eqy7M1YNSA6jHXdSFHJmCZH+ugWfU0/4YtW7X7b2vqjDFo04U9P0kbikWU5qIG+tOp
	 AGzw9PGvsi5mbvmdLjMGXe97L/Uo8/48ylr3rZi0=
Received: from github.com (hubbernetes-node-7a9d38e.ash1-iad.github.net [10.56.189.48])
	by smtp.github.com (Postfix) with ESMTPA id 909E0360982
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 01:25:37 -0700 (PDT)
Date: Fri, 17 Jul 2026 01:25:37 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129350/000000-27f844@github.com>
Subject: [bluez/bluez] 5e2434: shared/rap: Add bcs_procedure_data aggregation
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

  Branch: refs/heads/1129350
  Home:   https://github.com/bluez/bluez
  Commit: 5e2434dbf7add97640e9053ee98bf03215ee6e54
      https://github.com/bluez/bluez/commit/5e2434dbf7add97640e9053ee98bf03215ee6e54
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

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


  Commit: 27f844638412dc9d65b0bb1f374f7e580a9e07bf
      https://github.com/bluez/bluez/commit/27f844638412dc9d65b0bb1f374f7e580a9e07bf
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding

Marshal bcs_procedure_data (subevents, steps, mode 0/1/2/3 results,
and CS/procedure-enable config) into an a{sv} dictionary and emit it
as a new ProcedureData signal on the CS D-Bus interface.

Register a procedure_data callback on the RAP HCI state machine so
rap.c is notified when a procedure completes, and propagate the
locally supported T_SW time capability from the read-local-supported-
capabilities response into bt_rap.


Compare: https://github.com/bluez/bluez/compare/5e2434dbf7ad%5E...27f844638412

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
