Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1473451216.28342.4.camel@deako.com>
References: <1473451216.28342.4.camel@deako.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 10 Sep 2016 11:27:10 +0300
Message-ID: <CABBYNZLwu-PG+Vwrzx4-tPufvre7tjgZxJmgk=VaSCi3qttAjA@mail.gmail.com>
Subject: Re: Option to disable filtering of duplicate LE ADV
To: Brennan Ashton <brn@deako.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brennan,

On Fri, Sep 9, 2016 at 11:00 PM, Brennan Ashton <brn@deako.com> wrote:
> Right now in all of the le_scan functions filter_dup is set to
> LE_SCAN_FILTER_DUP_ENABLE.  This is not always desired with beacons as
> the content may change.  I can force this by sending the HCI commands
> to enable scanning without this filter, but then the mgmt api (and
> DBUS) cannot be used for scanning.
>
> I was wondering if people had thoughts on making this configurable?

Check out the SetDiscoveryFilter:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt

When that is used it will not enable duplicated filter and in fact is
the only way to discover beacons which don't have discoverable flags
sets e.g. broadcaster.


-- 
Luiz Augusto von Dentz
