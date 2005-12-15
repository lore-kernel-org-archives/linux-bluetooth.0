Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A189C3.6030700@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] avrcp volume control
References: <43A114D1.4000506@xmission.com> <1134636865.5198.44.camel@localhost>
In-Reply-To: <1134636865.5198.44.camel@localhost>
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
Date: Thu, 15 Dec 2005 08:20:35 -0700

Marcel

>>My best guess at volume control over avrcp is to send volume up/down
>>commands to the panel subunit on the headset. It doesn't seems to do
>>anything (no ack/nak or change in volume on bluetake iphono mini). I was
>>able to confirm the operand codes with a helpful 1394 developer by the way.
> 
> 
> do you have the HP/Logitech headphone at hand? I can try it if you tell
> me what to do. I also have a CSR based headphone for testing.

I do have an hp set that I will try this weekend.

I just committed changes so the (single-threaded) avrecv test app sends
a volume up op shortly after it acks any command coming from the
headset. So punching buttons on the headset should raise the volume :(

fyi, avrecv just has to be running when you send audio to the headset.
the headset turns around and opens the avrcp connection when the stream
starts.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
