Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth socket + rfcomm tty
Message-ID: <Pine.LNX.4.44.0501291742500.13497-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 29 Jan 2005 18:03:14 +0100 (MET)

Hi Marcel,

I use TTY because I want to provide AT command communication and PPP over 
the same channel, in my case I send a number of AT commands, then start 
pppd over the channel (converted to TTY) and then, after it is finished, I 
want to send AT commands again. I want to do this all without reopening 
bluetooth connection with the phone, which is being closed when pppd 
finishes on TTY. I also can open a TTY from my application, so pppd can 
not close the connection on exit (cause there are still open descriptors) 
- but 
sending commands through an open TTY works strange to me... 

The phone is SonyEr T630, and so far is the most stable phone regarding communication using Bluez stack (Nokias, Siemens - hang or crash 
now and then).

Regards,
    Victor.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, January 26, 2005 18:34
Subject: RE: [Bluez-devel] bluetooth socket + rfcomm tty


> Hi Victor,
> 
>> Now I close the socket after converting to TTY. After this I open
>> "/dev/rfcomm0" with O_RDWR | O_NOCTTY and write ATD12345\n\r command to
>> it, then read the response (receive echo), and sleep, meanwhile phone
>> starts to dial the number, but then stops for no reason. If I do the
>> same with original (non-converted) socket (skipping converting to TTY),
>> everything is OK.
> 
> if the socket way works, why don't you use it?
> 
>> I've taken a look at hcidump output and it looks rather strange if I
>> compare it for both cases. In the case of file handle to converted TTY
>> all the data looks fragmented between ACL packets (like ATD1234 is not
>> sent in one packet, like in the case of non-converted socket, but piece
>> by piece in a number of packets) + there is a lot of activity from the
>> phone during the sleep phase when I do not do anything with the file
>> handle.
> 
> What kind of phone is this?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
