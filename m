Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F5A472.30003@xmission.com>
Date: Wed, 30 Aug 2006 08:45:06 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com>
In-Reply-To: <44EC8877.8050200@palmsource.com>
Subject: Re: [Bluez-devel] Small patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

> Latest patch : Default daemon logfile is /dev/null. Try to open an l2cap
> socket with short timeout before doing  sdp_connect that can last very
> long. Also a script called a2dpair that wrap hcitool and passkey-agent
> as an effort to simplify pairing and a2dpd setup :D
> What about Matthew's patches? I plan to move to getopt and cleanup
> indent and traces so having them integrated first would be better as
> there are new options.

I looked over Matthew's patches and applied them. I applied your "small
patch" which turns out to be bigger than it sounds :)

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
