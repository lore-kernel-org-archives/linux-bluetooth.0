Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E84242927
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620188; cv=none; b=PbAOA4z6PfB0OQCMdwAgveJnh+vgqU7FFGGySt1GDNfiZZiGAUI9y+4AcHMRAnbZMr2fQa5wORr8OYMdJqicYDg0ILQrVGXpk3UYVSTLnIUJivaWMqwoQhFpBjqcfSkpTtg1XZkMS/q/zcLckwaWnWHU43umLKYqLBDvDIZhqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620188; c=relaxed/simple;
	bh=qQzV8hDH6uNDpXRdIaf+xblSmOhzbSTJz4hFtUcNdrU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OkPk0jzQh+UiHDXqQ1QUZKMBLydUawLFixwWPSOXlyHAxX++bCAFMOYlZh2iOzXzHZ/ded4TVUInKnGyL2Hz+BaAAFkgt1fT0Q34N3r2p6XWKn6fsmjuEsLouyZzL9+NS+wQfp951qyQv14Mrn2X54Z2XXM/ZS3p2mUocdgOzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OmqrPeR3; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OmqrPeR3"
Received: from github.com (hubbernetes-node-7a93ea8.va3-iad.github.net [10.48.133.35])
	by smtp.github.com (Postfix) with ESMTPA id 28A97E0DE2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757620186;
	bh=M84aetAeU3aWC0ymH3+bBRFLK0aCj2K2OX3OmyOotzc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OmqrPeR3XjyEXmY+GGm7yY77KCFE0/GuKRdkkYgAHyj7NzC6KgxEJ9U5MSrMatJUJ
	 8YRA2HiSTfUn8z7l3sTQuCPU6J82fMBbYSK2OYG9BGIEWhd64xUfYdLPmSj8IEeA2G
	 9GZtU/d1ix9Ngp3DIXdUPlfoM8mDSoOm0OnmSqtQ=
Date: Thu, 11 Sep 2025 12:49:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/441f95-befdac@github.com>
Subject: [bluez/bluez] a887b1: audio: Add support for specific error codes for
 A2...
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
  Commit: a887b1a1b91fcb7fc1ddc052cafe1818230d97db
      https://github.com/bluez/bluez/commit/a887b1a1b91fcb7fc1ddc052cafe1=
818230d97db
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/avdtp.c
    M profiles/audio/media.c

  Log Message:
  -----------
  audio: Add support for specific error codes for A2DP configuration

The A2DP specification defines error codes that shall be used if
the codec capabilities contain improper settings. This change allows
clients to trigger the sending of these specific error codes by
returning the corresponding error messages from
MediaEndpoint1.SetConfiguration.

This update is fully backwards compatible: clients passing other error
messages will continue to receive the default error code as before. On
older BlueZ versions, these new errors will also result in the default
error code, enabling clients to implement support for the new errors
without breaking compatibility.

This change enables passing A2DP/SNK/AVP/* and A2DP/SRC/AVP/*
qualification tests.


  Commit: befdacd236c3a761d766da9f95bd7763cd216425
      https://github.com/bluez/bluez/commit/befdacd236c3a761d766da9f95bd7=
763cd216425
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2025-09-11 (Thu, 11 Sep 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: Document error codes for A2DP MediaEndpoints


Compare: https://github.com/bluez/bluez/compare/441f95a9c146...befdacd236=
c3

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
