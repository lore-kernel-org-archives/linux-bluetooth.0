Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F32C16.8000000@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco blocking audio mode
References: <pan.2005.01.22.15.45.57.119048@yahoo.com>
In-Reply-To: <pan.2005.01.22.15.45.57.119048@yahoo.com>
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
Date: Sat, 22 Jan 2005 21:46:14 -0700

Paul,

Do you know what the OSS and ALSA api has to say about nonblocking 
open/write? I'm a little clueless here about whether or not we are 
producing the behavior the client is asking for.

I do see what you mean. Another example for which you'd want nonblocking 
writes is live streaming.

Brad

Paul Ionescu wrote:
> Hi,
> 
> Currently when snd-bt-sco is loaded but btsco is not connected, any
> attempt to play something will be blocked until a btsco connection is made.
> Sometimes, a "play anyway" mode would be preferred.
> Example:
> If I watch a movie with mplayer with output to my headset, and I
> disconnect the headset, the movie will stop playing, because snd-bt-sco is
> not sending positive response.
> Can snd-bt-sco be made to send positive response even if there is no
> headset connected ?
> This should be user selectable.
> 
> Thanks,
> Paul
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


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
