Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alex Blasche <alexander.blasche@qt.io>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Runtime retrieval of bluetoothd version
Date: Thu, 2 Nov 2017 12:05:30 +0000
Message-ID: <DB6PR0201MB2197AD5A1FD8C8D504599396E75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
References: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
 <CABBYNZK3YcGK-qONbFbZEhM5xRnRAuXeQUtPVj9OUgzqLzgszg@mail.gmail.com>
 <DB6PR0201MB219730A45D69A9EC0163B0B5E75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>
 <CABBYNZKvh6kc7QnS=8Y-i-vHODPheYpqRJ-EzGbB1kqo=+y8oQ@mail.gmail.com>
 <DB6PR0201MB2197B885638BD4A61D50D85FE75C0@DB6PR0201MB2197.eurprd02.prod.outlook.com>,<CABBYNZKHqfUEwuqV0GR9S6xcnqPQ6qQ1TkN7W8iYEXA76jrTYg@mail.gmail.com>
In-Reply-To: <CABBYNZKHqfUEwuqV0GR9S6xcnqPQ6qQ1TkN7W8iYEXA76jrTYg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>

>Regarding intervals, we do have support for timeout and duration in
>the management interface, though these 2 are not exposed yet in D-Bus,
>not sure if is that what you want?

Indeed the mgmt interface has support for it and will be the fallback. Ulti=
mately it would be nice to=20
have this in DBus as CAP_NET_ADMIN is a no go for a client application.
For the time being that's no worse than the current situation though.

Clearly there is some work for me to do. Once again thank you for the point=
ers.

--
Alex
