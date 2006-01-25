Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <002401c6220a$1e4a4900$c800a8c0@kazama>
From: "Sir Graham (Terra)" <sir__graham@terra.es>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Subject: [Bluez-devel] Question about the SPDTOOL and the sdp_service_search_attr_req
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
Date: Thu, 26 Jan 2006 00:49:48 +0100


> Hi,
>
> we try the SDPTOOL and the sdp_service_search_attr_req function. Both w=
ork
> well, but We observate a peculiar detail.
>
> We work with other Bluetooh Stack (Windows, Symbian, etc...) In this St=
ack
> when we ask for all services, the SDP is one of them too.
> But... with bluez the SDP service don=B4t appeards in own list. We ask =
the=20
> SDP
> list of services to the same terminal (for example with Symbian and=20
> BlueZ),
> but in BlueZ show one less: DON=B4T show the SPD service in the list...
>
> It=B4s this normal? How can list the own SDP service in his own list...=
 ?
>
> Any idea..?
>
> Regards,
> Sir Graham.
> EndoraSoft.
>=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
