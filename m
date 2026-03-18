Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13C34575F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832188; cv=none; b=uwS11KgLhBe/LAw8OIfaUj/io9RDiDX+OhVnMts3mH2YQmkGFDGzkuRuC2W5VngPEIC289OjawMS12d3wJ/b1npw4FUf5i4O8mAix5wgG+K3+iPlfeQAu9UJHYX0/OU/O/TYFszwdLNLRPa7Yc4+8oLSvHInNe/yAsG1NhTqp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832188; c=relaxed/simple;
	bh=CNkv/mWUFVL0pZFpR74TCQ9qO8NT2pYQcxfDj57XJbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=HrR3q3vwcBUhbNqU1a80uM/yaIqyxss81Qla68DMM8TN78FbdFgEGmKE4g8eOThTwsMc5uR2FDULqrOr+R5AYpun6RkBFJe8iZe+vaSYtqGqIv3VnYszU9km3rjQ0nz5xfbG01mbdRa0YbOxUcm1zaX8QXB9plWmFGlN9cR3kmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JxCft0n0; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JxCft0n0"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260318110943epoutp0155abfb82bb096a2dc1d830b02c815452~d6vjrvmbB2761027610epoutp01Y
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 11:09:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260318110943epoutp0155abfb82bb096a2dc1d830b02c815452~d6vjrvmbB2761027610epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773832183;
	bh=uhQ4qK/k6zbTVSiNkj8X0PGcZs8XmSdrKOSpe2yB2o4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=JxCft0n0dZ2LSTgyHFrHlCbNsBino6Pg+cH02HjACLgvR71xA0R5/Tw3G0JZRXxLc
	 cBaC6eouqpXE4tqzQjCBe+/G5yZvowiWHnQM0gZ1jj8+iff/1DN38M46hm8tWng4+5
	 sAiRRp5SZamMyOUftqi4EKlTWL9M4XMf5uXQO7IQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260318110942epcas5p33a49c54d53afc713f7b132afe1a76c02~d6vi1YW0u2736527365epcas5p3k;
	Wed, 18 Mar 2026 11:09:42 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fbR1L103Zz2SSKX; Wed, 18 Mar
	2026 11:09:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260318110941epcas5p14254ccd641695fb7715ec1c10776ae27~d6vii4JZ42682926829epcas5p1O;
	Wed, 18 Mar 2026 11:09:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [109.144.5.214]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260318110941epsmtip2e6d349dec538b504861a4143cdf2b088~d6viOsz-r1969819698epsmtip24;
	Wed, 18 Mar 2026 11:09:41 +0000 (GMT)
From: Tailu Shi <tailu.shi@samsung.com>
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: Tailu Shi <tailu.shi@samsung.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
Date: Wed, 18 Mar 2026 19:09:35 +0800
Message-Id: <20260318110935.3859683-1-tailu.shi@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reoly-To: <1f3486f1ddb0adcccbbfcd676ed3dc9e32e5e69c.camel@iki.fi>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260318110941epcas5p14254ccd641695fb7715ec1c10776ae27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260318110941epcas5p14254ccd641695fb7715ec1c10776ae27
References: <CGME20260318110941epcas5p14254ccd641695fb7715ec1c10776ae27@epcas5p1.samsung.com>

Hi Pauli,

Thanks for your valuable feedback in your previous email.

On Fri, 13 Mar 2026 22:50:33 +0200, Pauli worte:
> TMAP likely assumes the controller implements the specification so that
> providing correct time stamps would be possible, but when they in
> practice don't, spec compliance seems dubious and not setting known-
> wrong Time_Stamp on packets sounds safer.

Okay! I see. Thank you.

> I think we will want LE Read ISO TX Sync support at least, as this will
> solve the CIS/BIS synchronization problem, as user application can then
> know what ISO packets controller considers are playing at the same time
> (if controller actually implements this command properly).
> 
> It would be good to have information how different manufacturers have
> interpreted the specification vs. LE Read ISO TX Sync. Right now, I can
> only read what Zephyr is doing, and tested some other controllers
> return zeros. If you have access to controllers that implement this
> command, it would be very useful to know their precise interpretation.

Yes, I can confirm that we have a working controller that implements this
command. However, I am unable to disclose any specific hardware details
due to our company's confidentiality policy. I appreciate your understanding.

To facilitate upstream integration, I can give a concise overview of the
implementation of the LE Read ISO TX Sync command on the controller side.

The controller returns information about the currently ongoing CIG/BIG.
- The sequence number is tied to the currently active CIG or BIG event.
  It originates from the HOST and is extracted from ISO packet.
- The timestamp is the reference point of the ongoing CIG (or the anchor
  point of the BIG). It is taken from the controller's free running clock.

 Partial btsnoop output:

 *No.* -- *Time* ----------------------*Info* -------------------------*Source* ------------- *Destination* --------- *Protocol*
 46971 | 72.066457 | Sent LE Read ISO Tx Sync                   | host              | controller                      | HCI_CMD
 46972 | 72.067106 | Handle: 0xa01, SeqNo: 4408, SDU length: 60 | 44:67:93:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
 46973 | 72.067118 | Handle: 0xa02, SeqNo: 4408, SDU length: 60 | 44:67:93:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data

 46981 | 72.072452 | Rcvd Command Complete (LE Read ISO Tx Sync)| controller        | host                            | HCI_EVT
 46982 | 72.072462 | Sent LE Read ISO Tx Sync                   | host              | controller                      | HCI_CMD
 46984 | 72.074644 | Handle: 0xa01, SeqNo: 4409, SDU length: 60 | 44:67:93:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
 46985 | 72.074683 | Handle: 0xa01, SeqNo: 4410, SDU length: 60 | 44:67:93:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
 46986 | 72.074695 | Handle: 0xa02, SeqNo: 4409, SDU length: 60 | 44:67:93:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data
 46987 | 72.074701 | Handle: 0xa02, SeqNo: 4410, SDU length: 60 | 44:67:93:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data
 
 46992 | 72.077452 | Rcvd Command Complete (LE Read ISO Tx Sync)| controller        | host                            | HCI_EVT
 46993 | 72.077461 | Sent LE Read ISO Tx Sync                   | host              | controller                      | HCI_CMD
 46994 | 72.079450 | Rcvd Command Complete (LE Read ISO Tx Sync)| controller        | host                            | HCI_EVT

// sdu_interval: 7.5ms, Packing: Sequential, Unframed.
// HOST transmits SDU, SeqNum = 4408, handle = 0x0a01
 Frame 46972: 72 bytes on wire (576 bits), 72 bytes captured (576 bits)
 Bluetooth HCI ISO Packet
     .... 1010 0000 0001 = Connection Handle: 0xa01
     ..10 .... .... .... = PB Flag: Complete SDU (0x2)
     .1.. .... .... .... = Timestamp present: True
     0... .... .... .... = Reserved: 0x0
     ..00 0000 0100 0100 = Data Length: 68
     Data
     [Connect in frame: 6122]
     Bluetooth ISO Data
     Timestamp: 193973666µs
     Sequence Number: 4408
     .... 0000 0011 1100 = SDU Length: 60
     SDU

// CMPLT reported in frame frame #46981 for the command issued in frame #46971 
 Frame 46981: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
 Bluetooth HCI Event - Command Complete
     Event Code: Command Complete (0x0e)
     Parameter Total Length: 15
     Number of Allowed Command Packets: 1
     Command Opcode: LE Read ISO Tx Sync (0x2061)
     Status: Success (0x00)
     CIS/BIS Handle: 0x0a01
     SDU Packet Sequence Number: 4407
     SDU Packet Timestamp: 212355139µs
     SDU Packet Offset: 0µs
     [Command in frame: 46971]
     [Command-Response Delta: 5.995ms]

// CMPLT reported in frame frame #46992 for the command issued in frame #46982 
 Frame 46992: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
 Bluetooth HCI Event - Command Complete
     Event Code: Command Complete (0x0e)
     Parameter Total Length: 15
     Number of Allowed Command Packets: 1
     Command Opcode: LE Read ISO Tx Sync (0x2061)
     Status: Success (0x00)
     CIS/BIS Handle: 0x0a01
     SDU Packet Sequence Number: 4408
     SDU Packet Timestamp: 212362639µs
     SDU Packet Offset: 0µs
     [Command in frame: 46982]
     [Command-Response Delta: 4.99ms]

// CMPLT reported in frame frame #46994 for the command issued in frame #46993 
 Frame 46994: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
 Bluetooth HCI Event - Command Complete
     Event Code: Command Complete (0x0e)
     Parameter Total Length: 15
     Number of Allowed Command Packets: 1
     Command Opcode: LE Read ISO Tx Sync (0x2061)
     Status: Success (0x00)
     CIS/BIS Handle: 0x0a02
     SDU Packet Sequence Number: 4408
     SDU Packet Timestamp: 212356039µs
     SDU Packet Offset: 0µs
     [Command in frame: 46993]
     [Command-Response Delta: 1.989ms]

I hope this information will be of some help.

> @Luiz: thoughts on the below?
> 
> For setting Time_Stamp, I think there should be plan how userspace
> application uses the new APIs to produce working sound on different
> controllers, without having to maintain a quirk list for each
> controller. I think quirk lists should be in the kernel driver.
> 
> Depending on what hardware is doing, we could add driver quirks along
> the lines of
> 
> HCI_QUIRK_BROKEN_LE_READ_ISO_TX_SYNC, /* always zero / dummy value */
> HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_PREV, /* most recent from host */
> HCI_QUIRK_LE_READ_ISO_TX_SYNC_NOCP, /* most recent completed */
> HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_SEQ, /* uses host seqnum */
> 
> and should affect what skb is reported in hci_cc_le_read_iso_tx_sync(),
> and if SOF_TIMESTAMPING_TX_HARDWARE capability is reported in ethtool.
> 
> (Eg. IIUC Zephyr HCI appears to interpret LE Read ISO TX Sync meaning
> as follows:
> 
> - The sequence number is controller-assigned.
> - The response corresponds to the ISO data packet that
> the controller *most recently received from host*.
> 
> This interpretation makes sense, but is different from my patch and
> iiuc also different from what Luiz had in mind.)
> 
> If no quirk is set but the command is supported, probably should emit
> visible error in kernel log, or something along such lines, so the
> driver authors can see something is not right.
> 
> But knowing what is the precise hardware behavior for each
> chip/firmware seems a bit involved, probably should have some testing
> tool for this.
> 
> ***
> 
> What it seems userspace can do:
> 
> Userspace application would check via ethtool
> SOF_TIMESTAMPING_TX_HARDWARE capability to know whether controller
> handles Time_Stamp in a non-broken way. (For testing, there could be a
> switch to force it to use timestamps regardless.)
> 
> It could then rely that the HW timestamp corresponds to specific packet
> it sent earlier. It could assume that in its clock domain, the HW
> timestamp is after SND timestamp, before COMPLETION timestamp, and
> likely close to COMPLETION.
> 
> Since it doesn't know the exact correspondence, probably it would
> always have to ensure a few packets are always queued in controller.
> 
> There also needs to be a way to recover from a situation where the
> application is setting timestamps that are in the past in controller
> clock domain.
> 
> The controller does not necessarily send them I think, but will report
> them completed immediately (after older ones get flushed from its
> buffers).
> 
> In this case LE Read ISO TX Sync timestamp would not advance, as no
> packets get sent. Kernel would also not send HW timestamps to user
> application in this case.
> 
> If the application when it doesn't receive HW timestamps from kernel,
> just increments its send timestamp by SDU interval for each packet, it
> eventually catches up the controller clock, and receives HW timestamp
> and can resync.
> 
> Alternatively the user application may stop setting timestamps, in
> which case controller shall send it in next SDU interval, and in this
> case HW timestamp is received and user application can resync.
> 
> Or, alternatively, controller will decide the clock is out of sync and
> send the SDU regardless, in which case user application will receive a
> new HW timestamp and can again resync. 
 

Thanks!

Best regards!

Tailu
