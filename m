Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98C331200
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974942; cv=none; b=s0GIIU8ntzQGdwL1PAsn/sc0QpxwwfPljiBC/qACDOp2o2PzGSqS19jhaJYtvpqOBpjN82m2o3YsuWjn0s5V29GLtiAHiiHWvyob7wJR/d72+LIsR7iUSNSF0DHDD7SGidzEXcdDMw2ZfHYghzuq9/FM9WQDtzOlHycrncp4nQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974942; c=relaxed/simple;
	bh=M1IU/GSgJqtanO8NGl5aGOWVnlo3e0Jo4hhJEnlc1TM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oZoHYS3ZyTYTdeBc4c1z2jKwCOJd3edeQe1+QLZs/LSIFQGM3Ix5Ub6q/HKOFmeQ1WbX3aXjW8EIFrc2pfHP3+1XoK7fUSuHCMpKjdScf903VYxML8fuQPMS25VDDYhysOZfatuRs1ZU/JPPivDfLBF9yQPJpD42hKmeGdDHJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=Qe1/Qihd; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Qe1/Qihd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790974939;
	bh=aDfjrixl0J4BO70TXGeNGnZvT/MHzoq9RqOuwtEyDx0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qe1/QihdopEmh3Rx5AnGRTvgD6WwrT8lfXYQi/p2Q+gHkpupPH4dGI3IPPlAx1NaN
	 /f5CqEDp9cu2wpy5VKqd1TJdR1b+Q6ng8F+pYTawyf3+yTiI+DqblHmRLiXlTiMWXp
	 DHz+N1v4vMXXZVIr7077J36VKtS9KpD67v77ffIbvvBg6eySsFmZZb9jtwtUc+8we2
	 GnztJZaYs4s083w7kaPP5P2zrhp8HAluFhER+EPxV4Qp+A7QdJF0ZDmEnCWXULbhOg
	 SVQ9yd+ysXRgYt20Z6Ca2cvCUT1FNv209zRs5VQrZiuInMcl7jgrnvC4VEa3o/u7i0
	 uBHm5bcQ7I0YQ==
Received: from github.com (hubbernetes-node-efe8b2e.ash1-iad.github.net [10.56.149.37])
	by smtp.github.com (Postfix) with ESMTPA id 6DA00361F20
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 14:02:19 -0700 (PDT)
Date: Fri, 02 Oct 2026 14:02:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1178559/000000-39b3f1@github.com>
Subject: [bluez/bluez] d29450: monitor: Add audio quality statistics for ISO
 streams
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1178559
  Home:   https://github.com/bluez/bluez
  Commit: d29450a9ef161bc4652db92dca3efc1ee1549ab7
      https://github.com/bluez/bluez/commit/d29450a9ef161bc4652db92dca3efc1ee1549ab7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M doc/btmon.rst
    M monitor/analyze.c
    M monitor/main.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add audio quality statistics for ISO streams

Track the bursts of erased samples, the Gilbert model burst ratio and the
RFC 3550 interarrival jitter of received ISO data, using the controller
timestamp when present or the SN paced at ISO Interval over BN otherwise.

Live decoding now prints the loss only for the sample revealing it, along
with late samples:

> LE-CIS: Handle 2304 SN... flags 0x02 dlen 4 sflags 2  #302 [hci0] 83.728300
        Lost: 0/34 (0.00%) dropped 1 invalid 0 burst 1
        Late: +7.50 msec (interval 7.50 msec)

The new --quality option prints a periodic summary per stream:

= Quality: LE-CIS 2304                                       [hci0] 55.004307
        RX loss: 5/101 (4.95%) burst max 4
        RX jitter: 1.10 msec late 2

The analyze mode reports the bursts and the jitter per connection:

  Found LE-CIS connection with handle 2304
        ...
        RX loss: 2896/30733 (9.42%) dropped 0 invalid 0
        RX bursts: 1304 (max 7) [1: 799, 2: 52, 3-5: 326, 6-10: 127, >10: 0]
        RX burstiness: p 0.0468 q 0.4503 BurstR 2.01
        RX jitter: 6.66 msec (max 13.06 msec, late 4275)
        RX interval: 10.00 msec (0-91 msec, ~8 msec +/- 10 msec)

A reordered sample is no longer accounted as lost.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: b2edf6402d24321b7adc0796fe13bbfaf289f881
      https://github.com/bluez/bluez/commit/b2edf6402d24321b7adc0796fe13bbfaf289f881
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix a new connection for each BIS or eSCO packet

The lookup of a CIS, and of a SCO, allocates a connection when the handle
belongs to another type, so the fallback to BIS, and to eSCO, was never
reached and each packet ended up on a connection of its own.

Fixes: 8157e2fde5d3 ("monitor: Print connection type in Disconnect Complete")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: fbc8733def7e1d2a9392d822e960febee65ad24f
      https://github.com/bluez/bluez/commit/fbc8733def7e1d2a9392d822e960febee65ad24f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix the size of SCO packets

The SCO header is one octet shorter than the ACL one used to strip it, so
the packets were accounted one octet short.

Fixes: dce3971d227d ("monitor/analyze: Fix not calculating latency for ISO/SCO packets")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: 07170047741e872bd2facd2f44de8018800fefe2
      https://github.com/bluez/bluez/commit/07170047741e872bd2facd2f44de8018800fefe2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix the type of synchronous connections

The Link_Type of the Synchronous Connection Complete event was used as
the connection type, so an eSCO connection was tracked as SCO and a SCO
one as of any type.

Fixes: 1f6e606c8504 ("monitor: Add connection tracking for SCO/ISO with -a/--analyze")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: da9ea4f163aab7745f48a872a1d0645b472823a8
      https://github.com/bluez/bluez/commit/da9ea4f163aab7745f48a872a1d0645b472823a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add audio quality statistics for SCO data

Account the Packet_Status_Flag of received SCO data, reported with
Erroneous Data Reporting, as erasures, and the jitter against the time the
data of a packet takes to play, derived from the air mode:

> BR-ESCO: Handle 257 [90:09.. flags 0x01 dlen 120  #1455 [hci0] 19979.296105
        Status: Possibly invalid (0x01)
        Lost: 0/1 (0.00%) missing 0 dropped 0 invalid 1 partial 0 burst 0

  Found BR-ESCO connection with handle 257
        ...
        RX loss: 0/8 (0.00%) missing 0 dropped 0 invalid 1 partial 0
        RX jitter: 0.11 msec (max 0.48 msec, late 0)
        RX interval: 7.50 msec (7-7 msec, ~7 msec +/- 0 msec)

The loss now reports all the erasures, with the missing samples apart.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 98137d498ad7f082547a834372a5463e389a1805
      https://github.com/bluez/bluez/commit/98137d498ad7f082547a834372a5463e389a1805
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add ISO link details to the analyze mode

Print the link parameters of CIS and BIS connections along with the last
LE Read ISO Link Quality counters:

  Found LE-BIS connection with handle 2560
        ...
        Link: ISO interval 30.00 msec NSE 12 BN 3 PTO 0 IRC 4 latency 28880 usec
        ...
        Link quality: 1 reads
          TX unacked 140 flushed 9 last subevent 31 retransmitted 210
          RX CRC errors 402 unreceived 12 duplicated 3

With a burst number above one the SDUs of an ISO interval are delivered
together, so pace them by the interval they belong to rather than by the
SDU interval, which reported most of them as jitter. On the BIS above:

-       RX jitter: 13.05 msec (max 45.73 msec, late 2556)
+       RX jitter: 0.68 msec (max 30.00 msec, late 0)

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 39b3f1020609673eb669232b2662e624cf076abb
      https://github.com/bluez/bluez/commit/39b3f1020609673eb669232b2662e624cf076abb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M doc/btmon.rst
    M monitor/analyze.c
    M monitor/avdtp.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add audio quality statistics for A2DP streams

Track the RTP sequence numbers and timestamps of AVDTP media channels, in
both directions, with the clock rate derived from the arrival times. A
pause in the arrivals of a second or more, such as a suspended stream,
restarts the pacing instead of reporting a late packet:

< BR-ACL: Handle 256 [E8:EE:C.. flags 0x02 dlen 602  #15682 [hci0] 141.214796
      Channel: 41024 len 598 [PSM 25 mode Basic (0x00)] {chan 3}
        Late: +374.81 msec (interval 14.51 msec)

= Quality: A2DP 256 CID 0xa040                               [hci0] 36.379012
        TX loss: 0/345 (0.00%) burst max 0
        TX jitter: 0.12 msec late 0

  Found TX L2CAP channel with CID 41024
        ...
        TX RTP: payload type 96 clock 44100 Hz gaps 1
        TX loss: 0/14786 (0.00%) missing 0 dropped 0 invalid 0 partial 0
        TX jitter: 0.06 msec (max 915.34 msec, late 2)
        TX interval: 14.51 msec (0-929 msec, ~14 msec +/- 8 msec)

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/d29450a9ef16%5E...39b3f1020609

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
