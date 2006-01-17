Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net, Claudio Takahasi <cktakahasi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] D-Bus tasks planning
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
Date: Tue, 17 Jan 2006 11:35:46 -0200

Hi guys,

I've just started planning the activities for this year. I would like
receive feedbacks/comments about the items below. There are some tasks
suggested and a lot of clouds :)  I consider these tasks essential to
make the D-Bus services usable and necessary to start the development
of Network, Serial, HID, ... services over D-Bus.

* Move hcid to bluetoothd

* BlueZ SDP D-Bus
    - How design it?  According with an old discussion, the SDP should
be implemented inside the bluetoothd completelly, because this gives
the possibility of SDP record caching. Considering this assumption,
what are the drawbacks and the side-effects to the current
applications?

* Kernel/Userspace communication interface
    - kernel inquiry cache. At the momment, one important enhancement
is provide a easy access and non-blocking inquiry operation.
    - probably this communication interface will be usefull to avoid
another blocking operations. eg: connection control stuffs.


Others planned tasks:
* Continue GBlueZConf: Check Gnome UI guidelines, create CVS
repository, support for local adapter setup, ...
* Force authentication: Make possible re-pairing.
* Remote Name: use text file stored data to solve instead of use LMP
command for every request.


Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
