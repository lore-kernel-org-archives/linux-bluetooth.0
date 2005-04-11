Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <C70061B183DE09419568AB2060C52A95324E4F@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Reopening RFCOMM socket
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Apr 2005 10:06:47 +0200

Hi Marcel,

In the quoted message below you say "If no other session is active the
underlaying ACL link will be terminated." It looks as if it does not
happen immediatelly. So there is a chance that if you open a new RFCOMM
socket very fast it will not bring down ACL link and will actually reuse
it? Cause I have a problem with Motorola V3, I bring down HF RFCOMM
socket (the only one active at the time) and then open DUN channel and
start pppd over it. And unless I see HCI disconnect for a underlaying
ACL link in hcidump log after closing HF RFCOMM, DUN RFCOMM becomes very
slow (takes much time to push/pull a packet to/from the phone). May be
some flow control issues?

Regards,
      Victor.
=20

Victor Shcherbatyuk | Software Developer | TomTom |
victor.shcherbatyuk@tomtom.com | +31 (0) 20 4469 873 office | +31 (0)
628 186314 mobile


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, April 08, 2005 19:28 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem to really close RFComm socket

Hi Frederic,

> I am trying to use RFComm sockets, but I have a problem when I close=20
> the socket, it does not close RFComm or ACL connection.
> So, if I try to reconnect I got an error 0x10. I used hcidump and=20
> nothing happens when close is called.
> The only way to really close is to stop the app.

are you using fork() in between?

The close() will close the DLC and if all DLCs are closed it will close
the session. If no other session is active the underlaying ACL link will
be terminated.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide Read honest & candid
reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
