Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 16:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013762078C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 16:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdtKcwbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbgE1QyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405105AbgE1Qx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 12:53:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63CCC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 09:53:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so2903742otr.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rVMH/lPBnj2Ofwhb8VGIGMVRX//UNquu8I6DnfQzma8=;
        b=EdtKcwbWIIiAVvLU7QIcoQqsYa9ybcLed1MPS6pioPWdzHujKc7f9x9FUhI4n75ewK
         qrseKt3kah3qR1jf01/5ofmWorrkLBzSFkKxNNzmz0cbyEBrGWDtT/pkraoUygURHHPl
         ObCk8lwX40nQp5q5WNtx843lITsfuNW3bumPaP3U/MRjlopfNMIwrZjb3q9YCX2b8VeK
         KhsOZbX3ubgqdq42lzShoIcVke3iHKn8iF3DcrRwwLeJKBl5o3qfpVV6GuERBYVM77pn
         mBEgExuqXRAEzDrcHKPGkupAaeH3ErAKMRVpbrsTsv0MnaYn++dxHD37LwOW3mBjaR1T
         fSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVMH/lPBnj2Ofwhb8VGIGMVRX//UNquu8I6DnfQzma8=;
        b=GULAdn8RNRXSwX58s5w220SbajQIitRsJrjW+xL7Z3PE+ZTuiWpobpy3VDxUI30z14
         EF5ucdL+wpkIb63Ga90i43WdfA3WekYX7EYAhgT5LX4ukgq3ip61sOBqsJVH3vZheZiJ
         F4m0NSJRULHj9+N8n8fEcQ7oXjJyNETMYm5/kJEj4YD/lM+nidXKZ3JJwuRTOMg3S8Ya
         DszLWJYGzRtkMjpf4yEn8Buk3KP7VsnnNH8VWMn1SoiRxH/Ao78cJkz497eZGP51ZCHo
         k6vP2+ls3X9a2CTRVTAa/z9rG+gZnGInkZ96+yVSnynxtjVBFwFMyPTCXSJ/OBXXWd/v
         vJEw==
X-Gm-Message-State: AOAM533RZjvrgYBChBx+fH2RGYZZn00YIGLpu112j7O+Tdl6ID2uOMiF
        CBgwZ9A1MdoSmBVY2i8VViA95s3olw7caFSp5As=
X-Google-Smtp-Source: ABdhPJx8BuqociWX2EQ7UML/v+AObv1GdktZoD9X1lxr1LsVyHH99uHwHztUZk+V7ZNRwH6xSbxnG1rvXFWK1Qd99uc=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr3038116ots.11.1590684838811;
 Thu, 28 May 2020 09:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org> <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
 <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org> <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
 <6F17F57F-8AF4-4539-8564-C3F13BC6FBF5@holtmann.org> <CALWDO_Umz9T9-_U3spSTO85V3sjw8AWku9iwwuF0J7SKQYiE6w@mail.gmail.com>
In-Reply-To: <CALWDO_Umz9T9-_U3spSTO85V3sjw8AWku9iwwuF0J7SKQYiE6w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 28 May 2020 09:53:45 -0700
Message-ID: <CABBYNZLfEVmjXYfSMFDdazgt68Y53ssWqmD71m=YUJ-0g2zU=A@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP authentication
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, May 28, 2020 at 6:18 AM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> On Thu, May 28, 2020 at 4:22 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Alain,
> >
> > >>> Starting with the 2.1 specification, it is my interpretation that i=
t
> > >>> is not valid to support EIR but not SSP.  I understand that SSP may=
 be
> > >>> disabled from BlueZ's point of view, but this doesn't seem to be a
> > >>> legitimate/qualifiable configuration.  Should we instead fail the
> > >>> legacy pairing if EIR was received as an invalid condition?
> > >>
> > >> I know that using EIR requires to also use SSP. However this is just=
 a precaution in case the other device is an attacked and tries to trick us=
.
> > >>
> > >> You might get an inquiry result and not extended inquiry result, but=
 you are still talking to a SSP device. This has to do with the fact that t=
he reception of EIR is not guaranteed. In case of radio interference you mi=
ght miss one and only get an ordinary inquiry result.
> > >>
> > >> If we indeed received an EIR and then get legacy pairing request, we=
 could try to reject the pairing. However keep in mind that our inquiry cac=
he is time limited and we through outdated information away. This might cau=
se some race condition. So I rather read the remote host features to ensure=
 we know the actual host features of the remote device.
> > >
> > > You are correct, the EIR response is not a guaranteed thing.  For thi=
s
> > > reason, the host should try to resolve the name of the device before
> > > initiating bonding where a Remote Host Supported Feature Notification
> > > Event is generated to signal the remote side's support of SSP.  As yo=
u
> > > allude to, a remote spoofing a legitimate SSP device may always just
> > > jam and downgrade to not SSP, but if you have any signals that SSP is
> > > supported by the device, it may be a good defensive posture.
> >
> > trying to resolve the name before connected is a waste of time. Resolvi=
ng the name after connecting will not give you that event. You should just =
read the remote features.
>
> I have a vague memory that there was an interoperability issue around
> this that required the initiator to know ahead of time if SSP was
> supported by the remote host before connecting which was the reason
> why this was added in the first place.  However, I agree that this can
> also be read after you are connected rather than just waiting for a
> RNR page to complete just to page again.  The point here however is
> about the signals that SSP should be supported and the conditions
> where we let legacy pairing go through.  My assertion is that EIR
> implies SSP, so legacy pairing shouldn't be allowed in that case.
> It's not a definitive security measure, but IMO, every signals that we
> can get will help close a door to downgrade attacks.

Legacy pairing is still indicated with MGMT_DEV_FOUND_LEGACY_PAIRING
so for what is worth this didn't change any logic regarding how legacy
pairing is detected, in fact hci_conn_ssp_enabled is used to determine
if encryption is required or not for low security it was never used to
detect if the paring method used was really SSP or legacy.

> >
> > > Receiving an EIR response or a Remote Host Supported Feature Event
> > > with the SSP bit set is a good indication that the device supports SS=
P
> > > and you should expect SSP to take place.  Again, it is not a valid
> > > configuration to have EIR enabled but not SSP per my interpretation o=
f
> > > the 2.1 specification.
> >
> > If you have an idea on how to tighten this and fail, please send a patc=
h. It is just that our inquiry cache was never designed for that. It was ju=
st to speed up the connection process.
> Ack.  This definitely looks like an opportunity.  We can add it to the ba=
cklog.

If you guys agree I can prepare a patch requiring SSP to be used, but
first we will need to agree on what action we would take under such
situation, shall we disconnect if we figure out the SSP bit is
disabled? Btw, if the remote device has dropped SSP for some reason (I
suppose the spec allows doing it) and we have a EIR on the cache
(which we keep for 30 seconds) that doesn't necessarily mean the
device is broken since the use of EIR may have been dropped in the
meantime.

> >
> > Regards
> >
> > Marcel
> >



--=20
Luiz Augusto von Dentz
