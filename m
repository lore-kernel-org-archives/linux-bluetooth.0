Return-Path: <mreimer@vpop.net>
Message-ID: <4032E137.7080902@vpop.net>
Date: Tue, 17 Feb 2004 21:51:19 -0600
From: Matthew Reimer <mreimer@vpop.net>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.1077037423.2665.72.camel@pegasus.SOMEWHERE>	 <lists.bluez.users.403291AD.7080601@csr.com>  <40329F44.5070603@vpop.net> <1077061006.2665.141.camel@pegasus>
In-Reply-To: <1077061006.2665.141.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body>
Marcel Holtmann wrote:
<blockquote cite="mid1077061006.2665.141.camel@pegasus" type="cite">
  <pre wrap="">Hi Matt,

  </pre>
  <blockquote type="cite">
    <pre wrap="">Can I change the L2CAP MTU? Is that different than the ACL MTU that can 
be set via hciconfig? Can I get "an HCI trace" with hcidump, or is that 
what a protocol analyzer would be needed for?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
you can change L2CAP MTU, but in case of RFCOMM or BNEP the correct one
will be choosen for you.

Run "hcidump -w &lt;file&gt;" (as root).
  </pre>
</blockquote>
Ok, it's at <a class="moz-txt-link-freetext" href="http://sermons.desiringGod.org/~mreimer/h2215.dump">http://sermons.desiringGod.org/~mreimer/h2215.dump</a>. It's
large (11M), but I thought that it would be better to give you more
info than less. This is what I did:<br>
<br>
1. linux: start hcidump<br>
2. ipaq: start a NAP session from PocketPC2003 to the linux box<br>
3. ipaq: start PocketIE and began downloading a movie trailer<br>
4. ipaq: stopped the download after a minute or so<br>
5. ipaq: disconnected the NAP connection, then turned off bluetooth<br>
6. linux: stopped the dump<br>
<br>
My Actiontec dongle is 00:20:E0:3A:2E:57 and the ipaq is
00:04:3E:81:90:E0.<br>
<br>
Let me know if there might be sensitive information in this dump so I
can respond appropriately. I hope this info helps.<br>
<br>
Matt<br>
</body>
</html>
