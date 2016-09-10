Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 10 Sep 2016 16:15:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brennan Ashton <brn@deako.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Option to disable filtering of duplicate LE ADV
Message-ID: <20160910131522.GA27849@t440s.P-661HNU-F1>
References: <1473451216.28342.4.camel@deako.com>
 <CABBYNZLwu-PG+Vwrzx4-tPufvre7tjgZxJmgk=VaSCi3qttAjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLwu-PG+Vwrzx4-tPufvre7tjgZxJmgk=VaSCi3qttAjA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Sep 10, 2016, Luiz Augusto von Dentz wrote:
> On Fri, Sep 9, 2016 at 11:00 PM, Brennan Ashton <brn@deako.com> wrote:
> > Right now in all of the le_scan functions filter_dup is set to
> > LE_SCAN_FILTER_DUP_ENABLE.  This is not always desired with beacons as
> > the content may change.  I can force this by sending the HCI commands
> > to enable scanning without this filter, but then the mgmt api (and
> > DBUS) cannot be used for scanning.
> >
> > I was wondering if people had thoughts on making this configurable?
> 
> Check out the SetDiscoveryFilter:
> 
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt
> 
> When that is used it will not enable duplicated filter and in fact is
> the only way to discover beacons which don't have discoverable flags
> sets e.g. broadcaster.

Actually Brennan is right that none of these methods disable duplicate
filtering. All of the places in the kernel that set the LE scan
parameters explicitly enable duplicate filtering. I suppose we should
seriously consider extending the mgmt API to allow performing LE scan
without the duplicate filtering. Right now the only way to do that is
through raw HCI access.

Johan
