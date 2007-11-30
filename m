Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: christopher reder <creder@digitalcpt.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <02eb01c83391$bea8d7f0$2600a8c0@engineering5>
References: <02eb01c83391$bea8d7f0$2600a8c0@engineering5>
Date: Fri, 30 Nov 2007 16:11:10 -0600
Message-Id: <1196460670.27518.120.camel@linuxserver.digital>
Mime-Version: 1.0
Subject: Re: [Bluez-users] headset not connecting, pin issue?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Fri, 2007-11-30 at 14:44 -0600, Christopher Reder wrote:
> Hello all.  I have searched around and seen people with similar issues but
> have not found a solution yet.  
> 
> I am trying to connect a headset to a linux box with a usb Bluetooth dongle.
> I would like to listen to music through the headset.  
> 
> When I run mplayer -ao alsa:device=Bluetooth song.mp3, I get:
> 


Sorry for the previous post as I am further along than I thought.  This
may be the wrong list but I'll continue what I found in the hopes that
someone can tell me where I have gone wrong and what I need to do. 

I think the issue is that the audio service has not started.  I did a
hciconfig -a and I don't see that in the services.  I do see
audio.service in the /etc/bluetooth directory.  

I don't have python installed as this is an embedded system, but I would
like to have the audio service running (which may be what needs to
connect alsa to bluetooth).  

Currently, I am able to connect to the headset via rfcomm and it does
the pin and connection correctly.

Any help in this regard would be appreciated.

Christopher


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
