Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <a3b1b800605021215y4bd5377bs2d9d5163975e7a98@mail.gmail.com>
From: "Jan Benes" <jbenes@gmail.com>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] debugging apps using bluez under C
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
Date: Tue, 2 May 2006 21:15:47 +0200

hello,
I've been trying to make this application I'm working on run for over
a month now. it doesn't do anything extraordinary, just scans for
devices and if appropriate devices are found, sends a file via OBEX.
The thing is I'm getting all kinds of different problems all the time
that are very hard to decypher. So I ask (for BlueZ), is there any
tool that can help me with figuring out if there's anything wrong with
the stakc? If I did something wrong? Or how am I supposed to know?

for example: It happend to me twice that my app. failed with a SDP
request and since then, all the requests failed as well (for some
time). How do I know what I did wrong?
another example: I inquire for devices (my previous posts) but it
takes longer than I specify in the parameter. I can't afford to wait
for 3 minutes till the inquiry is over, cause all the devices I've
found could be out of reach by then. Again, how am I to know what went
wrong? Also, I've noted that sometimes, the hci_inquiry function
returns immediately (some result caching i suppose, and yes, I tell
the func. to flush the cash).
last example: "I got a Software caused connection abort" error from
OBEX (which runs on top of the RFCOMM protocol afaik). What, how, no
documentation, google doesn't know either. What went wrong?

I study the sources, I study the other sources, I search all the
mailing lists I've found for the answer, but most of the time to no
avail.

1) how can I tell what went wrong, is there a diagnostic function in the st=
ack?
2) I don't mean to be impolite, but you should consider putting
together some documentation. I know you probably don't get paid for
this, you do it in your free time (I'm talking about the authors), but
that would really be a good idea. Just 10 lines of comments for each
function, is that too much to ask? Not that I couldn't imaigine what
function hci_inquiry does, but figuring out all the pitfalls (as many
already have I believe) is very tedious. I can offer my help (that's
not much considering my knowledge) with documentation if you want.

thanks, Jan


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
