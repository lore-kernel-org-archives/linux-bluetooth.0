Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41496D78.3080807@uni-paderborn.de>
Date: Thu, 16 Sep 2004 12:39:52 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   =?ISO-8859-1?Q?Bernd_E=DFmann?= <psycho@uni-paderborn.de>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de>	 <1095282542.19426.9.camel@pegasus>  <41496B2C.1030103@uni-paderborn.de> <1095330875.19426.28.camel@pegasus>
In-Reply-To: <1095330875.19426.28.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Marcel Holtmann schrieb:<br>
<blockquote cite="mid1095330875.19426.28.camel@pegasus" type="cite">
  <pre wrap="">Hi Stefan,

  </pre>
  <blockquote type="cite">
    <pre wrap="">Your suggestions have no effect for me. Still errno 16. I think at the 
moment it is not possible to connect concurrently via l2cap if one 
device is down. But as a workaround I can use non-blocking connect (but 
with a timeout of 60 seconds just to prevent deadlocks) and simply 
reduce the pageto. My connection attempts are sequential anyway because 
of the master-slave-limit. But I would suggest to change the behavior of 
l2cap to allow more concurrent connection attempts even if some devices 
are down.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
use hcidump and check the result code of the failing HCI connection
complete event. Look them up in the Bluetooth specification. This may
lights this behaviour a little bit more up.

  </pre>
</blockquote>
I guess you mean one paging process at one time per device? :)<br>
<br>
Regards<br>
Stefan<br>
<br>
</body>
</html>
