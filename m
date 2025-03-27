Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98307218ABC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087540; cv=none; b=Fg+7gNxZtgIKMeMCP09XYK30Fbt+XgeKpt9pFsyfKIuxbYlhiRiSWvneW0vkwaW8sWrvS/RZD2Kgc5Nl6qP1bqC3MhdcYpviBnsYxmOmZLYVg+l28OjYHghHXIw7kuG9rPLoRDcwHlDA0LR83teEQ8Qp3huYLAY4pgjavkUznhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087540; c=relaxed/simple;
	bh=cV99N+SvOX5kBxOSKEtUY021/OpMnvI1LC4WROJRxTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jokTowYgwDYmWvIMS+zFFSx5MuxoYK8ZEHAs1mONY/bzPKoH3Q8/yihCzoZXz+sWTS5l7gBQQ5fbKw93NhwnPAdL1SWlE2tNawXqevgHa86iwXs+TF/0YUOrBxUezb2B1QSAt0Bl2EbM2Nc/PfiOBgf0mV+w3ZfkIuAg3R6/NOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DONpKAOT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DONpKAOT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so10029681fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743087537; x=1743692337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU4J5zTA2aXIujVrMVYRIe0Sn0qkuZPfCaD79IRFCWE=;
        b=DONpKAOTCI8QVOcCTsfyLobjM6x9dhjiNqpUs2ca1SL6tWYXOwIYnLKFGet6uf5I1C
         AByC89B5hcTx1KRzX9jhd7OUEse/YcBfZYBUXULiVxOCn43TsgZzhPgNUF3wf5zkVYwx
         kYaCtzoWyjo+s/LUVYY/2BjxZI5F6zQWa547GCAG7CxYbT/G5zF5SxtCMX3HSIE3o7R7
         088C5q3ocLznsQT7jkGQZUg2z4ETdisvW3L+ymQ7VJqg92sU9Ucy1SIKHhxJKycAuL72
         UzWzYRt/+UiP+iC0cefUuo5CEZzOJTYOD9AJodqESwpWRto/8YoGA5bpmp1tChAIJBp0
         1fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087537; x=1743692337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OU4J5zTA2aXIujVrMVYRIe0Sn0qkuZPfCaD79IRFCWE=;
        b=I1nfy8CfCyfJ/Ys0WHedVEqp2AZamgrS475ui3Q6IvlyDenFhKCLDRxKFG9g1n3qQQ
         tMQeh7Y+XfnK052R+TnSBJ4u2WyLOdCE1KHW8Czzd27fg3mFRY931edX7iu/N8C/yvXm
         FR80G6NIMkCqMxbzAagkdkB8O/Z+ZRCxc6HLmjkpxkRbjypaHmgU9H1esO7LBqDdkOFk
         pMPMbBH0TYglsCzAX5QXoetBqUTT4m9xbvY3hYgK7YzSxqloyLpk+l0HKbVGvaCJ39hQ
         RdDwitb7EZPkt1yAobyaY9bR4Uj8s4nVQxgfa7sy/1Cr/CKaHNgmm9LEq+C2jUriPrm3
         pbeg==
X-Gm-Message-State: AOJu0YwJ7mLwbIaSlcxS0a+AAD/FvpYzaQqFSh6Ypaf/drxeOYhS0LVi
	C0iaJs3wiWEOsFFvX/z5HkSaX+H0ifhFEHU3X7cpqFWJNpFRdmYvpVFQOnfag76hr9FIrd6Kan9
	hyGuQHQ1JVN6fWnjb12XGgCVwpRuz1C58
X-Gm-Gg: ASbGncvrD390c3uPm54XQ0NyNTFv39P3ZR65s5GbdVocnKD2qVl0s73k2P5XQwEkrYL
	PlaXRqmylYTESjvUgAsPSkFYPHkT2eLYd1diuMlHWD0V4WBr65B7dzqL+Q/xwMZnyjSrBkPwoW/
	lHoeT4hli/v90ohAeflY6K3f6E
X-Google-Smtp-Source: AGHT+IGP17NqhJDiMhHvht2fjJQPA62gpGP3cEMaZ+pvAIzsl8Kvp6CZXvS5xqT5BJEPjy33FQpT1R8Zr27RGq7seNc=
X-Received: by 2002:a05:651c:551:b0:30b:be23:3ad with SMTP id
 38308e7fff4ca-30dc5e30fa3mr20853001fa.10.1743087536318; Thu, 27 Mar 2025
 07:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Mar 2025 10:58:43 -0400
X-Gm-Features: AQ5f1Jqm8gdmBWB_MFfQ3r9qPFUcaaGKfdFfUK86SRtudcs_EMjEwEgt-ZPFWF8
Message-ID: <CABBYNZLkwH=8TztnGnuzGy7FJ+iugp3sKT_cS0dsRoo1aV_hrw@mail.gmail.com>
Subject: Re: [PATCH v1] dbus: Fix add invalid memory during interface removal
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com, 
	quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com, quic_zijuhu@quicinc.com, 
	quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Thu, Mar 27, 2025 at 4:41=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com=
> wrote:
>
> test setp
> register_service <uuid>
> register_application <uuid>
> unregister_service <uuid>
> unregister_application
> register_service <uuid>
> register_application <uuid>
> core dump

Ok, what exactly are you talking about above, you are not referring to
D-Bus api it seems, are these bluetoothctl commands?

> invalidate_parent_data is called to add the service to the application's
> glist when unregister_service. However, this service has already been
> added to the glist of root object in register_service. This results in
> services existing in both queues,but only the services in the
> application's glist are freed upon removal. A null address is stored
> in root object's glist, a crash dump will occur when get_object is called=
.
>
> Add a check for the parent pointer to avoid adding the service again.
>
> 0  0x0000007ff7df6058 in dbus_message_iter_append_basic ()
>    from /usr/lib/libdbus-1.so.3
> 1  0x00000055555a3780 in append_object (data=3D0x31306666,
>   user_data=3D0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:=
1117
> 2  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.=
0
> 3  0x00000055555a37ac in append_object (data=3D0x5555642cf0,
>   user_data=3D0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:=
1122
> 4  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.=
0
> 5  0x00000055555a3630 in get_objects (connection=3D<optimized out>,
>     message=3D<optimized out>, user_data=3D0x555563b390)
>     at /usr/src/debug/bluez5/5.72/gdbus/object.c:1154
> 6  0x00000055555a51d0 in process_message (
>     connection=3Dconnection@entry=3D0x5555639310,
>     message=3Dmessage@entry=3D0x5555649ac0,
>     method=3Dmethod@entry=3D0x55555facf8 <manager_methods>,
>     iface_user_data=3D<optimized out>)
>     at /usr/src/debug/bluez5/5.72/gdbus/object.c:246
> 7  0x00000055555a575c in generic_message (connection=3D0x5555639310,
>     message=3D0x5555649ac0, user_data=3D<optimized out>)
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  gdbus/object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 7b0476f1a..d87a81160 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -809,7 +809,8 @@ static struct generic_data *invalidate_parent_data(DB=
usConnection *conn,
>
>         if (child =3D=3D NULL || g_slist_find(data->objects, child) !=3D =
NULL)
>                 goto done;
> -
> +       if(g_slist_find(parent->objects, child) !=3D NULL)
> +               goto done;

Use empty lines after if statements, and keep the one you are removing.


>         data->objects =3D g_slist_prepend(data->objects, child);
>         child->parent =3D data;
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
