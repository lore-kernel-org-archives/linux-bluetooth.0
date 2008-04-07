Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (lists)" <aklists@mixdown.ca>
To: bluez-users@lists.sourceforge.net
Date: Mon, 7 Apr 2008 09:56:23 -0400
References: <Pine.LNX.4.64.0804071115190.866@arimo.local>
In-Reply-To: <Pine.LNX.4.64.0804071115190.866@arimo.local>
MIME-Version: 1.0
Message-Id: <200804070956.23449.aklists@mixdown.ca>
Subject: Re: [Bluez-users] Emulating a gps receiver
Reply-To: akohlsmith-lists@mixdown.ca,
	BlueZ users <bluez-users@lists.sourceforge.net>
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

On April 7, 2008 04:34:54 am arimo@iki.fi wrote:
>   I could connect an ordinary  receiver to Linux  box and read it's
> output but as a   Bluetooth newbie i do not have any clue how to  make a
> computer looks like a receiver.

You're looking for the local device class definition 
in /etc/bluetooth/hcid.conf.  It's a bitfield.  Googleing for hcid.conf gives 
me one of my favourite documentation sites, die.net: 

http://linux.die.net/man/5/hcid.conf

About halfway down you can see what the device class is composed of and what 
each bit means.

>   I can search the bt devices with the phone and computer is listed there
> but apparently i had to run some daemon to link the bluetooth and rfcomm
> devices together. According my experiences so far this application is not
> rfcomm:-(

I imagine you want to use rfcomm; it has a 'listen' command that would allow 
you to attach your own utility (which spits NMEA sentences out to stdout) to 
an rfcomm channel.

You may also have to configure an SDP record to "advertise" the rfcomm port to 
the phone you're testing with.  "sdptool add" would probably be what you want 
here.

I'm not an expert either, but us newbies have to stick together and pull 
ourselves out of this muck.  :-)

-A.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
