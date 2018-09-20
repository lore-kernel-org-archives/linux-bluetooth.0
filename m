Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 20 Sep 2018 18:30:33 -0500
From: Ryan Nowakowski <tubaman@fattuba.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcus.chang@arm.com
Subject: Re: BLE out of band mgmt over dbus?
Message-ID: <20180920233033.GK23038@fattuba.com>
References: <20180919225522.GF23038@fattuba.com>
 <CABBYNZJx7gY=6G2YHOcEPJag5rUeHPM3ZEdmhWvLqFhdbaxbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJx7gY=6G2YHOcEPJag5rUeHPM3ZEdmhWvLqFhdbaxbOg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 20, 2018 at 11:31:18AM +0300, Luiz Augusto von Dentz wrote:
> Hi Ryan,
> 
> On Thu, Sep 20, 2018 at 1:55 AM, Ryan Nowakowski <tubaman@fattuba.com> wrote:
> > Hello bluez devs!
> >
> > It seems like the mgmt API, particularly the out of band management[1]
> > isn't available via dbus.  Is there a particular reason that the mgmt
> > stuff isn't exposed via dbus?
> 
> We have a plugin for neard, which is probably outdated by now, to do
> OOB, not sure if that is your use case though.

We've looked at the neard plugin and it doesn't quiet fit our
situation.  It looks like some other mgmt commands are already available via
dbus(discovery, etc).  I'm thinking about writing a patch that would
add the OOB mgmt commands to dbus.  Is this a terrible idea?

- Ryan

> > [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n1279
