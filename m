Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795817240;
	b=juVSliMkhrbUx3+HaKTXXOxrF6mf6taDHx1Pnw2pTeMiwqZHpOYDS1m4isbva3Ld3TMQ
	 kCdo80brbyCQ+nyt2VyyfjUce/zZx+3rPbXd90lFCPgS/EiwmeWdRGXBRYGWByhoZ9DbF
	 wrYHW++o3yyVj2RnedUO3QAzeGp8U9XFpHA9aHjIxn6SNtj7w0RtVuIj4OL2P7N1PjgMY
	 aWHKlbtpcVwPsXHwgBTADJCNUaphtkBl865GPu/5+YIHxkskC77ELb3Px1TlqtELMO3GV
	 f2h6X7JseiHV0d1DM3VEVc4758Uay5FAOoMxRm9d2iPZ7calR1YqdDgZv30jM5A/D3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=37AGvCNQ+G+MSCa2G8zZh5KEi21Dc0zZ5WF3DKxrcYc=;
	b=bc7UPNvW/cbjs3frxA3WKFkHpy9M8QTteLLiMn93wFK1TViSMhgPHOKkd7L5eHN6e2z0
	 axu0lRkm5EQb340HkKoiK6KIt05xs48RAX7z9z+5nsfz1LDBjG0D4S3uL5ioxaleDUlqx
	 DP/x+g5H7lyz1wXhD5w+yAcerwNHcneBeeknV/GuKWhTRCb0C/NAbHp5Wp7YfDrj7Qscr
	 0vUnspwoksZujD8UKn2q8zGQFcXQtQm3t8Cbj6O97y1j10uptRj7fL8A5iFHSVGF3FJNZ
	 a+/Lyaw3gNP9x/Ozr7CpeUusAHlAo4tW+t7YfhJxcuYvSR/zbZ6nktob0IQvmuDef2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMvIf0Yg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F9606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMvIf0Yg
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b3402105b9so60712417b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:07:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795817238; cv=none;
        d=google.com; s=arc-20260327;
        b=G7xyzchqbXJK2rapTRzYq6sTu/n1s94HT5GXOyUemQ2I3TT5oK/1PJLPtUMuvEKejl
         CE4ji/wIVQ9nB7P6EQYfBVL65/DjGKmLw7UAb3TpCzrlQchRFLw0/Vo5O+16g7KbnDY/
         f8610xhFO+YFDavOTCHldXT4C7vNx2INmIyNcbWFdW9PZVbQA/0SwmTGWJONDgfxuunL
         5WzGO3l73p9KM483DVAuIJDns0FCmxy9urbtLPTvRHlzYamboKwZ1BKy9kK+EUY2uBoa
         JvuMUGOK0DosRZqa5VRHGnMt105frJnbobTfOUoInuSBl1kiaqOsdBFqSW+7A33d6KuT
         fY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=37AGvCNQ+G+MSCa2G8zZh5KEi21Dc0zZ5WF3DKxrcYc=;
        fh=dpvWgeSkoF/7FcqjU+ums/jOKGP/QzggphET7BHjaJo=;
        b=F/VI0JPPzThOs9W3AdpT6mQ6ckCCXtN51Y2ChRyJHX8AxsYlvt+iwC2Q75ge4gV6DI
         0hHxOypu8JtefoMhpkFGnx08oiK2JhuG1H8fJG24nejiVSVBMMFyMcmVP9Az03Jb3RPg
         JAfnq1G6gbtNPQBOZvDM5GYa3jxIXbTyZWPiyqrRNWM8OZhjuwKxoHKKu5uBOoYrDXLD
         QACuslTw++/3Yon5NuGJBoRgPH/jhUI3/0ZIgkQR3xS8lxqolSBlkKz0ZHxnXOmFRIJz
         Kt7CpS1d1c+Tiz74Hcko+2Eh7v9UUhUTXnsRy7KBdWxfPIn0Ow51UhoGZv4ZS6lMIjC8
         pTzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817238; x=1796422038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=37AGvCNQ+G+MSCa2G8zZh5KEi21Dc0zZ5WF3DKxrcYc=;
        b=JMvIf0Ygu4Q+edRrsPOTEP0uMDRxVeyS+2EaZKjkjyZ/nhluUBlBoPfcbjrQmZ+sYv
         fik6nFy3pdcIAG06KeO85UTg0JYXLmZsyWlDJEy2BDcO3uQZM6O8EsFOcpiT4MX7SAq/
         J7FY+uemO/8cfeTjHCFW/o23GedPZ2OSMv6mt8BNiCBFA9YCphreI+69CbJMgdL5mpMI
         75LLmpmhD6TY3/apkunvSJLaPG/wKUtFKBbvT0l1LPKwBWnSb0uG3u0XJ3NWfJElKypQ
         GYJGhLA3JtCI/+SvEcVSDZ1ljZ+amSI/gJWCuk/YF92pClS27IoKv4lZqvuS91OeCMsj
         esSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817238; x=1796422038;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=37AGvCNQ+G+MSCa2G8zZh5KEi21Dc0zZ5WF3DKxrcYc=;
        b=SGCsarOoTNnhdXI4gSkQpf2HW25vf4B88CfjFd03Hh7Hz7w+7O/gOxnoRBZZPfvh2d
         g86hjiJ6VgFWQFw6hkY8zn0dK2am7VUe3u/6IMqRJiGWUgkVGW9Y1QSA+J9SCHO3U15i
         CITj67E4wK4HtAD4o81kWH0YcX8SXHLn9t8+3JLZY1iPGlDSv4Z4DrBYvemE2ejBo/au
         R1k2eFlFEb0QKEDHnRxck08zgKtNuOlyMiz8HdJwBYuPiRfT3I/2emhXJyNRCblHcl6b
         s8gHoMvJR7kq9s07H07nXWdZakdcVcyM7I4hnzY3n6Xk1T0usYJNdvaH9zB2ojGAowrL
         oWOA==
X-Gm-Message-State: APuU4Z8auzd6PG8slUTgv8fDjFIZwv3qalZVEEQ8t5C85h+s/Wv/FwfS
	suSFV8IG0Q8neloMIOW3ucXG0AEwkiniRnAzvhR6lSbCM2JZ2iRJe35Nmp7NMsQYZtM8eejcc3n
	gW3IywODZ3C4WX9RoehCsZ02//Y7YD935PyUcueA=
X-Gm-Gg: AZFdTZfRt8nPpDhv9ykYXHGJSYFuGkvEtAstvd41s5ape6f0mnnf8J1IYaFk9IGh9Ni
	/cqI0ckboBrXN6BKBfEJC8aaiQ/yzltZWHkprPptPTtEZoFMd9eLyVwpWmyT79xqSiYAg2C8JU5
	4sBQbuVihZQxNL7fMNp7gAp9zVT4QylVH8zJLICq6g74uzISTfLJPW8Pd98QFSY8KKMAYU59ED7
	diqjTQWhHGjtOgpKrXo4sU/5PS/MtXZwReCJkWvmPQiWWPKu/0h3RMm+fwSuIzP/843ybj9bec5
	Qki1fbzU1XljkEvpqJzPqjCc38LaFwO947BS2ewf/uJBE1mRetsaLc7hrig/VfvggJFVlWpwLFp
	9NFfJqSTsE8z7ynxrhBapZsogb0B3He5Hhq+HUVdatLKetEeo+OjIxb66taGrKQS/YpmO
X-Received: by 2002:a05:690c:9b06:b0:8b4:c2c4:1422 with SMTP id
 00721157ae682-8b5204d7d9cmr100296257b3.70.1795817238430; Fri, 27 Nov 2026
 14:07:18 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Martin Stark <immel.m@gmail.com>
Date: Fri, 27 Nov 2026 23:07:24 +0100
X-Gm-Features: Aa3M54q1UeyCiYi7K6f9lG9-nXido_Hhn-rWkdwM8cRO_qSNSkrIJXrGHZb70wU
Message-ID: <CALSm0xTGVTRd+YuFArsoxmhscS-fg_GP9k98ZkYyQPQEGiuugQ@mail.gmail.com>
Subject: MT7925: LE Enhanced Connection Complete reports resolved public
 identity as Random (0x01), breaks reconnect of bonded RPA peers
To: linux-bluetooth@vger.kernel.org
Cc: Chris Lu <chris.lu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

With MT7925 Bluetooth and address resolution enabled, the controller
intermittently reports a resolved *public* identity address with
Peer_Address_Type = Random (0x01) and a zero Peer_RPA in
HCI_LE_Enhanced_Connection_Complete. The advertising report just
before correctly shows Resolved Public (0x02) for the same peer, and
the host connected to it as Public (0x00).

On Linux this leaves the connection with dst_type = LE random. It no
longer matches the bond: no LTK is found and bluetoothd cannot map the
link to the device. The orphaned link also keeps the peer from
advertising, and because the host's next LE Create Connection to the
public identity never completes, it blocks other LE reconnects.

Setup
-----
- Controller: MediaTek MT7925 (USB 13d3:3602, part of the 14c3:7925 combo card)
- Firmware: mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin, build
20261016233221 (linux-firmware 20261124, the latest published build)
- Kernel: 7.3.6 (Arch), btmtk with the mainline ISO RX fixes
- BlueZ 5.88, ControllerMode = le
- mgmt settings: le secure-conn cis-central cis-peripheral ll-privacy
- Peer: Sony WF-1000XM6 (LE Audio earbuds, CSIP set)
  - right bud: public identity 58:18:62:xx:xx:xx, bonded (LTK + IRK),
advertises with an RPA when it reconnects
  - left bud: static random identity CD:4B:xx:xx:xx:xx, bonded (IRK)

Observed (btmon excerpt, bad case)
---------------------------------
> HCI Event: LE Meta Event (0x3e) plen 118     #80264 22:07:01.529810
      LE Extended Advertising Report (0x0d)
          Event type: 0x0001 (Connectable)
          Address type: Resolved Public (0x02)
          Address: 58:18:62:xx:xx:xx
< HCI Command: LE Extended Create Connection (0x08|0x0043)
                                               #80267 22:07:01.532079
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 58:18:62:xx:xx:xx
> HCI Event: LE Meta Event (0x3e) plen 31      #80269 22:07:01.545797
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Role: Central (0x00)
        Peer address type: Random (0x01)          <-- expected 0x02
        Peer address: 58:18:62:xx:xx:xx
        Local resolvable private address: 00:00:00:00:00:00
        Peer resolvable private address: 00:00:00:00:00:00

Good case (same peer, same procedure, earlier attempt)
------------------------------------------------------
> HCI Event: LE Meta Event (0x3e) plen 31      #205 22:03:50.422137
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Peer address type: Resolved Public (0x02)
        Peer address: 58:18:62:xx:xx:xx
        Peer resolvable private address: 00:00:00:00:00:00

Frequency: in about 25 minutes of reconnect tests (earbuds in and out
of the case, adapter power cycles), 5 of roughly 10 connections to the
right bud were reported as Random (0x01). The rest were Resolved
Public (0x02). In the same session the static-random left bud was
reported once as Random (0x01) instead of Resolved Random (0x03); that
is harmless for a static address, but it looks like the same issue.

Per Core spec Vol 4, Part E, 7.7.65.10, a connection to a peer whose
RPA the controller resolved should report Peer_Address_Type 0x02
(Public Identity Address) or 0x03 (Random (static) Identity Address),
with the RPA in Peer_Resolvable_Private_Address. Type 0x01 is never
valid for a public identity. Separately, even the "good" events carry
a zero Peer_RPA together with type 0x02.

Host-side effect (Linux)
------------------------
- le_conn_update_addr() takes the event's type, so hci_conn->dst_type
becomes ADDR_LE_DEV_RANDOM. hci_get_irk() then cannot map it back,
because the address is the identity rather than an RPA.
- SMP: "security requested but not available"; the link stays unencrypted.
- MGMT Device Connected carries LE Random. bluetoothd logs "Unable to
register device interface" / "Unable to get device object" and ignores
the link.
- The peer stays connected on that orphaned link and stops
advertising. The kernel's next LE Create Connection to the public
identity stays pending, which also blocks the other set member's
reconnect.
- Recovery: power-cycling the adapter, sometimes more than once.

I can provide full btsnoop traces privately; they contain link keys,
so I'd rather not post them to the list.

Thanks,
Martin
