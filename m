Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rob Raper" <djrobx@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] What's the best way to go about device detection?
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F18SByh133tYw0004e544@hotmail.com>
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
Date: Sun, 16 May 2004 22:35:44 -0700

Without involving any of my source code at alll, I can demonstrate one of my 
biggest problems.     I'll first create a connection to an existing 
bluetooth device.  It works fine.  I can get an RSSI value or link value.  
Then, I'lll try a non-existent device.   I get a connection timed out error 
fairly quickly.  Great, that's exactly what I want and what I expect.  What 
follows, however, is what is really causing me problems.  I can no longer 
connect to the valid bt device.   I just get errors for a long time.  I 
can't disconnect either.   How can I clear out the failed connection and 
move on without everything breaking down like this?

pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:15
pluto62:~/bluez-utils-2.4/tools# hcitool rssi 00:60:57:23:35:15
RSSI return value: -1
pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:15

So far so good...Now try an invalid address

pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:14
Can't create connection: Connection timed out

As expected.

pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:14
Disconnect failed: Input/output error

Why an input/output error?  It's on the con list, how do I get it off?

pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:15
Can't create connection: Input/output error

Uh oh.. why can't I connect to the bt adapter that worked before?




>From: Marcel Holtmann <marcel@holtmann.org>
>To: Rob Raper <djrobx@hotmail.com>
>CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] What's the best way to go about device 
>detection?
>Date: Sun, 16 May 2004 22:20:24 +0200
>
>Hi Rob,
>
> > Thanks for your reply.   I'll have a look into RSSI.   Is it
> > possible to use RSSI for detection, but then use RFCOMM to do the actual
> > communications?    Once "linked" to a server they don't ever need to 
>talk to
> > multiple servers at the same time.  It's just that other servers need to
> > determine signal strength in order to decide when to perform a hand off.
>
>this is what I said. The RSSI comes for free with an inquiry with RSSI
>command from the Bluetooth 1.2 specification. And while a connection is
>active you can retrieve it without any extra cost. Look at the hcitool
>info command and see how it finds the needed ACL handle of an existing
>connection.
>
>And btw check your devices that they really support inquiry while they
>maintain an open ACL connection.
>
> > Here's the block of code that I'm currently using to do a scan.  The old
> > version which worked better was simply a verison of the "hcitool scan"
> > routine modified to connect and check singal strength.
>
>Sorry, but I won't read that code. It is too much nested and actually
>code that needs more than 80 chars in a row is way too complex.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: SourceForge.net Broadband
>Sign-up now for SourceForge Broadband and get the fastest
>6.0/768 connection for only $19.95/mo for the first 3 months!
>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! http://join.msn.click-url.com/go/onm00200439ave/direct/01/



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
