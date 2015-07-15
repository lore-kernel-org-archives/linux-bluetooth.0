Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLLd-dS0u39roqCrin=MpYy7WNiL4MEYDik0o-0G84JDA@mail.gmail.com>
References: <CAPcThSGd9RO=8aK0ALkyWzSa7zLpr=8o7qMpT5sNex=LWu_XtQ@mail.gmail.com>
	<CABBYNZLLd-dS0u39roqCrin=MpYy7WNiL4MEYDik0o-0G84JDA@mail.gmail.com>
Date: Wed, 15 Jul 2015 22:13:39 +1000
Message-ID: <CAPcThSHpPpV8f=WeEEFySrWP9sHCfzqs+n5U+n+=wohwg0=g-g@mail.gmail.com>
Subject: Re: How to write a C program to be paired asynchronously?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Many thanks for your comments! I sure will try to navigate through the
source code to find a concrete answer.

I did some progress today but had a further related question about the
agent in the pairing process.

Previously I have manipulated bluez's dbus APIs to pair a given remote
device successfully, turns out before invoking the
CreatePairedDevice() method on the org.bluez.Adapter interface, I only
need to register the handler of the RequestConfirmation() message on
the org.bluez.Agent interface (although no object existed to register
it in the first place) to reply an empty reply and the pairing attempt
launched by remote device can succeed.

Later today I found that in order to handle async pairing request from
remote device successfully, aside from the handler of the same
RequestConfirmation() message, the missing piece seems to be using the
RegisterAgent() method on the org.bluez.Adapter interface, without
which the bluetoothd seems won't throw out the RequestConfirmation()
message at all.

Now what puzzles me is that if I register an agent before invoking the
CreatePairedDevice() method and passing it the discretionary object
path of the agent registered,  the RequestConfirmation() won't be
called at all in the first scenario. Also the doc/adapter-api.txt says
that during CreatePairedDevice() invocation it's not necessary to
register an agent, but it didn't prohibit it. By contrast, an agent
would have to be registered in the second scenario.

So, how should I use an agent consistently regardless of whether it is
incoming or outgoing pairing request?

Moreover, different agent capability such as KeyboardDisplay or
NoInputNoOutput will make a difference in terms of agent APIs invoked
by bluetoothd during pairing, how should I assign a proper capability
for my agent, if needed, for different devices such as mobile, headset
or keyboard?

Many thanks for all my newbie questions.

Cheers,
Harry


On Wed, Jul 15, 2015 at 8:58 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Harry,
>
> On Wed, Jul 15, 2015 at 1:53 AM, Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
>> Dear bluetooth community,
>>
>> I am a rookie to bluez internals. After "fixing" a potential defect in
>> one of blueman's script
>> (http://ubuntuforums.org/showthread.php?t=2286664) I can pair the HCI
>> adapter on my laptop from my mobile phone.
>>
>> Now I would like to come up with a C program for the same purpose, it
>> will manipulate the dbus APIs to capture the messages emitted from
>> bluetoothd when receiving async pairing request and consult the end
>> user whether to accept it.
>>
>> I can use dbus-monitor --system "sender='org.bluez'" command to
>> monitor all potential messages sent from bluetoothd during this
>> process, however, they all seem to be the PropertyChanged signal when
>> populating the newly created object /org/bluez/<pid>/hciX/dev_xx with
>> new properties. I am still clueless about relevant method_calls
>> blueman may have captured for pairing purpose, and am wondering if I
>> can do something similar for the same purpose but in C directly.
>>
>> Any suggestions or comments or references to bluez's work flow during
>> pairing process would be highly appreciated.
>
> You can check how our command line tool bluetoothctl does it, its
> source code is under client/ directory.
>
>
> --
> Luiz Augusto von Dentz
