Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 3 Mar 2016 11:46:54 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kurt McAlpine <kurt@linux.com>,
	Ivan Deviatkin <devyatkin.ivan@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT server example issues in BlueZ
Message-ID: <20160303094652.GG17563@comms.fi.intel.com>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
 <CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
 <CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
 <20160302204223.GA18853@kurtmc.Eroad.local>
 <CABBYNZLnvwa5Xa=cg1eNdppJHynPj+HZChrmVAS52HCk49zmTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLnvwa5Xa=cg1eNdppJHynPj+HZChrmVAS52HCk49zmTw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 03, 2016 at 11:34:04AM +0200, Luiz Augusto von Dentz wrote:
> > I do see this but my android device cannot discover the GATT service within the
> > app. It is possible to pair with it, but not discover the services or even the
> > device within the app.
> >
> > I've tired "Bluetooth LE Scanner" and nRF Master Control Panel"
> >
> > Ivan if you have any success with this could you let me know how you did it?
> 
> Do you guys remember that you have to advertise to be able to connect:

I do it with btmgmt:

[mgmt]# advertising on
hci0 Set Advertising complete, settings: powered bondable ssp br/edr le
advertising secure-conn 
[mgmt]# connectable on
hci0 Set Connectable complete, settings: powered connectable bondable
ssp br/edr le advertising secure-conn 

Best regards 
Andrei Emeltchenko 

