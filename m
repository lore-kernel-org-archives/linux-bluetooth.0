Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739857;
	b=KaFf1xGbm6xZAEbuJhYJxboUTEG4My4SjD1ltZrvPxvnvSej5wXyV1T/5f+bzg6VtACE
	 2E6wPLdfNPzDC6nObJS5Cjtr/wwsqdhlawf5Kbt+AFGA6v6y3gBCU0PNISLwL+/dU+nPu
	 VSzRNa/bhlIaA75OD8b/TQBpo3VTLTbx6aqkmxsjuV/oW9Psya5LHw8es5Oknxr3PPfPU
	 SkFOl7zM64/cP8POxZ/VvxNtqgKDJ+nwmQR7jfZ9rGhCeN8OyV22TMGYt98xmCfqZR4bu
	 Act+A29idPAowEzDzLGO3EwL6Uwj0dlXpO0yMsIcYiImiBufTw+21b5ykRAs/EVMp3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=oFecwN3RYDD4yV0jcK6iKdh1p+H+i4Dh/TZHPXt8v94=;
	b=DBALCTj65R6wwnEVNt1E53GQYkmRigAxxpAAdJ5CvSUfVXCZx60LGjDuJb2c9CAL1ZR1
	 nogCpNqkQmiovHWzDIewDbVe+dgACzSdsRA4MHlXW9Ybia5uzIbeDBCSbHZG604BI/+Nx
	 6ZeQkt2gwj7pFSGQMsKE1cP2wnafKwdbShIWUi3HgX0ySIZ5YGSXoTZcEqDgKryYSSnhU
	 AYQjcWzFYGoIjY6HDy0oi+NZjfEEuZnbytanUX7Rj+QR8D3khLY8PiJAriBWfqZ7uwDzG
	 clMIJ0Ij5SJumxSaKPZ/wg7b+QYP1jtH5XKEPKZplsHjXiaoLLS/Nwzg9GbkPyPH1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=K0GZfDjj;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AE606A322
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 07:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5AE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=K0GZfDjj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso5830435e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792739856; x=1793344656; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFecwN3RYDD4yV0jcK6iKdh1p+H+i4Dh/TZHPXt8v94=;
        b=K0GZfDjjev+MRYwCLjtTqqo10IhI376lT4ECs5nRFEnQMGAyAvyP7qqt8Gtef837Pj
         bTOspWP+ml/IUdbK4C9YGGzJty97pw9pDnr7U22/m39tsXwmXfMjaBE8VgDqh9qnkFcC
         SHiHbnskVXSePsxzuxHVycriMTZn2sbHODY3HhhYpRt9aFGbNlt7bafHx0MMGpygCLtp
         oBYDEqebBwaxEorehdDsRrkN+F/7wB2+q5nkIQ144cdnE+Gc+jDf1uGubxUczIjlKkki
         HdYCu72wqq2oy2rXKZoEYcCYsAmoB01HO/eSVNaZMthIVKClxnWY6HlUSuf+2BgsRcfi
         QZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739856; x=1793344656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oFecwN3RYDD4yV0jcK6iKdh1p+H+i4Dh/TZHPXt8v94=;
        b=awyOSdwUQsUOykjN8cnbMdn+0HvDIwV/wDwQSmiKCL6sBenAqZ0wzWM5DgiScP/OSU
         r7MR26n/z+srkKVxo6YKNedDLt0y3iz1bjFtRY8sZNnbS0SGxPDsQziJrsvFibdnN5aP
         mBADbh6cWjnFcKiSvYzcBqbZnuCyS7H9xnC//a2p/7TGct/6KkudIuVPpWRDOiKX37Q9
         pxPcQWebOFbWi+t9cINb39/tn3UefKhUX27j8zHMACT+iTKKaHZhj+4iinmhdf5w1PcP
         lApbLtOE60X+ny8hg0CVgrhDvaXxokXQxT3fErHWV5Apx8QK4EUlxyEPj0MTFegIxhqo
         Fokg==
X-Forwarded-Encrypted: i=1; AKwUvBw96DaOeUFadq7eP2yr/+YEHhCxbjmS8Ka4FzGPdDDC58VH/xbLxxTYHb3z80z/ByozOAo+3pKuvDFEFzsLZHU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI18jd5U1koJhH3wR8HUPMWKt944n2nQuvb1CwtcxJHOunw3NHe
	XWgCMjHhJR/BuLSsMa7mPGLCWYmiPVxD8rDpFeHK9i4z8+ZcHrL4pnia6VUy+8rOpWnK2DGWRSX
	z6GzACVI=
X-Gm-Gg: AYBFou1h1UwLcJa1DbgKnx4Ki5yT1Y6lJ7g1DMIJT7RNjs7YCskgmHUCS3R+tRAXsUw
	DCIi1fY4Pm1QE+XjNBxZBKFUKz5OgCAQNc/lNX5tldNirNPBUT/7Nx5c72deRQPJHqlPMEK27yt
	BsHKYPJ2qtdihyIWiXP/lsSKOdkDYcoKxtOIJwgp6CSQX+z01vd0gBysqpr0OA6QHZ3MOp2u1pp
	16xhUKVfBYGIkO4xx36r9H9KpXJkLDXW6/NqqZUM+S2rUoJ85buxW77zYCnGedANvULlaPGZNpS
	gXzjFgiD3ChlC3QUui7M+iGw8yFns3qi+wzGmtVb20eJma3lYcT3jdpPsr52C6qGM1W0/ITx7JF
	MedxYIX86H76/aYWbubuuXbAsXDmtbrDooG5ZHzVWoJDc6zFcdyiC8YfTv6Yc/p7QOkL/9jsJVD
	AmJQFru7jpWunE8bl2smrsQuY2zoZK1pbUot7IrikAKadl/3XRY5aQZEP1Te8VNY1+aUNsWHAHR
	YQb2SRO5L4iqFn4mIeXCEMdmbHiUkfOKihw/8gmvjDHGChx7tpFstmOPOs9EjeM4Q==
X-Received: by 2002:a05:600c:a00c:b0:4a2:397:73f2 with SMTP id 5b1f17b1804b1-4a211cd477cmr20493595e9.17.1792739855542;
        Fri, 23 Oct 2026 00:17:35 -0700 (PDT)
Received: from linux-691t ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7af6eeb9sm6750895ad.4.2026.10.23.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:17:34 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:17:24 +0800
From: joeyli <jlee@suse.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, jlee@suse.com
Subject: Re: [PATCH] Bluetooth: SMP: Fail if the X coordinate of remote and
 local public keys are identical
Message-ID: <atsKBPdEtsxMFP6r@linux-691t>
References: <20261021093522.3536051-1-jlee@suse.com>
 <CABBYNZ+7ro4EHt8DXL-Oo_tgN1bn5av_KkGtaXXU7YqoQ0vDxQ@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+7ro4EHt8DXL-Oo_tgN1bn5av_KkGtaXXU7YqoQ0vDxQ@mail.gmail.com>

Hi Luiz, 

Thanks for your review!

On Wed, Oct 21, 2026 at 10:00:41AM -0400, Luiz Augusto von Dentz wrote:
> Hi Chun-Yi,
> 
> On Wed, Oct 21, 2026 at 5:35 AM Chun-Yi Lee <joeyli.kernel@gmail.com> wrote:
> >
> > The 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys
> > are identical") patch be introduced since v5.13. Looks this patch can
> > handle the CVE-2021-37577 issue. However, it only checks if the full
> > 64-byte public key (X and Y coordinates) is identical, which is
> > insufficient.
> >
> > In CVE-2021-37577:
> > Bluetooth LE and BR/EDR Secure Connections pairing and Secure Simple
> > Pairing using the Passkey entry protocol in Bluetooth Core
> > Specifications 2.1 through 5.3 may permit an unauthenticated
> > man-in-the-middle attacker to identify the Passkey used during pairing
> > by reflection of a crafted public key with the same X coordinate as the
> > offered public key and by reflection of the authentication evidence of
> > the initiating device, potentially permitting this attacker to complete
> > authenticated pairing with the responding device using the correct
> > Passkey for the pairing session. This is a related issue to
> > CVE-2020-26558.
> >
> > And base on spec, the remote and local public key should not have
> > the same X coordinate:
> >
> > Bluetooth Core Specification Version: v5.4
> > (7.1 PHASE 1: PUBLIC KEY EXCHANGE)
> > "If the two public keys have the same X coordinate and neither is the
> > debug key (see [Vol 4] Part E, Section 7.6.4), each device should fail
> > the pairing process."
> >
> > Bluetooth Core Specification Version: v6.0
> > (7.1 Phase 1: Public key exchange)
> > "If the two public keys have the same X coordinate and neither is the
> > debug key (see [Vol 4] Part E, Section 7.6.4), each device shall fail
> > the pairing process."
> >
> > Update the check in smp_cmd_public_key() to only compare the 32-byte X
> > coordinate of the public keys, making the validation strictly compliant
> > with the specification and effectively mitigating CVE-2021-37577.
> >
> > Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
> > Link: https://nvd.nist.gov/vuln/detail/cve-2021-37577
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > ---
> >  net/bluetooth/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 2df303f6a38f..80128b31e631 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -2734,7 +2734,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
> >          * not in use.
> >          */
> >         if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
> > -           !crypto_memneq(key, smp->local_pk, 64)) {
> > +           !crypto_memneq(key, smp->local_pk, 32)) {
> >                 bt_dev_err(hdev, "Remote and local public keys are identical");
> >                 return SMP_DHKEY_CHECK_FAILED;
> >         }
> > --
> > 2.51.0
> 
> Sashiko is flagging a problem:
> 
> https://sashiko.dev/#/patchset/20261021093522.3536051-1-jlee%40suse.com

Thanks for your reminder! I will fix it.

> 
> That said I do wonder if the check is only truly valid as an
> initiator, since as a responder, this could be checked before
> responding in the unlikely event that the X coordinate happens to be
> the exact same as the initiator's (if that is even possible).
>

Honestly I'm not familiar with Bluetooth. How about the following change?
It also checks local pk before Responsor sends public key to
Initiator:

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 80128b31e631..d1786e398128 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1889,6 +1889,16 @@ static u8 sc_send_public_key(struct smp_chan *smp)
        }
 
 done:
+       /* Check if remote and local public keys are the same and debug key is
+        * not in use.
+        */
+       if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
+           !test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+           !crypto_memneq(smp->remote_pk, smp->local_pk, 32)) {
+               bt_dev_err(hdev, "Remote and local public keys are identical");
+               return SMP_DHKEY_CHECK_FAILED;
+       }
+
        SMP_DBG("Local Public Key X: %32phN", smp->local_pk);
        SMP_DBG("Local Public Key Y: %32phN", smp->local_pk + 32);
 
@@ -2734,6 +2744,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
         * not in use.
         */
        if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
+           test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
            !crypto_memneq(key, smp->local_pk, 32)) {
                bt_dev_err(hdev, "Remote and local public keys are identical");
                return SMP_DHKEY_CHECK_FAILED;

Thanks a lot! 
Joey Lee
