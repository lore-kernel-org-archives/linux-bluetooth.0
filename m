Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: BlueZ-Users <bluez-users@lists.sourceforge.net>
Message-ID: <1068150549.3faaaf153cd2c@student.up.ac.za>
From: Alan Huang <alanh@tuks.co.za>
References: <200311050945.34166.sybren@thirdtower.com>  <004101c3a3b4$81f42dd0$dc01a8c0@alan> <1068107961.1284.123.camel@pegasus>
In-Reply-To: <1068107961.1284.123.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=Big5
Subject: [Bluez-users] Re: [Bluez-devel] rfcomm patch
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 06 Nov 2003 22:29:09 +0200 (SAST)

Hi,
  Thanks again Marcel, for your reply! Can you tell me a bit more how to 
switch to raw terminal mode? Does it mean that I'll have to skip the bind 
action and directly connect after I created the socket?

Hmm... it really seems like I should enhance my socket programming 
knowledge...Any good online guides/tuts or books anyone can recommend ;-)

Thanks~

Alan

 Marcel Holtmann <marcel@holtmann.org>:

> Hi Alan,
> 
> >   Regarding this topic that rfcomm doesn't flush. I just want to ask
> that,
> > I'm using an USB Bluetooth dongle that's connected to another
> Bluetooth
> > device using the rfcomm program. This other Bluetooth device is
> connected to
> > a Windows PC's COM1 port (RS-232) and connected/displayed by
> > hyperterminal... For some unknown reason, what ever the hyperterminal
> sends
> > on the Windows side can be shown
> > "cat /dev/rfcomm0". But what ever the USB Bluetooth dongle sends
> (using
> > "echo hello > /dev/rfcomm0") it can't be shown on the Windows
> > hyperterminal...
> 
> try to use the --raw switch to set the terminal into RAW mode after
> connect (this works not for "bind").
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
