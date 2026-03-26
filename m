Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56C245014
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484569; cv=none; b=DSUhmXrwOiHCdMu8wwHIiCL21rVDoTHzoj5S+P0naifP8srhAiP7X6CqL11zqL48B6fIBVMOSTBIy7uDABYYLkSHZIvn7uJvI612z36xgiwINSzkFGC85UoTBtT8fyH1o04XRgrKtt32nMUi0EMUqEVxvBp9up7x1HizEHR/tPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484569; c=relaxed/simple;
	bh=b1AgfsLKCoe8OXLKXgdSHPh3A69VjEzgB/IV7CQLcWs=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=OMHD3Koghf/lf0R/G9IhqWho3w2q9VuKJprgKYkbKSyAXcOTkMfRtGTydXxQIeZFRmN5gs4VjxR/RY2788d6rBiEvB/FbwVDpKlqTxeX99+j5+7Ihftcigi3pqRn+AojBFbDpD2IWy2x++TfbUrdyuQw97+mREzQtGHDw57AJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=Iq74m6yM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwXFUIWq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="Iq74m6yM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwXFUIWq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 256BF1400104;
	Wed, 25 Mar 2026 20:22:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 20:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774484565;
	 x=1774570965; bh=b1AgfsLKCoe8OXLKXgdSHPh3A69VjEzgB/IV7CQLcWs=; b=
	Iq74m6yMLF/Ldt30iwJNxJ8w1lJJDLBFmh5p4Is1GA1yUk1hvi0vgivlGM3b9jnk
	Yqti1/0J4w2rUuREBcruR8tw4eUHlZl0UIFn4Z7TCy9fffhEvKgBvpyjBzNJnUkI
	/1b0cUfnpczt8gjD7YX4LjdfALU8mJgpqYEEChGlu7zREszqZHXRnN0lG/9HEvdm
	yEhdtC/TiDltNXBb1/sSI/7m7MjSlXkeP0IH9AQjiK1uo0dq27F7Xx1Nquft4hzk
	4iEj/W2hlMgeEvzDLSkEDb/M51JOCQLlv9/BvshR/Js5D9Hp81iS0bEAs3glcXhq
	4OC81hJEE+27FHIHQL7Ikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774484565; x=
	1774570965; bh=b1AgfsLKCoe8OXLKXgdSHPh3A69VjEzgB/IV7CQLcWs=; b=S
	wXFUIWqyBtoJlbFAlKW0Aw1N6FFCQXD2eLA9llhpcD4tnm1HlyA11wgnpkysKjZn
	sC6g116hjksrwnosOFYkg3uLyWZ2yBHAJI12/FKevHEAjTT5n6QOI/MN06HPl/PH
	N/x6fp5t3GWKRXsfsVRr+DoOH9+7uLgsnRuSPB9obfUSkDdFWX53RnEBmhOj3pxh
	NxXlDA4SOL7/UFCpahSRWmWhpOXEcSujc2kKiu8+Ziry+D4+XXpPlfM61xYvHEEk
	9x65BSnZ+kUfxwDlyV6g4aWCPx9xuhKWWAVcu23Cypdr1KbGsmNtpyyuUlqFGGj9
	SmGXQoAkaetLe1UYDOaTw==
X-ME-Sender: <xms:VXzEabBsRgklh1rekjvJnMDZjYIOMwsICC9GwS3_7sR4VOT7U9gO_Q>
    <xme:VXzEacU6cebUBmqIfZFqO-6uMN1siT8mNVzsnqHHXf_n-3I-rBVKKPcmsWS921G5U
    FKqJIS9FTy4hbG-koo9A_ZyR8DUTRt6nPmSkrZVjIyGhnKmgQQwEQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpedtudejffejkeekteelueefvdejvdeuhfefteehkeevtddvleduteek
    leetvdelhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:VXzEadtfxSIM-af72BCWelz93RA0ymec_H7szS4wXsML3Suw8DaDoA>
    <xmx:VXzEaUbb5pEPSuyzl8YbY1ZQiewUmlbxhwnjjMAUwcmC8-imDL-J8w>
    <xmx:VXzEaYW-mkoD9kVBpdFUmHHTc2f25OdgEtUqfwok-G4WxvW8Sv72Kg>
    <xmx:VXzEaQ6IQmGjteY3iYru3AlMZczAaT05YeqpR1S2tzTEiVAXprY6kQ>
    <xmx:VXzEaVFDLZnrHnmpif1fDqLp8IqIdrFAMmkAqtTKrNf8cftOiKEHWB0p>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00F941EA006C; Wed, 25 Mar 2026 20:22:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2026 18:18:45 -0600
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add USB device IDs for MediaTek MT7927 (MT6639)
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: CABBYNZ+PTk5+Dq5p+kHQdmqQshsC1kOzuqqmJtZyF5XAJzLzmA@mail.gmail.com
References: 20260305172813.12F6E1EA006C@mailuser.phl.internal CABBYNZ+PTk5+Dq5p+kHQdmqQshsC1kOzuqqmJtZyF5XAJzLzmA@mail.gmail.com
Message-Id: <20260326002245.00F941EA006C@mailuser.phl.internal>

Hi Luiz,

On Thu, Mar 5, 2026 Luiz Augusto von Dentz wrote:
> Let's gather their emails and list them as Tested-by, or perhaps
> we it should really be multiple changes to make easier to trace
> back how it was tested.

Done. v2 splits the USB IDs into per-device commits (6 commits),
each with its own Tested-by trailer from the hardware owner.

> Ok, so Id probably require 'Tested-by' to be a human, and in this
> case, I want the lsusb and dmesg | grep bluetooth either directly
> in the commit message or as a Link so it can be verified.

Each USB ID commit in v2 includes the full USB descriptor output
from /sys/kernel/debug/usb/devices. All Tested-by trailers are
from humans who tested on their own hardware.

Tested-by coverage: 5 of 6 USB IDs have trailers. The one
exception is 0489:e110 (MSI X870E Ace Max) where the user
confirmed it works but has not provided a formal trailer yet.

v2 is sent with all requested changes.

Best,
Javier
