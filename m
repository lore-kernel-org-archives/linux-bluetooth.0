Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60606301615j2f7fe75n3ec26ead68ef724a@mail.gmail.com>
References: <be976db60606301615j2f7fe75n3ec26ead68ef724a@mail.gmail.com>
Date: Mon, 03 Jul 2006 17:15:53 +0200
Message-Id: <1151939753.12125.18.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluetooth protocol question
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

Hi Mark,

> I am somewhat new to Bluetooth and Bluez so this may be somewhat of a
> newbie question.
> 
> I have a bluetooth device that I am trying to write code to work with
> it on my Suse box.   In my log
> file, I see link_key_request, and then pin_code_request and then
> link_key_notify.  All seems successful. 
> And then after a few minutes I get this line in my system log:
> 
>   sdpd[8619]: close_sock:  Read error: Connection timed out
> 
> What is sdpd trying to do?  I think there must be something about the
> bluetooth protocol that I am missing. 
> Is sdpd trying to read data out of the device?   Is there a good doc
> somewhere I can understand the bluetooth protocol (handshake etc...)

run "hcidump -X -V" in another terminal and show us its output.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
