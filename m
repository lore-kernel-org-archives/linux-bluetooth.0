Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 12 Aug 2006 09:05:25 -0300
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20060812090525.14568a99.ml133@netpole.com.br>
Mime-Version: 1.0
Subject: [Bluez-users] inquiry scan
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi list,

I'm trying to write a server which, among other things, also works
with bluetooth. I've got two questions:

First, is it actually true, that there is no way to perform an inquiry
scan and an obex transfer at the same time? Wouldn't there be a moment
in which the radio is idle, in which I could do other things with it?

The second question: In hci.h there is defined EVT_INQUIRY_COMPLETE
and EVT_INQUIRY_RESULT. My guess would be that, if I set the flag
O_NONBLOCK and revolve around a select, I should get notified as soon
as the inquiry is finished and a result is available. This is just
what I would like to do, but unfortunately, O_NONBLOCK after
hci_open_dev() won't cause hci_inquiry() to return before the inquiry
of the given length has finished. So, how can I get hci_inquiry to
return immediately?

Thanks,

-- 
Cris

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
