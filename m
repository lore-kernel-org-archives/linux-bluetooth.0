Return-Path: <taylor@ms.usi.com.tw>
Message-ID: <01cb01c475ce$2e737d90$df0618ac@USI08844>
From: "taylor" <taylor@ms.usi.com.tw>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <019d01c47543$d6aa4c40$df0618ac@USI08844> <1091090204.12651.21.camel@pegasus>
Subject: Re: [Bluez-users] How add correctly add SP service record to SDPdaemon
Date: Fri, 30 Jul 2004 08:43:05 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
List-ID: <bluez-users.lists.sourceforge.net>

Dear Holtmann,
  Thanks your quick answer, it have worked now.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "taylor" <taylor@ms.usi.com.tw>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Sent: Thursday, July 29, 2004 4:36 PM
Subject: Re: [Bluez-users] How add correctly add SP service record to
SDPdaemon


Hi Taylor,

>  I could use those step to connect the Linux SP to Windows Series
> profile
>
> At the linux side:
> step 1:rfcomm connect 0 <BD address> 1
> setp 2:open minicom -s,
>           set the device as /dev/rfcomm0
>           set the baud rate as 19200 8N1, no flow control
>           exit
> At the windows site:
> step 1: open the hyerpterminal,
>            set up baud rate as 19200 8N1 , no flow control
> step 2: sucessfuly transfer the data
>
> But I hope ass the SP profile service record into SDP daemon, I do
> thoe step
> At the linux side
> step 1: rfcomm bind 0 <BD Addreess> 1
> step 2: sdp add SP 1
>
> At the windows site:
> step1: Obrowse the SP service
> step 2: reject SP connect, the port is not correct.

and your steps on the Linux side are wrong. Do you read the manpages?

sdptool add --channel 1 SP
rfcomm listen 0 1

Regards

Marcel
