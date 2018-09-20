Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180919225522.GF23038@fattuba.com>
References: <20180919225522.GF23038@fattuba.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Sep 2018 11:31:18 +0300
Message-ID: <CABBYNZJx7gY=6G2YHOcEPJag5rUeHPM3ZEdmhWvLqFhdbaxbOg@mail.gmail.com>
Subject: Re: BLE out of band mgmt over dbus?
To: Ryan Nowakowski <tubaman@fattuba.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ryan.nowakowski@arm.com, marcus.chang@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

On Thu, Sep 20, 2018 at 1:55 AM, Ryan Nowakowski <tubaman@fattuba.com> wrote:
> Hello bluez devs!
>
> It seems like the mgmt API, particularly the out of band management[1]
> isn't available via dbus.  Is there a particular reason that the mgmt
> stuff isn't exposed via dbus?

We have a plugin for neard, which is probably outdated by now, to do
OOB, not sure if that is your use case though.

> Thanks!
>
> Ryan
>
> [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n1279



-- 
Luiz Augusto von Dentz
