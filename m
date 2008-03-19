Return-Path: <cyrus@holtmann.org>
Message-ID: <47E12208.1050803@aircable.net>
Date: Wed, 19 Mar 2008 11:24:08 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <BAY118-DAV93F8B33BE33C1D9FAEC00C7070@phx.gbl>
In-Reply-To: <BAY118-DAV93F8B33BE33C1D9FAEC00C7070@phx.gbl>
Subject: Re: [Bluez-users] multiple rfcomm listen
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1787390205=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1787390205==
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit

Chane,
> Can "rfcomm listen" accept multiple connections from rfcomm clients? I
> have tried two rfcomm listen as following:
> >rfcomm listen 0 1 &
> >rfcomm listen 0 2 &
rfcomm listen can listen to up to 7 concurrent connections, but not all
the connections to the same port (rfcomm# node). You should do:
rfcomm listen 0 1 &
rfcomm listen 1 2 &

And when the connection is established you will get:
/dev/rfcomm0
/dev/rfcomm1




--===============1787390205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1787390205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1787390205==--
