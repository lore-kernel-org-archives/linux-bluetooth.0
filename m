Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44674F48.2060605@struction.de>
From: pille <pille@struction.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] l2ping seems to ignore -t timeout option
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
Date: Sun, 14 May 2006 17:39:52 +0200

hi,

i noticed that l2ping does not care about the timeout-argument.

running a current l2ping from bluez-utils-2.25 against a device that's 
not available timeouts after 20 seconds regardless of any -t parameter.

pitti ~ # time l2ping -c 1 00:01:02:03:04:05
Can't connect: Host is down
0.00s user 0.00s system 0% cpu 20.527 total

pitti ~ # time l2ping -c 1 -t 10 00:01:02:03:04:05
Can't connect: Host is down
0.00s user 0.00s system 0% cpu 20.509 total

pitti ~ # time l2ping -c 1 -t 20 00:01:02:03:04:05
Can't connect: Host is down
0.00s user 0.00s system 0% cpu 20.515 total

pitti ~ # time l2ping -c 1 -t 40 00:01:02:03:04:05
Can't connect: Host is down
0.00s user 0.00s system 0% cpu 20.521 total

pitti ~ # time l2ping -c 1 -t 80 00:01:02:03:04:05
Can't connect: Host is down
0.00s user 0.00s system 0% cpu 20.513 total


regards
   pille


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
