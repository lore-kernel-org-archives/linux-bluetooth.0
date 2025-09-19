Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34632FF67D
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271003; cv=none; b=BAVherRs5zKIhFdU5N9gM51tc+QCSrWydxmbPzr8AsZOLLJD+RUIbg1FWuGQYkZ6FjufiSrWHq1qldahy2RcI7TpIUJ/YdK19JX9w9MhrTY9yth/89opwC2LxH59VxI79k9eGQ59GMrod/BXoJgwjZ5dvkFKIj0OTXZruy3yPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271003; c=relaxed/simple;
	bh=7lWA6IJlDFqXHpymBtCjDW7YI3uPcTh5qY/ryeQPJRE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OLnXwU9wQ6eZgchJp7dVq8ZZYnhROdf/GqdhKkLN4fWtry5ps3hvaGoUd8sqPOuEjunSi9qKT4KEW5n6xEyAN+A0Wjn3m8YcL6yEKYUX1J+FkX3ECo6sMoUzxbmJ8HxHbKmoyCBuL0oefSILd0zT/Qf9fcqIlQrcrjD/JRvMddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fx6vw00V; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fx6vw00V"
Received: from github.com (hubbernetes-node-ec1602c.ac4-iad.github.net [10.52.180.34])
	by smtp.github.com (Postfix) with ESMTPA id 108DB7005EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758271001;
	bh=ocyeG6irew5ysRAIYmwz/UwlntODw8kSfdbTtaMGNwE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fx6vw00Vcj5BrXR092bMlUfskHPwJ4qAJvaXVBPyhEJ4MxkVQhp7guXmvtZfB/iTb
	 AYxVj6eR6pE6RVy2S96LqUtYKTirNXd0NFjhIpAXc1HYE6R4kxXTiNhfvomNRdsBW6
	 2lOdYOGNa7a+v4n39cJq5bcTsUEI+NBp+cGFfXsE=
Date: Fri, 19 Sep 2025 01:36:41 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004133/000000-33e7ae@github.com>
Subject: [bluez/bluez] 4d9636: shared/hfp: Add Call answer support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1004133
  Home:   https://github.com/bluez/bluez
  Commit: 4d96363ea28d66becdddcacc023b54854ce46d4a
      https://github.com/bluez/bluez/commit/4d96363ea28d66becdddcacc023b5=
4854ce46d4a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Call answer support

This also manage the +CIEV:<call>,=E2=80=A6 event to create, remove or up=
date
calls.


  Commit: b4089c456cb595fb5fdeac76aa7ddde79811a7b8
      https://github.com/bluez/bluez/commit/b4089c456cb595fb5fdeac76aa7dd=
de79811a7b8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Answer Incoming Call tests for HF

This add the following tests:
- HFP/HF/ICA/BV-04-C
  Verify the incoming call is answered from HF, no in-band ring.
- HFP/HF/ICA/BV-06-C
  Verify the incoming call is answered from AG, no in-band ring.


  Commit: 5f5d1bafcc1891208b72bf7957368cee3dd907ed
      https://github.com/bluez/bluez/commit/5f5d1bafcc1891208b72bf7957368=
cee3dd907ed
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Call hangup support


  Commit: 57d12dc73e8f9e62b406173ff2ff8ee0f119851b
      https://github.com/bluez/bluez/commit/57d12dc73e8f9e62b406173ff2ff8=
ee0f119851b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Reject Incoming Call tests for HF

This add the following tests:
- /HFP/HF/ICR/BV-01-C
  Verify that the HF can reject an incoming call after being alerted.
- /HFP/HF/ICR/BV-02-C
  Verify that the AG, upon the corresponding action, rejects an incoming
  call and properly indicates this event to the HF.


  Commit: 33e7ae8f480f7f42f16dcbcb7a60dff060c26fdf
      https://github.com/bluez/bluez/commit/33e7ae8f480f7f42f16dcbcb7a60d=
ff060c26fdf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Terminate Call tests for HF

This add the following tests:
- /HFP/HF/TCA/BV-01-C
  Verify that the HF can terminate an ongoing call in the AG.
- /HFP/HF/TCA/BV-02-C
  Verify that the AG, upon the corresponding action, terminates an
  ongoing call. The AG then indicates this event to the HF.
- /HFP/HF/TCA/BV-04-C
  Verify that the HF can release a call after dialing and prior to
  call completion.

/HFP/HF/TCA/BV-03-C (Verify that after a call is terminated from the
remote party, the HF receives the proper indication from the AG) is
similar to /HFP/HF/TCA/BV-02-C for the HF side.


Compare: https://github.com/bluez/bluez/compare/4d96363ea28d%5E...33e7ae8=
f480f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
