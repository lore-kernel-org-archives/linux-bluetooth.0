Return-Path: <cyrus@holtmann.org>
Message-ID: <493D878C.3040300@slackdot.org>
Date: Mon, 08 Dec 2008 15:46:04 -0500
From: "Rob \"Deker\" Dekelbaum" <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4939BB42.1080607@slackdot.org>	<1228598207.28839.49.camel@violet.holtmann.net>	<493B281E.3000200@slackdot.org>	<1228616055.28839.51.camel@violet.holtmann.net>	<493BF4F8.4050609@slackdot.org>
	<493D6925.3070206@slackdot.org>
	<1228766182.28839.99.camel@violet.holtmann.net>
In-Reply-To: <1228766182.28839.99.camel@violet.holtmann.net>
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

Ok, sorry for the confusion. :) We're using the Compulab EM-X270 SBC. It 
has a CSR BT chip on it that's connected to the machine via USB (a 
diagram of the basic interconnects in the system can be see in the 
document at http://www.compulab.co.il/x270em/download/x270-em-man.pdf). 
So, as far as I know it should be working in a similar fashion to a 
desktop PC.

-d

Marcel Holtmann wrote:
> Hi Rob,
>
>   
>> I've done a little more looking and you are correct that my SCO routing 
>> on the embedded devices I'm using (Compulab EM-X270) is incorrect 
>> (hciconfig revision reports SCO routing to PCM rather than HCI). 
>> Unfortunately, bccmd doesn't seem to work right on this platform (I 
>> haven't dug into why yet) so I'm at a loss as to how to change it. Any 
>> suggestions are really appreciated.
>>     
>
> you confused me now totally. So what do you wanna do actually?
>
> SCO over PCM is for Bluetooth chips that are hardwired to a codec or
> DSP. These is default for mobile phones and most embedded devices.
>
> SCO over HCI is for desktop/laptop system or for system with external
> Bluetooth hardware/dongles.
>
> Regards
>
> Marcel
>
>
>
> ------------------------------------------------------------------------------
> SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
> The future of the web can't happen without you.  Join us at MIX09 to help
> pave the way to the Next Web now. Learn more and register at
> http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
