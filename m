Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How add correctly add SP service record to SDP
	daemon
From: Marcel Holtmann <marcel@holtmann.org>
To: taylor <taylor@ms.usi.com.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <019d01c47543$d6aa4c40$df0618ac@USI08844>
References: <019d01c47543$d6aa4c40$df0618ac@USI08844>
Content-Type: text/plain
Message-Id: <1091090204.12651.21.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 29 Jul 2004 10:36:45 +0200

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




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
