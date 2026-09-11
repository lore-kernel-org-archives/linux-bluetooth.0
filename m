Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80793B95FF
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155184; cv=pass; b=d2gJUT396KVD/kbWxlMsAIEaU7fRJ0hDJALiJnoqxjuxTh/JzvJ8O/RcruuLiClUS9oQVxH8D15fPNetOPuCT1wSnhf66eNKSzgtCcG1GmK69BVw5/lzGuhbmRftZvE0JxOwvSKqKuflKhscprgaK+OaWYsaOUsBya2D5dKYbZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155184; c=relaxed/simple;
	bh=CGyOJflPw9TgiV+rqedwCHC27ERtreB0Gsv6VIvPr90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj3wBjLDaQAY87feoeqAa5PFcPThQ87tzIkUuhVONfU0jRA0gRPm6jJ5inZPVzUkTh0FjGSoPG8UeWrq05+KT8z88ihku4kEYxdMzKSBqkknOu3GQva+TbVUzc6OIZUEGq5m8JC/zwLMNNkfCoQM0r1ZDFtPq83omf4hW7Whl1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm/oUhEH; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm/oUhEH"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66fcf87897fso1843187d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 12:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789155173; cv=none;
        d=google.com; s=arc-20260327;
        b=WEpOy04SXpoTKkRKjtMFcT5p6hnsOD6N4oeYvczgeKRC9vVjYZtHfvNSgYK28TP/JP
         Q7lF5UMrWNujJd3LCGn67ahhAD6HcTdcSImFJ2R4sy8zAeZpLj8UNOwDFRX+N52UIqQb
         CxmtWsADlIca66g5QNOpq5GnP0kAjFAdKf5yjDJXJ8uNCNQ69XEAgNJ/XioiLqJAPmW4
         764lX6c6mTQ+YyGTcM1rvtypwfJdda6jd5xS1Wm2cGI48D3bcgMCZgJrcYUq0Edm2BUp
         EewB1ZAP0CsTL2u8/zkVp0Vm3Db1JC2h2MWdMMU7eiDk15PYy2dYKbPDcRDQTQfaXeBs
         wbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rJ/7COLhmxpolU24jgY2LdSFwnw3Shgdsy8Wx+a790=;
        fh=YnGFie0KD2pM97AvW3RJsbpr/bswbYyftM9oh+ZPNhM=;
        b=Dl4JzzFT8Zo2jCzIhWX8/3TJGkMiVnYsihxSqjMIBld+46Y85N17lOhogATKgGOpWS
         puwVN7Q3y/d195oPmb31DtaQc6fWNQdhFxiWMaNYu9x+5nfoVqnRrjtJ2oTea5oynkVW
         gPJqwUGMTGCOhjyaiqEppLDxlb1ez9thV6F2iLSNk4pUc0+Lb9HSxuKJVjlvosw7vVLP
         0UVl/RI8unPV9pqpgn4QXyz3lSIk8hW086xmbo8+kCEOiuzMKtR+mwtyqd9v/MK4yFyA
         hUkotZN5WsXkk+X5lSJb185hqbQOUrWE4pCJpr+Qusoyn6lDlV5o/SBsYmxWQVRNfFDA
         +2BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789155173; x=1789759973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rJ/7COLhmxpolU24jgY2LdSFwnw3Shgdsy8Wx+a790=;
        b=Pm/oUhEHcqPF43r2HvKgd0CydFNW8cBsXI6K59+mMSlso0bKPZ6hXu96UZBd1MRqAk
         4+3131sVWFYveKQigE6rBRsXxF7pp0XR+4lYbkTFOn+VK4Geu0tMLnr3OGYjlsrfMhok
         AE6a+7xdtyOiaPql/tXmhfMcymORcfLuY2VQFQWv3BjERrBN1Tat00rtMiPHTYOaX9Ms
         rC0C+ZaiUO4bKHGgXozk04YiQwkGOMS4B44FA+gGOtZG5zHRBdEjU3rlpKIfX+XNolz6
         UYF2OWuxPX5h3Uf28jMXl8pf7ibY2IONKkTXAzfERpNKUnl52+GsSeBVmdUfv/EwhClj
         ktIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155173; x=1789759973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rJ/7COLhmxpolU24jgY2LdSFwnw3Shgdsy8Wx+a790=;
        b=PhGM2S9X4186a6djNtFw53vi98W6nXbk/2UW4njl2erJigvyRRj1cjBuPN8ub3FTtE
         3238OaYgJ6Jk+6zFWv5JuynwbdgjaV4lIP9nX/NJ4tbCAS/cKykz1CgWmoNUGsWuG6JD
         EOEpo41zlhCpuwWxsYem0jQDDWdxN+KvBWRxoWbPJZ/tNR1TEm3Ze53RKFnpR4LMdAmE
         6fCpNJFtW6sHpltdqfnfkXjX+MicyU/zzPN6HkA9DfEzH8F1nYgxqP6yjvwNIf2ngQ2z
         /mZBv2cTxfWDxpnFWA6dOI4JzbF82ZI724VvUMH89Iapc0F6VC+5Ru1NB1DxBxoxJbt5
         IvSQ==
X-Forwarded-Encrypted: i=1; AKwUvByMJb8dBRqXCIKI5rC0jByCbhz7u7hbh//GheudF78OE2NbSk2ox7RBrgDqFUnfpGt8i96CH0QbLZy+IVvxYK4=@vger.kernel.org
X-Gm-Message-State: AFuF++kmEVJkiWWAKG+ndmp23KTG4VrL9Oi4t/zovH8ysY/wlNUly6wl
	PAmwOcMiy+6EeQVKGTd+1U2qMGQen+qvXQMyC12Ud6Iu53GzD1G6RZsUbUuWOWRN0/to3/Df9Hj
	lId3PKAsHe95M3rvuZgUtQTFwodW0c2E=
X-Gm-Gg: AYBFou28DavUrWf4GLcN4rkQtL+djHI+ZMlRCAafuh7WzKzJEzSkScMSb7Jshdg1U8p
	bRFB5FNoth8DylTEj+rii2vnpXd1Tf/X+5t7WHAcygSf6CLeCpxSHC0okW8dEz99rG7G8WOlFYW
	rmOZ1OL9pfyWugWIFP9aC7yYCi16zRjixyj3LWss4+26DTMe/4bhLxAVQcT5Nf3QXdgCNpUegID
	9xSOV1EUMZ+pmt4Zyh8NSBDdgn3dGhQYejA0APWbiDtuV6nddyDRtrxyWMY4oGoJKgQC99abqbt
	FM5Roa0Z4lL2sGNcSfaN9cjOfXaI5N/BkR4gUQaHir83xRB4nto4WGJWQXeg8eo4qLyn0D+c7n6
	3D/uZSSPthFnLRQVxeb1k8BsCIC98dAxChiudZHI=
X-Received: by 2002:a05:690c:c50f:b0:865:c62b:6075 with SMTP id
 00721157ae682-884adfe8f7fmr22555577b3.2.1789155172327; Fri, 11 Sep 2026
 12:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
 <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com> <e316af2c02709047ae4982a72d92bebc7feb81e3.camel@iki.fi>
 <1ce72e4f26b5c35940a160d121cb479203e5d565.camel@gmail.com>
In-Reply-To: <1ce72e4f26b5c35940a160d121cb479203e5d565.camel@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Sep 2026 15:32:39 -0400
X-Gm-Features: AcwNN1W9JIb3p4fVmP5IRreVpehwt6CRRZxNeTdV1ae3_S4uHbdAWA_8dkBZJFE
Message-ID: <CABBYNZK6kzJ0z1Mi5s4Ju6wyd-G0TGidQBJsrnPWhFbDA0abqw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: defer security confirmation to krfcommd
To: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, marcel@holtmann.org, nicoyip.dev@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Sat, Sep 5, 2026 at 10:49=E2=80=AFAM mikhail.v.gavrilov@gmail.com
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi Pauli,
>
> thanks for running the checker, and for looking at this again.
>
> > This v2 checks session hci_conn is the same as original, however it
> is
> > unclear if delayed processing of confirmation on the same hci_conn,
> can
> > result to wrong outcomes.
> >
> > What makes it not introduce new race conditions?
>
> Only two values cross the window: status and encrypt.  Everything else
> is read when the confirmation is applied - the session lookup, the DLC
> list, d->state, d->sec_level, and conn->sec_level in
> hci_conn_check_secure(), the last one under hdev->lock as before.
>
> Confirmations are queued and drained FIFO, and krfcommd drains the
> whole queue in one pass before rfcomm_process_sessions(), so none is
> dropped or reordered.  Two encryption changes in the same window are
> applied in the order they arrived, and the last one wins, same as
> without the queue.
>
> That leaves stale status/encrypt applied to a DLC list that may have
> changed meanwhile, and every path they feed fails closed:
>
>   - RFCOMM_SEC_PENDING with stale status or encrypt =3D=3D 0 sets
>     RFCOMM_ENC_DROP, which drops the DLC;
>   - a stale success does not clear anything the next confirmation would
>     have acted on: if encryption really went away, that event is queued
>     too and reaches step two, which re-arms SEC_PENDING for
>     BT_SECURITY_MEDIUM and sets ENC_DROP for HIGH/FIPS;
>   - RFCOMM_AUTH_PENDING is answered with
>     !status && hci_conn_check_secure(conn, d->sec_level), and that
>     function reads the live conn->sec_level.  A stale failure can only
>     reject.  An accept still requires the link to be secure enough at
>     the time the decision is made.
>
> So a stale confirmation can close a DLC that would have survived; it
> cannot accept one that the current state of the link does not justify.
> A confirmation that cannot be allocated has the same effect - the DLC
> closes on its auth timeout.
>
> > GPT-5.6 produced report of pre-existing race condition where
> > security_cfm() races with DLC open and results to intermittent wrong
> > security level, but I didn't verify this was not nonsense.
>
> There is such a window and it is older than this patch.
> __rfcomm_dlc_open() sets RFCOMM_AUTH_PENDING on a new DLC when
> rfcomm_check_security() finds the request still in flight, and the next
> confirmation for that link clears the bit and answers with the status
> of whatever event it came from, which is not necessarily the request
> that DLC is waiting for.  Before this patch the callback took
> rfcomm_mutex and hit exactly the same DLC as soon as the opener
> released it.  The queue makes the window longer, it does not add a case
> that was not reachable.  Untangling that needs per-request state on the
> DLC and looks like separate work to me.
>
> > I wonder if the kernel_connect() could be moved out from under
> > rfcomm_mutex, since the RFCOMM channels should already have to handle
> > transition to CONNECTED state and possible failures there, and the
> lock
> > cycle solved from the other side.
>
> I agree that is the better place to fix it - it removes the inversion
> for any future callback that needs rfcomm_mutex, and it leaves the
> security confirmation synchronous, so none of the above has to be
> reasoned about at all.  Luiz suggested the same direction on the
> original thread.
>
> It is a rework of the connect path rather than a regression fix,
> though: rfcomm_session_create() would have to build and connect the
> socket outside the lock, and __rfcomm_dlc_open() would have to look the
> session up again after re-acquiring rfcomm_mutex and drop the socket it
> just made if another thread won the race.
>
> Luiz, which one do you want?  759c185d0bbd is in v7.3-rc1 and marked
> for stable, so the inversion is in a released tree and heading for the
> stable trees.  If you would rather have the small fix now and the
> connect-side rework in -next, v2 is here; if you want the connect side
> instead, I will write it - I would just rather not write it twice.

This is not small fix though, so I rather have the kernel_connect
rework fix this for good than doing one on top of the other.

> --
> Thanks,
> Mikhail



--=20
Luiz Augusto von Dentz
