Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F95DFC.6060805@webstuhl.net>
From: Ben Pezzei <ben@webstuhl.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] partly OT: pipe sound from Headset to soundcard
References: <41F7CEF6.1050508@webstuhl.net> <41F7D274.4030208@xmission.com> <41F82DA9.8090806@webstuhl.net> <41F91420.8080300@xmission.com>
In-Reply-To: <41F91420.8080300@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 27 Jan 2005 22:32:44 +0100

Hi Brad,

Brad Midgley schrieb:

> Your program would be an alsa client, copying from one alsa device to 
> another. No btsco changes at all.

yup, I have written some "prove of concept" proggy which copies
the mic - stream from the soundcard to the headset-earphone.
Bad, bad style, but it works (ALSA-API only).

But: To finally manage the other way round (Headset mic to
soundcard playback) the code should work in some sort of
Duplex mode.

Since I still think, this whole thing can be accomplished via
asound.conf and/or jackd (or even some sort of pipe-system),
I'll ask around if someone has already done this kind of
setup.

greetings
ben

PS Is there a problem with mail delivery on this list?




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
