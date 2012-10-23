Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Oct 2012 23:48:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
Message-ID: <20121023204809.GB12042@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
 <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
 <1351018956.1785.45.camel@aeonflux>
 <CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 23, 2012, Anderson Lizardo wrote:
> Johan: do you have further plans on improving LE peripheral support
> after these patches? If yes, please keep in mind that we still have
> ongoing plans to push broadcaster/observer roles upstream, which also
> requires hability to enable/disable advertising and set advertising
> data/parameters.

Looking through the various "shall" and "shall not" clauses in the core
spec it seems to me that only Central, Observer and Broadcaster roles
are compatible with each other, and Peripheral is mutually exclusive
with anything else. E.g. section 9.2.4.2 (page 1700):

"While a device is in the Broadcaster, Observer or Central role the
device shall not support the general discoverable mode."

and section 9.3.4.2 (page 1709):

"While a device is in the Broadcaster, Observer, or the Central role
the device shall not support the undirected connectable mode."

Both general discoverable and undirected connectable are needed by
Peripheral role, i.e. essentially excluding the other roles.

Extending the other roles could indeed be a matter of interpreting the
mgmt_set_le parameter as a bit mask and then returning an error if an
incompatible combination of roles is attempted. Also, once support for
new roles is added it should be easy to extend the current state checks
to make a distinction on exactly what kind of scanning/advertising is
done instead of just looking at "advertising or not" on a general level.

Johan
