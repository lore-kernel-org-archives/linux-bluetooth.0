Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOMqctQvwYLYp2N=sp+NHrAJyW9_8h6V1_KG-9cV5=uvBTzdSg@mail.gmail.com>
References: <CAOMqctQvwYLYp2N=sp+NHrAJyW9_8h6V1_KG-9cV5=uvBTzdSg@mail.gmail.com>
Date: Mon, 23 Nov 2015 13:47:18 +0200
Message-ID: <CABBYNZ+J5AwMuyKpz0RYXHYX_oK8Y6H1gVT_WYJy8BGdiEaB=g@mail.gmail.com>
Subject: Re: bluetoothd crashes when media endpoint SelectConfiguration reply
 does not contain an array
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Suchanek <hramrach@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Sun, Nov 22, 2015 at 12:45 AM, Michal Suchanek <hramrach@gmail.com> wrote:
> Hello,
>
> I am using bluez 5.36 on Debian.
>
> I tried to export a media source from an application. However, when
> the SelectConfiguration call finishes bluetoothd crashes.
>
> Looking at the code there is no check that the return from the
> callback actually contains an array before trying to extract the array
> content.
>
> Adding a check avoids the crash in bluetoothd.
>
> I am not sure why the return value does not contain a proper
> capabilities array but that is another issue.
>
> Sending a patch that fixes the problem for me.

The fix looks good, please send a proper patch so I can apply. About
the response not being an array, this is probably a custom endpoint
because with PA or simple-endpoint but should respond properly, but it
is a valid fix anyway.


-- 
Luiz Augusto von Dentz
