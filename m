Return-Path: <brn@deako.com>
Message-ID: <1473698521.3306.4.camel@deako.com>
Subject: Re: Option to disable filtering of duplicate LE ADV
From: Brennan Ashton <brn@deako.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>
Date: Mon, 12 Sep 2016 09:42:01 -0700
In-Reply-To: <CABBYNZLkY1mQ8m62oWw1gFLrLVVOj_ENUuxCaLhwZnAbE4eB+g@mail.gmail.com>
References: <1473451216.28342.4.camel@deako.com>
	 <CABBYNZLwu-PG+Vwrzx4-tPufvre7tjgZxJmgk=VaSCi3qttAjA@mail.gmail.com>
	 <20160910131522.GA27849@t440s.P-661HNU-F1>
	 <608EEAD3-684A-4120-8694-B1777891447E@holtmann.org>
	 <CABBYNZLkY1mQ8m62oWw1gFLrLVVOj_ENUuxCaLhwZnAbE4eB+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2016-09-12 at 13:52 +0300, Luiz Augusto von Dentz wrote:
> Hi Marcel, Johan,
> 
> On Mon, Sep 12, 2016 at 9:47 AM, Marcel Holtmann <marcel@holtmann.org
> > wrote:
> > 
> > Hi Johan,
> > 
> > > 
> > > > 
> > > > > 
> > > > > Right now in all of the le_scan functions filter_dup is set
> > > > > to
> > > > > LE_SCAN_FILTER_DUP_ENABLE.  This is not always desired with
> > > > > beacons as
> > > > > the content may change.  I can force this by sending the HCI
> > > > > commands
> > > > > to enable scanning without this filter, but then the mgmt api
> > > > > (and
> > > > > DBUS) cannot be used for scanning.
> > > > > 
> > > > > I was wondering if people had thoughts on making this
> > > > > configurable?
> > > > 
> > > > Check out the SetDiscoveryFilter:
> > > > 
> > > > https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapte
> > > > r-api.txt
> > > > 
> > > > When that is used it will not enable duplicated filter and in
> > > > fact is
> > > > the only way to discover beacons which don't have discoverable
> > > > flags
> > > > sets e.g. broadcaster.
> > > 
> > > Actually Brennan is right that none of these methods disable
> > > duplicate
> > > filtering. All of the places in the kernel that set the LE scan
> > > parameters explicitly enable duplicate filtering. I suppose we
> > > should
> > > seriously consider extending the mgmt API to allow performing LE
> > > scan
> > > without the duplicate filtering. Right now the only way to do
> > > that is
> > > through raw HCI access.
> > 
> > however when a driver sets the strict duplicate filtering quirk,
> > then scanning will be restarted and thus new advertising data can
> > be found.
> 
> Im not sure what the quirk actually means but it doesn't look like it
> will be able to attend the RSSI filtering since the controller may
> omit results thus why I though duplicate was not enabled when
> filtering is. From the code it looks like the quirk would force
> restarting the scanning:
> 
> /* If duplicate filtering does not report RSSI changes, then restart
> * scanning to ensure updated result with updated RSSI values.
> */
> if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)) {
> restart_le_scan(hdev);
> 
> Isn't that a causing a little too many restarts? I wonder if there is
> anyone using this quirk in practice? And is this really worth it
> instead of just disabling the duplicate filter?
> 

I am not sure I fully understand what this quirk, but I suspect we are
going to want to have the option for turning on duplicate filtering.
Beacons and mesh are going to become more and more common and the later
would cause an HCI event every time a new packet was broadcast. In most
cases these are not of interest to people unless they are explicity
expecting them.

I would propose adding SetSuplicateFilter to the adaptor API. I am
happy to write some code for this today if people think this makes
sense.


--Brennan
