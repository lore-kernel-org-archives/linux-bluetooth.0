Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Apr 2012 18:13:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Auth combination keys should be stored
 permanently
Message-ID: <20120417151337.GA9131@x220.ger.corp.intel.com>
References: <1334663953-15017-1-git-send-email-vishal.agarwal@stericsson.com>
 <20120417123301.GA4069@x220.ger.corp.intel.com>
 <CA+_sZW9z4+daWt8MwksJQqK+T58t=90ZWo1RnUow9QZptq0=tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+_sZW9z4+daWt8MwksJQqK+T58t=90ZWo1RnUow9QZptq0=tQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Tue, Apr 17, 2012, vishal agarwal wrote:
> > On Tue, Apr 17, 2012, Vishal Agarwal wrote:
> >> If either local or remote device auth type is general bonding
> >> (for ex. if local auth type is 0 but remote auth type is 5) then it
> >> will result in link key of type authenticated link key. Which according
> >> to spec should be stored for future use.
> >
> > You'll need to give some precise references into the core specification
> > about where you think it says this since I think you are a bit confused
> > here. I'd also advice you to carefully read section 5.2.2.6 on page 1668
> > and table 5.6 on page 1669. Those describe how the IO capabilities
> > (note: *not* authentication requirements) map to the resulting key type.
> > The only case where the auth requirements affect the key type is if
> > neither side has the MITM bit set (in which case you get an
> > unauthenticated key).
> >
> > In your example with the local auth requirement being 0, meaning no
> > bonding, the spec says this (section 6.5.3.1, page 1680):
> >
> > "'No bonding' is used when the device is performing a Secure Simple
> > Pairing procedure, but does not intend to retain the link key after the
> > physical link is disconnected."
> >
> > I.e. if we have 0 it means that we do not intend to store the key and
> > hci_persistent_key should return false. The key type otoh tells us
> > nothing about the authentication requirement. You can get an
> > authenticated combination key with no-bonding, dedicated bonding
> > as well as with general bonding.
> >
> Thanks for your comments -
> I will try to modify a bit my example
> 
> Local device -
> Auth type = 5 (MITM with general bonding)
> iocapability = DisplayYesNo
> 
> Remote device -
> Auth type = 0 (No MITM)
> iocapability = DisplayYesNo
> 
> Now as one of the device supports MITM, key type will be determined by
> the table at 1669(table number 5.6). and also as both devices support
> DisplayYesNo key type will be Authenticated. And also as local auth type
> is not 'no bonding' should'nt we try to store the key? or because remote is
> saying 'no bonding' we will also not store the key.
> 
> correct me if I am wrong, Spec is not saying that we should not store
> the key if auth type is 'No bonding'. 'No bonding' is used when we do not want
> to store the key. But because remote requested MITM and also supports required
> capabilities link key generated is Authenticated. And if we store the
> link key we will
> avoid future pairing. If both the devices requested 'No Bonding' then
> we will not store
> the key.

As I quoted the spec says that a device which has no-bonding "does not
intend to retain the link key after the physical link is disconnected".

If one side doesn't store the key it makes no sense for the other side
to do so either as it couldn't be used for anything in subsequent
connections and this is why the logic is as it is.

Johan
