Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <c362cb880902281532ia34c1f8r64e7a8fae8684a3a@mail.gmail.com>
References: <c362cb880902281532ia34c1f8r64e7a8fae8684a3a@mail.gmail.com>
Date: Sat, 28 Feb 2009 23:33:43 +0000
Message-ID: <c362cb880902281533w260a358bo42bac372c65f1508@mail.gmail.com>
Subject: Re: How to set up and use BlueZ/Bluetooth in Slackware
From: Lee Jones <slothpuck@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 28, 2009 at 11:32 PM, Lee Jones <slothpuck@gmail.com> wrote:
> Hello all,
>
> Here's what I am trying to do. Basically my aim is to use USB based
> bluetooth adapters to share an internet connection from one PC to an
> old Apple imac (G3). However, I'm not really having much success in
> doing so.
>
> First of all let me mention what version of linux distro I'm using.
> The computer(s) I am using all run slackware, slamd64 (64-bit version
> of slackware) and slackintosh (a PPC version of slackware). From
> memory, slackintosh is 12.1; slackware and slamd64 are on 12.2 .
>
> Unfortunatly although slackware already comes with a compiled version
> of bluez which appears to be functioning I cannot really find any
> information on how to set it all up. All the information to date I've
> come across by googling suggests the following;
>
> * Refers to a different distro (e.g. ubuntu) so all the config/setup
> details are different.
> * The information is 3,4,5 or more years old and out of date.
> * "Install KDE". :( .
>
> Ok so you might wonder why I don't just use wireless? Well, the idea
> goes like this -- use wireless (which is already functioning on the PC
> running slamd64) to get the internet connection (fully working, I'm
> using it right now to type this message and email it!) and then use
> bluetooth on the old imac G3 with slackintosh to share the PC's
> internet connection. Ndiswrapper could never work on the G3 since it's
> only for x86, not PPC, and none of my USB wireless adapters work
> without ndiswrapper. Besides, on such an old (but usable) machine the
> full speed of a wlan (wireless) USB would never be used.
>
> But bluetooth *does* seem to work on the G3, and for that matter -the
> 64 bit (slamd64) system too! Only snag is .... is how to set it all
> up.
>
> One bluetooth adapter (on the 64 bit system) is configured with MAC
> address 00:11:67:45:45:45
> The other (G3 imac) is configured with MAC address 00:11:67:18:18:18
>
> So far, I can get each adapter to scan one another, and they detect
> one another ok. So "hcitool scan" on the system with MAC address
> displays 00:11:67:18:18:18; the other 00:11:67:45:45:45  . But that's
> as far as I can get!
>
> Now if I try hcitool hci0 up, and try to  l2ping one anothers'
> bluetooth USB sticks, I always get the same message - "no route to
> host". Trying something like "sdptool browse 00:11:67:45:45:45"
> displays nothing, I have to hit CTRL-C to stop it.
>
> I understand that both USB bluetooth sticks need to "see" each other
> but that's where I cannot find the information. Both of my USB
> bluetooth sticks have green LEDs which flash on and off, which (I'm
> guessing) means they're looking for one another but can't find one
> another.
>
> Can anyone help on this?
>
> ljones
>


I should also add that I get exactly the same problems if I replace
the G3 imac with a normal PC laptop, I have tried doing the same thing
by replacing the G3 imac with an IBM T22 laptop, but I get the same
problems.

ljones
