Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46F952BD.4010009@redhat.com>
Date: Tue, 25 Sep 2007 14:26:05 -0400
From: Chuck Ebbert <cebbert@redhat.com>
MIME-Version: 1.0
To: Pierre-Yves Paulus <py@idlum.be>
References: <46F92364.3080603@idlum.be>
In-Reply-To: <46F92364.3080603@idlum.be>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] Warnings and Oops on 2.6.23-rc6 while activily
 using rfcomm links (mm/slab.c)
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 09/25/2007 11:04 AM, Pierre-Yves Paulus wrote:
> Hello,
> 
> Putting the bluetooth system under load (opening and closing several
> rfcomm links off several USB adapters, and transmitting data over them),
> I got the Oops below. The computer hung completely, as you can see. Just
> before, I also got those warnings.
> 
> I'm not sure if I'm providing the right and useful informations to allow
> fixing of those problems, as I'm definitely no expert. Please tell me if
> I do something the wrong way.
> 
> 

Please use CONFIG_SLUB and turn on SLUB debugging. Something is very wrong
somewhere...


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
