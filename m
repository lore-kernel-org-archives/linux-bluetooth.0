Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7467d398-33a5-fdaa-7e57-46e4f37fad87@felipetonello.com>
References: <CAOJvutMnJJJi=O1=e1kttqk4cLk_UvpwQyS4uetziqjsN_FX2g@mail.gmail.com>
 <5551c99c-e21c-2381-8b17-96a79ed233de@felipetonello.com> <CAOJvutNaiTm8FY2-zuCm5BC2uOJ13_cvOqEizeeFt1DpJYtv2A@mail.gmail.com>
 <7467d398-33a5-fdaa-7e57-46e4f37fad87@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jan 2017 21:19:58 +0200
Message-ID: <CABBYNZJqL6OeEeMBi3eYJY8RRgJOiR3Qayf9=iYswh9M8YdxGw@mail.gmail.com>
Subject: Re: Blood Pressure GATT LE profile
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "yon ar c'hall" <yon.ar.chall@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 24, 2017 at 9:02 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Yon,
>
> On 24/01/17 15:53, yon ar c'hall wrote:
>> Hi Felipe,
>>
>> On Tue, Jan 24, 2017 at 3:45 PM, Felipe Ferreri Tonello
>> <eu@felipetonello.com> wrote:
>>
>>> plugin/gatt-example.c is not in the repository, as it is relevant
>>> anymore. gatt-example implemented a gatt-server using older deprecated API.
>>
>> Oops, I made a typo : the sub-folder is "plugins" (with "s"), not
>> "plugin", and it's still in the bluez archive (5.43).
>
> That is true, but it is still not usable anymore. From git log:
>
> commit cc80afff47938a2c93aff0f7904fd937e6333908
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Tue Nov 8 11:00:28 2016 +0200
>
>     build: Remove gatt-example plugin
>
>     This examples can be done over D-Bus already so it makes no sense to
> have
>     it as a plugin and in fact it currently it doesn't even work since
> it was
>     never ported to the new code under src/shared.
>
>>
>>> Anyway, there are two ways to implement a GATT client profile (Central
>>> role). As a generic bluetoothd plugin that will export an API to
>>> applications via D-Bus, more likely.
>>
>> We didn't find any source of a bluetoothd plugin implementing a GATT
>> LE profile (such as those listed on http://www.bluez.org/profiles/ :
>> HTP, HoG,...). Sorry, we're still missing something... Would there be
>> any piece of doc that could help for creating a bluetoothd plugin, as
>> it looks to be the correct way to proceed ?
>
> Not really. Just source code.
>
> You can check profile implementations under profiles/ and then just
> check the code there.
>
>>
>>> Or in your own application using the GATT D-Bus API that bluetoothd exports.
>>> test/example-gatt-client implements the Heart Rate profile quite simply
>>> using the D-Bus API.
>>
>> We do understand the Python code of test/example-gatt-client :-) It
>> clearly helps to get the whole picture.
>> Thanks for the pointer.
>>

In case you are looking for C examples, take a look at bluetoothctl
code under client/, it is pretty complete generic GATT client.


-- 
Luiz Augusto von Dentz
