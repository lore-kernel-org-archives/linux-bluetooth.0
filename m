Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] lockup problem with larger packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Erwin Authried <eauth@softsys.co.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098973897.11799.97.camel@justakiss>
References: <1098480115.3258.61.camel@justakiss>
	 <1098539750.26310.17.camel@pegasus>  <1098928778.23859.32.camel@kabel>
	 <1098964060.6636.15.camel@pegasus>  <1098973897.11799.97.camel@justakiss>
Content-Type: text/plain
Message-Id: <1098984652.6636.31.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 28 Oct 2004 19:30:51 +0200

Hi Erwin,

> here's a patch that reduces the execution time for "unslipping" the
> received data considerably. The patch does NOT support packets with CRC!
> This would require a little bit of additional work, I think that it
> would be better to rewrite the crc routine to calculate the whole packet
> checksum at once for better performance. I have not done that because
> the CBT100C doesn't use crc's.
> Please ignore the __fastram attribute, it's for uClinux on my specific
> board only. Functions with this attribute are placed into the cpu's
> internal 32-bit ram for faster execution.

thanks for the patch, but I can't apply it. You don't follow the coding
style and some parts are looking too hackish to me. However I don't have
enough time to look at the performance problems of the BCSP driver, but
it seems that this is necessary. So is anyone volunteering?

Regards

Marcel




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
