Return-Path: <cyrus@holtmann.org>
Message-ID: <493B281E.3000200@slackdot.org>
Date: Sat, 06 Dec 2008 20:34:22 -0500
From: "Rob \"Deker\" Dekelbaum" <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4939BB42.1080607@slackdot.org>
	<1228598207.28839.49.camel@violet.holtmann.net>
In-Reply-To: <1228598207.28839.49.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] Continued SCO audio issues...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
>
> you never thought that routing the SCO packets via the chips internal
> PCM (instead of HCI) might be a problem if you wanna use ALSA?
>
> Regards
>
>   

Marcel,

 I'm not certain I'm understanding you correctly. Are you saying that 
audio SHOULD be routed through the HCI? We are currently routing the 
audio via the PCM via the "SCORouting=PCM"...I may have forgotten to put 
that into the message, but it is indeed in the config file.

Thanks,

-d

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
