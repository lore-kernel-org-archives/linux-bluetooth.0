Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438F2311.9050103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] avrcp and dbus
References: <438DD431.1090607@xmission.com> <1133371554.18079.37.camel@blade>
In-Reply-To: <1133371554.18079.37.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 01 Dec 2005 09:21:37 -0700

Marcel

>>I have my test app ("avrecv") accepting connections and ack'ing
>>passthrough commands.
> 
> sounds promising. Keep up with it.

Ok, well I found almost everything I need. The only thing I'm not
finding is the format for a volume up/down sent back to the headset.
Have you seen with your sniffer what those frames look like?

I'm assuming it's also sent as a passthrough to the panel device but I'm
guessing/experimenting to find the value of the volume up/down operands :(

Passthrough may not be right for volume changes... the headset neither
acks nor naks those commands sent to its panel.

> I think it is far to earlier to think about D-Bus integration.

Fine. Once we have real a2dp alsa integration then it'll be more clear
how avrcp fits in.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
