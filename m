Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41470C59.2050909@uni-paderborn.de>
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] L2CAP: One failing connection hurts others?
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
Date: Tue, 14 Sep 2004 17:20:57 +0200

Hello!

I'm observing the following issue: I have 3 BT devices. 2 in listening 
state, the 3rd is connecting to both of them repeatingly via L2CAP 
(polling some data). If one of the listening devices is almost of the 
range and makes connection attempts fail, this also causes the 
connection attempts to the other device (which is good in range) to fail 
with errno 16 "Device or ressource busy". The (almost) out of range 
device fails as expected with errno 110 "Connection timed out" (since I 
set a timeout) or 112 "Host is down".

Now my question: Is there a way to circumvent this errno 16, so that I 
can further connect to in range devices even if one device is getting 
out of range and thus producing errors? What makes L2CAP failing with 
errno 16? How can I prevent it?

Regards
Stefan

P.S.: Funnily enough, 110 and 112 are the telephone numbers for police 
and fire department in Germany. I wonder if there's any connection. :)



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
