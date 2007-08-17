Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
	<46C1A52F.7050102@free.fr> <1187109044.6698.276.camel@violet>
	<46C57BA5.5000400@free.fr> <1187348439.6698.369.camel@violet>
	<46C58673.70201@free.fr>
	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
Date: Fri, 17 Aug 2007 14:44:14 +0200
Message-Id: <1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
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

> The reason why the audio service rejects the start command is that  
> STREAMING state should only be entered by request of alsa, since if  
> we have no app to provide audio it's unnecessary to have the headset  
> think it will receive some audio when in fact it wont.
> 
> Do you have any ideas how to solve this? I was thinking that we could  
> accept the start command but immediately afterwards send a suspend  
> command. OTOH this feels a little "hackish". The headsets that I have  
> which are capable of acting in initiator role will simply disconnect  
> when their start command is rejected, so I have not been very happy  
> with the current behavior either.

I had the feeling that start suspend and stop were some basic audio
player controls... Maybe the start command could be used to launch the
audio player and start playback. Then rejecting should only occur if
launching failed.

And acceptor role is mandatory.

Frederic

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
