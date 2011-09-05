Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 15/16] Bluetooth: Support LE-Only discovery procedure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Sep 2011 11:00:57 +0200
In-Reply-To: <E08AB77C-CFED-4C47-ACE2-5BF773B2BC2F@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-16-git-send-email-andre.guedes@openbossa.org>
	 <1312984325.3373.119.camel@aeonflux>
	 <E08AB77C-CFED-4C47-ACE2-5BF773B2BC2F@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315213258.1979.14.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> This patch adds support for LE-Only discovery procedure through
> >> management interface.
> >>
> >> A new flag (HCI_LE_SCAN) was created to inform if the controller is
> >> performing LE scan. The HCI_LE_SCAN flag is set/cleared when the
> >> controller starts/stops scanning.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >> include/net/bluetooth/hci.h |    2 ++
> >> net/bluetooth/hci_event.c   |   39 +++++++++++++++++++++++++++++++++ 
> >> +++---
> >> net/bluetooth/mgmt.c        |    5 +++++
> >> 3 files changed, 43 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/ 
> >> hci.h
> >> index fb40388..c4fdeeb 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -86,6 +86,8 @@ enum {
> >> 	HCI_DEBUG_KEYS,
> >>
> >> 	HCI_RESET,
> >> +
> >> +	HCI_LE_SCAN,
> >> };
> >
> > I am really against adding any new flags here. This is a public API  
> > and
> > a horrible one actually.
> >
> > We need to have these states internal and stop adding more flags to  
> > this
> > public API.
> 
> The HCI_LE_SCAN flag is really device/controller related as well as
> HCI_INQURY flag is. They both have similar meaning and using. Besides,
> the userspace (hciconfig) might be interested in checking this flag to
> know if the controller is carrying out the LE scan (just like it does
> with HCI_INQUIRY flag).
> 
> So, may you consider we keep this flag here?

we can keep it for a little bit, but long term, these need to go away.
Especially since they are not available via the mgmt API (and that is
good this way).

Btw. it is not about telling the userspace that we currently run a
discovery procedure, it is more about how the flags are defined and how
bad off an ABI that is.

Regards

Marcel


