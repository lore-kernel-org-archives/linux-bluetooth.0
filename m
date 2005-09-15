Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43291AB1.8060402@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP in Bluez
References: <8522981.1126758155187.JavaMail.Administrator@appsrv>
In-Reply-To: <8522981.1126758155187.JavaMail.Administrator@appsrv>
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
Date: Thu, 15 Sep 2005 00:54:41 -0600

Ivy,

There is no AVDTP code implemented in the kernel or bluez libs. The 
closest thing we have is an example of some AVDTP (specifically, just 
A2DP) negotiation in userspace by a2play.c. see bluetooth-alsa.sf.net.

Brad

Brad

Ivy wrote:
> Hi,
> 
>         I'd like to know that weather AVDTP has implemented and integrated with BLUEZ Stack or not ?.  I have gonethrough Bluez Mailing list. I had seen the discussion between Marcel and Aarthi about AVDTP Design. If it is implemented, where can i see that file ?.. 
> 
>         Thanks for your time and Help...
> 
> Thanks
> -Ivy ..
> 
> 
> __________________________
> Free 3000MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
