Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F5320721
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 17:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcwbysW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405478AbgE1RQx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405457AbgE1RQv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 13:16:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57893C08C5C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 10:16:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so11893075ljn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9pB+bcLI542nzqq1JUGAN8kUj/fCBfJpje/CV8ZMgr8=;
        b=AcwbysW1yQ4mYAL4XF8ZNh5CdWf1zSZNweiEcHOjOqZvD0aVSEuTL8ksJRdej2Hm1m
         3vdw7frGjg4coU+QzpVrook8PRlBZZl4TqmXHWin0h02SVsaOjpRViePDz8J1uIUpxQ3
         CTxBOQNF8AmtmeEGslpbLLaLJEUSjXdk01GK86GkncD0KexUxAwCoRlahLurmfuhXidn
         dCBNNToVZen/TmNDu/KlRA8F1NKP5YFHIc2kH9GwPY00WazMLnJ+BcxEEcXuz6iIpGsh
         ISPBZJ5Fbu3kLzxdxtAB8VCOZOzZx4dKiqRDQqVAkgoJmVqTZn7inTSgy2tUk/OIltjJ
         VAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9pB+bcLI542nzqq1JUGAN8kUj/fCBfJpje/CV8ZMgr8=;
        b=WtFbF0AB6ONproz0aGKrbKrpAr6FFmF+wG+y0uR1heVJYROA9Cyy7F14dYryJIj032
         NcZsLayAZygKDlBjWHdn5KP6779PunzTu3+t65hJ/MA+Sw7k0pawuzMELXwsJ6gw+0OG
         PiYENXf883qoaOLcYzd4HzJp0cc8JuJO2UbXKBfpaedhIlzqwaPALcibU+AR85n7EmQc
         6Bjn9fdn/myFCEkXP58sjE6O9akYcaUVB5KOuuJVflsxg3baXvmvekst47Vccqkw41ai
         MW1fx1WaxflFD9Qh2rqrDvHsUnqIt+nadPDBNIx2s9l6xr68DmihdeEs2OB1GtBrcFo3
         znKw==
X-Gm-Message-State: AOAM532Wxk2oCpP98aNN4PtKyHMHF8V4IeG7VhndEWgq0I6KcUBOxAKs
        9wfgq0NjEDM8fbvYq3KEBG7FpNNItSvHcAt6HAW9/e8m6ao=
X-Google-Smtp-Source: ABdhPJyWFBccNKNRa3MhSJoUaXDXjcFWSPsosDFem4BNeSztzA4zsHuol7JIv9aTmJZyTaJ5nW049bTMpdcWJP7+HC8=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr1968378ljm.39.1590686208465;
 Thu, 28 May 2020 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org> <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
 <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org> <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
 <6F17F57F-8AF4-4539-8564-C3F13BC6FBF5@holtmann.org> <CALWDO_Umz9T9-_U3spSTO85V3sjw8AWku9iwwuF0J7SKQYiE6w@mail.gmail.com>
 <CABBYNZLfEVmjXYfSMFDdazgt68Y53ssWqmD71m=YUJ-0g2zU=A@mail.gmail.com>
In-Reply-To: <CABBYNZLfEVmjXYfSMFDdazgt68Y53ssWqmD71m=YUJ-0g2zU=A@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 28 May 2020 13:16:36 -0400
Message-ID: <CALWDO_ViGdppcdDm_VNQF9fVSpCfya4WQshn7s2EtcV7HK0b_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP authentication
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, May 28, 2020 at 12:54 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Thu, May 28, 2020 at 6:18 AM Alain Michaud <alainmichaud@google.com> w=
rote:
> >
> > On Thu, May 28, 2020 at 4:22 AM Marcel Holtmann <marcel@holtmann.org> w=
rote:
> > >
> > > Hi Alain,
> > >
> > > >>> Starting with the 2.1 specification, it is my interpretation that=
 it
> > > >>> is not valid to support EIR but not SSP.  I understand that SSP m=
ay be
> > > >>> disabled from BlueZ's point of view, but this doesn't seem to be =
a
> > > >>> legitimate/qualifiable configuration.  Should we instead fail the
> > > >>> legacy pairing if EIR was received as an invalid condition?
> > > >>
> > > >> I know that using EIR requires to also use SSP. However this is ju=
st a precaution in case the other device is an attacked and tries to trick =
us.
> > > >>
> > > >> You might get an inquiry result and not extended inquiry result, b=
ut you are still talking to a SSP device. This has to do with the fact that=
 the reception of EIR is not guaranteed. In case of radio interference you =
might miss one and only get an ordinary inquiry result.
> > > >>
> > > >> If we indeed received an EIR and then get legacy pairing request, =
we could try to reject the pairing. However keep in mind that our inquiry c=
ache is time limited and we through outdated information away. This might c=
ause some race condition. So I rather read the remote host features to ensu=
re we know the actual host features of the remote device.
> > > >
> > > > You are correct, the EIR response is not a guaranteed thing.  For t=
his
> > > > reason, the host should try to resolve the name of the device befor=
e
> > > > initiating bonding where a Remote Host Supported Feature Notificati=
on
> > > > Event is generated to signal the remote side's support of SSP.  As =
you
> > > > allude to, a remote spoofing a legitimate SSP device may always jus=
t
> > > > jam and downgrade to not SSP, but if you have any signals that SSP =
is
> > > > supported by the device, it may be a good defensive posture.
> > >
> > > trying to resolve the name before connected is a waste of time. Resol=
ving the name after connecting will not give you that event. You should jus=
t read the remote features.
> >
> > I have a vague memory that there was an interoperability issue around
> > this that required the initiator to know ahead of time if SSP was
> > supported by the remote host before connecting which was the reason
> > why this was added in the first place.  However, I agree that this can
> > also be read after you are connected rather than just waiting for a
> > RNR page to complete just to page again.  The point here however is
> > about the signals that SSP should be supported and the conditions
> > where we let legacy pairing go through.  My assertion is that EIR
> > implies SSP, so legacy pairing shouldn't be allowed in that case.
> > It's not a definitive security measure, but IMO, every signals that we
> > can get will help close a door to downgrade attacks.
>
> Legacy pairing is still indicated with MGMT_DEV_FOUND_LEGACY_PAIRING
> so for what is worth this didn't change any logic regarding how legacy
> pairing is detected, in fact hci_conn_ssp_enabled is used to determine
> if encryption is required or not for low security it was never used to
> detect if the paring method used was really SSP or legacy.
The general idea is to both "try" to protect against a downgrade
attack but also to encrypt all channels (other than SDP) if SSP is
supported by the remote.  If the later is already handled, we just
need to make sure we use all available signals that the remote side
supports SSP.  Receiving an EIR is a valid signal, the absence of EIR
doesn't imply the remote doesn't support SSP.
>
> > >
> > > > Receiving an EIR response or a Remote Host Supported Feature Event
> > > > with the SSP bit set is a good indication that the device supports =
SSP
> > > > and you should expect SSP to take place.  Again, it is not a valid
> > > > configuration to have EIR enabled but not SSP per my interpretation=
 of
> > > > the 2.1 specification.
> > >
> > > If you have an idea on how to tighten this and fail, please send a pa=
tch. It is just that our inquiry cache was never designed for that. It was =
just to speed up the connection process.
> > Ack.  This definitely looks like an opportunity.  We can add it to the =
backlog.
>
> If you guys agree I can prepare a patch requiring SSP to be used, but
> first we will need to agree on what action we would take under such
> situation, shall we disconnect if we figure out the SSP bit is
> disabled? Btw, if the remote device has dropped SSP for some reason (I
> suppose the spec allows doing it) and we have a EIR on the cache
> (which we keep for 30 seconds) that doesn't necessarily mean the
> device is broken since the use of EIR may have been dropped in the
> meantime.
Right, but if we do have the EIR signal, then we should expect SSP to
be used.  It is legitimate, in my interpretation, to fail anything
less than SSP in that case.

>
> > >
> > > Regards
> > >
> > > Marcel
> > >
>
>
>
> --
> Luiz Augusto von Dentz
