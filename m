Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
References: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
 <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Mon, 25 Jul 2016 16:41:45 +0530
Message-ID: <CAMj0Yys1efPQoZPPHbPKs54c9DFWRfFjhkt4Pe3K-fYaZZiarw@mail.gmail.com>
Subject: Re: BT PAN Connection - NAP with PANU ?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>
> I am using bluez 5.35 and performing one POC with NAP and PANU communication.
> I want to connect PANU with NAP, for this i executed below tasks
>
> 1) Created a bridge successfully with Ubuntu 15.10.
> 2) Executed /test/test-nap script and i can see that NAP has established.
>
> 3) I am not getting how to start PANU (client) so that it can be
> connected with NAP (as defined in above step 2) and start
> communicating each other.

How about doc/network-api.txt:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt

e.g: org.bluez.Network1.Connect("panu")

----------------------------------------------------------------------------------------------
My fault i did Top posting, so giving my reply again in right format.
----------------------------------------------------------------------------------------------------
Hi,

Thanks for reply, I will try this connect API.
In my case it need to be connected with NAP as PANU itself, so the
parameter of connect api  should states its own role or the role of
server with whom it needs to be connected?

These APIs are used in python examples, is there similar API available
for C programming application also?
Can i get similar C example ?

On Mon, Jul 25, 2016 at 1:50 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ajay,
>
> On Sat, Jul 23, 2016 at 9:39 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
>> Hi,
>>
>> I am using bluez 5.35 and performing one POC with NAP and PANU communication.
>> I want to connect PANU with NAP, for this i executed below tasks
>>
>> 1) Created a bridge successfully with Ubuntu 15.10.
>> 2) Executed /test/test-nap script and i can see that NAP has established.
>>
>> 3) I am not getting how to start PANU (client) so that it can be
>> connected with NAP (as defined in above step 2) and start
>> communicating each other.
>
> How about doc/network-api.txt:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt
>
> e.g: org.bluez.Network1.Connect("panu")
>
> --
> Luiz Augusto von Dentz
