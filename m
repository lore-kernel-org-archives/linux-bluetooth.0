Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AD2B86.6010002@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] About rfcomm socket
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
Date: Wed, 01 Dec 2004 10:25:10 +0800

Dear all

    I am new to this place. Thanks for any help first.

    I have tried to fork two process, One use socket system call - 
accept at rfcomm channel 2, and another try to connect to a bluetooth 
device thought channel 3. But i found that i can not use a 3rd device to 
connect to the listen channel 2 at the same time.
    I am using bluez-lib-2.6, utils-2.6. ,hci-uart and linux-2.4.18 
patched with patch-2.4.18-mh15.

    My question is simple, Could bluez be multi-tasking?

best regard
Mike,Lee


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
