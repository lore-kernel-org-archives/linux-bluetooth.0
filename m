Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <79ae4fa10508111433c9739cb@mail.gmail.com>
From: venkat akella <akellav@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Multiple RFCOMM connections with 2.4.x kernel
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
Date: Thu, 11 Aug 2005 14:33:00 -0700

Hi

  I am trying to establish two rfcomm connections between two linux
machines running 2.4.21 kernel. I am using different channel numbers
for both connections. First connection getting established normally.
Second connection fails in the connect() with EBUSY OR EAGAIN. I have
putdown the steps I am doing exactly below. My question is "Can I
establish more than one RFCOMM connection between two machines running
2.4.x kernels"? It would be very helpful if somecan reply to this.

Here is what I am doing:
1. Start RFCOMM serversocket on Machine1. Its waiting on accept()
2. Connect from Machine2 to Machine1 using connect(). I am able to
connect to server here.
3.Start another serversocket on Machine2 on different channelID. Its
waiting on accept()
4. Try to connect from Machine1 to Machine2 using connect(). This
fails with EAGAIN or EBUSY as long as the connection established in
step 2 remains.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
