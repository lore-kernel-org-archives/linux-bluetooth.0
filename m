Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI RESET with CSR
Message-ID: <20040430131349.GA30877@gmx.net>
References: <20040430122351.GA30746@gmx.net> <20040430140355.0a14ca82.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040430140355.0a14ca82.Andreas.Gaufer@blue-cell-networks.com>
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
Date: Fri, 30 Apr 2004 15:13:49 +0200

On  0, Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com> wrote:
> do you have this problem every time or just sporadic? I noticed this problem 
> mostly while using usb-hubs. A autoclean of the usb kernel-module with
> modprobe -k [your usb module] helps in this case.

Everytimewith 3 different USB dongles, with hub and without. I fix it,
with just plugging the dongle out and in again.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
