Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886783AC1E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTRpU+2/"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4863AAE
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 11:49:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c6b5841f61so27008121fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 11:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699645753; x=1700250553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjU3eUt1btTmqETSk7rVg/q+7PaZxcnIJIyWmV+mZzQ=;
        b=VTRpU+2/hTi/CaE153gAsbcEB8p7x3HNduD+bUn0vut06HRCU7z/GsaEIYKtsUjn1K
         EXUn0sPm9cPRcSY1ZzUjYuRq6H3h4pewN9bDN6hAxbrXSRSA7pNjCCukauD8o+UxnbrB
         cKpUdoZ4p+hBQjhRPPMdBltsN1VFLeXPnKeda89bI9bQbue1YcZEFbmjRrgnT3eKMOkN
         I/SHstTOA6He5X3dumQl3YYFByPIzVDCrhRAIwz7iuF45hTVtV5qSaMSKMe7FoSOLyoS
         9QJv+fUI5HBNk6UcPamryvTo8pGxzBmEtWlfUu7Ty6EraaZUVZjLCeAk06EQhcDTzZCj
         4bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699645753; x=1700250553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjU3eUt1btTmqETSk7rVg/q+7PaZxcnIJIyWmV+mZzQ=;
        b=gvLcLSm+JIIQU1Xug+c39iMHg5uN9mhIGfFVKWDs6npHftQkBPiW4NAYPFpmDytOyJ
         fJ2P2dTnX1MZiBPgjSSVvVfxPLqpG+KyxTgtlsJ6VQTJiyar9k2oLryPIlSYyQrV6SvI
         1zsBxweipAjDj9ntvl3FAzF9RaR9TZYGD08L52nxvZ8rgr+hPAcsaiNzKjM5RUFjEJmC
         8JyW7N8V1v0cHoThmRnPYHPvLtVH2hkkygwMHURBM6LnkaZOfkbyVDDBH156fxqUWLm3
         hJjKiPkpFRHGLRZNaE0I9sn4nJaCN79TUn4v6Mr5T6qJMBrjw8xP3svvn4D1vp3iIqWe
         nCaw==
X-Gm-Message-State: AOJu0YzWPsCsjAzcQgYv1LmGOseZImSqG/AQVa3xKmg3mEWnMQPehb8t
	uPei/WYRZW+c2M3DMNJ7k4GWIPWDr25lE7IGY20=
X-Google-Smtp-Source: AGHT+IFoVsQknBnJ+kXdpTfhEGulVbDaRc0Q4ldH41wooVwH7ktHLMrislqefCVihIV/m+DyopPvOP0A43zqIjfWFiM=
X-Received: by 2002:a2e:b60b:0:b0:2c0:c6a:8795 with SMTP id
 r11-20020a2eb60b000000b002c00c6a8795mr1238098ljn.24.1699645752435; Fri, 10
 Nov 2023 11:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7c90f4c-8868-42ea-86c0-3f9f2b0f27e0@braneaudio.com> <94061775-df7e-4aa5-b760-94a28a13667f@braneaudio.com>
In-Reply-To: <94061775-df7e-4aa5-b760-94a28a13667f@braneaudio.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Nov 2023 14:48:59 -0500
Message-ID: <CABBYNZJHz1x0zwxokOecD4Fq9BNxO4Dkx+RN=fXYjbxFbs6q+g@mail.gmail.com>
Subject: Re: a2dp delay reporting
To: Ethan White <ethan@braneaudio.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ethan,

On Thu, Nov 9, 2023 at 5:36=E2=80=AFPM Ethan White <ethan@braneaudio.com> w=
rote:
>
> On 10/17/23 13:10, Ethan White wrote:
> > Hi,
> >
> > How do I inform Bluez of my a2dp transport delay?  The media-api
> > document shows a Delay property for the MediaTransport1 interface but
> > attempts at writing this property yield the following error:
> >
> > org.freedesktop.DBus.Error.PropertyReadOnly: Property 'Delay' is not
> > writable
> >
> >
> > Reviewing profiles/audio/transport.c a2dp_properties (Bluez 5.70) I fin=
d
> > that the delay property does not have a set function:
> >
> > line 846: { "Delay", "q", get_delay_reporting, NULL,
> > delay_reporting_exists },
> >
> >
> > What am I missing here?  How an I supposed to inform the a2dp source of
> > my playback delay?  Thanks for any help.
> >
> > Regards,
> > Ethan
>
> I'm currently using org.bluez.Media1 RegisterEndpoint to expose my a2dp
> sink to a2dp sources.  I use org.bluez.MediaTransport1 Acquire to get
> the transport.  I can write the 'Volume' property of
> org.bluez.MediaTransport1 to change the audio source volume.  However,
> writing to the 'Delay' property of the org.bluez.MediaTransport1
> interface yields only errors as this property appears to be read-only
> despite bluez/docs/media-api.rst showing this property to be read/write.
>
> When using busctl from the host running my a2dp sink to inspect the
> transport I get a dash '-' in place of a numerical value:
> host:~$ busctl introspect  org.bluez
> /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/fd0
> NAME                                TYPE      SIGNATURE RESULT/VALUE
>                         FLAGS
> org.bluez.MediaTransport1           interface -         -
>                         -
> .Acquire                            method    -         hqq
>                         -
> .Release                            method    -         -
>                         -
> .TryAcquire                         method    -         hqq
>                         -
> .Codec                              property  y         2
>                         emits-change
> .Configuration                      property  ay        6 128 1 4 131
> 232 0                     emits-change
> .Delay                              property  q         -
>                         emits-change
> .Device                             property  o
> "/org/bluez/hci0/dev_E8_78_65_F2_14_24" emits-change
> .State                              property  s         "active"
>                         emits-change
> .UUID                               property  s
> "0000110b-0000-1000-8000-00805f9b34fb"  emits-change
> .Volume                             property  q         64
>                         emits-change writable
> org.freedesktop.DBus.Introspectable interface -         -
>                         -
> .Introspect                         method    -         s
>                         -
> org.freedesktop.DBus.Properties     interface -         -
>                         -
> .Get                                method    ss        v
>                         -
> .GetAll                             method    s         a{sv}
>                         -
> .Set                                method    ssv       -
>                         -
> .PropertiesChanged                  signal    sa{sv}as  -
>                         -
>
> Does Bluez allow an a2dp sink to report its playback delay to the a2dp
> source via the org.bluez.MediaTransport1 Delay property?  Is there some
> other way to communicate this delay back to the audio source for proper
> lip-sync with video?

Looks like setting the Delay was never implemented:

https://github.com/bluez/bluez/blob/master/profiles/audio/transport.c#L878

File an issue at github, I don't have time to resolve it right now but
it should be relatively trivial to implement it.

> Regards,
> Ethan
>
>


--=20
Luiz Augusto von Dentz
