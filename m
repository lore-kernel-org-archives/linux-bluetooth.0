Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A752CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 17:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJRRFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRRFN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 13:05:13 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B547118
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 10:05:10 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S9cfV1myrz49Q5W;
        Wed, 18 Oct 2023 20:05:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1697648706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+hJ5cfobUL1Bv8d3R8Okvt4Ltsxzls6htrMvfbb+xlY=;
        b=irE7sZBVCLgjzFVxl627JoCMLECz9l/fuR8qYbKfQNc9rpeHT4ZF3/+tbPrwwoBmmhDOm5
        +XQ8Vl+qcgX9xNlzBOuI5vCFBV1Disb+VRDPf0t7nUZFplHr0l6+GXMFZAJrgYM9PFZimj
        MVWFUk0g1gz/Bhgx4tfmMEjg5+RW9vzxa/yjBd+LZTRtTA4qYyZ/U9sR/VS7V7Aoa2qMIQ
        2V4Q9eYf3y8RF5mQ1Owcf5tp3AXpRx/4jI5Qm9HugoHKREPosplZssdcLsSOpZKVxLVams
        L4OR6yZK7bK1ecO9G+/JAIXNDRuB2QlCNrlkmb631N7rZWYF4BbtGClE+WYiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1697648706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+hJ5cfobUL1Bv8d3R8Okvt4Ltsxzls6htrMvfbb+xlY=;
        b=E/0a2HjYCgqcCtYWKNB+lLH9sYCybbmAqve2rpCbhULZcv3k4B12qtm7qj44Rc9KeNiX0V
        wAZwPIfRf5In2/V7M6N04cgRtqKt5EvimdFZiwefAKXcxkPx2oF/8COhvCDr8209p3rCgo
        3g7GcAH/h3snZAQkoekch+M2BbPH9DQIGyTO2MIijFKSAgZRuc8A8Wv4/oPVUhukHMyMs1
        Awwh1F8HasQ1ApJB0QIbHIbze0pVQ02eCSQkiP8AxWsUr4whsG6pLQ6OVamMEx+uUD6/b3
        4MzSp+fQIEyVIKXZOPPXAeQWPr01sEEiEjlm7z5NSK1vwxFscFr8GTJRMcrV0w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1697648706; a=rsa-sha256;
        cv=none;
        b=M+r+xSB5P5ukzBN76xcpYowCb4NK2kYF8q3UA904vL2dIXQVF94zg+pVnucXaHeLFPYIw0
        NbVoW7LypUiPFPfRVsVbpgfRC++sRrQvloFJY0T+/1PYXTBQ+4UCIbV+Gc0+BquGDR0brF
        RWBrxprGcajkvHkEV9fLEeUkqQTpZI7mGMfgvvcVlBL5rPk25iQ8vUSxJgtQm0D1Btu7wo
        jOUcC6ivgb3p6jC/C++3vMZbXDDWbC0TNXwTD9kpQUZZmUJRej6gpr8W8obFp4SesIhDAX
        6z7dEUtkWAFDQESVehgXbwke3tC2VZNelnVBr/E3eG8vH1+Te3M46MRExqnwBQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <67463c6bf63ae16d7807d23693b2f058496a54e2.camel@iki.fi>
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Allow binding a PA sync socket
From:   Pauli Virtanen <pav@iki.fi>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 18 Oct 2023 20:05:02 +0300
In-Reply-To: <20231018143435.3388-2-iulia.tanasescu@nxp.com>
References: <20231018143435.3388-1-iulia.tanasescu@nxp.com>
         <20231018143435.3388-2-iulia.tanasescu@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ke, 2023-10-18 kello 17:34 +0300, Iulia Tanasescu kirjoitti:
> This makes it possible to bind a PA sync socket to a number of BISes
> before issuing the BIG Create Sync command.
>=20
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 07b80e97aead..f20238c4702f 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -813,6 +813,37 @@ static int iso_sock_bind_bc(struct socket *sock, str=
uct sockaddr *addr,
>  	return 0;
>  }
> =20
> +static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
> +			       int addr_len)
> +{
> +	int err =3D 0;
> +
> +	if (sk->sk_type !=3D SOCK_SEQPACKET) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> +
> +	if (addr_len <=3D sizeof(*sa)) {
> +		err =3D -EINVAL;
> +		goto done;
> +	}
> +

This does not seem to check addr_len is big enough, sizeof(*sa) won't
count the sa->iso_bc flexible array member.=20

That sa->iso_bc->bc_num_bis <=3D ISO_MAX_NUM_BIS is not checked, so
memcpy may write out of bounds.

The values in sa come from user, so may be invalid.

iso_sock_bind_bc seems to have similar issue.

Sorry for second round comments.

> +	iso_pi(sk)->bc_num_bis =3D sa->iso_bc->bc_num_bis;
> +
> +	for (int i =3D 0; i < iso_pi(sk)->bc_num_bis; i++)
> +		if (sa->iso_bc->bc_bis[i] < 0x01 ||
> +		    sa->iso_bc->bc_bis[i] > 0x1f) {
> +			err =3D -EINVAL;
> +			goto done;
> +		}
> +
> +	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
> +	       iso_pi(sk)->bc_num_bis);
> +
> +done:
> +	return err;
> +}
> +
>  static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
>  			 int addr_len)
>  {
> @@ -828,6 +859,15 @@ static int iso_sock_bind(struct socket *sock, struct=
 sockaddr *addr,
> =20
>  	lock_sock(sk);
> =20
> +	/* Allow the user to bind a PA sync socket to a number
> +	 * of BISes to sync to.
> +	 */
> +	if (sk->sk_state =3D=3D BT_CONNECT2 &&
> +	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> +		err =3D iso_sock_bind_pa_sk(sk, sa, addr_len);
> +		goto done;
> +	}
> +
>  	if (sk->sk_state !=3D BT_OPEN) {
>  		err =3D -EBADFD;
>  		goto done;

