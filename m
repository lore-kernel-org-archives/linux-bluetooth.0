Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041216134138.6218.qmail@web53205.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
To: BlueZ Devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Interwork of RFCOMM and L2CAP layers
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
Date: Thu, 16 Dec 2004 05:41:38 -0800 (PST)

Good afternoon

I am not a kernel developer but I would like to do
profiling in BlueZ code as part of my PhD research,
specifically on RFCOMM/L2CAP layers. I took the source
code from my 2.4.22 kernel. 

I was expecting to see some functions on the RFCOMM
files calling functions on the L2CAP files, as RFCOMM
is a layer on top of the L2CAP layer. However I could
not find any (actually there is one: rfcomm_init calls
l2cap_load; but this last function is a dummy
function). 

Could you please tell me where I could find
information on how the RFCOMM and L2CAP layers
interwork in the BlueZ implementation (I, of course,
tryed Google and BlueZ web sites but I could not find
information)?

I would be particularly grateful if someone could give
directions on how to use the BlueZ stack in a simple
user space mode.

Many thanks,

Filipa Duarte


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
