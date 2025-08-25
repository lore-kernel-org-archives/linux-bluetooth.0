Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3A393DF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153051; cv=none; b=LI+CQnXxQD6Jp+v/Nem02POG8i69qcqA/NLOjFlA3oy9l+Yj2c1uKvPfpldfNzUhV/FFlFusoTKLFQnJKlLWpB8Fwvq5kv2uC1zzcgOkkPQ/43qHPh1Od65zq5RVg9I3F0CqcW3UVmwnNdAsTue+sQOTyGmMbZuDx4Oxxcw951I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153051; c=relaxed/simple;
	bh=BO2FFZQ9KAfxe5NTpfE17DzygjzQwWXXhtHbfIv8VFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D0MEYT5rZyfKDMBZYDdybr+iaaDNQSFwY1wVuC1nP6sNc4BtHYh5boXTwApOz4q7PQeNjJN2nIU0fvdUxsv//hjsCusYFQA0SBCCUpCEY6ybMUKgxD1UwZoqYsiVO8EKlQJE9RbCZRCiBjC5iGyLfHzgBhciFHeKQt97p8peKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H3znshzN; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H3znshzN"
Received: from github.com (hubbernetes-node-222d189.va3-iad.github.net [10.48.133.37])
	by smtp.github.com (Postfix) with ESMTPA id 46E908C0763
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756153049;
	bh=ZQ1S9nXRv85ZZ6eff/v6UQ6mQlBDCsUEd6tvgbWQEpc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H3znshzNIcB7Erzv3nYaMXkX5tblGZ2fjq3gTEcnUfsaW+1T1JkivbwJuS0KxEh9Q
	 PtsGjxe+LVXkcAkEzxM2c7ShoAUYhvmaXBH5pkhWuUAOgKqDJv3O/+CA3vUCpoxoTf
	 1iracgNAnHvgEcYnvoghX53BkkgRcXKt3c97wwCY=
Date: Mon, 25 Aug 2025 13:17:29 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3acfa2-f911b6@github.com>
Subject: [bluez/bluez] 61c49d: lib: Add missing includes in bluetooth/hci.h
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 61c49dfa2e8d4a1eb0926ae5fd8cde38ac01c74a
      https://github.com/bluez/bluez/commit/61c49dfa2e8d4a1eb0926ae5fd8cd=
e38ac01c74a
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: Add missing includes in bluetooth/hci.h

Compilation fails when using bluetooth/hci.h without other includes.

/usr/include/bluetooth/hci.h:310:9: error: unknown type name =E2=80=98uin=
t8_t=E2=80=99
310 |         uint8_t         lap[3];
    |         ^~~~~~~
...
/usr/include/bluetooth/hci.h:383:9: error: unknown type name =E2=80=98bda=
ddr_t=E2=80=99; did you mean =E2=80=98daddr_t=E2=80=99?
383 |         bdaddr_t        bdaddr;
    |         ^~~~~~~~


  Commit: f911b6df4fd1462d9718bcacced508cad03ce4d1
      https://github.com/bluez/bluez/commit/f911b6df4fd1462d9718bcacced50=
8cad03ce4d1
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Add missing includes in bluetooth/hci_lib.h

Compilation fails when using bluetooth/hci_lib.h without other includes.

/usr/include/bluetooth/hci_lib.h:21:9: error: unknown type name =E2=80=98=
uint16_t=E2=80=99
21 |         uint16_t ogf;
   |         ^~~~~~~~
...
/usr/include/bluetooth/hci_lib.h:182:27: error: =E2=80=98HCI_VENDOR_PKT=E2=
=80=99 undeclared
182 |         hci_set_bit((t =3D=3D HCI_VENDOR_PKT) ? 0 : (t & HCI_FLT_TY=
PE_BITS), &f->type_mask);
    |                           ^~~~~~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/3acfa2d50a9f...f911b6df4f=
d1

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
