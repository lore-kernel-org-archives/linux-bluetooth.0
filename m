Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <403E7EFD.90500@netcabo.pt>
From: filipe abrantes <filipe_abrantes@netcabo.pt>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Failed to connect to SDP server on	00:10:60:A4:89:15:
 Function not implemented
References: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3E@VS1.hdi.tvcabo> <1077818189.2849.3.camel@pegasus>
In-Reply-To: <1077818189.2849.3.camel@pegasus>
Content-Type: text/html; charset=us-ascii
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
Date: Thu, 26 Feb 2004 23:19:25 +0000

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
  <title></title>
</head>
<body>
Marcel Holtmann wrote:
<blockquote cite="mid1077818189.2849.3.camel@pegasus" type="cite">
  <pre wrap="">Hi Filipe,

  </pre>
  <blockquote type="cite">
    <pre wrap="">[root@ee99217 bluez-sdp-1.5]# sdptool search GN
Inquiring ...
Failed to connect to SDP server on 00:10:60:A4:89:15: Function not implemented

if i try this i get :

[root@ee99217 bluez-sdp-1.5]# pand --connect 00:10:60:A4:89:15 --nosdp

Feb 26 17:16:34 ee99217 pand[8447]: PAN daemon ver 1.1
Feb 26 17:16:34 ee99217 pand[8447]: Connecting to 00:10:60:A4:89:15
Feb 26 17:16:37 ee99217 pand[8447]: Connect to 00:10:60:A4:89:15 failed. Function not implemented(38)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
show us the output of "hciconfig -a" on both sides.

Regards

Marcel



  </pre>
</blockquote>
i think it is solved now, it was some error in hcid.conf file, don't
know for sure what line it was cause i changed a few...<br>
<br>
sorry for wasting your time<br>
<br>
and thanks <br>
<br>
filipe<br>
</body>
</html>


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
