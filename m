Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5551c99c-e21c-2381-8b17-96a79ed233de@felipetonello.com>
References: <CAOJvutMnJJJi=O1=e1kttqk4cLk_UvpwQyS4uetziqjsN_FX2g@mail.gmail.com>
 <5551c99c-e21c-2381-8b17-96a79ed233de@felipetonello.com>
From: "yon ar c'hall" <yon.ar.chall@gmail.com>
Date: Tue, 24 Jan 2017 16:53:07 +0100
Message-ID: <CAOJvutNaiTm8FY2-zuCm5BC2uOJ13_cvOqEizeeFt1DpJYtv2A@mail.gmail.com>
Subject: Re: Blood Pressure GATT LE profile
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Tue, Jan 24, 2017 at 3:45 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:

> plugin/gatt-example.c is not in the repository, as it is relevant
> anymore. gatt-example implemented a gatt-server using older deprecated API.

Oops, I made a typo : the sub-folder is "plugins" (with "s"), not
"plugin", and it's still in the bluez archive (5.43).

> Anyway, there are two ways to implement a GATT client profile (Central
> role). As a generic bluetoothd plugin that will export an API to
> applications via D-Bus, more likely.

We didn't find any source of a bluetoothd plugin implementing a GATT
LE profile (such as those listed on http://www.bluez.org/profiles/ :
HTP, HoG,...). Sorry, we're still missing something... Would there be
any piece of doc that could help for creating a bluetoothd plugin, as
it looks to be the correct way to proceed ?

> Or in your own application using the GATT D-Bus API that bluetoothd exports.
> test/example-gatt-client implements the Heart Rate profile quite simply
> using the D-Bus API.

We do understand the Python code of test/example-gatt-client :-) It
clearly helps to get the whole picture.
Thanks for the pointer.

-Yon
