Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342E1DA5E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808777; cv=none; b=uovHAVaAThOa2umJOQ4O+j+RGN4srC74jyyMx8mJ1o7Ojzud83Arzej7+C47vs+a2VQPCm02ioTkhOfHNFmWw6R+zVh3ygJwu5QTwf2e+eEN9e9Rjq7TluAcdPpxd9uhRAL7YPMK+fbT6jYF8pC2HgEkfNKGueSrOqCV6AiecvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808777; c=relaxed/simple;
	bh=sfQBCjNaqzMY+EBi1Xawz0jaFEXxipj9tOmMMKN8DDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO33vnAuwGdc/7GfK/uMSgDAi6gIAJY9zjfRnaT87QS3xNR1kL3XKl/m8V+N9UlXXZGv1oPvJgY//KWOeejkhFFmSqFw4J0wKr80PNUHAN33BvGUmq12qn9jsnpEr1LZpWgFK+cvhG6QwQBrWvbBF0qUhwUupcGrDhslNgvD03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCjM/+b9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCjM/+b9"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so75472431fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718808773; x=1719413573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBN95D0NRl7ww5crUafDKYgY1JpBM79cVPzAMclySXs=;
        b=dCjM/+b9qnwMeyPtZDpNy2h18zQ+ecuD/eXX/zIDtK7CwytnwTEpPzuLKbb2b0QWpF
         Z+hzFDGyX7RUB7FGAPmb2bS+C5TeaVvUiS7mSfT38Agz/sD6eNGWyQEEFfcAs9dRp7LY
         d+/B4dPel9PWHCpDutb9m2+XvRvIjmPhrswWuRDriK/JQiU2msNn/lgey2fn+2qONmc4
         CGIlQ6qtnmd1xkVY9lO8qDB2yu4yzMvesGfNBG3ZENsv0HS+cCMsuKMgzF99QQSFHmPM
         XWxe44P8V61qiQNWJfgkiinEBxu+yZ6PO8N7muKFXmbCs4OM7NRCVtbG/CM4ZITEgo5J
         k2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808773; x=1719413573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBN95D0NRl7ww5crUafDKYgY1JpBM79cVPzAMclySXs=;
        b=qtdg/noPOIA+kPAmNd4iEg0AgnE8NqdXTr9P9/BiwsZKv3iDx8lxefnnjPFc43MoT1
         jGASCYv2UmngG6YlCuFxBhbDfyqkMZXWTco5i1X846a7vBtHFOaohVQN+cGs0Fy4HUy/
         GddR1swhSRcg/IXrcMTBHH/ZLCn5oPlolzPQN7A/Jz/v/kECq8nqFTXb6Y2W3qRkCd24
         okbgPvDRp77o+7EhG1GQ33xuIgtcfSsWaleiNSaa+6eqDXNI047+F7hrFBTJcedUKMtg
         Ubji30gnERaSYF3kcJdFpxCWm5yzHmEmPHJZ8I6khOfun4WkwE9i2jCnAv61UtpexgKU
         FxqA==
X-Gm-Message-State: AOJu0YynlCRu7RMEr1lhira9J08zRScVQU1pu91VDaHufr0o6HpFrWOz
	rEYnbr7uCMIa5U17bpIkdJPki+lpHvOqIbdj4/XgOv9chChUxv47BHg7qJpfJWO0Lh/JXHVAF6g
	NPAEbiMHmFzlcwSJn1GGdaPhWJWZ5dP0/
X-Google-Smtp-Source: AGHT+IHOesERwTGDuwF1ok4uChXB8a+7Cjv8mmC2ahzPKMuDuP78xtN84FlR6riOn/m8Qi7G5K7ovNnXv6s3ZymDNac=
X-Received: by 2002:a2e:860e:0:b0:2ec:1890:5e8 with SMTP id
 38308e7fff4ca-2ec3cffcdffmr18068211fa.52.1718808773032; Wed, 19 Jun 2024
 07:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619113520.7617-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240619113520.7617-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Jun 2024 10:52:40 -0400
Message-ID: <CABBYNZJh1Maz1ZyG7+N-Xux7c3hbx_YqEinCO_z=tMvpRxU+dA@mail.gmail.com>
Subject: Re: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Jun 19, 2024 at 7:35=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This proposes a new D-Bus API to be used by the BAP Broadcast Assistant
> role.
>
> The BAP Broadcast Assistant is a Master device that can have multiple
> connections with BAP Scan Delegators. The Broadcast Assistant has the UI
> to start scanning, enumerate Broadacast Sources, allow the user to select
> a desired Source and send the stream information to one of the peers. If
> the selected stream is encrypted and the peer requires a Broadcast Code
> to decrypt the stream, the user should issue a command to send the code.
>
> A new D-Bus API is necessary to allow the BAP Broadcast Assistant
> implementation in BlueZ to communicate with a top level UI process.
>
> The Broadcast Assistant in BlueZ should register a D-Bus object for each
> scanned BIS that matches the Audio capabilities of a peer. Each object
> should be linked with the stream and the peer device that matches the
> stream capabilities.
>
> The top level process should detect these objects and display the
> information to the user. The user can issue commands to select an object
> or to provide the Broadcast Code for an object.
>
> More information on the proposed design can be found here:
> https://github.com/orgs/bluez/discussions/822
> ---
>  Makefile.am                  |  6 ++---
>  doc/org.bluez.MediaSetup.rst | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 3 deletions(-)
>  create mode 100644 doc/org.bluez.MediaSetup.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index 0ae721111..217e7d2e4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -362,7 +362,7 @@ man_MANS +=3D doc/org.bluez.Adapter.5 doc/org.bluez.D=
evice.5 \
>  man_MANS +=3D doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
>                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
>                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> -               doc/org.bluez.MediaTransport.5
> +               doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaSetup.5
>  man_MANS +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
>                 doc/org.bluez.GattService.5 \
>                 doc/org.bluez.GattCharacteristic.5 \
> @@ -395,7 +395,7 @@ manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.blu=
ez.Device.5 \
>  manual_pages +=3D doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
>                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
>                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> -               doc/org.bluez.MediaTransport.5
> +               doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaSetup.5
>  manual_pages +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.=
5 \
>                 doc/org.bluez.GattService.5 \
>                 doc/org.bluez.GattCharacteristic.5 \
> @@ -475,7 +475,7 @@ EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.blu=
ez.Device.rst \
>  EXTRA_DIST +=3D doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
>                 doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.r=
st \
>                 doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.r=
st \
> -               doc/org.bluez.MediaTransport.rst
> +               doc/org.bluez.MediaTransport.rst doc/org.bluez.MediaSetup=
.rst
>
>  EXTRA_DIST +=3D doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.=
rst\
>                 doc/org.bluez.GattService.rst \
> diff --git a/doc/org.bluez.MediaSetup.rst b/doc/org.bluez.MediaSetup.rst
> new file mode 100644
> index 000000000..7463d7cfb
> --- /dev/null
> +++ b/doc/org.bluez.MediaSetup.rst
> @@ -0,0 +1,45 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.MediaSetup
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Let's use MediaAssistant as name:
https://github.com/orgs/bluez/discussions/822#discussioncomment-9818645

> +
> +-------------------------------------------
> +BlueZ D-Bus MediaSetup API documentation
> +-------------------------------------------
> +
> +:Version: BlueZ
> +:Date: June 2024
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez
> +:Interface:    org.bluez.MediaSetup1
> +:Object path:  /org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_Y=
Y_YY_YY_YY_YY/bisZ
> +
> +Methods
> +-------
> +
> +void Select()
> +````````````````````````````````````````````````````````

How about using Push as the method name here?

> +
> +       Send stream information to the remote device.
> +
> +void SetBcode(array{byte} broadcast_code)
> +`````````````````````````````````````````````````````````
> +
> +       Send Broadcast_Code to the remote device.

Hmm, I wonder if it wouldn't be better to just have a dictionary that
you can pass to the Push method.

> +Properties
> +----------
> +
> +string State [readonly]
> +```````````````````````
> +
> +       Indicates the state of the setup. Possible values are:
> +
> +       :"idle": setup created
> +       :"pending": setup selected
> +       :"requesting": remote device requires Broadcast_Code
> +       :"active": remote device started receiving stream

We might want to add a property that refers to the MediaTransport
object, that way the application can tell what is the BIS
configuration from the transport and we don't need to duplicate them
here. The lifetime of MediaAssistant shall be the same as the
MediaTransport object it refers to, so if the transport is
removed/free so is its MediaAssistant object, we may want to document
this though because the Device object could persist if they are not
temporary but the MediaTransport objects for broadcasters are normally
considered temporary as they are not paired/bonded.

> \ No newline at end of file
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
