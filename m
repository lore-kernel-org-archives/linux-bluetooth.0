Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4694A485.40904@idlum.be>
Date: Wed, 11 Jul 2007 11:36:05 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070709093602.A2C6B58D565@mailflip16.edt02.net>	<46935C56.5060108@idlum.be>
	<2EB6297382462046A9427D7324788A4801FD0E6C@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <2EB6297382462046A9427D7324788A4801FD0E6C@MCLNEXVS06.resource.ds.bah.com>
Subject: Re: [Bluez-devel] Kernel Oops while transmitting data on several
 RFCOMMlinks
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

Hi Richard,

Thanks a lot for the answer. I will perform the kernel update then.

Best Regards,
Pierre-Yves Paulus


Williams, Richard wrote:
> M Paulus,
> 
> I had the same problem. Upgrade to the latest kernel and the problem
> will be fixed.
> 
> Regards,
> 
> Richard Williams 
> 
> 
> -----Original Message-----
> From: bluez-devel-bounces@lists.sourceforge.net
> [mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
> Pierre-Yves Paulus
> Sent: Tuesday, July 10, 2007 6:16 AM
> To: BlueZ development
> Subject: [Bluez-devel] Kernel Oops while transmitting data on several
> RFCOMMlinks
> 
> Hello,
> 
> I performed a test on a system with several dongles, establishing
> several RFCOMM links to remote devices, and transmitting data over them.
> 
> At one point, there was a kernel Oops. Please find attached the relevant
> parte of the kernel log. Kernel on the box is 2.6.20-1.
> 
> Is it a known problem which can be avoided by upgrading the kernel to a
> latest release?
> 
> Best Regards,
> Pierre-Yves Paulus
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
