Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Fw: [Bluez-devel] Question about the SPDTOOL and the
	sdp_service_search_attr_req
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <001701c625ed$d4921c60$c800a8c0@kazama>
References: <001701c625ed$d4921c60$c800a8c0@kazama>
Content-Type: text/plain; charset=utf-8
Message-Id: <1138731763.3968.8.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Tue, 31 Jan 2006 19:22:43 +0100

Hi,

> Have problems with the SDPTOOL . It don=C2=B4t show all services of the=
=20
> devices...
>=20
> Some can say any about this....??
>=20
> the sdp_service_search_attr_req function works the same...  =C2=BF?
>=20
> What=C2=B4s happend with BlueZ and the SDP ?

if the remote device doesn't support the public browse group you won't
see anything. That isn't a problem of BlueZ. However you can work around
it with specifying --l2cap as additional option.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
