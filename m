Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041208102112be98ee@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] HCI data bits corruption
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 8 Dec 2004 23:51:26 +0530

Hi Marcel,
I am communicating between 2 d-link DBT-120 dongles. I am using the
l2test for sending known data. I am using the DH packets to avoid FEC.
I am measuring the link quality for various scenarios.
I try and compare the link quality values to corresponding BER values
as per the CSR article at your website. I use hcidump to record
received bytes, but with link quality dropping as low as 180-170, I am
unable to see any corrupted bits. With the l2test, the connection
terminates even before the assigned bytes are sent with link quality
going bad, but there is no data corruption. Could you tell me how I
could get the corrupted data bits???I want some sort of error over air
interface.

I am also looking to study the behaviour of HCI and LM firmware. Is
this available at the Bluez or are the firmware well guarded by the
manufacturers and not to be given to users.

I also wanted to know if there are any bluetooth Test development kit,
in hardware and software as we could build a BT device. Buying a
Trainer/Analyser is a little over budget for my project.

Thanks,
Regards,
Manjunath


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
