Return-Path: <cyrus@holtmann.org>
Message-ID: <54FDD188.4000201@ubnt.com>
Date: Mon, 09 Mar 2015 18:59:52 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Tim Tisdall <tisdall@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: bt dongle goes awry after too many connections
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>	<6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>	<CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>	<EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>	<CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com>	<CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com>	<54FDBBD2.10608@ubnt.com>	<185295B8-ABD9-4EDF-B290-12C430CCA906@holtmann.org>	<54FDCEBC.2050705@ubnt.com> <CAGxYWpYQGAYpDoa3=G+fwUxcqsA2pNbq81y4=-6ww8QXxeg+jQ@mail.gmail.com>
In-Reply-To: <CAGxYWpYQGAYpDoa3=G+fwUxcqsA2pNbq81y4=-6ww8QXxeg+jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


On 2015.03.09. 18:53, Tim Tisdall wrote:
> On Mon, Mar 9, 2015 at 12:47 PM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>> Sure, I noticed that lots of work has been done lately in regard to LE, so
>> I'm indeed using 5.28 daemon@3.19.x kernel in LE-only mode and so far so
>> good.
>> One of the useful things which still seems to be missing is the control over
>> LE advertisements via D-Bus iface. "Discoverable" property change does not
>> affect LE advs. I'm currently using 'hciconfig hci0 leadv' to make it work.
>> But still, LE advs stop and do not re-start after adapter is
>> connected/disconnected to some peripheral.
> It's doing what I'd expect then...  I expect dongles to be reset if
> they're unplugged and then re-attached.  I don't know if there's an
> expectation for devices to be returned to their last state if they're
> disconnected and re-connected when using DBUS, though.
I didn't mean physically re-plugging the adapter. LE advs stop when 
adapter (controlled via D-Bus) is connected to some other device and 
does not start again when connection is closed. The adapter itself stays 
as it is.
>   I've pretty
> much avoided the DBUS interface since most of what I'm doing is simply
> not possible through it.
