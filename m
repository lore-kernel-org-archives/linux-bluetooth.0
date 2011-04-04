Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 10:46:42 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Ferraton, Jean RegisX" <jean.regisx.ferraton@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Question about supported profiles
Message-ID: <20110404134641.GA3696@piper>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8CC70E3BCE@irsmsx501.ger.corp.intel.com>
 <AANLkTim3NBH2dB=EF2pZDEoj+77Gv+k3JKvqSwc=6sFk@mail.gmail.com>
 <6E42A1B4DD2F7B4D80A1F26BB498BF9F8CC70E3EC6@irsmsx501.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8CC70E3EC6@irsmsx501.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jean,

On 09:32 Mon 04 Apr, Ferraton, Jean RegisX wrote:
> Hi Arun,
> 
> > -----Original Message-----
> > From: Arun K. Singh [mailto:arunkat@gmail.com]
> > Sent: Friday, April 01, 2011 7:06 PM
> > To: Ferraton, Jean RegisX
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: Question about supported profiles
> > 
> > Hi Jean,
> > 
> > > I have a question about supported profiles under linux-bluez.
> > > Where and how are defined the default supported profiles? Is it a conf
> > file?
> > > In our case, by default we support HFP, A2DP, OPP, AVRCP...
> > > But if we want to use FTP or DUN, we have to enter "sdptool add DUN" or
> > " sdptool add FTP"
> > > Can anyone tell me how to change the default params?
> > 
> > First of all its not clear what exactly are you looking for? in case
> > you need to know which all profiles are supported in bluez,
> > ./configure --help should help! Most of the profiles are implemented
> > as plugins to either bluetoothd or obexd.
> > Few of the profiles are also supported via daemons. All data profiles,
> > such as FTP/OPP/PBAP they are supported as obex plugins.
> > hope this helps.
> > 
> > thanks,
> > Arun
> 
> To clarify my question, I want to know where is stored the information of profiles supported by our device when we launch the command "sdptool browse BDADDR" from an external device. This command gives us our platform default supported profiles.
> If I launch additional commands like "sdptool add DUN" or " sdptool add FTP", my platform is seen as supporting more profiles.
> Where and how can I modify this default profile list?

Normally those SDP records are added by bluetoothd services (audio and
network, for example) or some external service (obexd is a good example).

For the bluetoothd services case, you can disable the services that you
don't want editing the configuration file (by default,
/etc/bluetooth/main.conf), for obexd you have to edit its command line
parameters.

> Thanks
> Regards
> Jean
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


Cheers,
-- 
Vinicius
