Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F7D274.4030208@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] partly OT: pipe sound from Headset to soundcard
References: <41F7CEF6.1050508@webstuhl.net>
In-Reply-To: <41F7CEF6.1050508@webstuhl.net>
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
Date: Wed, 26 Jan 2005 10:25:08 -0700

Ben

I had the same thought.

We have a way to send line in to a stereo headset but there is a delay. 
(see bluetooth-alsa.sf.net)

You could write something similar that runs in userspace and copies 
audio streams around using sco.

Brad

Ben Pezzei wrote:
> Hi again,
> 
> Apologies if my question is a bit OT, but no one on the alsa
> list had an answer for this one:
> 
> I try to pipe the sound from the headset to line in of the
> soundcard. something like:
> /dev/snd/pcmC1D0c -> /dev/snd/pcmC0D0p
> and vice versa:
> /dev/snd/pcmC0D0c -> /dev/snd/pcmC1D0p
> 
> So everything which comes through the soundcard mic should
> be "forwarded" to the headset earphone, and everything
> which comes from the headset mic should land at the
> soundcards line in.
> 
> is there a way to accomplish this?
> 
> any hint would be great
> 
> greetings
> ben
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


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
