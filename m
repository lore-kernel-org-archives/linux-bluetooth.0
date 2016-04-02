Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Oscar C <oscar-listas@naiandei.net>
Cc: szymon.janc@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: sixaxis: Improved support for DualShock 3 clones not working (undefined symbol)
Date: Sat, 02 Apr 2016 09:40:27 +0200
Message-ID: <1558539.FTrjhmdCRM@ix>
In-Reply-To: <c1557d88bcf8b0d4fe64f76569c66396@naiandei.net>
References: <c1557d88bcf8b0d4fe64f76569c66396@naiandei.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oscar,

On Tuesday 22 March 2016 17:58:35 Oscar C wrote:
> Szymon,
> 
> I tried the patches sent to the list on June 2015 regarding the DS
> clones made by ShanWan. That patches are necessary because the DualSock
> clones do not work with the current sixaxis plugin.
> 
> They compiles ok, but when I try to run the daemon it fails because a
> symbol can not be found. Of course, the same code but without the
> patches applied works fine (but the gamepad does not work).
> 
> Any idea on how to solve this? Thanks!

Sorry for late reply.

Yeah.. the problem is that only certain types of symbols are exported to 
external plugins by bluetoothd (check src/bluetooth.ver). And sdp_* are
not among them. (TBH I'm not sure why I didn't noticed this when running 
bluetoothd from source tree).

I think we would have to provide SDP record as xml and then only generate 
sdp_data in Bluetooth input code. Other solution would be to export sdp_* 
symbols (if those are the only ones that are missing).

Unfortunately I'm quite busy recently and cannot provide any ETA for those 
changes. But if you want to pick this up, I'll be able to review patches (you 
are not the first person asking for this).

> 
> gardenia:/root # /usr/lib/bluetooth/bluetoothd -n -d 9
> bluetoothd[5943]: Bluetooth daemon 5.37
> bluetoothd[5943]: Starting SDP server
> bluetoothd[5943]: Can't load plugin
> /usr/lib/bluetooth/plugins/sixaxis.so:
> /usr/lib/bluetooth/plugins/sixaxis.so: undefined symbol: sdp_data_alloc
> bluetoothd[5943]: Bluetooth management interface 1.6 initialized
> 


-- 
pozdrawiam
Szymon Janc
