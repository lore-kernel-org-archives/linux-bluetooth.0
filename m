Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349E1474C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935199; cv=none; b=FYIFA0kYEwJe4E/fbrEUTAxuQRVjNkefv+kmc3R46d7zkwA6qDAk4lB7OIsQlyVbskaCJ8xMQ70O7+OkYzhHzRopzTjwkvCy03ziQ02LzQR6/YpbSmql6h2z7OR5j3ySHschJa/CixaIKbayLGMcWqQ5KICbFbTsDQht3wI4kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935199; c=relaxed/simple;
	bh=Vyq/uOzfOSfNdrFP7xJnIjg0/KTf7ZI+BpoEDuwPhXo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bIKWeWhspT7RjIsS3YzDZ0Txv0yt5ydLgvK/7IbFnenGjjInyomoyPe6TRWKL0Iadh/I+V8Wf4K597zpnLzRGk03XmAJEM8WU78TDh222OH6B0+Jeny/fIX2v8x6S0swTLUr7Iu3KYrxuuXmtX7qoaCmHZEyybTXMyH2M8jr/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XgRmIWvb; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XgRmIWvb"
Received: from github.com (hubbernetes-node-280a920.ash1-iad.github.net [10.56.153.38])
	by smtp.github.com (Postfix) with ESMTPA id 8913064107A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712935196;
	bh=6wLzOpf8hgPdG2H9vwGcskhumU91y9iAG0wMLNTmr0M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XgRmIWvbSKdbisRx4H4nyL2GckPpzlizWKRk5HSbAQqa9H+LU1VxbGPYZK2pQPRBa
	 wPnvrdWGucfdONsVCSSOfG4pRkCX3q0baQkbZYESdLiNn9yFnWxil4L+307+RqlPuY
	 cP5fACy1fWBzK+FU2TNTeG2Aqt/MHcgv3EB6o9ss=
Date: Fri, 12 Apr 2024 08:19:56 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fe71fa-6b5447@github.com>
Subject: [bluez/bluez] be79cd: shared/bap: Fix not updating location
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
  Commit: be79cd19c5c5f6b42e40c0edb04d67ab21773f19
      https://github.com/bluez/bluez/commit/be79cd19c5c5f6b42e40c0edb04d67ab21773f19
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-11 (Thu, 11 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not updating location

Fix not updating map.location when selecting.


  Commit: c7dcd064057fb89628c5da55da91dff363b559ca
      https://github.com/bluez/bluez/commit/c7dcd064057fb89628c5da55da91dff363b559ca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-11 (Thu, 11 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Make bt_bap_select fallback in case of no channel allocation

If channel allocation could not be matched attempt to call .select
without a channel allocation as the device might require a different
matching algorithm.

Fixes: https://github.com/bluez/bluez/issues/793


  Commit: 7db85520b76d4acdcea1301dcf80a4ca5f228e1b
      https://github.com/bluez/bluez/commit/7db85520b76d4acdcea1301dcf80a4ca5f228e1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-11 (Thu, 11 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not resuming reading attributes

If there is an unexpected disconnect and some attributes values
where left uninitialized this attempts to resume reading them once a
new session is attached.


  Commit: 9be5d8018dd1b75cb9cf9d206b389049a0515c74
      https://github.com/bluez/bluez/commit/9be5d8018dd1b75cb9cf9d206b389049a0515c74
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-11 (Thu, 11 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Update properties of endpoints

If a MediaEndpoint if found during registration stage attempt to check
and update properties since they may have been updated at later stage
when a session has been attached.


  Commit: 6b544758375c3c68c92cec1e32c83a8ba24e4e59
      https://github.com/bluez/bluez/commit/6b544758375c3c68c92cec1e32c83a8ba24e4e59
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-04-12 (Fri, 12 Apr 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Do not crash in case of adv update failure

The refresh_extended_adv() is used in case of direct advertising
request from the client or in case of advertising properties update
or configured advertising timeout. In the two latter cases it is not
possible to prepare reply D-Bus message, because there is no request
message to begin with.

bluetoothd: ../src/advertising.c:add_client_complete() Failed to add
            advertisement: Busy (0x0a)
dbus: arguments to dbus_message_get_no_reply() were incorrect, assertion
"message != NULL" failed in file ../../../dbus/dbus-message.c line 3235.
This is normally a bug in some application using the D-Bus library.


Compare: https://github.com/bluez/bluez/compare/fe71fa3dfe26...6b544758375c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
