Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B670A9.4030804@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco problem
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
In-Reply-To: <20041206225609.GA1177@zeus.galaxy.org.uk>
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
Date: Tue, 07 Dec 2004 20:10:33 -0700

Chris,

Did it start working when you clicked the 'connect' button on the 
headset? Sebastian pointed out that this was something one might miss so 
I highlighted it recently in the docs.

Brad

Chris Boyle wrote:
> Hi, I can't get snd-bt-sco (bluetooth-alsa) to work and was told this
> was the best place to ask for help:
> 
> The problem is, btsco starts up successfully, the device indicates a
> connection has been made, but no audio can be read or written, and after
> maybe a minute the device indicates the connection has been dropped.
> There is no noticeable difference on the host side at this point, i.e.
> audio apps directed at the headset still just hang, and btsco is still
> there. The mixer produces output from btsco, but has no effect on the
> device.
> 
> Driver version: bluetooth-alsa CVS checked out 02/12/2004
> Kernel: 2.6.9 debian (presence / absence of hci_usb patch seems to make
> no difference)
> Host bluetooth adapter: Trust BT180 USB
> http://www.trust.com/home/default.htm?viewpage=service/sss/preview.htm%3Fartnr%3D13853
> Headset: Logitech Mobile Bluetooth Headset
> http://www.thinkgeek.com/computing/speakers/headsets/65ff/
> Also tested: Nokia 6310i, various channels (this functionality works
> under windows)
> 
> I'd be grateful for any hints you can give me.
> 
> Thanks,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
