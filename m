Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C273B4EBF;
	Fri,  8 May 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241499; cv=none; b=ivM673IwLKSaHoqIJ231aHDdE5p5D7UOZqYX83rHNf5BU8Lqd+Suf8f666UXd20TXfyjzq1NqPGPMsyyZQaiO2xDvSdLlVvqw/dZRvFUtF72tk4TepOA08Nde7bo69GsF4+iHfo64P/qQZlhYS5fhf35oBBgMIr2t383Yt7e0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241499; c=relaxed/simple;
	bh=85dTceD0IWboELxihnqRVHzi7RDeZJAOaAXgcRQkFpc=;
	h=Date:Message-ID:From:To:Cc:Subject:Content-Type; b=DRIngdVdkzb022BvKAq8ZM1hJezzC+iIDUXj51xfijgTI4D4aB2R9jrR5MEx5VSG8Nufzlba4TL5yL2N2I/NV4gaq0aSgSQLjzmMNU+/u1AR3K3Z85HUePRtdc9lr2zwWhQL/3OvWWC32uba/HDhYNdlpnCjwnmvYvCMxhpgBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com; spf=pass smtp.mailfrom=desarrollaria.com; dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b=xhCGkGq4; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b="xhCGkGq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desarrollaria.com;
	s=s1-ionos; t=1778241495; x=1778846295; i=y2k@desarrollaria.com;
	bh=igq5MOPxA7P+ODUeQe+UTATdqArvLfUvAFWoZXb7zwY=;
	h=X-UI-Sender-Class:Date:Message-ID:From:To:Cc:Subject:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=xhCGkGq4rpHs2N5PU7+WAb5wGVN/HZQ70ch+6qHiXU/IyTVBzjOj2O+dNLPaxcmN
	 7tAF5vIOiJf0oFLBYp9MxIMKvIG0nSw2xF0ud/fYvugdA3skHTbwxF765uZ88uxCV
	 2C1DyT7kYMSdG5OH4sEcOReRYQdDz47cM8cRkKSUXhHdN0LKKcIkGMBy7vO7zI29c
	 k4/YkzNesucPX4MNQyHTqXkQenTcSivNAhpTUorGLx1+G+yXOCXUhnrIsk3kAZfC0
	 HEp/wF+0TID8r/fA6aJYRzuMl2HdxiejewwvUvEwS2PSd6MJfjb6xDOBQYg3TLXp/
	 nm34y33xoi7VVSjoBQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1MQeDw-1vyiAT1XOA-00IkEY; Fri, 08
 May 2026 13:53:03 +0200
Date: Fri, 08 May 2026 13:53:02 +0200
Message-ID: <b02f7394c751e4313442cd156e00c38a.y2k@desarrollaria.com>
From: y2k <y2k@desarrollaria.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Bluetooth: RFCOMM: missing sock_hold() in rfcomm_get_sock_by_channel()
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:UHmHS/4tfWMVSt9LZav6qcqnAepwIPZonEBXx3J4L8eOo0aNNwP
 PRBwFcW1xSzRBRn50fZFvfUHPB4Gq3miD1nMu9Fc+r8jvVcyZ+4C6FnrHRnkNsSw9+FnfXX
 84W2hFzeKNSDNJxLp+CsVW5+LaJFoZvKz8b7cmkx4nUPpdWUadRxlODZ0+ZPIXeRJ/g8RGA
 sseN9/Sa+BQfjyWgudZpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PrQRY6Lw4Fs=;NhT+x+3VGomMujocvmgak5Ankaq
 Kd0mX3HNrsbR1dtXiFtzBq3TtJPZUKc4lgob5GNZmxkWkdv7DXePctRjDA9a+J8SsO+YcLaUj
 D/WzvOWF89LaUOIsIjgxzxj0k5IMctJMDRA5HOZBSmvdgd9MkUQW/B/Ka7H5N/DzpCHpvF7v2
 9zk5zMXuNQzXA5cloRNVlxkvWU9lu83Nlro9gxxiv80F6t3vtQcYYEvPyuGa+MALNL0u9YTNe
 49LGJeLu9aBmDi2XPZsISzKcSuEbCTsfhiVEUytnes5QMxqON3JSbMLg0lnWTADJ26Xgyhg99
 VtreO/d5DhCUzvrpaT1lvZ3JMlTyJ3Fq3tAd5vjyRenJZXZOkHn9NWnfzxjOm/tZJCeajsRFG
 8EjLg3pCfToK2q91a5AUf0GDJfLrvzGvVE+106Uu7aAn0Buz0+YsQ8VNbpoa6JPIsBlpLMo2Z
 BsfxzVck5YggVOWtqH1kQ7EIt5qUXn8DvPtytF0D/kwFwc6b3Fbago5w7JxEp7+6c6Ckivu8z
 smDVRI9XsOiNBWmrRDoTFOtRIUjL3LEZ3fKV2HJDz1gZq3Su7PasDzF5+M59cHWZ+3/Uhicvf
 bR8PVOQe5j7b21JqZhNkMURZliA8XJCFMSdYdGkG4bmqwFKNrHheHvtOKaKl7d2ug+b5MfRHd
 mvnL8fYmgZujsM38SRxsxttlaB+gOFqxsG/coUrSysnY7larKCwjz5K6qfwAKjpL28Q1uxBtr
 U9KYMnD5ZLUgMMJ14r9ep85KMmAVM97fHPxIUrhtsKszt0kxeZjF5jiFWh+tgvWwmUByOuWwH
 RISDnAA5BK4NxNCgfDIrD0VC/d4upXR9u4mCTHydH8cMB5irwvOIzUEUVZr0VgvBqgIRRCgoH
 s0Ukol7bh138ekuTPpQg2+sH8kASlSBd0DBqv5R1XvRo+UiuckIsOTdJ0DjwWMDCRRteHfc3Z
 d2Qkl11+J3vOVMhdFcw41Bc3+w0PSu05n4/HDKe6vtcNsUOlVueyNYbzRM3bM+cPX10YYdRpk
 uo77CUklaLhLEMxanuW5xsfuoHdo5dnRh+nhPhJ4VPzPu9PCHXVLfTQ5JYQJAoQC70LoLEYP2
 zzUvWAQb6ojXv+Jy5RXGVxSaxPphLsJd7UU3VEK40oFiRn7qOx+gtoAwX2IHdSMjYNvG+PPwz
 Ce6mk7m3kB3RR3WglgymkuCTsaFCPXzIipxJUEBgY5FSkMfEQZDn1sFq/PGRvg9LG2v8ll1vl
 wLGWpxMFsjBTgZ16CaGnaG59Uo6w4d9oWYerNj4a4fol8HAVewmS8wSdMtues0liUSi2KwjkW
 JvPgW+uXlq7UOR3/vBqoCXIBd6A45W06rIeAyp/oNVD4KPXhRteN/uv7hS1Pqi/mQoX0pIXQh
 /itwo8JE3mZgM2UAHeirdseNq9EZHAhZqwBtGiYfRd6PG3D3U5B8aHPCsi7SbihoRWIktkrgM
 1Kt2CfUPnqx8qcKn+s4KnQvGsHS/7hoBDkPU+5mmRKY+Ep0hh1Q7TAIYWyUBcWEznO/I5p+n5
 R92TGMGnzzJ3ZOBsSXU+ffL1kM5LY8gZZ/88fUDCU2wvnc0KbSMInbRmvVrXt1iPMLrvqZt9u
 A5j31xPTZZ5OFnPvB7UW/rq0cXlM9K5lvfbTzsjqlGiRAdMNeweHm4BpwMwli4yiX8/KahxKn
 by1jc71zVJ6TUZZiNeclx0k/eoQ3gMUJNTnz5SbdkHFNAWMVaE0u+MRZ19mQsnKTcidQDnAXO
 ZVj2jece2tq2MY36MapIk7vDiG6/nDgi2l/RZ0jmg9JJrnBL/DcKupCupCDsEA3BTPdz3OQIr
 dOdMZvUqy1mtMelA7WWCiMPm4FNJYS4sO/RpjXfNFIGw8Z6yLN2v1xrn9KhRRHgh6DtV3A7D6
 94uyj9XEfehZsYTbhMTBst4uq91xes4lfZQwj4HA9dgHVjG1CenSy530pJhtTIkHMyc3ZqSmh
 0HiWNCvT20AZ4pJFimUuf7+8z+FG54UF8pmYhQhx81IzgbtPmTzbl3nArTa1UjtGdlqglLoa5
 hlFP1qkoJ8JElM+q0S0PtDrTgGzlkbknmq11YSKx6lQrnk40ghlRF81VvVuaMF4v1/I731QTW
 FHGNcYOkaMGBLs62n0bwnEtYYHdZKiQ5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

Commit 4e37f6452d58 ("Bluetooth: SCO: hold sk properly in sco_conn_ready")
fixed a UAF in SCO by adding sock_hold() before returning a socket pointer
from sco_get_sock_listen(). The RFCOMM counterpart has the same problem.

rfcomm_get_sock_by_channel() returns a socket pointer without holding a
reference. The caller rfcomm_connect_ind() then calls lock_sock() on the
returned pointer:

  parent = rfcomm_get_sock_by_channel(BT_LISTEN, channel, &src);
  if (!parent)
      return 0;
  lock_sock(parent);   /* UAF if parent was freed */

rfcomm_get_sock_by_channel() holds read_lock(&rfcomm_sk_list.lock) during
the search but releases it before returning. Between the return and the
lock_sock() call, the socket can be closed and freed by another thread
since rfcomm_sock_release() does not take rfcomm_lock().

rfcomm_connect_ind() is called under rfcomm_lock() but the socket close
path does not take rfcomm_lock(), so there is no mutual exclusion.

The race condition is:

  Thread 1 (rfcomm_connect_ind)    Thread 2 (rfcomm_sock_release)
  rfcomm_get_sock_by_channel()
    returns parent (no sock_hold)
                                    __rfcomm_sock_close()
                                      SOCK_ZAPPED set
                                    sock_orphan() -> sk_socket = NULL
                                    rfcomm_sock_kill()
                                      sock_put() -> refcount=0 -> FREE
  lock_sock(parent)  <- UAF

The fix should mirror 4e37f6452d58: add sock_hold() before returning
the socket in rfcomm_get_sock_by_channel(), and sock_put() after
lock_sock() in rfcomm_connect_ind().

Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")
Reported-by: y2k <y2k@desarrollaria.com>

Thanks,
y2k
y2k@desarrollaria.com
