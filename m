Return-Path: <survivor@uni-paderborn.de>
Message-ID: <414974B5.30007@uni-paderborn.de>
Date: Thu, 16 Sep 2004 13:10:45 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   =?ISO-8859-1?Q?Bernd_E=DFmann?= <psycho@uni-paderborn.de>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de>	 <1095282542.19426.9.camel@pegasus>  <41496B2C.1030103@uni-paderborn.de>	 <1095330875.19426.28.camel@pegasus>  <41496D78.3080807@uni-paderborn.de> <1095332448.19426.50.camel@pegasus>
In-Reply-To: <1095332448.19426.50.camel@pegasus>
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
<blockquote cite="mid1095332448.19426.50.camel@pegasus" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">use hcidump and check the result code of the failing HCI connection
complete event. Look them up in the Bluetooth specification. This may
lights this behaviour a little bit more up.

      </pre>
    </blockquote>
    <pre wrap="">I guess you mean one paging process at one time per device? :)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
there is always an underlaying creation of an ACL link and this fails
for you. The Bluetooth error codes don't map 1:1 to Unix error codes, so
use hcidump to find out the Bluetooth error and look up what it means.

  </pre>
</blockquote>
It is 0x04 "Page Timeout". I think I understand why the ressource is
busy. There can only be one paging in progress. Hmmm, then it is
because of the physical limitations of Bluetooth and my workaround
isn't really one.<br>
<br>
Regards<br>
Stefan<br>
<br>
</body>
</html>
