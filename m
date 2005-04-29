Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4271D1F8.4000307@impulsesoft.com>
From: Mayank Sharma <mayank@impulsesoft.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Help with L2CAP sockets
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
Date: Fri, 29 Apr 2005 11:49:36 +0530

Hi all,
  I am developing an application using the L2CAP sockets provided by 
BlueZ. I am creating a pool of sockets and listening to all of them 
simultaneously. To avoid spawning of a thread for each socket, i tried 
using the async capabilities of the socket. I set the FASYNC flag using 
the ioctl to the socket, and set my pid to it. Thereafter i get a SIGIO 
whenever data is available on any of the socket. Everything seems fine 
except for disconnection. When an L2CAP socket is disconnected from the 
remote device, i do not get any SIGIO. Hence i am not able to do get the 
disconnection indication since i am not doing a read on the socket. I do 
a read only when i receive a SIGIO.
  I want to know if there is a way i can add code to the L2CAP file of 
bluez to send a sigio whenever it receives a disconnection indication. 
Can anyone help me with this ?

Regards,
Mayank



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
