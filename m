Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAQUJlMiCNgE+BBNd7LHoCQwEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAQUJlMiCNgE+BBNd7LHoCQwEAAAAA@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1103109183.2143.215.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 15 Dec 2004 12:13:03 +0100

Hi Peter,

> ##>
> ##>LAP and DUN are two different profiles. I don't get what you mean.
> ##>
> elmeg Hotline wrote:
> leider liegen uns f=FCr Anwendungen unter Linux keine Informationen vor.
>=20
> Fuer einen Verbindungsaufbau zum Bluetooth-Accesspoint wird das LAP (LA=
N
> Access Profile) via DUN (Dial-Up Networking) verwendet. Wenn diese Dien=
ste
> unterstuetzt werden, sollte ein Verbindungsaufbau problemlos moeglich s=
ein.

what the f* is this. Use "sdptool browse ..." and "sdptool search ..."
to find out what services/profiles this device really supports, because
it seems that their support don't even know it.

Also do a "hcitool info ..." for me.

> So, I'm not so good in Linux to find the right way. Perhaps it may be
> possible with rfcomm ?
> What da you mean?

Of course it is possible, but maybe this is not the best device you can
buy (at least speaking about its Bluetooth support).

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
