Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EFB84B.8070403@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ rfcomm channel
References: <20050120142851.72c326f4@CleverSophie>
In-Reply-To: <20050120142851.72c326f4@CleverSophie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 20 Jan 2005 14:55:23 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

# Bj=F6rn Specht # wrote:
| Hi guys,
|
| I am working on BlueZ for a few days now and it is hard to start
working with it for me. I want to write a program (Client/Server) in C
which uses the rfcomm socket and I want to use a channel to transfer
data between these two computers.
| The HCI_inquiry function is running and finds the other PC. How can I
establish a connection between these two computers with the rfcomm socket=
s?

have a look at the example programs. it should be something like:

(this is for connection to a headset with rfcomm, but it should be
similar. There are other examples in bluez-tools, if I'm not mistaken.

static int rfcomm_connect(bdaddr_t * src, bdaddr_t * dst, uint8_t channel=
)
{
~        struct sockaddr_rc addr;
~        int s;

~        if ((s =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < =
0) {
~                return -1;
~        }

~        memset(&addr, 0, sizeof(addr));
~        addr.rc_family =3D AF_BLUETOOTH;
~        bacpy(&addr.rc_bdaddr, src);
~        addr.rc_channel =3D 0;
~        if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
~                close(s);
~                return -1;
~        }

~        memset(&addr, 0, sizeof(addr));
~        addr.rc_family =3D AF_BLUETOOTH;
~        bacpy(&addr.rc_bdaddr, dst);
~        addr.rc_channel =3D channel;
~        if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
~                close(s);
~                return -1;
~        }

~        return s;
}

have fun,
~  Lars


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB77hLQWC6DTWkDAoRAqv0AJoCI5XuhYrqFGAM9qvqmbJr/VEQawCcD0uj
34s/2fQhdoiN+maE7liaH2M=3D
=3DPhyO
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
