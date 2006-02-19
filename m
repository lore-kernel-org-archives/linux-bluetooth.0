Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Vikulov Yuriy <vikulov@rscenter.ru>
Message-ID: <loom.20060219T184353-877@post.gmane.org>
References: <loom.20060219T145816-98@post.gmane.org> <1140365073.26560.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Multiply connections to different phones =?utf-8?b?dmlhCWRpZmZlcmVudA==?= dongles at same time
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
Date: Sun, 19 Feb 2006 17:54:30 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Vikulov,
> 
> > I can't create more than one connection to different phones. 
> > It means that I create rfcomm connection to one phone and no more to 
others. 
> > I'm using forks. I can find all devices, all phones and needed rfcomm 
channel 
> > May be someone can help me and give me a piece of source code for solving 
my 
> > problem? or give me some advices? 
> 
> looks like your Bluetooth hardware might be too old and doesn't support
> multiple connections. Check with "hciconfig hci0 version revision".
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> 
Thanks, Marcel


I think I have decided my problem.
In one fork I tried to send data (my own obex implementation) and in another I 
tried to get RFCOMM channel. At this moment the second fork did nothing( no 
result).

I solved my problem this way:

At the begging of any transmitting data I got needed RFCOMM channels of all 
phones I had found and saved them to array.

May be I wrong, but after this I can make different connections via different 
dongles(one dongle to one phone,another dongle to another phone and so on)

Thanks for answer

P.S.

Sorry for my English




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
