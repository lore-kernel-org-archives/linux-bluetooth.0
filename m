Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8C633F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192760; cv=none; b=tvpFZFO2o39OMx5/xOjioL9HWQna9hMCBb4K80IomHmUPz8f9976/LDWtUfAZ74A8m1F1F8vUEyzhIr/9Gtj4T+kVKqswMYjo3Yptf+cy/Jmq0n/R17G9Jxpo61MjjEODbsWG91Bfn0pZ61ay2YypaYPydBpqzwbqB1fYO17j2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192760; c=relaxed/simple;
	bh=eojqyo8cJO2nb+plxWsUTeE5ia56IXt2NMk9RTsHLyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZzoRYKzJ4H1WABet2IpJmiztpzbVSL6PtSAen/qRPsokFd0aQ3pr0fzyxA7MKrYfNV5sdcN+0Q2Ryyv26YpixQnMTsH8DgVmygMHUPPjmUYt4t8A0ywYchllS5rj/Xi9BLvRi9ABRbDIQy+YoTccr/03CfVqIS/qjMhS1lZL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY3HKH4n; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY3HKH4n"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so5376651fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192757; x=1706797557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQwYo7d9jzhQ0cz+JoDPjA772HOZGzxvXZvIXdQMOZg=;
        b=NY3HKH4nqNePKmxfJwS0lLMujr6g+Sl7inkkrlazfy5kwYeGOUUPqVworJlxoKSLCO
         p2G4qMN0ruCQOZonmbGNsIhPKG6eGeA4RlBmQEVdsOcg7hE1czpLszpfJxZFlAbO+5RN
         lGhO2A8uDLpcj2j4r0hQXBZiQSs8A8HJph8kmRMGW/qVtnr0gP8sEa7hDIyME/7DLi87
         ioFVEiP/4zlFk9tYPGDep+bEP5EfETYoVYo9QV+vXSx5IuIFRZU9/iju5kRHyj2KyGg3
         JYEnm5DKkF7JX/sqoIWaW+2QIpWYmTbZLPlf4Gociy/MEy/mp9w2Cxm7CDrFpw6P7i/L
         bR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192757; x=1706797557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQwYo7d9jzhQ0cz+JoDPjA772HOZGzxvXZvIXdQMOZg=;
        b=mhJbeg2nXre4DlyfzWdAJdxagPMM/7JN+xdAxPxzv9Yxqq0qQL77exIqKKIKx8lbmh
         7tdMjJZTkwcPVqy1nJleCbskzPf8fLg6yfGQ1EhcgLqjLu6/PvTEwnFs9zQfiZB3TWqs
         /2k+vfA+xBpcqAuuj1FKo6owRYHdwBwwwAyrP1hN622FrqrLikTKxKKs6uVtPHIXFW0A
         OInVE0FQLWyteud17cbtzQpNppvlPcW/FviuEJpCWmM3fSM+LHqLDeOVceb22aQ/+lRX
         enZGoeiSbhraKew3fqaYu2zrRd9r230BNi1ACcVrg+2fm+KafcSdkdc2x3XK37cD3p1q
         ml3A==
X-Gm-Message-State: AOJu0YxekxatKZqCINspPmf3MddLY+4c6TuoePUdHkJSl99UFxYeSC87
	9nebMo0+4glRxNBPSjw20g3/e5w2PsKSi32XfPQY5kmUh25KOQe76DfLFH7KKcqpoq27S2z1KxN
	+Rt8oOt719To+z+K+zWV0hkqwofA=
X-Google-Smtp-Source: AGHT+IFMlydMrpdksp20v4bV8VVNa6D4V+7WzxCYLRE4hELn18H8iDqK6sWjSDKPsD7R3aSPBuPeXsQY0/HNSES3xjc=
X-Received: by 2002:a05:651c:2126:b0:2cc:a61b:46df with SMTP id
 a38-20020a05651c212600b002cca61b46dfmr791155ljq.55.1706192756539; Thu, 25 Jan
 2024 06:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1O6sdTVEH-qHxWEPX3E2ia1yQ_HNTfZFEQck4144hO0iX5AA@mail.gmail.com>
In-Reply-To: <CAO1O6sdTVEH-qHxWEPX3E2ia1yQ_HNTfZFEQck4144hO0iX5AA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2024 09:25:43 -0500
Message-ID: <CABBYNZJucRWbun3hJAcjA0EZOFVWn1vPZXvfgb-4SsC8r_pO8Q@mail.gmail.com>
Subject: Re: Wrong order of ACL Data and HCI Event packets for HCI over USB
To: Emil Lenngren <emil.lenngren@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, Jan 25, 2024 at 8:51=E2=80=AFAM Emil Lenngren <emil.lenngren@gmail.=
com> wrote:
>
> Hi. I have a quite annoying issue on my Ubuntu 22.04 computer with an
> Intel Bluetooth controller (8087:0033, Intel Wi-Fi 6E (6GHz) AX211 2x2
> Bluetooth 5.2 Wireless Card).
> Very often BLE connections to a particular device behaves incorrectly
> (ATT timeout by remote device) because the initial ATT Exchange MTU
> Request arrives to the host (BlueZ) just before the LE Enhanced
> Connection Complete event arrives, and is therefore dropped. I guess
> this is due to separate endpoints and therefore separate flows are
> used in the HCI USB protocol, but have no idea how/if this can be
> fixed?
>
> See btmon log:
>
> < HCI Command: LE Set Extended Advertising En.. (0x08|0x0039) plen 6
> #11 [hci0] 8.102056
>        Extended advertising: Enabled (0x01)
>        Number of sets: 1 (0x01)
>        Entry 0
>          Handle: 0x01
>          Duration: 0 ms (0x00)
>          Max ext adv events: 0
> > HCI Event: Command Complete (0x0e) plen 4                           #12=
 [hci0] 8.104041
>      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
>        Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4
> {0x0001} [hci0] 8.104053
>      Add Extended Advertising Data (0x0055) plen 1
>        Status: Success (0x00)
>        Instance: 1
> > ACL Data RX: Handle 3585 flags 0x02 dlen 7                         #13 =
[hci0] 21.049023
>      ATT: Exchange MTU Request (0x02) len 2
>        Client RX MTU: 247
> > HCI Event: LE Meta Event (0x3e) plen 31                            #14 =
[hci0] 21.049304
>      LE Enhanced Connection Complete (0x0a)
>        Status: Success (0x00)
>        Handle: 3585
>        Role: Peripheral (0x01)
>        Peer address type: Public (0x00)
>        Peer address: (removed)
>        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvabl=
e)
>        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable=
)
>        Connection interval: 25.00 msec (0x0014)
>        Connection latency: 0 (0x0000)
>        Supervision timeout: 700 msec (0x0046)
>        Central clock accuracy: 0x00
> @ MGMT Event: Device Connected (0x000b) plen 13
> {0x0001} [hci0] 21.049366
>        LE Address: (removed)
>        Flags: 0x00000000
>        Data length: 0
> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
> #15 [hci0] 21.049405
>        Handle: 3585
> > HCI Event: LE Meta Event (0x3e) plen 4                             #16 =
[hci0] 21.050229
>      LE Channel Selection Algorithm (0x14)
>        Handle: 3585
>        Algorithm: #2 (0x01)
> > HCI Event: LE Meta Event (0x3e) plen 6                             #17 =
[hci0] 21.051290
>      LE Advertising Set Terminated (0x12)
>        Status: Success (0x00)
>        Handle: 1
>        Connection handle: 3585
>        Number of completed extended advertising events: 0
> > HCI Event: LE Meta Event (0x3e) plen 11                            #18 =
[hci0] 21.052293
>      LE Data Length Change (0x07)
>        Handle: 3585
>        Max TX octets: 251
>        Max TX time: 2120
>        Max RX octets: 251
>        Max RX time: 2120
> > HCI Event: Command Status (0x0f) plen 4                            #19 =
[hci0] 21.053228
>      LE Read Remote Used Features (0x08|0x0016) ncmd 1
>        Status: Success (0x00)

This is a design flaw in the Bluetooth Core Specification, it defines
different USB endpoints for data and events but since they don't come
with any timestamp from the controller the host has no idea about
their order. That said we do provide a workaround that can be enabled
with the use of the following config option:

config BT_HCIBTUSB_POLL_SYNC
    bool "Enable USB poll_sync for Bluetooth USB devices by default"
    depends on BT_HCIBTUSB
    default y
    help
      poll_sync synchronizes the USB data and event endpoints by
      prioritizing the later.

      Say Y here to enable USB poll_sync for Bluetooth USB devices by
      default.

--=20
Luiz Augusto von Dentz
