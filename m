Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth for network
From: Marcel Holtmann <marcel@holtmann.org>
To: "Peter K. Martin" <Peter.K.Martin@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAFSqC4ChMLEGKSvEU2nZPawEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAFSqC4ChMLEGKSvEU2nZPawEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1097235419.4407.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 08 Oct 2004 13:36:59 +0200

Hi Peter,

> > I'm using SuSE 9.1 and have installed and activated the 
> > bluetooth-function of my notebook (Toshiba Satellite Pro M10). Now I 
> > want to use the bluetooth-connection to an accesspoint - it is 
> > possible to establish this connection - as a dummy-networkcard.
> 
> > if you access point uses the PAN profile then you can use pand and then
> configure the new >  > bnep0 network interface like you did with eth0
> before.
> 
> Unfortunately I cannot use pand, I already tried it - no reaction, also the
> second one which comes with bluez. Only hcitool works and with hcitool cc
> <addr> I'm able to connect to the accesspoint. Is there a way with rfcommX
> and how to do this?

then you must use dund for PPP over RFCOMM.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
