Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Sat, 25 Jun 2011 16:40:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Keith Packard <keithp@keithp.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Waldemar.Rymarkiewicz@tieto.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <20110625194032.GE22619@joana>
References: <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
 <20110609083345.GA2894@dell.ccr.corp.intel.com>
 <yuny61b3pnm.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
 <20110610055558.GA1832@dell>
 <BANLkTim4F8ZvWPMHSXpcBj9Eb2uFThcz4w@mail.gmail.com>
 <yun8vsynkiy.fsf@aiko.keithp.com>
 <20110619175937.GA24188@dell.ger.corp.intel.com>
 <yunliwxabmz.fsf@aiko.keithp.com>
 <4E0575DE.4070004@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E0575DE.4070004@goop.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Jeremy Fitzhardinge <jeremy@goop.org> [2011-06-24 22:45:02 -0700]:

> On 06/19/2011 12:01 PM, Keith Packard wrote:
> >> I think you'll need both of them to fix the pairing/security issues.
> > Yup, with both of those patches, I get syncml and dun working again.
> >
> > (sorry for the delayed testing, I'm traveling)
> 
> I just bisected the problems I had reconnecting my Nokia BH-905i
> headphones to the same change that Keith identified, and merging
> git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git
> into my tree fixed it.
> 
> So +1 from me to get this into mainline soon.

It's on the way. Right now patches are on David Miller' tree.

	Gustavo
