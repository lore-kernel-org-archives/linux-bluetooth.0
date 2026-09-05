Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F936403A
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641784; cv=none; b=YPyQ2pkJE814a8sjpk6oA+P6NTri1EWH7i/ebvAi5HJTgvhXlLqAGuVvHwklLMuxPAFVtOBIF6mQBsGZGyKGAwPs3/MUGnkcCp6l3gyxPNOnsUsR81R3gLQ5fiM3siO4Pu58hZ6jSMOFi6SenqiBAzfl2QC5lMxil5THCtGz/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641784; c=relaxed/simple;
	bh=UdhsdI7QoIR46KU3cOKbYBI+5MnwDo0BiW+VrCUc4M8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Ccm8oZuDnGB3wQXwRa9e/ST24q8JiMvBYghuP58r7UdqSQu8RpQNN19nlnspaYlwcb1NIQKdpXEe3ZomFIjaIF33seC9sfSrWm1fhE/BNJyKxb9E0seb47i+bHBSpgZlj/+FXo7vZZArkR+9N4LT6h0BSTcWwETA7k/Gmmee2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SqLCc/kZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SqLCc/kZ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hclxH1G01zKvff;
	Sat, 05 Sep 2026 22:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788641779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PTLL2XvKuCw5eSeHezW8kB36G5YR0ID4o9TiGFewKas=;
	b=SqLCc/kZsuGHU8X/mQqFZyfHpRqCQ1xplGS6jxM5Xgn7UV/G6OlMPBNqwaAsZhz1k/7bDh
	t2HPSkeJbLoBvubhMWDnT6+tdZWnlJgj1oAHpdlxzfdrS2xGRALNIDtEx8YWZaTzpANmTa
	8Jkzo86hYz3m6ze8tfwPTVRhvbrnW4FkFWKreMd/N+/qDxdd16+PNXEiPjFlPIusI8vXKJ
	MvAvSkT/amqSO4iNOE+yAoe20iLLgeAWZD19wEaZvAGDvUTq6y1DizevccRXgWgdD8euTl
	1eHvCXpb9CEbRLgklcljXMA1ufxhgf5LqKOzdTsGXqfp3vnMpYZUX+zKPrVqwQ==
Message-ID: <72098331-fa7c-443c-8b56-7671f9d711f2@mailbox.org>
Date: Sat, 5 Sep 2026 22:56:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Gerlach <fedora-bugs@mailbox.org>
Subject: [BUG] btintel_pcie: Intel BE211 8086:a876 requests unavailable
 ibt-0190-01a1 firmware
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nw99nr5sz4gqnjzopccyxgta8qbj66mi
X-MBO-RS-ID: bd87b13f6b477912eae

Hello,

i am seeing a Bluetooth initialization failure with an Intel BE211
on a Lenovo ThinkPad E14 Gen 7 with Intel Lunar Lake
(Core Ultra 7 258V).

The PCI device is detected and btintel_pcie binds to it:

00:14.7 Bluetooth [0d11]: Intel Corporation Device [8086] (rev 10)
Subsystem: Intel Corporation Device [8086:0011]
Kernel driver in use: btintel_pcie
Kernel modules: btintel_pcie

During initialization, the driver requests:

intel/ibt-0190-01a1-iml.sfi

Loading the firmware then fails with ENOENT (-2):

Bluetooth: hci0: Failed to load Intel firmware file
intel/ibt-0190-01a1-iml.sfi (-2)

As a result, the controller does not complete initialization and

bluetoothctl list

shows no controller.

The issue is reproducible with:

Fedora 44 x86_64
kernel 7.1.9-200.fc44.x86_64
kernel 7.1.12-200.fc44.x86_64
linux-firmware-20260810-1.fc44.noarch

Hardware details:

Laptop: Lenovo ThinkPad E14 Gen 7
CPU: Intel Core Ultra 7 258V (Lunar Lake)
WLAN/BT: Intel BE211
PCI ID: 8086rev 10
Subsystem ID: 8086:0011

Wi-Fi on the same BE211 works correctly.

The installed linux-firmware package contains related Intel Bluetooth
firmware variants, including:

ibt-0190-0291-*
ibt-1190-01a1-*
ibt-00a0-01a1-*

but no:

ibt-0190-01a1-*

For diagnostic purposes, I temporarily created aliases from the
existing ibt-0190-0291 firmware files to the requested 0190-01a1
filenames.

With these aliases, the firmware files were found and downloaded, but
initialization then failed later with:

Bluetooth: hci0: Timeout (3000 ms) on alive interrupt,
alive context: intel_reset1
Bluetooth: hci0: Failed to send Intel Reset command
Bluetooth: hci0: Intel Soft Reset failed (-62)

I removed the aliases afterwards.

This suggests that the existing 0190-0291 firmware cannot simply be
used for this controller.

The same BE211 hardware works correctly under Windows using the HP OEM
driver package rather than Intel's generic driver package.

I initially reported this to Fedora to determine whether this might be
a Fedora packaging issue or an incorrect firmware selection by
btintel_pcie.

The Fedora developer has now confirmed that the issue is missing
firmware upstream and replied:

"The issue is missing firmware, we consume what ever the vendor pushes
upstream, it's not yet upstream, there's not much we can do about that
until the vendor bothers to send it upstream."

This therefore appears to require the corresponding Intel firmware to
be published upstream.

Could you please confirm that ibt-0190-01a1 is the expected firmware
variant for this BE211 / 8086/ subsystem 8086:0011 controller?

If so, could this be forwarded to the appropriate Intel firmware
maintainer, or is there an Intel contact or issue tracker where the
missing ibt-0190-01a1 firmware should be requested?

The Fedora bug report contains the full journal and lspci output:

https://bugzilla.redhat.com/show_bug.cgi?id=2527721 
<https://bugzilla.redhat.com/show_bug.cgi?id=2527721>

There is also kernel Bug 221481 concerning btintel_pcie on Lunar Lake.
That report concerns a separate suspend issue. I previously added
information there about this controller's firmware loading failure.

Thanks,
Mark


