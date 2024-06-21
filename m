Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5A1D55D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977270; cv=none; b=qC/kly/oXMl0c4Hg293U75CRxQaZ1QZPnjoNy+fnTfUFdY7S48vnOGKTutX4p3TU4sJ7Z9HXJ4w4mZ/s3U9rNeZwaL+7QtTFAiqLKkQBoXJJBn5aJjo/SBXErDcZFap9H7Mp6N0AUTTr1cy0461ceS4+5REIkvBzwAEnFeiC64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977270; c=relaxed/simple;
	bh=vEM7Eq/8t8RtB+hQ9Mj2jh+hL1e/MfykMflGe+mbWuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPLWWKFu0h65GQ+QQyn8Ohy+3LMyXUviktUnK60TlDqDWlfcMfvp+fOnWLlWSxUVaK8iKUi2vkPlrjkug2zKG0iDLR6+xMuOmI4BsgFhHxTlazhTYNUQZVrjmwUItHnsFpPh1zVnLpcTsVcGmoKaUnVVw/lSWtT46ws8OXuF0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzbFG1cq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzbFG1cq"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so28725531fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977266; x=1719582066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+fLGjUorxE9ykH/fcUDYxB4BUMleuygZBcL4sL75To=;
        b=IzbFG1cqYAmIJwjnehnlQFglX0K0r3cyD9PVN4VYI6sgFT+JqNgOxurS5YQh5aa3S3
         Wkqt4vkPwbnVpL8WOs0TDOKP98nlRIF0Q0H8BRo5mEQNIg6I2Jo7TelECu/Md1ZdML0F
         le+WtbwuQn+UJpRXtcBtKdsysJIHLCJY/BY9oIAOBRURoyv0oxfqBqZm5PShzCeCkW2y
         z00rlgfiW+v2yuWp0cZEZ1dgjYZZ3RiQkcntl7ExYavbaJJzVAvRDUcF3qTVzRQ/eGF1
         xnAr94+unH0slBYN20EA+T3gAmvog2zj2gYZ183Tc2Q+a7ARe2nb4JYZ1WMRjI5k/UwQ
         edJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977266; x=1719582066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+fLGjUorxE9ykH/fcUDYxB4BUMleuygZBcL4sL75To=;
        b=hKaOM6Y1GoP4MMgpf0PVjIk73OjZIi8SIo6A8SpO0dRQyWm6c32UcKfa9kuANDlpaz
         TDEnc+YoVej+wr2FA/s8x+oMp2LlolrUtbQqs2NjTBNDmQEuxV/AUlXit2GoXqH/lxxV
         x8QVv+RAU2t33prROwfl+Uvrb1sjXeH0QKgbAfI2enRJa8wX9reZrvz1Gp6/oMlvfHw5
         gFjcFnO2dLBvCEthToxTYxEM4iiCt+wfTprHnn4sT50q5wE7wHCkqlcYjCmSFzjFyUJp
         2ziapeSW2c2fi0gIZtlp/oGBL21bkTDtttkCcit9FuqTzaSD9H9/dYwEm0WmKXI+gecc
         PzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFfRPrIpGyzXfzK77dE5vXq8xuCViMkuikiXHQOFbwpHfcbfy43w74GMLzD/tp81hmPeDmV1iK7qOuPlGSEPkxDYF2LP7OctUgsIPeI9wY
X-Gm-Message-State: AOJu0YwUYE7bIDOQBoEQ3zMz6FXlmXcIe875SndoIzNOW71+AP6eRTop
	WjiDEkhnkDmOCbVYLgxA1IzIVI9motkTWTh6WChUqfeNInwkHF/LRJ9m31Wf+EfpvQhogC7Yoep
	pyxasnBdei+lp3j36LNkvp/HLxmYSOFgy
X-Google-Smtp-Source: AGHT+IGRuxfOf3764xWJtmyerYV4XkR6c01TqDa9La21Tuwk3lxU5oW9jkRd4yleMlZj9xTKhA/TgyimAXN4okRvJrc=
X-Received: by 2002:a2e:b01a:0:b0:2ec:5258:e889 with SMTP id
 38308e7fff4ca-2ec5258ea0cmr4331551fa.46.1718977265796; Fri, 21 Jun 2024
 06:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJh1Maz1ZyG7+N-Xux7c3hbx_YqEinCO_z=tMvpRxU+dA@mail.gmail.com>
 <20240621131026.5814-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240621131026.5814-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Jun 2024 09:40:52 -0400
Message-ID: <CABBYNZKf4hysErxwCH9GsR+aQnLVQOTuK8szv_EhRLL_BX=k8w@mail.gmail.com>
Subject: Re: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: andrei.istodorescu@nxp.com, claudia.rosu@nxp.com, 
	linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Fri, Jun 21, 2024 at 9:10=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Wednesday, June 19, 2024 5:53 PM
> > To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> > <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> > Istodorescu <andrei.istodorescu@nxp.com>
> > Subject: Re: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
> >
> > Hi Iulia,
> >
> > On Wed, Jun 19, 2024 at 7:35 AM Iulia Tanasescu <iulia.tanasescu@nxp.co=
m>
> > wrote:
> > >
> > > This proposes a new D-Bus API to be used by the BAP Broadcast
> > > Assistant role.
> > >
> > > The BAP Broadcast Assistant is a Master device that can have multiple
> > > connections with BAP Scan Delegators. The Broadcast Assistant has the
> > > UI to start scanning, enumerate Broadacast Sources, allow the user to
> > > select a desired Source and send the stream information to one of the
> > > peers. If the selected stream is encrypted and the peer requires a
> > > Broadcast Code to decrypt the stream, the user should issue a command=
 to
> > send the code.
> > >
> > > A new D-Bus API is necessary to allow the BAP Broadcast Assistant
> > > implementation in BlueZ to communicate with a top level UI process.
> > >
> > > The Broadcast Assistant in BlueZ should register a D-Bus object for
> > > each scanned BIS that matches the Audio capabilities of a peer. Each
> > > object should be linked with the stream and the peer device that
> > > matches the stream capabilities.
> > >
> > > The top level process should detect these objects and display the
> > > information to the user. The user can issue commands to select an
> > > object or to provide the Broadcast Code for an object.
> > >
> > > More information on the proposed design can be found here:
> > > https://gith/
> > >
> > ub.com%2Forgs%2Fbluez%2Fdiscussions%2F822&data=3D05%7C02%7Ciulia.tana
> > ses
> > >
> > cu%40nxp.com%7Cc4b5189ccea94198202d08dc906f805b%7C686ea1d3bc2b
> > 4c6fa92c
> > >
> > d99c5c301635%7C0%7C0%7C638544055766136877%7CUnknown%7CTWFp
> > bGZsb3d8eyJW
> > >
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> > %7C%
> > >
> > 7C%7C&sdata=3Dw8yqp2HZQqouwJTFALZVB9Z32st0a3GTKm3w1TcHg10%3D&res
> > erved=3D0
> > > ---
> > >  Makefile.am                  |  6 ++---
> > >  doc/org.bluez.MediaSetup.rst | 45
> > > ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 48 insertions(+), 3 deletions(-)  create mode 10064=
4
> > > doc/org.bluez.MediaSetup.rst
> > >
> > > diff --git a/Makefile.am b/Makefile.am index 0ae721111..217e7d2e4
> > > 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -362,7 +362,7 @@ man_MANS +=3D doc/org.bluez.Adapter.5
> > > doc/org.bluez.Device.5 \  man_MANS +=3D doc/org.bluez.Media.5
> > doc/org.bluez.MediaControl.5 \
> > >                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder=
.5 \
> > >                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint=
.5 \
> > > -               doc/org.bluez.MediaTransport.5
> > > +               doc/org.bluez.MediaTransport.5
> > > + doc/org.bluez.MediaSetup.5
> > >  man_MANS +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.=
5 \
> > >                 doc/org.bluez.GattService.5 \
> > >                 doc/org.bluez.GattCharacteristic.5 \ @@ -395,7 +395,7
> > > @@ manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> > > manual_pages +=3D doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 =
\
> > >                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder=
.5 \
> > >                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint=
.5 \
> > > -               doc/org.bluez.MediaTransport.5
> > > +               doc/org.bluez.MediaTransport.5
> > > + doc/org.bluez.MediaSetup.5
> > >  manual_pages +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProf=
ile.5 \
> > >                 doc/org.bluez.GattService.5 \
> > >                 doc/org.bluez.GattCharacteristic.5 \ @@ -475,7 +475,7
> > > @@ EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst=
 \
> > > EXTRA_DIST +=3D doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rs=
t \
> > >                 doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFold=
er.rst \
> > >                 doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoi=
nt.rst \
> > > -               doc/org.bluez.MediaTransport.rst
> > > +               doc/org.bluez.MediaTransport.rst
> > > + doc/org.bluez.MediaSetup.rst
> > >
> > >  EXTRA_DIST +=3D doc/org.bluez.GattManager.rst doc/org.bluez.GattProf=
ile.rst\
> > >                 doc/org.bluez.GattService.rst \ diff --git
> > > a/doc/org.bluez.MediaSetup.rst b/doc/org.bluez.MediaSetup.rst new fil=
e
> > > mode 100644 index 000000000..7463d7cfb
> > > --- /dev/null
> > > +++ b/doc/org.bluez.MediaSetup.rst
> > > @@ -0,0 +1,45 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +org.bluez.MediaSetup
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > Let's use MediaAssistant as name:
> > https://github.c/
> > om%2Forgs%2Fbluez%2Fdiscussions%2F822%23discussioncomment-
> > 9818645&data=3D05%7C02%7Ciulia.tanasescu%40nxp.com%7Cc4b5189ccea941
> > 98202d08dc906f805b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> > 7C638544055766147461%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> > &sdata=3DjHOPPf1bg8SpRg4N3AP33ozX51GGUslWid9JObkRzFw%3D&reserved=3D
> > 0
> >
> > > +
> > > +-------------------------------------------
> > > +BlueZ D-Bus MediaSetup API documentation
> > > +-------------------------------------------
> > > +
> > > +:Version: BlueZ
> > > +:Date: June 2024
> > > +:Manual section: 5
> > > +:Manual group: Linux System Administration
> > > +
> > > +Interface
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +:Service:      org.bluez
> > > +:Interface:    org.bluez.MediaSetup1
> > > +:Object path:
> > > +/org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_YY_YY_YY_YY_=
Y
> > > +Y/bisZ
> > > +
> > > +Methods
> > > +-------
> > > +
> > > +void Select()
> > > +````````````````````````````````````````````````````````
> >
> > How about using Push as the method name here?
> >
> > > +
> > > +       Send stream information to the remote device.
> > > +
> > > +void SetBcode(array{byte} broadcast_code)
> > > +`````````````````````````````````````````````````````````
> > > +
> > > +       Send Broadcast_Code to the remote device.
> >
> > Hmm, I wonder if it wouldn't be better to just have a dictionary that y=
ou can
> > pass to the Push method.
>
> So you're suggesting instead of having a separate method for setting the
> Broadcast_Code, we can provide it through the Push method if the stream
> is encrypted? I think this can work, but we will need another MediaAssist=
ant
> property to indicate stream information, maybe a "QoS" property like
> MediaTransport is implementing.
>
> So when calling Push from bluetoothctl, we can read the QoS property and
> if the stream is encrypted, we can display a prompt for the user to enter
> the Broadcast_Code.

Yep, I think we will need QoS properties anyway if we don't have a
transport to refer to, otherwise bluetoothctl would not be able to
list the stream configuration.

> >
> > > +Properties
> > > +----------
> > > +
> > > +string State [readonly]
> > > +```````````````````````
> > > +
> > > +       Indicates the state of the setup. Possible values are:
> > > +
> > > +       :"idle": setup created
> > > +       :"pending": setup selected
> > > +       :"requesting": remote device requires Broadcast_Code
> > > +       :"active": remote device started receiving stream
> >
> > We might want to add a property that refers to the MediaTransport objec=
t, that
> > way the application can tell what is the BIS configuration from the tra=
nsport and
> > we don't need to duplicate them here. The lifetime of MediaAssistant sh=
all be
> > the same as the MediaTransport object it refers to, so if the transport=
 is
> > removed/free so is its MediaAssistant object, we may want to document t=
his
> > though because the Device object could persist if they are not temporar=
y but the
> > MediaTransport objects for broadcasters are normally considered tempora=
ry as
> > they are not paired/bonded.
>
> I think most use cases do not require a Broadcast Assistant to enumerate
> MediaTransports, so I don't think the objects can be linked:
> https://github.com/orgs/bluez/discussions/822#discussioncomment-9839217

Fair point.

> But even if MediaTransports and MediaAssistants would coexist on a Broadc=
ast
> Assistant, they refer to different things: MediaTransports refer to strea=
ms
> that the local device is trying to receive, while MediaAssistants refer t=
o
> streams that peer Scan Delegators are trying to receive.
>
> As I see it, the "State" of a MediaAssistant allows the user to know the
> stream state on the peer: For example, if the user calls the "Push" metho=
d on
> a MediaAssistant, the BASS Client in BlueZ adds the stream information on=
 the
> peer, and then the BASS Client receives a notification that the peer
> successfully acquired the stream, then the MediaAssistant goes to "active=
"
> state.

Fair enough, we just need to make sure the clients have enough
information to decide on what to Push thus it is probably a good idea
to have QoS property as well.

> >
> > > \ No newline at end of file
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Regards,
> Iulia



--=20
Luiz Augusto von Dentz
