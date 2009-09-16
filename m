Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB107DE.5070700@binarywings.net>
Date: Wed, 16 Sep 2009 17:44:30 +0200
From: Florian Philipp <lists@binarywings.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com> <20090915061104.GA20323@jh-x301> <4AAFBFA6.70007@binarywings.net> <20090915165854.GA6550@jh-x301>
In-Reply-To: <20090915165854.GA6550@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg schrieb:
> Hi,
> 
> On Tue, Sep 15, 2009, Florian Philipp wrote:
>> Just out of curiosity: Why does Bluez no longer provide any kind of
>> deamon as a pin helper any more?
> 
> Isn't that exactly what the two command line based agents are if you run
> them in the background and modify them to always accept pairing requests?
> Or am I misunderstanding your question?

I suppose these two programs would suit my needs just fine - if I modify
them as you suggested. I just don't understand the reasons why an
arbitrary number of users (including me) should be bothered to
write/modify/fork their own pin helper. If it is something so simple
that every user can do it himself, sure enough the official bluez devs
can do it too. The latter option would have some advantages:

- programming it one time instead of programming it n times
- me as a user can (to some degree) be confident that the app will still
work with the next release whereas a 'test program' might just be
dropped without any warning
- linux distributions could provide packages for it. Therefore me as a
user wouldn't have to maintain it, compile it against the newest bluez
libs after every automatic update, test it, etc.

Of course I can't force you to do the programming but removing
functionality which worked - more or less - out of the box with an older
release and not providing any working alternative except of a
do-it-yourself solution ... well ... just sounds wrong.

> Note that we can't anymore have
> interfaces which just deal with a simple PIN. Bluetooth 2.1 SSP brings
> along it's own set of callbacks that need handling and any interface that
> we define (be it a config file, D-Bus or something else) needs to take
> that into account.
> 

Okay, so without some significant work, you could only support legacy
pairing for those old deamons and I suppose that's all those test apps
can, right?

>> I mean, it's not like Bluetooth itself is limited to interactive systems
>> which rightly demand graphical interfaces nowadays. Stuff like NAP is a
>> classic client-server situation in which you don't want to use Gnome or
>> KDE apps on the server side and maybe not even on the client side.
> 
> The current agent interface design doesn't restrict you in any way to
> interactive systems. It merely exports the pairing callbacks from
> bluetoothd to an external process. bluetoothd doesn't care if that process
> does some interactive stuff or not.
> 

I already understood that. It's just that the only programs which are
currently available (precompiled and ready to go) for me as a user are
interactive apps with dependencies on Gnome or KDE.

Do you understand what's my problem here? Bluetooth itself suits my
current needs just fine: Wireless network with less range, less
bandwidth and less power consumption than WLAN. That's why I adopted
bluetooth for this project of mine. Now with bluez-3.x or 4.x, Bluetooth
still suits my needs, it's just that the only available implementation
doesn't suit them any longer.

Now I have three options:
a) Create and maintain the missing parts myself.
b) Switch to WLAN which is far inferior for my use case but which will
work out-of-the-box with deamons like wpa_supplicant.
c) Stick with bluez-2.x until the situation becomes unbearable, then
think again.

Currently I'm with c)
