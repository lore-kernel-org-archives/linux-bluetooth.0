Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Thomas Green <TGreen2@sorenson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: More keyboard issues
Date: Fri, 09 Feb 2018 15:15:00 +0100
Message-ID: <5443491.2srKmUx91u@ix>
In-Reply-To: <C2BC44D770753C45AAAC42695FB5BE020125730EF4@SLC-EXMB01.CORP.SRELAY.COM>
References: <C2BC44D770753C45AAAC42695FB5BE02012572F769@SLC-EXMB01.CORP.SRELAY.COM> <5252185.UFqE8F7bMa@ix> <C2BC44D770753C45AAAC42695FB5BE020125730EF4@SLC-EXMB01.CORP.SRELAY.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday, 7 February 2018 20:48:13 CET Thomas Green wrote:
> Hi Szymon,
> 
> Was this helpful to you?

This looks like issue on controller, not host (bluez) but since you worte it 
worked on 4.101 maybe we could circumvent it.

Would it be possible to get btmon traces from 4.101 and from good scenario on 
5.48?


> 
> Tom
> 
> -----Original Message-----
> From: Thomas Green
> Sent: Thursday, February 01, 2018 10:48 AM
> To: 'Szymon Janc' <szymon.janc@codecoup.pl>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: More keyboard issues
> 
> Szymon,
> 
> Thanks for the reply,
> 
> >Hi,
> >
> >On Saturday, 27 January 2018 01:20:21 CET Thomas Green wrote:
> >> Hi all,
> >> 
> >> I'm testing more keyboards with 5.48 and have found issues with two
> >> other keyboards.  In this case the problem is during pairing.  The two
> >> keyboards in question are the SIIG AAZ2448 and the ANKER A7221.   The
> >> current issue is that during pairing of these two keyboards we are given
> >> a PIN code display, so I enter it on the keyboard and nothing happens,
> >> and
> >> eventually the pairing times out.
> >> 
> >> [bluetooth]# pair 20:73:03:A4:18:4D
> >> Attempting to pair with 20:73:03:A4:18:4D [CHG] Device
> >> 20:73:03:A4:18:4D Connected: yes [agent] PIN code: 851841 [Anker
> >> A7721]# [  282.174342] WARNING: at net/bluetooth/hci_conn.c:322
> >> hci_conn_timeout+0x44/0x198() Failed to pair:
> >> org.bluez.Error.AuthenticationTimeout
> >> [Anker A7721]#
> >> 
> >> This happens about 95% of the time.  The other 5% the pairing
> >> completes and everything works fine.
> >> 
> >> I could attach btmon output and output from running bluetoothd -d -n,
> >> but nothing interesting happens from the time the pincode is
> >> displayed and the timeout occurs.
> >> 
> >> Where do I begin to look for why the pincode isn't being transmitted
> >> back from the keyboards?  Why is it inconsistent?
> >> 
> >> As an interesting side note the Apple keyboard that I'm having the
> >> driver loading trouble uses the same pairing mechanism and it works
> >> well every time. (and all of these keyboards worked fine in 4.101)
> >
> >Get full btmon logs first, ideally from the moment you power on BT adapter.
> >
> >--
> >pozdrawiam
> >Szymon Janc
> 
> The log file is attached to this email....
> 
> Tom


-- 
pozdrawiam
Szymon Janc


