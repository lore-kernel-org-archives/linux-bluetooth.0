Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04814D717
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499438; cv=none; b=CZ3cpYQe/o6sm1OjbHQkVe1u7zk248h3jMvOtuz/h4b9WXNQJkTJ8oXFsn5mgjmkrZbcnRy07Br7BQf3xp+vZuglHRPvL7PSZXRjIVZtCtb4fo2MoSvWj2JJJxuA5C7i+VGfvnHyCCuEVkM0Qs8byjhZTnP/oBw2B8P7z3sIzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499438; c=relaxed/simple;
	bh=PcXlr1dHjy9mXmYM7pgF+LzNOnFRcBLQ0XiGtAxaKuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aXfd5MuC7kcJGPjTqHzzvzPvG1Ev1FLyZsTFQuk9c1X4FwRTKeoCDmxq2yVUByKvrQi+aEMcO90m/YsnSu1KdSszw5O+Q4jvAb61mam9sAzCFYl7Jkb6vJmuK90ELdNT7dd3KfSebp8Mi9MoKYJPQKQCpja+E/blo1cLcw//QnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmPYL2nA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmPYL2nA"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2975432b8cso4328922276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729499435; x=1730104235; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PcXlr1dHjy9mXmYM7pgF+LzNOnFRcBLQ0XiGtAxaKuY=;
        b=FmPYL2nApG298ray88U3rM72FFAOXHts4zDLZQFZbigUB6Y7pYizHTr9/EsMBFhCCb
         jiBkaysyhFtaxPflN2adv2wjK/XDoRKjD+XlGhEXNZAcsY/CFhjb9AOLDvM2/V8lzs5Z
         gYjYwv+IEblMQc18PLEsnSIDrCQyU+T8w6XWHLTo4wkRddczx8CB81aPwaI6G+qowp8Q
         4zY9UL7jL3gPP+R7XmMylmDPbPobaR2SaqSOJ+TQxk4kkqf3HWq3CuSkWT7FYTgQyBxW
         xZpw0PzyjhtmmrT0mgutUXbViu+f0QGWf2K0Y29OLcnwHdkmiXMWj/r1ChL25Z8WGcow
         w25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499435; x=1730104235;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcXlr1dHjy9mXmYM7pgF+LzNOnFRcBLQ0XiGtAxaKuY=;
        b=mAEuhAhLa7L4cvXHjL/uAMq6H/EvpRyblT9LOP1yr78R6xnCmrvkojUv8j06bWIAsa
         DquXg6uQu9GnSC+Z+xlnxfUHLXTT48LscNEhVApwTvivpwG2zyUXfMMkigSAdDYz8cGs
         INPARSjkmuR1vAyl55CatzMrP7GSrlH1iVHiNVN4jajIQ3BCR5W5NDvhdFuS9hZq5gaK
         6q5HXaKqklT6/KZEPKRYoGtVg4ikOfjEWd1gV8/3syFI3+TyY+uQVGRyHwoKY+XDOadc
         IYKj+K59qxIcR4uVArb4ACh6uz8cos+2dkBngcbzTXCaKyJq6QOt15jNXj2tuO3iMLfC
         +6kw==
X-Gm-Message-State: AOJu0Yz1JuwFeXUVye3sp6jYid32kzCBEamBqOFoFSS3Wk5IA30cGNl3
	eDBzI6XQv6xUiVShiupVfjzw/hgMvVBB2SkheuQr1Toviw8NEoclwK8+eW9NL/E/ZrF2yTurBtY
	R+F3kY39Yc3ahfOfE8ehIZa7hdrgh/FLgPKM=
X-Google-Smtp-Source: AGHT+IE/QQ3/HgpmeR6YfP0QExkoycyicQWyXpdaJgIX6E1juIj6prD+0nClKyryWXpcIKjDKtSHTG8KSfRfqVUbOeU=
X-Received: by 2002:a05:6902:1883:b0:e28:fc1c:eb4f with SMTP id
 3f1490d57ef6-e2bb1699639mr8701882276.45.1729499435252; Mon, 21 Oct 2024
 01:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilias A <akhmedovilias38@gmail.com>
Date: Mon, 21 Oct 2024 08:30:24 +0000
Message-ID: <CAP+CqKmR0YLCKYVzJtr8Saguc7WOCJPjNVAFQhOsx1FChsKsGA@mail.gmail.com>
Subject: BlueZ Mesh bug - doesn't send or receive messages with kernel 6.x
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Last year I've raised a bug ticket related to the issues with sending
and receiving Bluetooth Mesh messages when working with Kernel 6.x and
later. Can you please provide the status on whether it was fixed, and
if yes, in which version?

Issue raised on Github: https://github.com/bluez/bluez/issues/561

In addition to that, I've observed that when Mesh works on kernel 5.x,
there are significant delays with sending messages when received from
high-level applications (mostly when there are hundreds of messages
flowing in and out). I know one of the devs said that operations with
kernel 5.x won't be mostly maintained in the future, but because of a
bug with kernel 6.x, I can't check if this issue exists there.

Kind regards,

Ilias
