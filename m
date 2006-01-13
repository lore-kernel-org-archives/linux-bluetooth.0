Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C80EBC.8040503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP in BlueZ
References: <43C66070.5010601@labri.fr>
In-Reply-To: <43C66070.5010601@labri.fr>
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
Date: Fri, 13 Jan 2006 13:34:04 -0700

Martin

> According to the mailing archive (since september 2005) and the Todo
> List there is no implementation of avdtp in BlueZ.
> Is this right ?

it is true in that you can't create an avdtp "socket" like you can an
l2cap socket. but we can still build up avdtp signaling in userspace
using l2cap connections.

> I am planning to implement audio streaming (ogg) over bluetooth. If I
> understand correctly (reading the mailing archive) there were attemps
> to consider the bluetooth device as a soundcard using alsa. Is this
> working ? Would this fit my purpose ? Would it replace avdtp in BlueZ ?

we only have a prototype that runs in userspace and accepts audio data
from stdin if you want to stream stuff.

i've been tinkering with an alsa plugin.

> My idea was to implement an icecast plugin/patch to send the data over
> bluetooth and then implement a reader on the phone/pda/some device.
> Do you think it is doable ? Is someone already working on this ?
> 
> Do you any idea about that ?

you are going to implement an a2dp sink in the phone? it is probably
doable and we do have code for it but it will take some adapting to put
it on another platform and it will require a decent-powered arm cpu.
(many phones have a dsp where the encoder could run a lot more
efficiently, but it's a big job to write a dsp task.)

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
