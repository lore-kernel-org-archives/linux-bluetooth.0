Return-Path: <survivor@uni-paderborn.de>
Message-ID: <40718881.4050709@uni-paderborn.de>
Date: Mon, 05 Apr 2004 18:25:37 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP and SDP interface specification?
References: <407174BC.8020503@uni-paderborn.de> <1081179607.2843.9.camel@pegasus>
In-Reply-To: <1081179607.2843.9.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Hi Marcel,<br>
<br>
in your "btk2003_slides.pdf" (very nice) you say on page 13 "C/C++ API
f&uuml;r Kommandos und Events". Where is it? I can send commands easily via
the bluez-libs' "hci_send_cmd", but how do I get the result/event? Ok,
I could use "hci_send_req", but that function blocks until timeout.
Isn't there a simple way to use "hci_send_cmd" and register some kind
of callback for the result/event? Isn't bluetooth devices
interrupt-driven? If not, isn't there some kind of global polling and
event dispatching instance? I thought it was the hcid.<br>
<br>
By "Glib" you mean "glib-ectomy.c" of hcid? In it's main loop it does
"rc = poll(ufds, nfds, -1);". Does it wait/block forever for an event
or what does "-1" mean? Btw, what's hcid for (except for initializing
the device and giving it a name)? <br>
<br>
I'm coming from the Windows realm and therefore, I'm not so familiar
with Linux programming. Sorry for the stupid questions. ;-)<br>
<br>
Thanks,<br>
Stefan<br>
<br>
<br>
Marcel Holtmann schrieb:<br>
<blockquote type="cite" cite="mid1081179607.2843.9.camel@pegasus">
  <pre wrap="">Hi Stefan,

  </pre>
  <blockquote type="cite">
    <pre wrap="">where can I find the specification of the BlueZ L2CAP and SDP API? I 
hope there ist any.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
the L2CAP API is a socket interface and you will find the API in the
bluetooth/l2cap.h header file. For an usage example look at l2test.

The SDP API can be found in bluetooth/sdp.h and bluetooth/sdp_lib.h and
for example code look at the dund and pand applications.

  </pre>
  <blockquote type="cite">
    <pre wrap="">And how can I register my application for getting HCI events, so that I 
don't have to poll? hcid? API/specs?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The HCI API is also a socket interface. If you want to have some kind of
event based approach you have to use and IO event main loop like it is
used in the Glib.

Regards

Marcel



  </pre>
</blockquote>
</body>
</html>
