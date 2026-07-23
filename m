Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140843551E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818566; cv=none; b=di9j627Wrh/NgvGlaGq9Njp+TCV1CecDEAWwOqWYC3ltwFk9/qgJGc6UZhGh3lI4NAWRrNDade51epNeu6hGOFWPBzje0jjugkh8JXaCkKBpc9e0ybIAjqgC5LbMyWLpPwp5IUOceUQZ2zLB9CFNzn+3KSB+wBSwZ31DZxoeSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818566; c=relaxed/simple;
	bh=GFqd6Kz8u2EkYKYk63vXF1tQhVdX9C1CXrmuTXxFnmc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YYjf6kfEgAcUUq1QSS0xoSEwF3u6sB0Xu31VOTo8mZ/Obu2oyqwj5Q96O84Nf39mVRaL3FJ7gsxstLx2zj9PIx/E+Q8Aba66StNaSmoIxiRegYQUOO0VNRYSfVPxWe2lGeB48dHrPSSC5YPv6PVYXm4a8tGcSjU/eEJxkEKF17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FkrSmiTp; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FkrSmiTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784818555;
	bh=A5Q3Zi+xtvlIQy55emjbDfUMSXdo1vOmBUIz5fsU+lc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FkrSmiTpFVulfXdZk60Yg/2FMOkAmCVPpSZf39GJL1icipcaNLvznPSzVR0v/cWtM
	 jYdYIoSQMSkYhlrlY01XC1/OrcZKTfGcJK+s/ldQyklHX1BTmGMLdb5jUUtD4fGawE
	 ww5AL07qWNigNkpEnG+5j9fjUmi0D6kzua6/MzmM=
Received: from github.com (hubbernetes-node-83995b4.va3-iad.github.net [10.48.74.84])
	by smtp.github.com (Postfix) with ESMTPA id 2BEA81808DD
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 07:55:55 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:55:55 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133205/000000-1300a0@github.com>
Subject: [bluez/bluez] 1300a0: shared/rap: Add bcs_procedure_data aggregation
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

  Branch: refs/heads/1133205
  Home:   https://github.com/bluez/bluez
  Commit: 1300a08e5ed424ad22d2608de8a0b4423c43d9cf
      https://github.com/bluez/bluez/commit/1300a08e5ed424ad22d2608de8a0b4423c43d9cf
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-23 (Thu, 23 Jul 2026)

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
