Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66266D27A
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393615; cv=none; b=VTBu+z+NTXkSRudGlujeAh9bl1W52Li1UwLdcyhMAoJ8nO1K760QNB6+rqSlD14XycYzlAWhBAhbML/Do24Mh/vvAICfu8AzpaPsDzG4iwyfKyiF7iZX+ptUeNpN9Nb8Cpqyij4/d1t04O0ipVwYie3UFk1Gqgh9yhz+j5OcQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393615; c=relaxed/simple;
	bh=upXl6DWwI+BYQ1ee4lbEsBXIZN47l5SoVcymkibaoPg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b/CqOQg0CjiHSz+LSdD8pvFNC3m1s/TChoRcVPg1aNO6Mbv01JiyXIxajKnS/xrwJiOk8Wfenaq4YtvZWjNG0oZCeTB1j4tno7Fj1eBPxEXQ3zbEACYg9cxw+/Tlga2hKT6786VImbEghxAOv6qpE9AZkdD/ZvvwGInCMT5ExJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsB0rGQO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsB0rGQO"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2933793a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393613; x=1711998413; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/hhnXXyoP79Jf7ZPC/HKUdhyV3cIkzLRkKvGi9Nugs=;
        b=RsB0rGQOtHOUyenksut3UOB5ytA4NhEO655xWnGjnoB8F6lydFF2RMnQOeL3/KLjzL
         93+Z0Mbwj6QOkvx/l51/afS1ymvnzW00S9fi6APIyGe/s8ilqBWfZ1Io8YYCGFYVLAbA
         P7z2Y/gf60+KdKpouLLDjhIv6im49jw16MRYhCZKYL4z0R8gJ3kNLuae/bM1HkOsFQWe
         eS3SE778cd675sZ/BR2mtiyHFFHqTDC55/ejEdYW7n19SMdKh6eF7oJwFeHKwM+SM7m1
         U/4HXt7QmYRuhBY5rPAP9yZElwrFeyH18VQpdkGOW+JKmNVglgh2cGyq88ysqRhAYYk9
         gv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393613; x=1711998413;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/hhnXXyoP79Jf7ZPC/HKUdhyV3cIkzLRkKvGi9Nugs=;
        b=j31TFmNhKz3sYaUk4cNKkeOKZ0q31LKRETvBkCUdLVBM/2vPpmaTdarWcWTaz/IbT2
         Auk442F6Wv0fmR7RCSg5xI/QVvBEApy1kwL+DCQ/g5edJH0vFwUXA1dYNu4W/m8CXAOX
         g1/v5eEwfsDsOVstATH2jnKXl4GgbvG5u160dWDzeM95nacRnz4zZwLYApyhMfxw/AhW
         9aFJGDo1FxwUPyTcMFNPhKzzh/L1eVxV2c6K6rCdYHgGBwNBuZA3YXPRlXpm1MLslo2t
         B1PWR7Fr50ibTsyDUSFKOE3UGH8JNlQInufIrjyHPYroUYF84K5x2CIkIyZtYrxOwZ5/
         XZGQ==
X-Gm-Message-State: AOJu0YzaTaG0OFWv/WpIXRsdCbePa+Mq2z8zGslJF4faWtzSId4APZrL
	s5FaUZiumdxMdxUkT6t3cjF45oyDovS3VzZE8iYQcmLaOKpVcA+VWaJvQ77ibPXRqLXP0MmY+ox
	J+IyYP/d5/cP0PxvhO4uGyPwfLY7LWIvMZe8k5Q==
X-Google-Smtp-Source: AGHT+IF/5vlZN2/bF5p2mONcwBK7YPaUkSdw5z7MlnqXU87WHa2LthkNSbPu+IbzB5PGCB6wwIykcVV8bKhxP5D/x2Q=
X-Received: by 2002:a17:90a:a590:b0:29c:570d:7f5d with SMTP id
 b16-20020a17090aa59000b0029c570d7f5dmr11269557pjq.9.1711393613410; Mon, 25
 Mar 2024 12:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Genly <chgenly@gmail.com>
Date: Mon, 25 Mar 2024 12:06:42 -0700
Message-ID: <CAKHr62_BGpOfnboBzWPnstr3fosr3Q-_ypMBQP0vn9PoA3fR=Q@mail.gmail.com>
Subject: How do I used bluetoothctl's gatt menu to make an RFCOMMM discoverable?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have a very simple application that I've spent way too much time on.
I have a Raspberry pi 5, I've created a bluetooth serial port using rfcomm.
Now I want this new serial port to be announced by the rpi5.  Conceptually
simple.  I've spent time going through the bluetooth spec, and reading the
serial port profile spec.  It took some time to track things down.  I can't
say I understood everything, but I enjoyed it.

The bluetoothctl gatt menu looks like it has exactly the capability I want.
But I've had a very hard time understanding how to use it.  I haven't been
able to find good explanations or many examples of how to use it.

(1) Can anyone point me to examples and documentation of bluetoothctl's gatt?
Maybe I just haven't tried the right search terms and there is a trove sitting
out there.

I tried looking the bluez user mailing list.
  http://news.gmane.org/gmane.linux.bluez.kernel
As referenced from here
  https://www.bluez.org/development/lists/
But I'm getting server not found.
The list at marc.info works.

I tried reading the sourcecode for bluez/client.  But It's hopeless. I learned
a few things, but the effort is too high to find what I need.

I found blues/client/scripts.  That was helpful, but there aren't enough
examples to answer the questions I have.

I've found a number of docs like this:
  https://ubuntu.com/core/docs/bluez/reference/accessing-gatt-services
but they don't go into how to create gatt entries.

From the serial port profile doc,
https://www.bluetooth.com/specifications/specs/serial-port-profile-1-1/,
I want to declare the following information.

ServiceClassIDList(0x0001)
ServicClass0 UUID  0x1101 == SerialPort
ProtocolDescriptorList(0x0004)
Protocol0 0x100 == L2CAP
Protocol1 0x3 == RFCOMMM
ProtocolSpecificParameter0 1 == channel #
ServiceName(0x0000) String "MySerialPort"

From experimenting, I gather the gatt menu uses a nested strategy.
- Start with register-service
- continue by adding a characteristic with register-characteristic.
  You can't add a characteristic unless you have a service.
- If the characteristic is a list, add entries to it using
  register-descriptor.  Again, you can't add a descriptor unless
  you're working on a characteristic.

I tried
    version
    #Version 5.66

    register-service 0x1101 #(Serial port profile)
    #It asks it if this a primary service, I answer yes.

    # Here I'm trying to start the service class ID list.
    register-chacteristic 0x0001 read
    #Ooops, it is showing SDP.
    # [NEW] Characteristic (Handle 0x0000)
    #   /org/bluez/app/service0/chrc0
    #   0x0001
    #   SDP
    # And it's asking for a value.  What is the value for?
    # (2) What I'm I misunderstanding here?

    # Now I want to add a descriptor to the list.
    register-descriptor 0x1101 read
    # [NEW] Descriptor (Handle 0x0000)
    #    /org/bluez/app/service0/chrc0/desc0
    #    0x1101
    #    Serial Port
    # [/org/bluez/app/service0/chrc0/desc0] Enter value:
    # (3) Do I want to specify 0x1101 again, it was already
    #     used in register service?
    # (4) And again, what is the value it is asking for.

    # I would then go on to add other characteristics, but there
    # is no point in continuing without understing better.

    # If this had all worked, I would do
    register-application
    # And the service would be available for other bluetooth
    # devices to see.

(5)  I also don't understand when to use acquire-write, release-write
     and write.  Pointers to docs?

(6) Are there any other steps I have to do?  Do you see other
    glaring misconnections I have?

I think bluez is quite an amazing project.

Thanks
