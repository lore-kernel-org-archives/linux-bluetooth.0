Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: mirko_3 <mirko_3@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
Message-ID: <20050122151959.3384d572@mirko_3>
In-Reply-To: <41F25C4B.6040709@webstuhl.net>
References: <41F0EB0A.1020302@webstuhl.net>
	<41F0FE84.8030401@dark-reality.de>
	<41F128F4.2020006@webstuhl.net>
	<41F13638.1080207@dark-reality.de>
	<41F25C4B.6040709@webstuhl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Sat, 22 Jan 2005 15:19:59 +0100

On Sat, 22 Jan 2005 14:59:39 +0100
Ben Pezzei <ben@webstuhl.net> wrote:

> ok. Is it possible that the SCO Part of this dongle is somehow broken?
> Obviously the RFCOMM Part is working fine.
> 
> Since the hwdep module is part of the alsa-libs it looks like
> the dongle can't be re-initialized (as a soundcard) after a
> disconnect.
> 
> Question: when connected via btsco and trying to play
> some sound with:
> aplay -D plughw:Headset soundfile
> Does soundfile need to have the correct samplerate,frequency,etc
> as the Headset?
> I am also able to set speaker and capture volume of the Headset
> with alsamixer -c 1
> 
> unfortunately
> arecord -D plughw:Headset z1.out
> Recording WAVE 'z1.out' : Unsigned 8 bit, Rate 8000 Hz, Mono
> 
> only creates a 44 Byte big file z1.out with the header but
> no content
> 
> Last Question: Which are other methods to send/receive
> data from/to the headset beside aplay / arecord?
> 
> eg cat /dev/snd/pcmC1D0c > z1.out ? :)


Can't help you with the rest, but in xmms you can select the headset...


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
