Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430CA30B.7070104@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
References: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local>
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
Date: Wed, 24 Aug 2005 10:40:43 -0600

Victor,

That's good news, glad to hear.

I thought itimer used the rtc behind the scenes but maybe we need to try 
latching into the rtc directly for our timing. It's insane to have to tweak.

Can you tell me if the sources you tested used the new usleep value? I 
committed a change to use 1000 in that first usleep call but you may not 
have updated and gotten it.

Brad

Victor Shcherbatyuk wrote:
> Brad,
> 
> I ran one more test and instead of -n flag for a2play I changed magic 87 to magic 50, CPU usage dropped >2 times to ~8% on ARM9@400Mhz and sound is still smooth. That's how it was tested in first place which is close to 30 MIPS I guess...
> 
> Regards,
>     Victor.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
