Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAE43E9C8
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518882; cv=pass; b=PtJgDM8OMNn/k8vKdyq+AtlB0kUWRu+fA5yMkBJIwqDs95FLZ3bevMgpVAkbGWHN7nkBBn+LX3n7XuTXIZJQ5APUWWqRPnXoFktdvZlsfxZgodhpDff1lG+s35L5HddtxWK430w0sBUh8xiFwhniirxjDVTci2GygbG1inW6JLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518882; c=relaxed/simple;
	bh=sX76fFKdIdHWcvUPNAk6ORnTk1gk3SV4Auw12s3ZtLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSmWw4ldCHj1QIGMGuDb/VvHfh/goY6JFpUZBlHAqPHA3WQufMT6lA+EWUuiO/y32A+hRfV8aG6JsX0iJSQjtXJoOtEV1zSvaeJzzz02VKPYgoRU+gO7oY+KqKainA4oGXS3qhUcUmgFKmxRS+VnsLe2ryCHf8eqcibvMWo2xEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhEKgON8; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEKgON8"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bf695701so4799928d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518880; cv=none;
        d=google.com; s=arc-20240605;
        b=lCNacmbsHEq9jJUnYxpnJSySRriMhKf2QqGxd3/xb3Lo1F0nmowU3DivCP3lX7+c1P
         o3hwzzZm9JlIOcNSNR+zck/oedSsaMFQbHBGFrjeqjgWVpb56T8VJ1RhPANczzT71oaI
         /NOwbxXnjb/xbRHAfBfgqKxk71BSbSfnWTWaPTCRvoqFm0AQISU0RFbbZSiBjYuvrKkD
         wfb4qeqbjL3M/Ij27ANPA5BhNM/CFmfbxNnyxExJrvw2TXATHHaygMpGAoJJwZ3IOKlq
         Qc1FUXA3NeUac79h4kv8r99BARY9dq3HAwvzmWuCd+hhggYiV35aAd+LsCabDsH0+SoP
         vJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        fh=+Nd93flPUMGXad7+8/W57Y52jQy8blM4YjzW5HwkY2o=;
        b=brSbgvcJmX1eaLPKrZMR7uPxXhQw5L87dQdIxcaWSKl7q/bQlnJUSivCzLHBu+YcUO
         AbIBezNoGUi88RstgHxYZvqX+MBSB2CR/t3ngdD6MlTeMZlkctgW51jmZ96yLq07s8t9
         cz5blJe+XceU07kxVUcbJ4+Lbtceu9+xGq4StcKZKUaOcOWxrJS8MbQ47M6Q0b57EOVa
         iO9MkNrv9PO9XHHIaSPOdwoL6IlpuulgPxzXYRuCqgx92M8DMvyqNwJHM9DHZTAbUCx5
         nbxselGvBxnQXdlJyZ2Xs4MuPE57B5xk6wTLAO8rQuAvXBhybv+KghmPAeNGRAuGFwlJ
         JUdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518880; x=1779123680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=OhEKgON80OIy1TrQ5AedbWYWvXJkLRr3IZhNN7DgZU7cyH7SrhWJYPqsAi8s4ebSD8
         KL/hzXxjAXLYxa7zvr+3Gn7GznGYwUbRik3leQDjccaZ5ps4k5p8Oeqa1njPfoxTCIJd
         AuJ3xetEIp7x11qZl++Kw2107ViILLeOq9V+p1b+y7qggJGv2/Pq34esszFLe653MJID
         r5/G03+jQ5GUNz62wHT/0nSpkNOpgNQHd99WbGzd+awgzhR9kGtFZ6ODg9PnS2X8xVzl
         7fOwO0mhLL2Y3G9RjnWjBgsc0TFS+qM+aObqnH9stxbKckFsJCiUe17KjTzjsd3hH7sf
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518880; x=1779123680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=SheThLEBDy8lBRkCGUB97jqhBEs5lrBDCJzVRi1Xwhca8VILOsVnInnxrrxZ8goy45
         PmlMvSLkkh2DNWPgYHeLshUuUqkUOZ7kVogprBdKzhsrYdV/dbdt4kBbOpwthCi6DLMk
         QpjSb15ncLs3aHeDGKal4TlrtzHZLCDdtHdw4kxQbLgMGWV72P25UJmYSe14Z3LiMsD5
         pVJaG/WDmfjAAt9KZjLtp0D8maeBvbuMPeNx3dZn8sC9MpDrse24nMtFDGtRLInpG/6e
         6H1jgGRh/u2SGdWYMIeyzoaKx+zpQT0eZ1pJOgQUad1vtZdOzNeix6onkA5SJQpIjON+
         bp4g==
X-Forwarded-Encrypted: i=1; AFNElJ/6hJ+ty7XwOY58j7LMh8o26Bb1yO+hURi2A+x6FgRmZG0YaDklCbIWUYDl3IVI82bI+OO/KglDRvHE8sKAkmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LmqJU2PRWEiKXwuHbyh5GcbIqCTw4l7sbjcfujcAc2vYC5El
	j8t2c4deaYbAYMzJL0vUvSsklOmuDwi4HYKYD+J2+dBDi0iIcPsVe+W4rjc+cw+wgNn+gTE1Ez0
	TA4nCNwn7sVdchJH2US9iQiX9Fuw1QNs=
X-Gm-Gg: Acq92OGU4XN9PaSYNiFrnvWfyWj7xCVXkMHNRJJUVjUap1/Yifu1wq+N8s8cAbvlh7w
	tRPmXDPqm5Vmu8cVEkPHD5SpJKUBN7EV2BzVmAVK8cWLU01tl9ZlqGMrjQiJzYm4GXAyb1LCuD1
	P5MjDniH+OfQR2Xcbs6JSEsoBkn8aJwfXCB/nCDfrnh5Ry6XVjs5zvMivU3RQ4ybKrdnWlTINLY
	vFOM2VNkXzPx7YWKIzMOccRiZRvalvznh4QtBRp7BQFWDqWi5E0pH5idRwhI0q8mL2aaGC7teHI
	N6drh28SvFbIh0vfAsMwzn/JiXrLoAhn4/0k77bPVqJ8QfA=
X-Received: by 2002:a05:690e:4843:b0:654:49e4:ff14 with SMTP id
 956f58d0204a3-65c79994bd2mr19456740d50.37.1778518879990; Mon, 11 May 2026
 10:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
In-Reply-To: <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 11 May 2026 13:01:08 -0400
X-Gm-Features: AVHnY4JhB2d5GMH88lUH892q70_awbB8KMS0O-OtLSzvuZSSVcwIl7oatzofHYs
Message-ID: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Id suggest we dropped the once at the end so just hci_cmd_sync_queue_conn=
.
>
> > +                                       hci_cmd_sync_work_func_t func,
> > +                                       struct hci_conn *conn,
> > +                                       hci_cmd_sync_work_destroy_t des=
troy)
> > +{
> > +       int err;
> > +
> > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn),=
 destroy);
> > +       if (err)
> > +               hci_conn_put(conn);
> > +
> > +       return err;
>
> Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above, s=
o
> I don't think any caller should require queuing multiple procedures
> for the same conn.

OK, good call.  I checked the other 10 callers for
hci_cmd_sync_queue_once and there isn't any variation today, so that
seems safe.

Do you want me to wait another 24-48 for others to weigh in or ship v2 now?
