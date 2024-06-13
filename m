Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F614A098
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300163; cv=none; b=CPmK0xTI1gCPb+Y8v4freuMBzppgVxxxgKH3gP79ryOuj2N0P21ga7ew4b63SNegSuYpT2EUomuEy9T00ukWOY0x7hvS43EuQ7vugDp9l96KG4t6JfrbpqPn+aBDL9T8qJQSjxg1oJ1vQtL6pfb+QrEWU/vXPS1QwSO/0TFBBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300163; c=relaxed/simple;
	bh=Ok4RNWSPX0DQbmszGJbHz2xLGx7oU8wqpXvYf7dOzmI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cORBQ6ozbiMmCBHrSJk6sOe4aZN3K76mMYeUolCOtUWQ4J5jHXgj2dwqEYVXw/C8IHh48pAithz9BMDDPNeIfj2RQywmUyossRAoTsEt8q73aL+JEB905St+b/NLtOxZbKSen7ZsAzymG/gVnKqcea9brZIzDWyhtpAgbQIFBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CWctTDsv; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CWctTDsv"
Received: from github.com (hubbernetes-node-85c6ce3.ac4-iad.github.net [10.52.13.23])
	by smtp.github.com (Postfix) with ESMTPA id 906255E075C
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718300160;
	bh=cIsRmaw2POfBE5f5s59C1vUXRd/FwIOvihLkfGUZxqw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CWctTDsva+UMLBH4p2Ekl0pa6uhrcLhHTwzJGFd+JTz6gZmyewMzAFFGbXK1Isk34
	 8Nzg9ebdASgdY5yW4BGk+zqHpGKePd2vnQCJR0BHb9BhACJQyBZFvKMW1UgfGIQPTf
	 hu1Uufhg6ckQkvWqw28rvdbLPbYpl6WfAopJT62o=
Date: Thu, 13 Jun 2024 10:36:00 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/891552-792cff@github.com>
Subject: [bluez/bluez] 7861c5: client/player: Fix transport.send
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
  Commit: 7861c511ca7ecbbf8223aee22a3085d6152799cf
      https://github.com/bluez/bluez/commit/7861c511ca7ecbbf8223aee22a3085d6152799cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix transport.send

This fixes the usage of getpeername, introduced by 04153538aaf4
("client/player: Fix using unicast QoS for broadcast"), without
initializing optlen which causes the following problem:

Unable to send: Operation not permitted (1)


  Commit: 8e4bece63ce91f2debc9468a793f2c65e41c5bb2
      https://github.com/bluez/bluez/commit/8e4bece63ce91f2debc9468a793f2c65e41c5bb2
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    M Makefile.am
    M lib/uuid.h
    A src/shared/asha.c
    A src/shared/asha.h

  Log Message:
  -----------
  src/shared: Add initial implementation for an ASHA profile

This implements the server role for the Audio Streaming for Hearing Aid
specification[1]. Includes basic ability to probe the ASHA GATT service,
as well as starting/stopping streaming.

[1] https://source.android.com/docs/core/connect/bluetooth/asha

Resolves: https://github.com/bluez/bluez/issues/481


  Commit: c26389c466a0e7010acd245adc7a68b5178ca1d8
      https://github.com/bluez/bluez/commit/c26389c466a0e7010acd245adc7a68b5178ca1d8
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/asha.c
    A profiles/audio/asha.h
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  profiles/audio: Add an ASHA plugin

This exposes the ASHA profile implementation in the previous commit as
an audio profile.

The implementation registers a remote endpoint using a subset of the
MediaEndpoint1 interface, without any mechanism for setting/selecting a
configuration, as this is all static in the spec for now. Also exposed
on connection is a MediaTransport1 object, which can be used to obtain
an fd to stream to the device.

Resolves: https://github.com/bluez/bluez/issues/481


  Commit: 792cffb4992dee18ec4a8f3423c9a3c681c828dd
      https://github.com/bluez/bluez/commit/792cffb4992dee18ec4a8f3423c9a3c681c828dd
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    A test/simple-asha

  Log Message:
  -----------
  test: Add a script to test ASHA

Plays out an audio file to the device. Depends on GStreamer for media
file reading and decoding (specifically, gstreamer core,
gst-plugins-base, gst-ffmpeg, and gst-python, or equivalent packages).

Resolves: https://github.com/bluez/bluez/issues/481


Compare: https://github.com/bluez/bluez/compare/891552999317...792cffb4992d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
