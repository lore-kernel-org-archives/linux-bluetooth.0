Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jul 2011 12:58:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add SetRemoteProperty method for OOB mechanism
Message-ID: <20110705095830.GA10079@dell.ger.corp.intel.com>
References: <1309790985-32143-1-git-send-email-bulislaw@linux.com>
 <CABBYNZ+B_dDGRnoic6xyn4N1kRpOPTGrMJ7xBkmB7M=ZBsZzDQ@mail.gmail.com>
 <CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > I don't think this is the right approach for OOB data because this
> > information may become private to bluetoothd if the device is not
> > created since it is not associated with any device object/path, IMO
> > the OOB data needs to be passed in the CreateDevice which should take
> > a dictionary containing all the known information of the device, but
> > that breaks the API otherwise I would already send a patch proposing
> > this.
> 
> Right, i'v discussed this approach with Johan and Szymon on freenode
> -- i'v changed few things after that (mostly because implementing it
> in AddRemoteData would break api, so i moved it to separate method) --
> maybe it would be a good idea to have this functionality now in this
> form and change it when the api break would be possible (5.0?)?

To me, the closest analogy of receiving data like this over some OOB
channel is an inquiry result HCI event. Therefore, it'd be intuitive to
have this behave in a similar way: the data goes to storage and triggers
a DeviceFound event. Calling Create(Paired)Device remains separate from
all this.

This doesn't of course mean that we couldn't/shouldn't restructure the
device discovery process for 5.x to e.g. have D-Bus objects for every
found device and a Device.Pair() method, but the device information
received over an OOB channel should still map to a similar set of steps
as what happens when receiving a HCI inquiry result event.

Johan
