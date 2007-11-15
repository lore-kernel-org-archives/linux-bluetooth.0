Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a96155200711150615q38dcf09g140d2386830e9e23@mail.gmail.com>
Date: Thu, 15 Nov 2007 15:15:53 +0100
From: "Pawel Kot" <gnokii@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] select(2) or read(2) on bluetooth sockets not working
	correctly?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

In gnokii project, we use Bluetooth sockets as one of the phone
communication medium. We use it in quite usual way (simplified code):

fd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
[...]
bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
[...]
connect(fd, (struct sockaddr *)&raddr, sizeof(raddr));

Then we have (simplified code again):

while (1) {
   [...]
   write(fd, write_buf, size);
   [...]
   FD_ZERO(&readfds);
   FD_SET(fd, &readfds);
   if (select(fd + 1, &readfds, NULL, NULL, &timeout) > 0) {
      read(fd, read_buf, size);
      [...]
   }
   [...]
}

The problem is (or rather was) that then bluetooth device gets out of
range (or bluetooth gets disabled in the device) the program hangs on
read(2). So select(2) went OK and told us that there's something to be
read, but actually nothing can be read. According to select(2) manual
page, after the successful select(2), read(2) should not hang (it may
fail though).

It can be workarounded by setting O_NONBLOCK flag on the socket, but
still I consider it as a bug that read(2) hangs after successful
select(2).

take care,
pkot
PS. Please Cc me on replies.
-- 
Pawel Kot

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
