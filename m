Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073394683.8730.225.camel@saag>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
	 <1073392659.2508.43.camel@pegasus>  <1073394683.8730.225.camel@saag>
Content-Type: text/plain
Message-Id: <1073395217.2508.62.camel@pegasus>
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
Date: Tue, 06 Jan 2004 14:20:17 +0100

Hi Edd,

> > this only happens when rfcomm_connect_ind() returns false and this means
> > that we can't create the new socket. In most cases this is because there
> > is no listen socket for it. Do /proc/bluetooth/rfcomm show the listen
> > socket on that channel? Do you use the same channel number in your SDP
> > record as for dund?
> 
> sdptool browse ff:ff:ff ....
> 
> Service Name: Serial Port
> Service RecHandle: 0x804ee30
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 3
> Profile Descriptor List:
>   "Serial Port" (0x1101)
>     Version: 0x0100
> 
> 
> strace dund --listen --persist --channel 3 --nodetach

maybe the P800 is buggy. Run a second dund on channel 1 to see if it
connects.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
