Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.22.15.35.18.929419@yahoo.com>
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net> <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Again: Problems with Dongle, Headset or btsco
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
Date: Sat, 22 Jan 2005 17:35:19 +0200

Hi,

On Sat, 22 Jan 2005 14:59:39 +0100, Ben Pezzei wrote:

> Since the hwdep module is part of the alsa-libs it looks like the dongle
> can't be re-initialized (as a soundcard) after a disconnect.

How do you know the dongle can't be re-initialized ?
What does it say when you launch again btsco ?

> Last Question: Which are other methods to send/receive data from/to the
> headset beside aplay / arecord?
> 
> eg cat /dev/snd/pcmC1D0c > z1.out ? :)

I was able to use gnomemeeting, mplayer and other programs that use alsa
or oss.
For mplayer I used -ao alsa:device=hw=Headset -srate 8000 -channels 1





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
