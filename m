Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A302D781F
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477916; cv=none; b=Nc5yIEwdkREbDgZzL62u+9GSqmKTHUp0RwV95YLl0/LVIof0DixTUEWjmTlxVSxrIU8l/7lEG+fppnrOEMmwxJzsoROnn0d3dNa1hMmO6ANPhprGEPJdjZFKMM5K4DHoAbQT3gx8UjEP0pfrop8H1O0so2R6MzfnINQsF4VLLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477916; c=relaxed/simple;
	bh=JnrUrTI+bZqYGmtvBVCxhkgHhXdoIu3nV5wgI09rLJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhfq9MR5r4zLp3rTl9BcGbLGtni81GiOrY0NVaKgxBvD0+c9/TKUMRmtqDfGSLLRmJxlbjs842OS3oA/eO15fwzAHfkfHy7O+5xOLwwg/+aBn4o2t9ZCUbCLsXAXuWhNUa5KTmm1HUBNxNWNNdK+0lwO8tCvVYe2ar3shmciGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqqP4dty; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqqP4dty"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso40525941fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477912; x=1752082712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1/TSKFs7lgvZYnQHCrJN9yRapXWuswc0CwHDXItUrw=;
        b=fqqP4dtyd9hJZGXP4u+INcrxYUZUUrWZG8QkyoP2oleKUe+20iNUax3TjALjSqHqJG
         PzLtUrZSAK2U85ggD99BPR42Nr9GWM2CU+WwEoWS9aOdUyW0rI04tAwn/qfOEmxh9NSX
         dShKNk89btehjsY/ih81ffBnpv2nFlpvN4kyZcGS7ZN2G2ZI3W5aZhDZbCm0kNdQZU8u
         3u9DM9TWyxcScJ9ax88H9UXqwdT7QFHcpNEirGmuJiZVEYOt/KiYoOmq8HFoEW9hGrmO
         En5qylRFKY/g/34JipqKhUF3L7cbmlcNZYTDgZB22BRN+cjYec4acCetltuLN2f9qCp1
         E0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477912; x=1752082712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1/TSKFs7lgvZYnQHCrJN9yRapXWuswc0CwHDXItUrw=;
        b=Rc9L3bI4OCPpQUSq+9qevg6LvgiAUXLasmED9sx3p5LvfgJES3dvBDdkVmf9aub/IB
         BQ35VeD1YW6W8WWhoUOz6k7BcUSxR+9WiwUyFt6m72bfS/GXTmt0TKW9F+qlgx6ScI8E
         ekqNihlBe2gZChD4KTUI1+0d2LteHLbDnbhwS/EapbyRIYrR8z6YXaZUzpvU9y60hVDO
         44njzdzeubQh8svZ2MkGQJggz0XVLAHsHiuhaPr/CuzKxauQDlQqe3JTLsW04PKZgl9V
         MRXjveHeUzzp13jffqd1f7ish/z/PpUMjT2wqG4hs6epIVrq2EU1Ncwzp7twTVUo1qZa
         73/g==
X-Gm-Message-State: AOJu0Ywau0M9m/bAZtGTJ3MNSfhQNso7NzDjawNZTY/Z1k6uHF6Swbry
	e3+jFfv8g6AMPLAD192f+KRYeErdKRDjCvCzD3sIwdyF9oVI3Ho7s7gr5GR17Cz7gdYO0HLTdhA
	M6VpzLCyaRN7pkWa8vmacFZM9bKk3zPo=
X-Gm-Gg: ASbGncvCrYKgwNPDKgAzoTac/47sml/f0/UO6HfblkBspy7/wgASCv7vKaj1zCOaXVa
	0nBSXr0p+ugkuehF9K4+lL+kqL2ovA+Kw3mF42tsPwClk9gndwX4uILqt9tFcPpwlfVMn0KT6DY
	XSrIIxH53jRfuX5ssbouMO1P6ZrxXQFK2eezDx68ozmA==
X-Google-Smtp-Source: AGHT+IHXySutWROz0vU8t51emV/FHInca3osZ9Mj+mGk0T0mUvK+i07hAvn9Hzs5uP8+pZsIVi8lRm0lVsSQUuIYaNU=
X-Received: by 2002:a2e:a00f:0:b0:32a:8c63:a8b2 with SMTP id
 38308e7fff4ca-32e0cf88c61mr1982061fa.8.1751477911602; Wed, 02 Jul 2025
 10:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627145136.421853-1-frederic.danis@collabora.com> <20250627145136.421853-2-frederic.danis@collabora.com>
In-Reply-To: <20250627145136.421853-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 13:38:19 -0400
X-Gm-Features: Ac12FXy7zjswfaNqdgLIcItjY5vFVBX_4x7tLFToCoyR0LvHwolaqli-cjUs-6c
Message-ID: <CABBYNZKpMJC-h7FNf_wK5_=chiy_x0aEco4pErjDGhmOk28o+Q@mail.gmail.com>
Subject: Re: [RFC BlueZ v2 01/27] doc: Add new telephony related profiles interfaces
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jun 27, 2025 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> These are interfaces are meant to be generic to the telephony related
> "headset" profiles like HSP HS, HFP HF, and CCP.
> ---
> v1->v2:
>   - Rename org.bluez.TelephonyCall1 to org.bluez.Call1
>   - Remove reference to profiles in org.bluez.TelephonyAg1 object path
>   - Add profile UUID property to org.bluez.TelephonyAg1
>   - Add OperatorName property to org.bluez.TelephonyAg1
>
>  Makefile.am                   |   4 +
>  doc/org.bluez.Call.rst        | 136 ++++++++++++++++++++++
>  doc/org.bluez.TelephonyAg.rst | 207 ++++++++++++++++++++++++++++++++++
>  3 files changed, 347 insertions(+)
>  create mode 100644 doc/org.bluez.Call.rst
>  create mode 100644 doc/org.bluez.TelephonyAg.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index 02ad23cf2..12714ecf8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -388,6 +388,7 @@ man_MANS +=3D doc/org.bluez.obex.Client.5 doc/org.blu=
ez.obex.Session.5 \
>                 doc/org.bluez.obex.Message.5 \
>                 doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5 \
>                 doc/org.bluez.obex.Image.5
> +man_MANS +=3D doc/org.bluez.TelephonyAg.5 doc/org.bluez.Call.5
>  endif
>  manual_pages +=3D src/bluetoothd.8
>  manual_pages +=3D doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.=
7
> @@ -422,6 +423,7 @@ manual_pages +=3D doc/org.bluez.obex.Client.5 doc/org=
.bluez.obex.Session.5 \
>                 doc/org.bluez.obex.Message.5 \
>                 doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5 \
>                 doc/org.bluez.obex.Image.5
> +manual_pages +=3D doc/org.bluez.TelephonyAg.5 doc/org.bluez.Call.5
>
>  EXTRA_DIST +=3D src/genbuiltin src/bluetooth.conf \
>                         src/main.conf profiles/network/network.conf \
> @@ -505,6 +507,8 @@ EXTRA_DIST +=3D doc/org.bluez.obex.Client.rst doc/org=
.bluez.obex.Session.rst \
>                 doc/org.bluez.obex.AgentManager.rst doc/org.bluez.obex.Ag=
ent.rst \
>                 doc/org.bluez.obex.Image.rst
>
> +EXTRA_DIST +=3D doc/org.bluez.TelephonyAg.rst doc/org.bluez.Call.rst
> +
>  EXTRA_DIST +=3D doc/pics-opp.txt doc/pixit-opp.txt \
>                 doc/pts-opp.txt
>
> diff --git a/doc/org.bluez.Call.rst b/doc/org.bluez.Call.rst
> new file mode 100644
> index 000000000..3fcd6f6ea
> --- /dev/null
> +++ b/doc/org.bluez.Call.rst
> @@ -0,0 +1,136 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.Call1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +--------------------------------------------
> +BlueZ D-Bus Telephony Call API documentation
> +--------------------------------------------
> +
> +:Version: BlueZ
> +:Date: May 2025
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez
> +:Interface:    org.bluez.Call1 [experimental]
> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony_=
ag#/call#
> +
> +Methods
> +-------
> +
> +void Answer()
> +`````````````
> +
> +Answers an incoming call. Only valid if the state of the call is "incomi=
ng".
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void Hangup()
> +`````````````
> +
> +Hangs up the call.
> +
> +For an incoming call, the call is hung up using ATH or equivalent. For a
> +waiting call, the remote party is notified by using the User Determined =
User
> +Busy (UDUB) condition. This is generally implemented using CHLD=3D0.
> +
> +Please note that the GSM specification does not allow the release of a h=
eld
> +call when a waiting call exists. This is because 27.007 allows CHLD=3D1X=
 to
> +operate only on active calls. Hence a held call cannot be hung up withou=
t
> +affecting the state of the incoming call (e.g. using other CHLD alternat=
ives).
> +Most manufacturers provide vendor extensions that do allow the state of =
the
> +held call to be modified using CHLD=3D1X or equivalent. It should be not=
ed that
> +Bluetooth HFP specifies the classic 27.007 behavior and does not allow C=
HLD=3D1X
> +to modify the state of held calls.
> +
> +Based on the discussion above, it should also be noted that releasing a
> +particular party of a held multiparty call might not be possible on some
> +implementations. It is recommended for the applications to structure the=
ir UI
> +accordingly.
> +
> +NOTE: Releasing active calls does not produce side-effects. That is the =
state
> +of held or waiting calls is not affected. As an exception, in the case w=
here a
> +single active call and a waiting call are present, releasing the active =
call
> +will result in the waiting call transitioning to the 'incoming' state.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +Properties
> +----------
> +
> +string LineIdentification [readonly]
> +````````````````````````````````````
> +
> +Contains the Line Identification information returned by the network, if
> +present. For incoming calls this is effectively the CLIP. For outgoing c=
alls
> +this attribute will hold the dialed number, or the COLP if received by t=
he
> +audio gateway.
> +
> +Please note that COLP may be different from the dialed number. A special
> +"withheld" value means the remote party refused to provide caller ID and=
 the
> +"override category" option was not provisioned for the current subscribe=
r.
> +
> +string IncomingLine [readonly, optional]
> +````````````````````````````````````````
> +
> +Contains the Called Line Identification information returned by the netw=
ork.
> +This is only available for incoming calls and indicates the local subscr=
iber
> +number which was dialed by the remote party. This is useful for subscrib=
ers
> +which have a multiple line service with their network provider and would=
 like
> +to know what line the call is coming in on.
> +
> +string Name [readonly]
> +``````````````````````
> +
> +Contains the Name Identification information returned by the network, if
> +present.
> +
> +boolean Multiparty [readonly]
> +`````````````````````````````
> +
> +Contains the indication if the call is part of a multiparty call or not.
> +
> +Notifications if a call becomes part or leaves a multiparty call are sen=
t.
> +
> +string State [readonly]
> +```````````````````````
> +
> +Contains the state of the current call.
> +
> +Possible values:
> +
> +:"active":
> +
> +       The call is active
> +
> +:"held":
> +
> +       The call is on hold
> +
> +:"dialing":
> +
> +       The call is being dialed
> +
> +:"alerting":
> +
> +       The remote party is being alerted
> +
> +:"incoming":
> +
> +       Incoming call in progress
> +
> +:"waiting":
> +
> +       Call is waiting
> +
> +:"disconnected":
> +
> +       No further use of this object is allowed, it will be
> +       destroyed shortly
> diff --git a/doc/org.bluez.TelephonyAg.rst b/doc/org.bluez.TelephonyAg.rs=
t
> new file mode 100644
> index 000000000..ddb5eec0f
> --- /dev/null
> +++ b/doc/org.bluez.TelephonyAg.rst
> @@ -0,0 +1,207 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.TelephonyAg1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Id call it just org.bluez.Telephony1.

> +-----------------------------------------------------
> +BlueZ D-Bus Telephony Audio Gateway API documentation
> +-----------------------------------------------------
> +
> +:Version: BlueZ
> +:Date: May 2025
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez
> +:Interface:    org.bluez.TelephonyAg1 [experimental]
> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony_=
ag#
> +
> +Methods
> +-------
> +
> +object Dial(string number)
> +``````````````````````````
> +
> +Call number, if number is void try to call last dialed number.
> +Initiates a new outgoing call. Returns the object path to the newly crea=
ted
> +call.
> +
> +The number must be a string containing the following characters:
> +`[0-9+*#,ABCD]{1,80}` The character set can contain numbers, `+`, `*`, `=
#`,
> +`,` and the letters `A` to `D`. Besides this sanity checking no further =
number
> +validation is performed. It is assumed that the gateway and/or the netwo=
rk
> +will perform further validation.
> +
> +If number is an empty string, it will try to call last dialed number.
> +
> +NOTE: If an active call (single or multiparty) exists, then it is
> +automatically put on hold if the dial procedure is successful.
> +
> +Possible Errors:
> +
> +:org.bluez.Error.InvalidState:
> +:org.bluez.Error.InvalidArguments:
> +:org.bluez.Error.NotSupported:
> +:org.bluez.Error.Failed:
> +
> +void SwapCalls()
> +````````````````
> +
> +Swaps Active and Held calls. The effect of this is that all calls (0 or =
more
> +including calls in a multi-party conversation) that were Active are now =
Held,
> +and all calls (0 or more) that were Held are now Active.
> +
> +GSM specification does not allow calls to be swapped in the case where H=
eld,
> +Active and Waiting calls exist. Some modems implement this anyway, thus =
it is
> +manufacturer specific whether this method will succeed in the case of He=
ld,
> +Active and Waiting calls.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void ReleaseAndAnswer()
> +```````````````````````
> +
> +Releases currently active call (0 or more) and answers the currently wai=
ting
> +call. Please note that if the current call is a multiparty call, then al=
l
> +parties in the multi-party call will be released.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void ReleaseAndSwap()
> +`````````````````````
> +
> +Releases currently active call (0 or more) and activates any currently h=
eld
> +calls. Please note that if the current call is a multiparty call, then a=
ll
> +parties in the multi-party call will be released.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void HoldAndAnswer()
> +````````````````````
> +
> +Puts the current call (including multi-party calls) on hold and answers =
the
> +currently waiting call. Calling this function when a user already has a =
both
> +Active and Held calls is invalid, since in GSM a user can have only a si=
ngle
> +Held call at a time.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void HangupAll()
> +````````````````
> +
> +Releases all calls except waiting calls. This includes multiparty calls.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void HangupActive()
> +```````````````````
> +
> +Releases active calls. This includes multiparty active calls.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void HangupHeld()
> +`````````````````
> +
> +Releases held calls except waiting calls. This includes multiparty held =
calls.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +array{object} CreateMultiparty()
> +````````````````````````````````
> +
> +Joins active and held calls together into a multi-party call. If one of =
the
> +calls is already a multi-party call, then the other call is added to the
> +multiparty conversation. Returns the new list of calls participating in =
the
> +multiparty call.
> +
> +There can only be one subscriber controlled multi-party call according t=
o the
> +GSM specification.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.Failed
> +
> +void SendTones(string tones)
> +````````````````````````````
> +
> +Sends the DTMF tones to the network. The tones have a fixed duration.
> +Tones can be one of: '0' - '9', '*', '#', 'A', 'B', 'C', 'D'. The last f=
our
> +are typically not used in normal circumstances.
> +
> +Possible Errors:
> +:org.bluez.Error.InvalidState
> +:org.bluez.Error.InvalidArgs
> +:org.bluez.Error.Failed
> +
> +Properties
> +----------
> +
> +string UUID [readonly]
> +``````````````````````
> +
> +UUID of the profile which the Telephony Audio Gateway is for.
> +
> +string State [readonly]
> +```````````````````````
> +
> +Contains the state of the current connection.
> +
> +Possible values:
> +
> +:"connecting":
> +
> +       RFComm connection in progress
> +
> +:"slc_connecting":
> +
> +       Service Level Connection in progress
> +
> +:"connected":
> +
> +       RFComm and Service Level Connection are connected
> +
> +:"disconnecting":
> +
> +       No further use of this object is allowed, it will be destroyed sh=
ortly
> +
> +boolean Service [readonly]
> +``````````````````````````
> +
> +Network service availability.
> +
> +byte Signal [readonly]
> +``````````````````````
> +
> +Network level signal from 0 to 5.
> +
> +boolean Roaming [readonly]
> +``````````````````````````
> +
> +Network roaming usage.
> +
> +byte BattChg [readonly]
> +```````````````````````
> +
> +Battery level from 0 to 5.
> +
> +string OperatorName [readonly, optional]
> +````````````````````````````````````````
> +
> +Operator name
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
