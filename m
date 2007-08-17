Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
	<46C1A52F.7050102@free.fr> <1187109044.6698.276.camel@violet>
	<46C57BA5.5000400@free.fr> <1187348439.6698.369.camel@violet>
	<46C58673.70201@free.fr>
	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
	<1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
Message-Id: <E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Fri, 17 Aug 2007 16:18:04 +0300
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

On Aug 17, 2007, at 15:44, Frederic Dalleau wrote:
> I had the feeling that start suspend and stop were some basic audio
> player controls...

That's what AVRCP is for. Start and Suspend in AVDTP are only used to  
change between OPEN and STREAMING states. The "simultaneous use of  
HFP, A2DP and AVRCP profiles" white-paper (available on  
bluetooth.org) also has this as a recommendation in section 3:
"The A2DP profile should be seen as a way to setup and configure the  
actual transport of a
streaming audio link, the A2DP profile should not be used to control  
the applications streaming
data. To control the applications the AVRCP profile should be used."

> Maybe the start command could be used to launch the
> audio player and start playback. Then rejecting should only occur if
> launching failed.

Won't happen. It's just not how the architecture is. User  
applications initiate access to the system wide audio service, not  
the other way around.

> And acceptor role is mandatory.

Yes, and we of course support it.

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
