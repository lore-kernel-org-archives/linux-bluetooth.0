Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 May 2010 23:18:29 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Dial-up Networking profile API
Message-ID: <20100517021829.GG23754@vigoh>
References: <1273371107-31813-1-git-send-email-gustavo@padovan.org>
 <33AB447FBD802F4E932063B962385B351E79EBA6@shsmsx501.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33AB447FBD802F4E932063B962385B351E79EBA6@shsmsx501.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhenhua,

* Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-05-10 08:41:59 +0800]:

...

> > +DUNAgent hierarchy
> > +===============
> > +
> > +Service         unique name
> > +Interface       org.bluez.DUNAgent
> > +Object path     freely definable
> > +
> > +Methods		void NewConnection(filedescriptor fd)
> > +
> > +			This method gets called whenever a new DUN
> > +			connection has been established.  The objectpath
> > +			contains the object path of the remote
> > device.  This
> > +			method assumes that DBus daemon with
> > file descriptor
> > +			passing capability is being used.
> > +
> > +			The agent should only return
> > successfully once the
> > +			establishment of the data call has been fineshed
> 
> A typo 'fineshed' should be 'finished'.

Thanks. ;)

> 
> > +			without problems.
> > +
> > +			Possible Errors:
> > org.bluez.Error.InvalidArguments
> > +					 org.bluez.Error.Failed
> > +
> > +		void Release()
> > +
> > +			This method gets called whenever the service daemon
> > +			unregisters the agent.
> 
> Compared with hfp-api.txt, I think we should also add the sentence like "or whenever the Adapter where the DUNAgent registers itself is removed".

Or we can remove that sentence from hfp-api, since when a adapter is
removed bluetoothd relaese all agents on that adapter.


Regards,

-- 
Gustavo F. Padovan
http://padovan.org
