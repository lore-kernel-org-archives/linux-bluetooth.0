Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <53177187.3040009@archlinux.org>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
	<7E804DF3-E191-427E-8E20-FE6ECDC490EA@holtmann.org>
	<CA+5PVA56oO6FS2pG+D7yJtNrTqBGZ1CtPygjid4E0f3cPPi83g@mail.gmail.com>
	<424A74F3-7646-449C-9F72-A0F4E9A28551@holtmann.org>
	<53177187.3040009@archlinux.org>
Date: Wed, 5 Mar 2014 13:53:14 -0500
Message-ID: <CA+5PVA6vkGHJGMgEYCTSdvqOuMb-fHURVvP-sHAofd6840TLOQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for
 virtual HCI driver"
From: Josh Boyer <jwboyer@fedoraproject.org>
To: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 5, 2014 at 1:48 PM, Thomas B=E4chler <thomas@archlinux.org> wro=
te:
> Am 05.03.2014 19:36, schrieb Marcel Holtmann:
>>>>> This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.
>>>>
>>>> NAK. We allocated a static minor for this.
>>>
>>> Johan mentioned that.  Commit b075dd40c95d11c2c8690f6c4d6232fc,
>>> correct?
>
> I am sorry Marcel, I only looked at the Linus tree, not at bluetooth or
> bluetooth-next. This commit should indeed fix the problem. Disregard my
> patch.
>
>>  Why isn't that headed into 3.14 right now, and CC'd to
>>> stable?  Currently you have a somewhat broken driver in 3.13 and
>>> 3.14-rcX that seems to have a pretty clear fix.
>>
>> somewhat broken? kmod prints this as an error, but it is not a regressio=
n in user functionality. The driver works just as before. The error message=
 can be ignored.
>
> It's a regression in my sanity, since numerous users blame all kernel
> bugs on this error message and I am tired of explaining the situation
> (problem + error message =3D=3D problem found *sigh*). I only sent this
> patch since I hadn't found the correct fix.

Exactly.

>> So if anybody feels strongly that the static device node assignment shou=
ld be put into -stable, then I am fine with it. However I do not see this a=
s passing requirement for a -stable fix since it is really not affecting an=
yone (minus the misleading message from kmod).
>
> Since b075dd4 will end up in the Linus tree eventually, I have no
> trouble backporting it myself.

I don't have any difficulty doing that either, but if it was in stable
every distro getting bugs about it wouldn't have to carry the fix on
their own.

josh
