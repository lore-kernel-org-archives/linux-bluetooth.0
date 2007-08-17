Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
	<46C1A52F.7050102@free.fr> <1187109044.6698.276.camel@violet>
	<46C57BA5.5000400@free.fr> <1187348439.6698.369.camel@violet>
	<46C58673.70201@free.fr>
	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
	<1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
	<E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>
Message-Id: <7635988F-7113-477C-B33E-30E10DF56140@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Fri, 17 Aug 2007 16:43:50 +0300
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Aug 17, 2007, at 16:18, Johan Hedberg wrote:
>> Maybe the start command could be used to launch the
>> audio player and start playback. Then rejecting should only occur if
>> launching failed.
>
> Won't happen. It's just not how the architecture is. User
> applications initiate access to the system wide audio service, not
> the other way around.

Just a little clarification to this so you don't think we loose all  
usefulness of doing stuff automatically when a headset connects to  
us: The audio service sends (D-Bus) signals when devices connect and  
disconnect and the plan is to also integrate with HAL (a patch is  
already in the works) to provide a object which HAL aware  
applications (e.g. pulseaudio) could automatically use. This way the  
applications or a sound server can automatically recognize the  
connected headset and switch their audio routing accordingly.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
