Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473482DA.8090300@csr.com>
Date: Fri, 09 Nov 2007 15:55:06 +0000
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47348048.8000107@cenosys.com>
In-Reply-To: <47348048.8000107@cenosys.com>
Subject: Re: [Bluez-devel] BC6 over SDIO
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

Guillaume Ligneul wrote:
> Hi all,
> 
> I am developping on Linux 2.6.14. On this version, there's not SDIO 
> bluez support.
> Does anyone know if I can use Bluez to use my BC6 over SDIO ?

You will require 2.6.24-rc1 or later.

> To finish, do you think it could be better to use UART protocol than SDIO ?

This depends on your particular hardware/software platform.  If you
don't wish to upgrade your kernel and you have a sufficiently fast UART
available then it may be best to just use a UART.

David
-- 
David Vrabel, Software Engineer, Drivers group  Tel: +44 (0)1223 692562
CSR plc, Churchill House, Cambridge Business Park, Cowley Road, CB4 0WZ

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
