Return-Path: <survivor@uni-paderborn.de>
Message-ID: <414780B0.2070908@uni-paderborn.de>
Date: Wed, 15 Sep 2004 01:37:20 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de> <1095196325.5263.3.camel@pegasus>
In-Reply-To: <1095196325.5263.3.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Marcel!<br>
<br>
Marcel Holtmann schrieb:<br>
<blockquote cite="mid1095196325.5263.3.camel@pegasus" type="cite"><br>
  <pre wrap="">no, you only create a scatternet. This means when one device must be
member of two different piconets.

  </pre>
</blockquote>
Ah, I see. You mean just the topology.<br>
<blockquote cite="mid1095196325.5263.3.camel@pegasus" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Is there a way to upgrade it? Are there better dongles the University
could buy?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You can upgrade the D-Link DBT-120 Rev. B3 with the Apple firmware
update package to HCI 18.1.

  </pre>
</blockquote>
Would that solve the problem? Actually, is it a known problem?<br>
<blockquote cite="mid1095196325.5263.3.camel@pegasus" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Try to introduce some delays
between the connections and see if that helps.
  
      </pre>
    </blockquote>
    <pre wrap="">I'm experimenting with delays and timeouts for three days now. It
helps... a bit, but not really good. I just tried to switch
master-slave, but it doesn't really help. 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think you should avoid the role-switching and keep the listening
applications as slaves. In this case the client creates the piconet and
can keep both servers in the same piconet.

  </pre>
</blockquote>
I'm just testing it with a really simple program. The client (master,
no role-switching) connects sequentially to 2 servers (slave) with a
really huge delay of 3 seconds. As soon as one server becomes
unavailable, it is impossible to connect to the other. This is
obviously due to the connection attempts to the unavailable device.
Tomorrow I'll try to implement some kind of exponential backoff. Btw, I
read something about getting RSSI via Inquiry. Is it possible with
BlueZ? This could be used to faster decrease the backoff if the
unavailable device is found by inquiry and probably with a good RSSI
near 0.<br>
<blockquote cite="mid1095196325.5263.3.camel@pegasus" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">One year ago, I wrote another Location Awareness App on top of a
modified JBlueZ and it just used ACL links to measure RSSI and LQ. It
worked. I probably have to take care of the ACLs myself (does L2CAP
use existing ACLs?). The only drawback: The App has to run as root :(.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The L2CAP creates the same ACL links, so this can't be the problem.

  </pre>
</blockquote>
Yes, but I could disconnect faster on timeout and make L2CAP throw a
clean error instead of behaving strange. <br>
<br>
Connections:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:02:72:B1:1D:6C handle 45 state 1 lm MASTER<br>
<br>
stargazer:~ # hcitool dc 00:02:72:B1:1D:62<br>
Disconnect failed: Input/output error<br>
<br>
The connection to 62 persists even 5 minutes after I pulled the 62
Dongle out. A manual disconnect failed. This simply can't be! I
sometimes even have to reboot because BlueZ or something is confused. I
think there is a serious problem. I'll do further testing tomorrow.<br>
<br>
Anyway, thaks again!<br>
<br>
Regards<br>
Stefan<br>
<br>
</body>
</html>
