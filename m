Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
References: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 Nov 2017 15:00:48 +0200
Message-ID: <CABBYNZK3YcGK-qONbFbZEhM5xRnRAuXeQUtPVj9OUgzqLzgszg@mail.gmail.com>
Subject: Re: Runtime retrieval of bluetoothd version
To: Alex Blasche <alexander.blasche@qt.io>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Nov 1, 2017 at 1:07 PM, Alex Blasche <alexander.blasche@qt.io> wrot=
e:
> Hi,
>
> Is there a way to retrieve the version of bluetoothd runtime?
>
> Why is this necessary? Most bluetoothd versions add new or experimental D=
Bus API's (in particular in the LE domain). However most of those interface=
s/APIs do not turn up until later because they are dynamically added when d=
evices appear. Since it is possible to work around missing BTLE DBus APIs u=
sing hci et al it would be nice to retrieve the bluetoothd version at runti=
me to match against a map of available non-experimental API per bluetoothd =
version. After all it is kind of hard to wait for never appearing BTLE inte=
rfaces due to using old Bluez/bluetoothd versions.

While I understand what you are at adding the version would only
affect upcoming releases so I don't how it would fix the problem.

> The only reliable way I have seen so far is bluetoothd --version which as=
sumes that one knows where bluetoothd is located. At least in source I coul=
d not find any other way.

Perhaps with systemd you could check from the service what is the
binary and then parse the output, that would probably be the most
reliable way since the --version has been supported since 4.x times.

Btw, if you are looking for other hints you could try bind/listen on
GATT cid, as far GATT goes this should indicate bluetoothd is
listening on it.

> Thank you.
>
> --
> Alex--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
