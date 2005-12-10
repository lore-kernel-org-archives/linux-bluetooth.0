Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Inquiry Time
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80512101055p7ae07d0bp6063dc667b3d2425@mail.gmail.com>
References: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
	 <439823BF.1@csr.com>
	 <45bf5ff80512101055p7ae07d0bp6063dc667b3d2425@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1134241529.21414.2.camel@blade>
Mime-Version: 1.0
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
Date: Sat, 10 Dec 2005 20:05:29 +0100

Hi Artur,

>  Thank you for your email, that clear my doubt. Now my question is,
> can i edit or have any sort of control over that parameter? Sometimes
> this inquirie lasts forever (Over a minute) and causes a functional
> problem in the application that im developing since i only receive the
> list of discovered macaddress=C2=B4s once the inquiry complete event
> arrives. At work where we have a lot of bluetooth devices from mobiles
> to headsets,laptops , keyboards ...etc ...the inquirie process can
> take more then 5 minutes and sometimes it doesnt finish, i have to
> cancel it manually.=20

from the HCI you can't have unlimited length for an inquiry. The default
value is 10 seconds and then after 10 seconds the inquiry complete event
will be send by the chip. If it lasts 5 minutes then something else is
wrong here. What about sending in a "hcidump -X -V -t" to prove what you
are observing.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
