Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DED4A2.5090707@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] headset emulator apps
References: <5000105b05010705172040f6c3@mail.gmail.com> <Pine.LNX.4.33.0501071420510.21727-100000@redbean.intranet.gw-instruments.de> <20050107135431.GA19076@pangeia.com.br>
In-Reply-To: <20050107135431.GA19076@pangeia.com.br>
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
Date: Fri, 07 Jan 2005 11:27:46 -0700

Nelson,

You are not likely to find a phone that can send quality audio. You'd 
need it to support A2DP and most devices still don't.

Plus, to decode it, you'd need to write the AVDTP signaling to operate 
the A2DP "sink" to receive audio. The only good news is you would be 
able to use the sbc decoder we have at bluetooth-alsa.sf.net to 
uncompress the audio.

Brad

Nelson Murilo wrote:
> Hi guys,
> 
> sorry for off-topic, but anybody know any headset emulator for
> linux?  
> My idea is send mp3 from my phone via bluetooth connection to my linux box, 
> and may redirect sound for real sound sistem. 
> 
> Thanks in advance,
> 
> ./nelson -murilo
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
