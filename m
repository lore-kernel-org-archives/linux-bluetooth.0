Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41475033.3030209@uni-paderborn.de>
Date: Tue, 14 Sep 2004 22:10:27 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de> <1095191352.5695.205.camel@pegasus>
In-Reply-To: <1095191352.5695.205.camel@pegasus>
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
<blockquote cite="mid1095191352.5695.205.camel@pegasus" type="cite">
  <pre wrap="">Hi Stefan,

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Are you sure that both of your listining servers are set for switching
the role to master after connection? Remember that the connecting device
is master in the first place.

      </pre>
    </blockquote>
    <pre wrap="">Yes, I'm aware of that, but I don't know if this is a problem. It looks 
like this at the client:
    </pre>
  </blockquote>
  <pre wrap=""><!---->
your firmware is HCI 16.4 which is good, but you are going to create a
scatternet on your client and that can be the problem. Looks like this
is an internal problem of the CSR firmware. </pre>
</blockquote>
You mean the dongles try to create a scatternet (with packet routing
and so on) on their own? I always thought a scatternet has to be
implemented outside the hard-/firmware. Is there a way to upgrade it?
Are there better dongles the University could buy?<br>
<blockquote cite="mid1095191352.5695.205.camel@pegasus" type="cite">
  <pre wrap="">Try to introduce some delays
between the connections and see if that helps.
  </pre>
</blockquote>
I'm experimenting with delays and timeouts for three days now. It
helps... a bit, but not really good. I just tried to switch
master-slave, but it doesn't really help. <br>
One year ago, I wrote another Location Awareness App on top of a
modified JBlueZ and it just used ACL links to measure RSSI and LQ. It
worked. I probably have to take care of the ACLs myself (does L2CAP use
existing ACLs?). The only drawback: The App has to run as root :(.
Thanks for your help.<br>
<br>
Regards<br>
Stefan<br>
<br>
</body>
</html>
