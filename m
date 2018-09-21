Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180920233033.GK23038@fattuba.com>
References: <20180919225522.GF23038@fattuba.com> <CABBYNZJx7gY=6G2YHOcEPJag5rUeHPM3ZEdmhWvLqFhdbaxbOg@mail.gmail.com>
 <20180920233033.GK23038@fattuba.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Sep 2018 11:22:50 +0300
Message-ID: <CABBYNZJzebXGNaN-9jRM+9aAgN-ffBnrzHZ3ePjPaTaboeMTdA@mail.gmail.com>
Subject: Re: BLE out of band mgmt over dbus?
To: Ryan Nowakowski <tubaman@fattuba.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        marcus.chang@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

On Fri, Sep 21, 2018 at 2:30 AM, Ryan Nowakowski <tubaman@fattuba.com> wrote:
> On Thu, Sep 20, 2018 at 11:31:18AM +0300, Luiz Augusto von Dentz wrote:
>> Hi Ryan,
>>
>> On Thu, Sep 20, 2018 at 1:55 AM, Ryan Nowakowski <tubaman@fattuba.com> wrote:
>> > Hello bluez devs!
>> >
>> > It seems like the mgmt API, particularly the out of band management[1]
>> > isn't available via dbus.  Is there a particular reason that the mgmt
>> > stuff isn't exposed via dbus?
>>
>> We have a plugin for neard, which is probably outdated by now, to do
>> OOB, not sure if that is your use case though.
>
> We've looked at the neard plugin and it doesn't quiet fit our
> situation.  It looks like some other mgmt commands are already available via
> dbus(discovery, etc).  I'm thinking about writing a patch that would
> add the OOB mgmt commands to dbus.  Is this a terrible idea?

Perhaps you are referring to ConnectDevice:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n154

We could perhaps introduce an optional property for the application to
include the OOB data, but that should be validated by connecting and
attempting to encrypt, if that fails the OOB should be discarded.

> - Ryan
>
>> > [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n1279



-- 
Luiz Augusto von Dentz
