Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427FD5BD.7010605@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <42792979.90109@xmission.com>	 <20050507031314.548afb03.henryk@ploetzli.ch>	 <1115429201.9031.5.camel@pegasus> <1115494053.9031.15.camel@pegasus>	 <20050507222047.430774e9.henryk@ploetzli.ch> <1115498715.9031.24.camel@pegasus> <427F0492.1090007@xmission.com> <427F0F94.3060806@xmission.com>
In-Reply-To: <427F0F94.3060806@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
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
Date: Mon, 09 May 2005 15:27:25 -0600

guys,

I wrote up basic itimer/ring buffer support in a2play. It still needed 
some tuning (eg it uses the frame timespan * .87 to set the itimer)

I really just think the HP headset is poorly engineered. Either you are 
going to send frames too slowly and get a noisy glitch when it hits a 
dry patch or you are going to send them too quickly and have the 
occasional pop when it drops a frame. There's no way around it.

I did experiment with ring buffer size and SA_NODEFER option on the 
signal handler. I was trying to see if one write to the headset could be 
interrupted by the alarm so that the next frame could get on its way, 
like if you had a poor connection and wanted to keep the timing more 
accurate. I finally decided this wasn't the way... a long ring buffer 
and nodefer enabled meant really fast-playing catch-up periods after the 
connection was good again.

Brad

Brad Midgley wrote:
> I think my hack introduced timing issues of its own... tomorrow I'll fix 
> it up with code that uses a ring buffer and bleeds from the ring in the 
> sighandler.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
