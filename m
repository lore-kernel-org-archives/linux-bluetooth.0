Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495C233D85
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152520; cv=none; b=K+fGMIaErVqqnWOzrCKt+WwOUz1hsCrDC7HuhNEzWukyqzRYNoT3TtynZX0nCGtSWQia3tPsN/FW1Jf/Kw0/L9WvQbxVFRlU0yYnMDQCOT0qDBuiR9MdMEyaAlT9eUqjebfeFaNYChe2LTCHERf0Aeq3Q04HJwDD5JpPMLlREMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152520; c=relaxed/simple;
	bh=7uujfHYvCk4Hu3v/7AlJi62lFpM7OJQCr3VISTrC5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWmzMLqJfrj1UHcyOCAmHLzp8656KIeM4p1ZBsBZznULiGrCSBKexHFWvAYlr/b+LNlyRbpJ9cBKzwwzlfbiZB1bGOYCxCcMz3t/wV9a8CgueQxUn9ei2OCsPJ/JPb9rBWGRDnioWsWvGjyQubHOh1aZmwjnUiIUKeWb2cMCUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbepYbge; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbepYbge"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3367f35d129so7838851fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152517; x=1756757317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnsFcCqM93r1BR/U10hls1mOsuU5DKPko9808VTr7uQ=;
        b=PbepYbgebX9flTtZKyi/XdzwIEf3uBX0Dal9vyI+NxF72ObthYUD8Z8qk/1mNr/G11
         EtM/OMfFkwilCL2uCIbq2B0R3R9IZy8VZuyge+8I3jRCx7l2kg4MTVL82KBycqDpQttE
         J94gX/WjsE+gscTIO/bjzs8ejgEP9UvyKWSyFC2R/Wrj4N6vddcmkSWPDx6wA2Ka7F2o
         LMQ6dGz1hkB/leFuoqjHdaWNoDHDAWj5CbCEBBB8GEtpf70IWwNaipQDxFM/AJLcDwuT
         VKmtBAypfoTjj1PAZGUWsCj7kHKBp/kMZ9vgM04rYmhCHYWDLj+D35rNI2EzBujQ6eK5
         tsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152517; x=1756757317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnsFcCqM93r1BR/U10hls1mOsuU5DKPko9808VTr7uQ=;
        b=NCxVTlRnWSliOU99KMR2N/OzizDfEl5f+kaLDH+oQkXWzccetnB8+16TcrRCOCWfgX
         Ni3rF0NHK9Kwrmo1WzsotrMP2AF7GWzory+tHSgv2uH4vKh4GUyZFCEMoG12aF5N4ge3
         b8BU2+kZhBP5LJCK2Yrwr+ehKGZr1DeYycoyz+kP7We++4l7mRF+4sfXl/MpI3QG8OfH
         CLPP3HzlLQoR+AZQMWU1/ZM2xm+OKY5A83CZLwqYWFWGkW+sGiLay+1iy3gJ5EXgnw0W
         xokx1yNeobW713WNzaoDG5Olhc6BLc2uQW8T0OLMZNWNFclXnwfe/9DERpCGuI0OWJh8
         ciOg==
X-Gm-Message-State: AOJu0YxjHMkm8zL6FazD6GUZxbMndfzaLuak/xszfiKFsiThCeOpRLv4
	YyCTPcGCS0yiRHaNlOVmIDnZQWuCgxXgnfy9PQSBxYs56SSBouyrp2PcJ2+NQERJVASTJS+xcyf
	KrRHUN0Hg5QMvUqN17O2EbCwDzDtDGfo=
X-Gm-Gg: ASbGnctX+pLeRQ14XtvDZ4gr0Q2ArWGUqtE1RbpNDbN6blm5889DPMvDRStExFKzM9X
	O2C8pstu9hMB5JCIkV5qPTVQPNIc2EXVNgrOscM+HNYQkf6CtkbSTO6pKeYpZzVOWKuDATA44Pf
	zvrzurRNRdhwyjUKFloW8ZCfgBEYKfo+EqxjsZ9qcbNN5dqSso9WYFIg8/jE8mlEjINWbbzA9Dx
	0SnQY8UdKA7rGc5VRmX5NP5Cxvz0vcvqwc2oyWv3kqPcA==
X-Google-Smtp-Source: AGHT+IEkp1W6xm9Gm4W6eSjs8/CvJOyErfTu15ybhzUvY65exvZorNjcc4sZzOWG2jlc4vlSZQrnkAsHNA92gI40V8c=
X-Received: by 2002:a2e:be1c:0:b0:336:7b66:13a1 with SMTP id
 38308e7fff4ca-3367b662564mr9784501fa.0.1756152515789; Mon, 25 Aug 2025
 13:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com> <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
In-Reply-To: <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Aug 2025 16:08:22 -0400
X-Gm-Features: Ac12FXzhHoNoj5Qm0-0j-t_h_HRZf6rwPLOFH6us540g51JfwrHpZUQwaPbNs2A
Message-ID: <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Aug 25, 2025 at 3:37=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Yeah, but that is just working around the extra byte, but it seems
> > there is some way to detect that not all data has been read, which is
> > why wireshard is only considering the Read Local Extended Features as
> > received on frame 127 not on frame 123
>
> I have not checked how the wireshark logic works, but I guess that it
> works like this:
> 1) read URB and parse it's header to get the size of the buffer
> 2) reads HCI header which tells how long the HCI packet is
> 3) diccesst entire HCI packet
> 4) return dissection with the number of processed bytes
> 5) URB_packet_len - dissected_len =3D=3D 1 which triggers fragmentation l=
ogic
>
> USB capture from my controller:
>
> > 109 7.586834       host                  1.7.1                 USB     =
 64     URB_INTERRUPT in
> > 110 7.586985       host                  controller            HCI_CMD =
 68     Sent Read Local Extended Features
> > 111 7.596062       1.7.0                 host                  HCI_USB =
 64     Rcvd
> > 112 7.604809       1.7.1                 host                  HCI_USB =
 81     Rcvd Fragment
> > 113 7.604830       host                  1.7.1                 USB     =
 64     URB_INTERRUPT in
> > 114 7.604980       host                  controller            HCI_CMD =
 67     Sent Read Buffer Size
> > 115 7.610312       1.7.0                 host                  HCI_USB =
 64     Rcvd
> > 116 7.610814       controller            host                  HCI_EVT =
 77     Rcvd Command Complete (Read Local Extended Features)
> > 117 7.610823       host                  1.7.1                 USB     =
 64     URB_INTERRUPT in
>
> But this INFO column is not correct. The frame 112 contains:
>
> 0000   40 5e d7 04 80 ff ff ff 43 01 81 07 01 00 2d 00
> 0010   b8 73 a8 68 00 00 00 00 9e 80 05 00 00 00 00 00
> 0020   11 00 00 00 11 00 00 00 00 00 00 00 00 00 00 00
> 0030   01 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00
> -- HCI payload starts here
> 0040   0e 0e 01 04 10 00 01 02 00 00 00 00 00 00 00 00
> 0050   00
>
> First byte in the HCI payload is event type, the second byte is length
> 0x0e =3D=3D 14. However, the USB buffer has 17 bytes, which is one more
> than the event header size (2 bytes) + 14 bytes of data.
>
> The frame 116 contains:
>
> 0000   40 5e d7 04 80 ff ff ff 43 01 81 07 01 00 2d 00
> 0010   b8 73 a8 68 00 00 00 00 13 98 05 00 00 00 00 00
> 0020   0d 00 00 00 0d 00 00 00 00 00 00 00 00 00 00 00
> 0030   01 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00
> -- HCI payload starts here
> 0040   0e 0b 01 05 10 00 a7 02 ff 09 00 04 00
>
> And it is a correct event for the 0x1005 opcode on its own. But
> wireshark tries to defragment it with frame 112 and displays frame 116
> as "Rcvd Command Complete (Read Local Extended Features)" which is not
> true.
>
> So, here is the full diagnostic for what is going on. However, I'm not
> sure that the patch is the right remedy for this issue... It works, so
> at least it is a good PoC that these USB dongles can work with Linux
> as well. I have not tested all HCI commands, so I do not know whether
> there are any other quirks in this dongle. All I can tell is that I've
> tested it with A2DP audio and it works but it is not very stable...
> sometimes it hangs (unplug/plug is required), but most likely due to
> undervoltage on my RPi... (undervoltage does not jam the on-board BT
> chip or other dongles that I have, though).
>
> This extra byte in the 0x1004 response event seems to be random -
> garbage most likely. I've tested it with libusb. There is also another
> thing with this dongle which was not mentioned earlier. Dedicated
> Barrot Windows driver sends a few vendor HCI commands before standard
> initialization. Most likely queries version of firmware or something.
> Also, Windows driver does not use "Read Local Extended Features", so
> maybe it was not tested... Anyway, without these vendor commands the
> controller seems to work properly (as far as I tested it).

Could we solve this by doing:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3595a8bad6bd..168b07041605 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1194,6 +1194,17 @@ static int btusb_recv_intr(struct btusb_data
*data, void *buffer, int count)
                }

                if (!hci_skb_expect(skb)) {
+                       /* Each chunk should correct to at least 1 or
more events
+                        * so if there are still bytes left that
doesn't constitute a new
+                         * event this is likely a bug in the controller.
+                        */
+                       if (count && count < HCI_EVENT_HDR_SIZE) {
+                               bt_dev_warn(data->hdev,
+                                           "Unexpected continuation: %d by=
tes",
+                                           count);
+                               count =3D 0;
+                       }
+


--=20
Luiz Augusto von Dentz
