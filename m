Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Permission flags (chmod) for /dev/rfcomm*
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <90057D7E-8908-42B9-8067-BF9809EAE90B@epfl.ch>
References: <90057D7E-8908-42B9-8067-BF9809EAE90B@epfl.ch>
Content-Type: text/plain
Message-Id: <1138033491.7327.1.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 23 Jan 2006 17:24:51 +0100

Hi Thomas,

> We have a bunch of small robots that we can access via bluetooth. For  
> each robot, we added an entry in the /etc/bluetooth/rfcomm.conf file.  
> These entries look as follows:
> 	rfcommXX {
> 		bind yes;
> 		device HARDWARE_ADDRESS;
> 		channel 1;
> 	}
> 
> When we start the bluetooth service, the following line is executed  
> (as root)
> 	rfcomm bind all
> which creates a /dev/rfcommXX for each robot. There are two issues  
> with these files:
> 
> 1) All devices are created with chmod 600 (crw-------). This is a  
> problem for us because we want several users to be able to access  
> them. Is there a way of configuring the chmod mask in the rfcomm.conf  
> file?
> (Note that launching a "chmod 666 /dev/rfcomm*" after "rfcomm bind  
> all" is not a good solution since the devices are created with some  
> delay.)
> 
> 2) These devices belong to the locally logged in user, not root. Why?  
> Is there a way to configure that (user and group ownership)?

both are udev related questions and in both cases the udev configuration
is the answer.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
