Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F7BFFE.20808@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco/headset problems
References: <20050125015049.GA1520@viz.cacr.caltech.edu>
In-Reply-To: <20050125015049.GA1520@viz.cacr.caltech.edu>
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
Date: Wed, 26 Jan 2005 09:06:22 -0700

John,

I wanted to let you know that I've looked at this message and tried to 
imagine what is wrong and I don't have a lot of ideas.

It might be that the pairing is trying to get established and require a 
pin number. A few days ago someone reported that they had to change the 
pin script to hardcode "0000" in order for it to work. Check the recent 
archives.

Brad

John McCorquodale wrote:
> Hi, y'all,
> 
> I just pulled the current btsco CVS, compiled against vanilla 2.6.10-rc3,
> trying to talk to a HBH-35.  I run btsco <addr> and it gets thru the
> "AT+" lines, but never says "opened hwdep" no matter what I do (yes, I
> push the button on the headset).  I can set the volume just fine with
> alsamixer.  aplay does nothing (hangs forever) and arecord prints the
> header and then hangs forever, which are consistent with btsco never
> having opened the SCO.
> 
> stracing btsco shows that no data ever comes in on the BT file descriptor;
> the poll just sits in its little one-second loop never rx'ing anything from
> anybody, even when I bang on the headset button like an undersexed chihuahua
> on speed.
> 
> Tried two HCIs, the socket CF G card (which, yes, works in 2.6 with suitable
> patch for the serial driver) and the tiny little dlink USB dongle.  Exact
> same behavior both cases.
> 
> I hope this is obvious to somebody?
> 
> -mcq
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
