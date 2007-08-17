Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <46C58673.70201@free.fr>
References: <46C088D7.9000108@silicom.fr>	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>	<46C1A52F.7050102@free.fr>
	<1187109044.6698.276.camel@violet>	<46C57BA5.5000400@free.fr>
	<1187348439.6698.369.camel@violet> <46C58673.70201@free.fr>
Message-Id: <5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Fri, 17 Aug 2007 14:42:53 +0300
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

Hi Fabien,

On Aug 17, 2007, at 14:28, Fabien Chevalier wrote:
> The issue seems to be that my headset doesn't seem to like very  
> much the
> rejection of the start cmd that the daemon sends to him.
> After a while when xmms starts the daemon sends a start cmd, to which
> the headset answers with a start rsp, which should indicate that
> everything is ok... however i hear no sound in the headset  
> whatsoever :-(

To me this sounds like a bug in your headset. However we should of  
course strive to be interoperable with as many as possible  
implementations.

The reason why the audio service rejects the start command is that  
STREAMING state should only be entered by request of alsa, since if  
we have no app to provide audio it's unnecessary to have the headset  
think it will receive some audio when in fact it wont.

Do you have any ideas how to solve this? I was thinking that we could  
accept the start command but immediately afterwards send a suspend  
command. OTOH this feels a little "hackish". The headsets that I have  
which are capable of acting in initiator role will simply disconnect  
when their start command is rejected, so I have not been very happy  
with the current behavior either.

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
