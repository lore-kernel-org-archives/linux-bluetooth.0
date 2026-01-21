Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C46478E45
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985567; cv=none; b=qGrOgFh/hoLn7gF/+0d8QH8U7KT+BpNG1dCgi2q0gS+sDiOM8/5P44ZO+UspGddXoND0FCVZydhbd6c5LAU9rKaYlsEfGD6IFPg4/mr2dpkKTGYoFkfZgqDMkzOrRf+sux0eOYzFaQpVJxH3jG8NZYO/P395qVD+d9pJpr64Sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985567; c=relaxed/simple;
	bh=ReK8Hj6IFnHSM0ml/Cu3H8lZfK607/3w0BDimtfcQlU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p9KNxPR5J8I2M43S4Vz3lpWiKlFuHj3/78e8+AMR6OR83cRhZirOdwB0LcM8mriWJjmhtRtZLMgRuN4ey5lVLMONqpOBz/ejLC6LVPbKU0szrhi0jIwanXruyrZ0kuUyGanG8QPZoGsbRCLWmx1lDZcv6qNeuoNn9opqjQC9CvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dxizj2KK; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dxizj2KK"
Received: from github.com (hubbernetes-node-899da76.ac4-iad.github.net [10.55.97.12])
	by smtp.github.com (Postfix) with ESMTPA id 149E0400AA8
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768985565;
	bh=N3h6qf83V4mxqq6yUl9mBg1wGYCFOuEy8IFkmRsScNk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dxizj2KKTQKzvHHrbm/adsiYhdPx8nU5rbq8BMZ17c/Y3aqVLNfUxpRYNialZslxA
	 jKxOZhrkb4IkyogkaIPGxRIfimi4iudFG16aH771m1N4RT98i/RCz7Dl+LV6drFSJh
	 36vgwmZRhAqTwTlxjKc7zzxDJwigYqBoeSbJZIsc=
Date: Wed, 21 Jan 2026 00:52:44 -0800
From: MengshiWu-mengshiw <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1045032/000000-5a2416@github.com>
Subject: [bluez/bluez] 0de9ce: shared/att: Implement ATT error retry mechanism
 wi...
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

  Branch: refs/heads/1045032
  Home:   https://github.com/bluez/bluez
  Commit: 0de9ce8c6d80cb027bbe6f487601cb93ac464b39
      https://github.com/bluez/bluez/commit/0de9ce8c6d80cb027bbe6f487601cb93ac464b39
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2026-01-21 (Wed, 21 Jan 2026)

  Changed paths:
    M src/shared/att.c
    M src/shared/att.h

  Log Message:
  -----------
  shared/att: Implement ATT error retry mechanism with callback support

Add a retry mechanism for ATT operations that allows upper layers to
decide whether to retry failed requests. This includes:

- Add retry callback registration (bt_att_set_retry_cb) to allow
  applications to handle retry decisions
- Implement pending_retry state tracking in att_send_op to store
  operations awaiting retry approval
- Add bt_att_retry_request() and bt_att_cancel_retry() functions to
  approve or reject retry attempts
- Store error PDUs during retry_pending state for callback inspection
- Modify handle_error_rsp() to return retry decision codes instead of
  boolean values
- Add BT_ATT_RETRY_* constants for retry decision handling
- Update GATT helpers to support retry callbacks for operations like
  discovery and read/write requests

This enables more robust error handling by allowing the application
layer to implement custom retry logic based on ATT error codes.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>


  Commit: 5a2416d6630ee546d2e1b7c784afbcb744fe1ce0
      https://github.com/bluez/bluez/commit/5a2416d6630ee546d2e1b7c784afbcb744fe1ce0
  Author: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
  Date:   2026-01-21 (Wed, 21 Jan 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-helpers.c
    M src/shared/gatt-helpers.h

  Log Message:
  -----------
  gatt-client: Add DB_OUT_OF_SYNC error handling with retry mechanism

Implement automatic retry logic for GATT operations that fail with
DB_OUT_OF_SYNC error. When this error occurs, the client now:

- Reads and compares the remote Database Hash with the local cache
- Retries the failed operation if hashes match (database is in sync)
- Triggers service discovery if hashes differ or hash read fails
- Handles Service Changed indications during retry by checking if
  the error handle falls within the affected range

Add retry callback infrastructure in gatt-helpers to support deferred
retry decisions, allowing async verification before retrying requests.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>


Compare: https://github.com/bluez/bluez/compare/0de9ce8c6d80%5E...5a2416d6630e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
