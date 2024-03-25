Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015412D1FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711330492; cv=none; b=J0zms5cGrNOSJADD44W9nWHnlf7Y65EkH2Vaz+UkWlt0G6XJQg2WScrliaGQyZLTYmDiqfVW9+A0mnw7Ms96AmK4zGXIZ/AYI+ctEogPwdGzzxM6h6j9seEbCtg3XAbWQI7/y/UQufXwqruM9QZ71+J5NG+zED45ymNBl6gu8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711330492; c=relaxed/simple;
	bh=BGZbC7h7gpJzSiWVPruUdq/u1I/jzbdACS5FiX1sRz8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YwHUeD2ydGU+33QHMbAeLuS4b6aRPYzpwP3o7hlBiUoevn4qWgFdRNWDqIUESJ4iCGXB3h9A5eNYCCxqj21JEN34ZBxVHalNRRJ6HeodHTmepKFM2Q7E4JqwN/YsMyf6rzp253356MWJY4wfIN35aDc3B1EJ5CWUdTARBcPE1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixijpQgi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixijpQgi"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2867059a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Mar 2024 18:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711330490; x=1711935290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjkFkg3nnsjCDPa116dhGOjuMI9Qbb0OvHHWu23MQBo=;
        b=ixijpQgikvIHoPiKZo2uE27Hpn7owqrXzR62r9gjZVMSx2KYuF57jMu1Nmf55pbWrU
         WgfaD+j15r7ynMEq8zEhoq+7KktryroHCzaM192hMTkmPgg9BbfLvTU46xdQ9WEB1utZ
         vgbd1N3zUQk43om4rmJ4xCfYA7V5qZigTOVhUyRWLV6fS8vCO+Htdzc6sK/E3Jg4UHnB
         dt6cQrVj4Tts76y4tt27dl/KHrnFy8cf1+A9N2z6j1WXAiWB1YL/CWkOweNXR444X/Xf
         1VobSvBL8Z8Z03/covbUO2/2hzdCyMI8UfssPUYisBalNZbR7mnOHRh/S+r5poRxqNFm
         YzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711330490; x=1711935290;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjkFkg3nnsjCDPa116dhGOjuMI9Qbb0OvHHWu23MQBo=;
        b=ru1dHbAj2dNrp/lzq1AiWY0jyvYk/CbPESUstahZ6SdSj2lRIQ6YPImS9Vn5FpTzZ8
         /o2V2hFOgE4MqIyNcy8yMubxO89fxOQPQNdpRuGFzts9MbZEFCoPX0pR5n1m2N6B+zGr
         K6Xw35Vu4dkedSvcbVYufNuOfy8rQ3yOkWWkIumika+9THGA6pBucdyh0ArbSGiviCHP
         ozopyBWalpy53ZcVO0Yc0Meu+4ECokTw6Wcm6nr16kP4FPCDJRIGyB4TM4vGejHGsWwp
         a3daKCZO5jkNRTUS8aZNhR71gw/5SKxZEeScVrqhkSoMeIGQU1ds9/lzQQCk5bolcvzY
         GB0A==
X-Gm-Message-State: AOJu0Yy/vf+F+CleHrXfm2dyqcP9R+EvSFLz8ubZb7TU70qx3woZv4fH
	2LolIIbV+pHRtzC/1oQ6KN0HpZcPLhVGGZfLCEpJvUyrzobW5zzGoeTiQlFNH9izVZA1dEbIvpV
	bMJ+Hbdx4My40+/D64UGawY2X4NG5G6hxPo8=
X-Google-Smtp-Source: AGHT+IF3wKGKAivSfMTODTLKTw/l2ilb9hCZkb7VIdTjz/seSDlb4IcgG0ebDQ2YqkoOf+WjwLZ7sSrrsZZEEOKS2qE=
X-Received: by 2002:a17:90a:bc8e:b0:29c:5b1b:f75c with SMTP id
 x14-20020a17090abc8e00b0029c5b1bf75cmr3315236pjr.47.1711330489946; Sun, 24
 Mar 2024 18:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Genly <chgenly@gmail.com>
Date: Sun, 24 Mar 2024 18:34:38 -0700
Message-ID: <CAKHr629iZ00UgNwAG9JtaKzh_59t5BUwV1AL8CRmdZ38=F5ULg@mail.gmail.com>
Subject: How do I use bluetoothctl's gatt menu to make an RFCOMMM discoverable?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

have a very simple application that I've spent way too much time on.
I have a Raspberry pi 5, I've created a bluetooth serial port using rfcomm.
Now I want this new serial port to be announced by the rpi5.  Conceptually
simple.  I've spent time going through the bluetooth spec, and reading the
serial port profile spec.  It took some time to track things down, but I
enjoyed it and now I want to put my knowledge to use.

The bluetoothctl gatt menu looks like it has exactly the capability I want.
But I've had a very hard time understanding how to use it.  I haven't been
able to find good explanations or many examples of how to use it.

(1) Can anyone point me to examples and documentation of bluetoothctl's gatt?
Maybe I just haven't tried the right search terms and there is a trove sitting
out there.

I tried looking through the bluez user mailing list.
  http://news.gmane.org/gmane.linux.bluez.kernel
As referenced from here
  https://www.bluez.org/development/lists/
But I'm getting server not found.
The list at marc.info works.

I tried reading the source code for bluez/client.  But It's hopeless. I learned
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
- continue by adding a characteristic with register-characteristic
- If the characteristic is a list, add entries to it using
  register-descriptor.

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
     and write.  Pointers for docs?

(6) Are there any other steps I have to do?  Do you see other
    glaring misconnections I have?

I think bluez is quite an amazing project.

Thanks
