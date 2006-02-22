Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <1140603337.4519.1.camel@localhost>
References: <DE083D10-98AA-41A8-8A08-DC4CEEC3B6BF@epfl.ch> <1140603337.4519.1.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7D1C654B-B5BF-42B7-B2F3-9D49373B3D1E@epfl.ch>
From: Thomas Lochmatter <thomas.lochmatter@epfl.ch>
Subject: Re: [Bluez-users] /dev/rfcomm256 ...?
To: bluez-users@lists.sourceforge.net
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 22 Feb 2006 12:04:36 +0100

>> rfcomm devices with a number > 255 (e.g. /dev/rfcomm256) in "/etc/
>> bluetooth/rfcomm.conf" seem to be ignored by rfcommd. Is this a hard
>> limit, or does anyone know a simple way to increase this? We
>> currently have about 400 devices that should go into that file.
>
> yes, that is a hard limit. We only have 256 minor device numbers
> available and that is actually quite a lot. Describe your use case,
> because creating more than 256 TTY seems not like one of the best ways
> to go.

Thanks. We have 400 robots, numbered from 1 to 400 (with a couple of  
gaps) and equipped with a bluetooth chip (serial port profile). We  
don't need to communicate with more than 5 at the same time, but  
these 5 robots can be picked at random from the 400. Hence, we need  
to be able to establish a connection to all of them at any time.

Up to now, we only used the first 200 and put all them in /etc/ 
bluetooth/rfcomm.conf with "bind yes". This worked reasonably well  
(apart from the problems with concurrent access that I mentioned in  
another post). Is there a more elegant way?

Thomas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
