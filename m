Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D91A3154
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622925; cv=none; b=eWyMfcAsR0gtrIzWM+7Upii8vNDrvlHEKSBle6Ed+yggET3pHZtK8mFycAjHuZfRJCXlJTsGgUQj6fYm4vR32/H/f0DGVAlkNEoOvo6yROxlE/pCfjm2ijOZStjG1mqfyib9yuUEkx8qex+ezkuasjg5BGRbk33v1cBUeDvDT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622925; c=relaxed/simple;
	bh=X80DQBRM0JJLphYoZ0EmUC9YvV2r8g9Qp5G2iKqFocY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DdNgqYiy40BCaCM+ZUjKEojRyUBX9JMA7AbnAmEl+l7WiF1pK0/Xu47menhqfosqI8MnixwWth/UZcyFFZsOW8tIW+pLgKk1TFZ6wyVK9OStnNf9V6kbiRX7fn8b3OhMFQyOV/7aeB+lSu1OelaFsRXoBkYv8nFyaeC2YPSdtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kClzYiJH; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kClzYiJH"
Received: from github.com (hubbernetes-node-bb23fe3.ash1-iad.github.net [10.56.128.70])
	by smtp.github.com (Postfix) with ESMTPA id 1E3AE14011D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 20:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754622923;
	bh=3DHWP+nG2hKhQk5BRNEOp1bPOIRhQ0z0dkXJXjh0nFE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kClzYiJHRqOqvPcsqADguyXDf3VSMD+9Cvjv0MunK4xTU0OX6Jp+YhbgNcNmnBrCa
	 TUxbVJHnwjqHg7O5XxmWV4VbeOblAoM/uIOkboi+ne0PIsTxZ2D2/VtcGlPKlEM6yo
	 FZ+qlMJBO+jxDhdv2FQgi01j4/pMhgc3jORuirzk=
Date: Thu, 07 Aug 2025 20:15:23 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989263/000000-90680c@github.com>
Subject: [bluez/bluez] 90680c: Fixed heap-buffer-overflow in
 `compute_seq_size`.
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

  Branch: refs/heads/989263
  Home:   https://github.com/bluez/bluez
  Commit: 90680c05ae5d3f335db66c04f883b5ede2eac1d1
      https://github.com/bluez/bluez/commit/90680c05ae5d3f335db66c04f883b5ede2eac1d1
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  Fixed heap-buffer-overflow in `compute_seq_size`.

By adding checks for sequence/alternate types in element_end and
ensuring proper cleanup in sdp_xml_parse_record error path.

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
