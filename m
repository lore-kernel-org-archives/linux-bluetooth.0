Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAO1O6sfUC2msw2yq5jxod9Fjagt8ckj0iNefod62Okubj0Nxvw@mail.gmail.com>
References: <CAAu3APY4HhpFyBBu9nLqPyO6SvQpC_tTj1pokSCn4DtxQQZbRg@mail.gmail.com>
 <CABBYNZ++LGPjjWSxz4DyjgjNRm2Qyq6F50bbLDfKgJAdXSVYLA@mail.gmail.com>
 <CAAu3APYkBV3OfrEeB8QQrTLPL86sVoSaawdyew7qkEv210Br2A@mail.gmail.com> <CAO1O6sfUC2msw2yq5jxod9Fjagt8ckj0iNefod62Okubj0Nxvw@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 6 Oct 2016 13:49:17 +0100
Message-ID: <CAAu3APaJrFOqZU2EHQXkposk9Nm3fLegAz6Z2L2wYsExG8_Kdw@mail.gmail.com>
Subject: Re: Fatbeacons and 'streamed read' of a characteristic
To: Emil Lenngren <emil.lenngren@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Emil,

On 6 October 2016 at 12:21, Emil Lenngren <emil.lenngren@gmail.com> wrote:
> Hi
>
> 2016-10-06 10:49 GMT+02:00 Barry Byford <31baz66@gmail.com>:
>>
>> Hello Luiz,
>>
>>
>> On 6 October 2016 at 09:23, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> wrote:
>> > Hi Barry,
>> >
>> > On Wed, Oct 5, 2016 at 11:31 PM, Barry Byford <31baz66@gmail.com> wrote:
>> >> Hello,
>> >>
>> >> I've been doing some experiments with Googles Physical Web Fatbeacon
>> >>
>> >> https://github.com/google/physical-web/issues/784#issuecomment-251571858
>> >>
>> >> The experiments have been with BlueZ 5.40 using the DBus API with
>> >> Python 3. BlueZ is advertising a connectable Eddystone beacon. When
>> >> the Physical Web Android app connects there is one service with one
>> >> characteristic that it is looking for. That characteristic contains a
>> >> string that is the HTML content.
>> >> All is working well if the web page contained in the characteristic is
>> >> nice and short.
>> >> However if I make the web page content slightly longer then I end up
>> >> getting stuck in a loop where the Physical Web app is just reading the
>> >> first part of the characteristic over and over again.
>> >
>> > How big is it? The spec actually limits the attribute contents to 512
>> > bytes. On the other hand I remember the Android App returning
>> > different parts of the data on every read, so it essentially doing its
>> > own fragmentation.
>>
>> My content is bigger than 512 bytes when it starts failing. The app is
>> definitely making multi-read requests of my characteristic. The bit
>> that I'm missing is how to make the beacon/service give the next chunk
>> of content on each read.
>>
>>
>> >> I'm assuming that it is not that uncommon for data to be larger than
>> >> can be retrieved in one read although I've not been able to find an
>> >> example. I'm a little bit at a loss as to what the ReadValue method
>> >> should look like for this characteristic.
>> >> Is anyone able to give me some pointers as to what I need to do to get
>> >> this to work?
>> >
>> > Check out the Android physical web application:
>> >
>> >
>> > https://play.google.com/store/apps/details?id=physical_web.org.physicalweb&hl=en
>> >
>>
>> It is that app that I'm using to connect to the
>> beacon/service/characteristic I've created with BlueZ.
>>
>> I seem to be missing something obvious. The app is making multiple
>> reads and I had expected the ReadValue to be called with an offset
>> given in the options. This isn't the case.
>
>
> Since a characteristic can only be 512 bytes, you can never use Read
> Requests or Read Blob Requests to get more than 512 bytes if the
> characteristic is not updated.
> Normally when you want to stream over a lot of data over BLE you don't put
> everything in a GATT db and then read it. Instead you use set up to send a
> lot of notifications for example when you receive some write to a control
> point. Since there is no limitation how many notifications you can send,
> just fragment your data into multiple notifications (according to the ATT
> MTU size) and send them over.

Your comments seem to be inline with the discussion going on in the
issue tracker over on the Physical Web repository as how to possibly
implement this in the future. Your input I'm sure would be welcome
over there.

However this isn't what the Physical Web app is currently looking for.
Am I correct in assuming from your reply that I can't implement what
is currently required with the BlueZ DBus API?

Thanks,
Barry
