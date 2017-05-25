Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: How to create multiple rfcomm devices with a set name
References: <c41a61c1-73f9-3e9a-ae18-c778a7db09f9@rug.nl>
 <CAAu3APZXiidEnqO0XbS=+oAp0nLzxY2wFfpRFXiL=98Psw+C+Q@mail.gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
From: "s.achterop@rug.nl" <s.achterop@rug.nl>
Message-ID: <a3c034f2-6947-3bb9-d52e-38c90752a061@rug.nl>
Date: Thu, 25 May 2017 10:16:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAAu3APZXiidEnqO0XbS=+oAp0nLzxY2wFfpRFXiL=98Psw+C+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/23/2017 09:21 PM, Barry Byford wrote:

>> Now with debian/stretch and ubuntu/16.04 (and rfcomm.conf not working
>> anymore) i need something simular.
>> My question is how do I create a rfcomm-device that matches the above rule.
>> I only can create rfcomm0 devices.
>
> Not sure I have all the answers to your questions. I think you need to
> use Profile API.
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt
>
> There is an example in bluez/test:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile
>
> I've also got an example using it with the Serial Port Profile:
> https://gist.github.com/ukBaz/217875c83c2535d22a16ba38fc8f2a91

   Thanks for the reply.

I now am diving into bluetooth programming!

Am I correct in assuming that the rfcomm.conf functionality does not exist anymore?
And that it has to be created again for bluez5?
So that's probably what I will be doing in the next few days;)

    Regards, Sietse


