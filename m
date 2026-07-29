Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E589456DFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325176; cv=none; b=fSgLEkKKCWqU6aOPTFnC7g0ZcqyQcu6liqPiXChOdiTMvZBjgxemJfTZ9TrVQiVlrM/pRT7SPYe6vQFdl+hIutnuW7ybqbj05Um0aGCfExAoB4CEWU2C1Oq9ETY3WtFfocS4hQH+n/72pO/dWsyCL3PEy8e5gxDwA59p7zvMNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325176; c=relaxed/simple;
	bh=5TBnpQHeKMRPqoQMPV8c/SnIYGpIncHYpL9cMcyUzYM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XKoClA8OwcqcKgXHyHTeXIMj5TkUQfIQTgttTnb97KmhvhXGF85Mp4t9DswTgrIe3aehYFjOb9SIMlYKFUQnFRj7r2cJ4/bObJ1wypl0YYq1cClfxLoPUWTuyLRMbwcLSAdIyzkEVeU1WRnbqWnzt0F+oFHUva5etX1vzhV/5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Mlcfnat/; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Mlcfnat/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785325174;
	bh=vAs1yiqCYbfpwZVHMlm9a51UqVOrZ7BHXTh8w713xkg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Mlcfnat/Ptm2PuKby7AuaiR0WmocSOsBRlWo2ckrFgiXsm0HvozvkDvKoQUMRz7YW
	 6gUAbDi9e28UmE47zkYvs4ZW6OxxyGvRs1i22IXDXMthun7bzeDdmKPPVYfwLyPQ0C
	 AhWRlQYwz+OVhgawYO+qa8SdOpptJj8uxZ9cJYRY=
Received: from github.com (hubbernetes-node-bc80831.ac4-iad.github.net [10.52.82.28])
	by smtp.github.com (Postfix) with ESMTPA id 6EB8A780B6A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 04:39:34 -0700 (PDT)
Date: Wed, 29 Jul 2026 04:39:34 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136563/000000-417b3d@github.com>
Subject: [bluez/bluez] 26d1de: shared/rap: Add bcs_procedure_data aggregation
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

  Branch: refs/heads/1136563
  Home:   https://github.com/bluez/bluez
  Commit: 26d1de5e4c12686df8565bc796df00631bc9076c
      https://github.com/bluez/bluez/commit/26d1de5e4c12686df8565bc796df00631bc9076c
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

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


  Commit: f98e4a98e84e347e5795046e06313a1ad63ee55c
      https://github.com/bluez/bluez/commit/f98e4a98e84e347e5795046e06313a1ad63ee55c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

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


  Commit: 417b3d11164f593a3a802c24d950bf9c7b1a7d32
      https://github.com/bluez/bluez/commit/417b3d11164f593a3a802c24d950bf9c7b1a7d32
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

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


Compare: https://github.com/bluez/bluez/compare/26d1de5e4c12%5E...417b3d11164f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
