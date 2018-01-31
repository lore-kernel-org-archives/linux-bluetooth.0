Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Thomas Green <TGreen2@sorenson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: More keyboard issues
Date: Wed, 31 Jan 2018 10:29:16 +0100
Message-ID: <5252185.UFqE8F7bMa@ix>
In-Reply-To: <C2BC44D770753C45AAAC42695FB5BE02012572F769@SLC-EXMB01.CORP.SRELAY.COM>
References: <C2BC44D770753C45AAAC42695FB5BE02012572F769@SLC-EXMB01.CORP.SRELAY.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Saturday, 27 January 2018 01:20:21 CET Thomas Green wrote:
> Hi all,
> 
> I'm testing more keyboards with 5.48 and have found issues with two other
> keyboards.  In this case the problem is during pairing.  The two keyboards
> in question are the SIIG AAZ2448 and the ANKER A7221.   The current issue
> is that during pairing of these two keyboards we are given a PIN code
> display, so I enter it on the keyboard and nothing happens, and eventually
> the pairing times out.
> 
> [bluetooth]# pair 20:73:03:A4:18:4D
> Attempting to pair with 20:73:03:A4:18:4D
> [CHG] Device 20:73:03:A4:18:4D Connected: yes
> [agent] PIN code: 851841
> [Anker A7721]#
> [  282.174342] WARNING: at net/bluetooth/hci_conn.c:322
> hci_conn_timeout+0x44/0x198() Failed to pair:
> org.bluez.Error.AuthenticationTimeout
> [Anker A7721]#
> 
> This happens about 95% of the time.  The other 5% the pairing completes and
> everything works fine.
> 
> I could attach btmon output and output from running bluetoothd -d -n, but
> nothing interesting happens from the time the pincode is displayed and the
> timeout occurs.
> 
> Where do I begin to look for why the pincode isn't being transmitted back
> from the keyboards?  Why is it inconsistent?
> 
> As an interesting side note the Apple keyboard that I'm having the driver
> loading trouble uses the same pairing mechanism and it works well every
> time. (and all of these keyboards worked fine in 4.101)

Get full btmon logs first, ideally from the moment you power on BT adapter.

-- 
pozdrawiam
Szymon Janc


