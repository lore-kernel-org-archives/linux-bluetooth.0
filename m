Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI RESET with CSR
Message-Id: <20040430140355.0a14ca82.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <20040430122351.GA30746@gmx.net>
References: <20040430122351.GA30746@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 30 Apr 2004 14:03:55 +0200

Hi nicholas,

do you have this problem every time or just sporadic? I noticed this problem 
mostly while using usb-hubs. A autoclean of the usb kernel-module with
modprobe -k [your usb module] helps in this case.

Greetings

Andy  

On Fri, 30 Apr 2004 14:23:51 +0200
"Nicholas A. Preyss" <nalp@gmx.net> wrote:

> Hi,
> 
> i am a bit curious whether anyone else experiencing the problem that the
> dongle doesn't answer after the HCI_RESET command was issued. In the
> Changelog of 2.6.4-rc3 is a note about this problem with CSR chip and
> firmware prior 12.X. But I still see this problem with 16.4.
> 
> nicholas
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
