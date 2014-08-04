Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <34DE67E73839C446B4269BCE8A1F303A01248EBDD5@CAMEUREXM01.EUROPE.ROOT.PRI>
References: <34DE67E73839C446B4269BCE8A1F303A01248EBDD5@CAMEUREXM01.EUROPE.ROOT.PRI>
Date: Mon, 4 Aug 2014 11:21:03 +0300
Message-ID: <CABBYNZJsbwsT9d5AxpDwtWVZFw60mY5TevGbTJqO_AowV4G2fw@mail.gmail.com>
Subject: Re: Re: HoG: Support multi output report
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Aravind Parvathala <Aravind.Parvathala@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aravind,

On Fri, Aug 1, 2014 at 3:06 PM, Aravind Parvathala
<Aravind.Parvathala@csr.com> wrote:
> Hi Luiz,
> Further to Murat's response I am interested in the solution you mentioned.
>
>>>On Thurs, July 31, 2014 at 09:11 AM, Luiz Augusto von Dentz <luiz.dentz <at> gmail.com> wrote:
>>>Hi Murat,
>>
>>Hi Luiz,
>>
>>>
>>>On Wed, Jul 30, 2014 at 5:34 PM, Murat Kilivan <Murat.Kilivan <at> csr.com> wrote:
>>>> Hi,
>>>>
>>>> I have a BLE HID device which has 2 output reports and it is discovered properly by BlueZ. However, when I
>>try to send an output report it always >calls the first registered report id's handle. It doesn't matter
>>what the first byte is in the message.
>>>>
>>>> How can I send to a different output report?
>>>>
>>>> I can supply any log/debug output if it is needed.
>>>
>>>I had the impression that you would have to have another instance to access the second output but perhaps we
>>>should check the report id but then the question is how do you know what are the available report ids? We
>>>never expose those to uHID so is this supposed to be hardcoded?
>
> What did you mean by another instance? Is there a way to configure the blue-z stack to create separate instances (are they hidraw device instances or something else) for each of the HID output report?

Take a look at android/hog.c it supports multiple instances already
you basically can have more than one HID service in your primaries
which I believe is what PTS does.

> Any suggestions on how to achieve that? Can the HID report map be configured such that there are two different collections, each with one output report so that the kernel enumerates them as two different device instances?

They are two completely separate instances with their own report map
and in that case we would create each individual instance as a
separate uHID device.

@David: If we got multiple output reports how do the driver discover them?
