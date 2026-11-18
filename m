Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794982328;
	b=p70BB5yqeH9WDt6+yPcfXLP0EmFB41+Rn+H71ccnmLNilHBxH/t+kpJ23xY4lv+/odvu
	 PqfAmnreAe6qPBCRPEQYy3EujCi5kHLQa/JuFOuIAR50ilt5+SFbaDcUGVWx7bCTX0naN
	 dRhL98dWw2Ga5bGRNo/CopRI9noMtZacPrA4J2W0ZeMAROGGkDQ18uVhNM+8VhGxTnsLn
	 Q0Z1Ifk4Z61DeqoAhMqIciwjBn8XmljbdYepSK5Ae1xzggVvtzZXJH2doZTfU9M673YRY
	 3nWs5fZVWifb7uLj95nEJcjwynCPDhAjeA1RcfNB5liBa2lrdBiB463mNlqIQ5o6PYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=rOZD9NavTMZu4GMHkt1R76i7kRFZMYLL2jjVXnkJeLQ=;
	b=TkyC+5uMAgoAksULm/Dd2/1jGb6yk1oJZLLkSF7Qs+TWWQn4UK1rY7ZmNXYEsLy1yTQU
	 wW7fZ5fjqXZFuckXW6KKtwLzYWw1muFDsggl6UwQtmZvXRMu+nnX/60Bef58IKHYMHGN9
	 WalF0+/gm/g9WIp+ujOn1U5dWi2AyCyNJvm0Kdq4MrqABGgOtBK9imLsLXEraZcUSIHwq
	 aTEW+agC6wkOFPsak2Qo3kc/fagDg5aQPc0uUJNqrP81A4cAvOKNpAb/ufo+a2cGQIGyv
	 l74WUWfO2g5yE/Ymf4cy72W2pG8IoeLen7mL3ujyZZi+S59olCl7BQGJyk8c15wxWsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RT/FYDTq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.139
Received: from mail-dl2-f11.google.com (mail-dl2-f11.google.com [74.125.229.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AC606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RT/FYDTq
Received: by mail-dl2-f11.google.com with SMTP id a92af1059eb24-1b345449fcbso18785c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 22:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794982327; cv=none;
        d=google.com; s=arc-20260327;
        b=PVPZN8Q6nZDMHws0HQ0V/xlK/uIS6fBaKOvLan3sNh1osa4zhNt3eEdrn4YqK+c2wr
         I2h0qyJGidsq8aaXH/yiM/jXnqI6DD4NB45imRSsacnULoM1UNKSrFTyX4FMoudldlgO
         yjhdplo4oFtXbvGOJpetUuLHUUamkc4ApoLC8xNvYjcUdwR17V+JTjXl7z756t403LTX
         jWWzGGDv+RAxGZ9aePrcOHc6H9q/mW7TSfuCo6xcpHY/whbMK3QHN+DuTpTVHLZRdeSH
         16HTcofrcf23FIHVk6r8Jt/+y78iaBO+hJHnmWnKx4gsvsaV26NMNPV8QHQRCqlC1pC8
         W7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rOZD9NavTMZu4GMHkt1R76i7kRFZMYLL2jjVXnkJeLQ=;
        fh=K5bUY0/FiCgQZTOWNHuDHHJixUoAwcbi+RIYCpQuKow=;
        b=F1D25XeIHEG3q0sX1K/tDTkPiSqJK94yYcEoBGasNGLfaeTBOODR/gu/q7ueSupN9J
         t5inWAhy6kfhdD/fUMBYCqoYxSNnxELeqZG8+3SRCESdLFxTnXqBk09MWC/kVCafLBal
         tmYywP0lyrxNe0UwVjdypHCOArIQzB6vPrv1P+g3HQ9H+03iZrtiJFkqIyaGkqDi9m83
         VDxxdCrrpI4Pg4e+Rx/FfJszpYtjipnM/9eBKK4rRSbNXK/8fd9uIJE8H1AfLt4tdnep
         Umm+3E9DzW+3fV5fvN85uPvo+wwAarfgUDCc19Y4kOBoNDYcn/sp84DFxyjtYtvtrCqm
         iwbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794982327; x=1795587127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOZD9NavTMZu4GMHkt1R76i7kRFZMYLL2jjVXnkJeLQ=;
        b=RT/FYDTqGAmZKAjtVot3xGlyatHECPP9HHjvw6hRUfyXXVFZErI8E8WrFbVMldeP8D
         5V95fHon4sXiIWRryTAD0WMMMmh7KXwPq06wuAxLXw0gAPMkiWZavw9g9mmagY0VKnYm
         aUrTr+3OcsJpVW3yDFD57LPWHJFu5xIRjjx2ygSazjF4aKlA2v6bvPCG/d57dddlYXnd
         KWP9UoJtAJYkl/jYa3DbrHlM4YLYYv9XCdHiUSE5/TCJof0dvYi7b/fxxdb4XsfqT8ZD
         jXXxT5HBZ3XfT7n8k3esylFNQRBq3IWe3b9zsBiCuZd7rPhaXPNLgqZiTmQk/o8jyXg0
         KpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982327; x=1795587127;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rOZD9NavTMZu4GMHkt1R76i7kRFZMYLL2jjVXnkJeLQ=;
        b=uNzHKmwTL39ShXPWXk/OHrf4WQ4XOggn4NIbHW9GfR3G2oWY8TaBL3Sq9cOFJj4Oh/
         JEwS6ZXe1kF0klyRoN+56xi/yMrD5TJ84uCFjEMODrdkc9ZbS3SSP/lzt/VVjaCYwwzH
         U+EiAIbCPjiCVEcIRq5/wRjAK/ugFAYCTpd8oRm5bG5UzXDUqYeH6q9nMoaBUCQPr4xq
         zbNjjs6JKw/8sozWL6aq35NZqzwyXA18FpJN+C939NQM5KEx9nPdq9K96ZhSxuBPFsaa
         6iIAd4k1yZoOdCd9z7Y/5g8APMBP+fi782GaP+NYp6UjKw1Ufa2XZZUtKiC90KuuBzUn
         hibA==
X-Gm-Message-State: APuU4Z/YrMgWYXOa1p4iyvRGiEPa4pviqq4Rm+NY6626xGnINr+3IrCk
	gBk88jHGeEwl5+sAuChWDAY15FNjE5rYKV2NDNsSnJEFSU0m+ogqoInY5D3jo+am2qIbaMpWy6U
	tvu+ghyqQ+YDisXqRo0DFumYXAG3eZ/26XD2ayg0wKbpPYVeDMHWKtAU=
X-Gm-Gg: AYBFou10Qe9tL7RP45DtV9rr2OTsdHfnTuF97fl9nAsA1QfPNPoOqEn2vkMGRlIPjrO
	hYfP7S3sTYcE71nd2g8hku7NNfB1mqUixCOmDzgVv2bCZGceyj6uo+sRMCYDbhXUlpl8A6idyMg
	EeXXkGYz2KgvEpz3b1efDIPthtbhESiOAW9ytHx2lS95CrLdTbwF7mqzAHJ5HSNtj0/7Z5Xj2ym
	zt2ngqzi24h0/Cp05GW5JKuYkbizqH6HfNSeTnoP/zh06NWGdTuEAfCOT102eqw4+kZjdCM+lbn
	I3aYa2kb/Htlr1TnMQZUMFyj4oqzfx/PDK+RGps9GbaWwXBiBQQpeDRyTssJm2glVMHSS5ccdE4
	MCAUOW23AGNUFY4NIzTOkqSSazPGBgqV86+aeKsGN3MfetQ/yUuxLC4qN65BtVFyQ
X-Received: by 2002:a05:7022:108a:b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1b543cee611mr1805061c88.26.1794982326872; Tue, 17 Nov 2026
 22:12:06 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Kelvin You <weyou.dev@gmail.com>
Date: Wed, 18 Nov 2026 14:11:55 +0800
X-Gm-Features: AclHuK85TDGxrXSsLsZfenLiDiIIqbLwCU0wAb_jPfW2VCCechhVhFcxlw_1NeU
Message-ID: <CABqFBbCRUuiTTi6mRdmjGCHW6dsiFsjCZTtupjuEOTL8TSBWyg@mail.gmail.com>
Subject: [BUG] Bluetooth: ISO: PA sync is never terminated on close when
 BT_DEFER_SETUP is not set
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

When using a BTPROTO_ISO Broadcast Sink socket without BT_DEFER_SETUP,
closing both the listening PA-sync socket and the accepted BIS socket
does not trigger HCI_LE_Periodic_Advertising_Terminate_Sync (0x2046).
The controller keeps the periodic advertising sync handle active, so a
subsequent sync attempt to the same peer and SID fails with HCI error
0x0b (Connection Already Exists) until the PA sync supervision timeout
expires (or indefinitely if the broadcaster keeps transmitting).

Environment
-----------
- Kernel tested: 7.0.0-34-generic (Ubuntu 24.04.5 LTS)
- Upstream inspection: verified the same code path on torvalds/linux master
- Socket usage: BTPROTO_ISO (SOCK_SEQPACKET), broadcast sink bind() ->
  listen() -> poll()/accept() without BT_DEFER_SETUP, then close()

Observed HCI Trace (bluetooth-monitor)
--------------------------------------
1. Socket 1 bind(peer, sid=7, bis=1) -> listen() -> accept() -> close(listener):
   12:23:21.712  host -> ctrl  LE Periodic Advertising Create Sync (SID=0x07)
   12:23:21.896  ctrl -> host  LE Periodic Advertising Sync
Established (Status 0x00, Sync Handle 0x0000)
   12:23:21.898  ctrl -> host  LE Periodic Advertising Report [v1]
(Sync Handle 0x0000)
   12:23:21.901  ctrl -> host  LE BIGInfo Advertising Report (Sync
Handle 0x0000)
   12:23:21.901  host -> ctrl  LE BIG Create Sync
   12:23:21.917  ctrl -> host  LE BIG Sync Established (Status 0x00)
   (listener fd closed right after accept(); accepted BIS fd kept open)

   Throughout the session, the controller continues reporting
   LE Periodic Advertising Report [v1] and LE BIGInfo Advertising Report
   every 80 ms on Sync Handle 0x0000.

2. Close accepted BIS fd:
   12:23:37.448  host -> ctrl  LE BIG Terminate Sync
   12:23:37.449  ctrl -> host  Command Complete (LE BIG Terminate
Sync, Status 0x00)
   (No HCI_LE_Periodic_Advertising_Terminate_Sync is ever sent.)

3. Next sync attempt 5.7 s later on Socket 2:
   12:23:43.134  host -> ctrl  LE Periodic Advertising Create Sync
(same peer, SID=0x07)
   12:23:43.135  ctrl -> host  Command Status: ACL Connection Already
Exists (0x0b)
   12:23:47.416  ctrl -> host  LE Periodic Advertising Sync Lost (Sync
Handle 0x0000)
   (Socket 2 times out because the old Sync Handle 0x0000 was still active.)

Root Cause Analysis
-------------------
1. In net/bluetooth/hci_conn.c, hci_le_big_terminate() only sets
   d->pa_sync_term = true (to call hci_le_pa_terminate_sync()) when:

       if (conn->type == PA_LINK &&
           test_and_clear_bit(HCI_CONN_PA_SYNC, conn->flags))

2. However, on the non-deferred listen() path, HCI_CONN_PA_SYNC is never
   set on the PA_LINK hci_conn:
   - hci_le_pa_sync_established_evt() (net/bluetooth/hci_event.c) sets
     conn->sync_handle on the PA_LINK hcon, but does not set
     HCI_CONN_PA_SYNC.
   - hci_le_per_adv_report_evt() (net/bluetooth/hci_event.c) returns early
     when !(flags & HCI_PROTO_DEFER), skipping set_bit(HCI_CONN_PA_SYNC,
     pa_sync->flags).
   - hci_le_big_sync_established_evt() sets HCI_CONN_PA_SYNC only on the
     child BIS_LINK hcon (not on the PA_LINK hcon).

3. As a result, when the PA_LINK socket closes, bis_cleanup() ->
   hci_le_big_terminate() sees HCI_CONN_PA_SYNC clear on the PA_LINK
   hcon and skips hci_le_pa_terminate_sync(). Closing the BIS_LINK socket
   only sends HCI_LE_BIG_Terminate_Sync because conn->type != PA_LINK.
   Per Bluetooth Core Spec Vol 4, Part E Section 7.8.67 / 7.8.107,
   LE_BIG_Terminate_Sync does not terminate PA sync, so the controller
   retains Sync_Handle and rejects the next LE_Periodic_Advertising_Create_Sync
   for the same advertiser and SID with 0x0b (Connection Already Exists).

Expected Behavior
-----------------
Closing the PA sync / broadcast sink socket(s) should send
HCI_LE_Periodic_Advertising_Terminate_Sync when no remaining BIS/PA
consumers hold the sync handle, regardless of whether BT_DEFER_SETUP
was enabled. Setting HCI_CONN_PA_SYNC on the PA_LINK connection upon
successful HCI_EV_LE_PA_SYNC_ESTABLISHED (ev->status == 0) would allow
hci_le_big_terminate() to terminate the PA sync cleanly on teardown.

Best regards,
Kelvin You
