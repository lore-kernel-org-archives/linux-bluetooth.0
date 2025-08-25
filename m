Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8C169AE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150654; cv=none; b=X5rxYha1jlM8LbpY07Ikbh4l+q4zyO5dwl/PiI5BMbMPqUrdpi+sbTvP0p9Ux3V1RYryYFn6v8EWFwjGdB5Fcqf9GG2FbJXL68tUZ5yyqN7UXrGKE8znn3Xf8Id26LvF4Z6qbTsyvkEsEpD3z7rX2Y9Tv2iDNamRVrhlkFnVEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150654; c=relaxed/simple;
	bh=VP/MmBl4El6sFugNq3vFD113B7tJtViq626UBlnk5LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYvGThHJQj3XQ6ctH6+Buiz7ASrstHoaGe7NJcT4358qQPlV7DZirNYdlFwI7DrB+Ueg0Yn+dev8IIyxPKNjqniFIzmr7AnXSw60LVXIvxVTKkng7Q2EcpKCO0O/5gzqNitzG0u2pfMi/HffvV+V9c8onsLAELdlgvgU8m5TVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU+01Hx4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU+01Hx4"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so3703138276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150652; x=1756755452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqx7BY1zpMF2QXPK5ac1dqRffHeFwZ4UVSSPm8dimgE=;
        b=IU+01Hx4xdU8ad8iU+BURhfxmjVl0rMUbBlt4q8mA1J6gJxdvPTjAT5ZWDvj62kUBi
         kCMuK5tKfPwIBboz1sYAI1d0jO0IMCPi909tVt3iewS/KKFfWRxy0fAWx43jaJuug2Mv
         WYhrPHns1rIQ/j98T1xWwrz7rS1212/oA/+gL+a0RtpoYnfIhwLp46LSHNUVrBQy7Qfi
         9llz0E1uBQQmWY6KKJoCS4Q66MmoGrNq+l4PLPKr+5V9jgfa2Z0WpjY31JnEmobQd/G5
         Tcd/mG5pccHdENnqBqYXokNcRUcawoaNfV7KjajBDji06Komx4+eyukPS67RQ3lbp+f1
         TBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150652; x=1756755452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cqx7BY1zpMF2QXPK5ac1dqRffHeFwZ4UVSSPm8dimgE=;
        b=dEOGo5so8ExskMzmLCNDj01JUGdKyx3qC+q2xnRBSc379MCGswej5Pk9r7cB0yQ57j
         kqMi1zZbSGPChwrFlRYpIfD029S39c+CRgaqyDtywZKDpf+k9+i0iaSv+P4iq2d2li5O
         tqrUSCYJFskGG9hgJRTl2ZM3+XVofUknMgortNg8FNmfLzaeetQrj9BHJ+Zxa56Pu3Cy
         5aOzNY1cqTCrGvUHAxHNt254QdfPpAb49fYuvIZduHbPGPbwX+cbs3IQ9Qhlp72dBhOy
         fHjgYkHW6CTCt6sqoeqqIpltmPUMOPB2E9uj3bYYwGC+WV6Q0P8m4JNjhUkxZbUhFrrx
         SAXw==
X-Gm-Message-State: AOJu0YzVGqoYmSkwj6tGDi6BlU0OPGr0sslaMzlQty4TnSZB2aDGNy/m
	WfVXKLGYRE+O8OokZsuj9J1goP2GTqlW2xfmCVdavsbC6IlLMTM+KHPeHxuYNiS3MLDx8qTVnpG
	9eLussAI2qXTaUPtwm80ZOweWyHi/VjF7pnf9qU8=
X-Gm-Gg: ASbGncuRZ8GLjSsWuAq0JTRrQfJr7ZhNHTdsjmI816ICQKPR+/9bbwJ0N61AXDPeU16
	0F6T/RDuslMndLcbgjlJdh1r6QugSXAdh55PIPccvpf56XtmH4s+RI4POlvVemDgpCgBWABsDUs
	tkUlEnZXOmhvh/bfPh4j7mQwLnFPbf2pU5Vl3M+GuGGMktTvTkgS0L948ZdizaOpGIowU1/o3ks
	59kJWVk
X-Google-Smtp-Source: AGHT+IG0uMLog8yXC5j2MEdoeVdhAl3NnaSuw3CuhgA/LOu+U4vvEx1hPfB3c9++LxHvEcVjY+tlT5i5d6yngDDe4No=
X-Received: by 2002:a05:690c:4d88:b0:71f:b944:1005 with SMTP id
 00721157ae682-71fdc427c3fmr151202467b3.44.1756150651571; Mon, 25 Aug 2025
 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com> <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
In-Reply-To: <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 25 Aug 2025 21:37:20 +0200
X-Gm-Features: Ac12FXxr2GXEG1HjFyEhLxzHi4FXK8TGZRCKDbeQiQkln5cEEBCHb8-tUsIo-OU
Message-ID: <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yeah, but that is just working around the extra byte, but it seems
> there is some way to detect that not all data has been read, which is
> why wireshard is only considering the Read Local Extended Features as
> received on frame 127 not on frame 123

I have not checked how the wireshark logic works, but I guess that it
works like this:
1) read URB and parse it's header to get the size of the buffer
2) reads HCI header which tells how long the HCI packet is
3) diccesst entire HCI packet
4) return dissection with the number of processed bytes
5) URB_packet_len - dissected_len == 1 which triggers fragmentation logic

USB capture from my controller:

> 109 7.586834       host                  1.7.1                 USB      64     URB_INTERRUPT in
> 110 7.586985       host                  controller            HCI_CMD  68     Sent Read Local Extended Features
> 111 7.596062       1.7.0                 host                  HCI_USB  64     Rcvd
> 112 7.604809       1.7.1                 host                  HCI_USB  81     Rcvd Fragment
> 113 7.604830       host                  1.7.1                 USB      64     URB_INTERRUPT in
> 114 7.604980       host                  controller            HCI_CMD  67     Sent Read Buffer Size
> 115 7.610312       1.7.0                 host                  HCI_USB  64     Rcvd
> 116 7.610814       controller            host                  HCI_EVT  77     Rcvd Command Complete (Read Local Extended Features)
> 117 7.610823       host                  1.7.1                 USB      64     URB_INTERRUPT in

But this INFO column is not correct. The frame 112 contains:

0000   40 5e d7 04 80 ff ff ff 43 01 81 07 01 00 2d 00
0010   b8 73 a8 68 00 00 00 00 9e 80 05 00 00 00 00 00
0020   11 00 00 00 11 00 00 00 00 00 00 00 00 00 00 00
0030   01 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00
-- HCI payload starts here
0040   0e 0e 01 04 10 00 01 02 00 00 00 00 00 00 00 00
0050   00

First byte in the HCI payload is event type, the second byte is length
0x0e == 14. However, the USB buffer has 17 bytes, which is one more
than the event header size (2 bytes) + 14 bytes of data.

The frame 116 contains:

0000   40 5e d7 04 80 ff ff ff 43 01 81 07 01 00 2d 00
0010   b8 73 a8 68 00 00 00 00 13 98 05 00 00 00 00 00
0020   0d 00 00 00 0d 00 00 00 00 00 00 00 00 00 00 00
0030   01 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00
-- HCI payload starts here
0040   0e 0b 01 05 10 00 a7 02 ff 09 00 04 00

And it is a correct event for the 0x1005 opcode on its own. But
wireshark tries to defragment it with frame 112 and displays frame 116
as "Rcvd Command Complete (Read Local Extended Features)" which is not
true.

So, here is the full diagnostic for what is going on. However, I'm not
sure that the patch is the right remedy for this issue... It works, so
at least it is a good PoC that these USB dongles can work with Linux
as well. I have not tested all HCI commands, so I do not know whether
there are any other quirks in this dongle. All I can tell is that I've
tested it with A2DP audio and it works but it is not very stable...
sometimes it hangs (unplug/plug is required), but most likely due to
undervoltage on my RPi... (undervoltage does not jam the on-board BT
chip or other dongles that I have, though).

This extra byte in the 0x1004 response event seems to be random -
garbage most likely. I've tested it with libusb. There is also another
thing with this dongle which was not mentioned earlier. Dedicated
Barrot Windows driver sends a few vendor HCI commands before standard
initialization. Most likely queries version of firmware or something.
Also, Windows driver does not use "Read Local Extended Features", so
maybe it was not tested... Anyway, without these vendor commands the
controller seems to work properly (as far as I tested it).
