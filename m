Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <000b01c81484$989af5b0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>	<47189691.2000504@cilnu.com><6656b6540710210008v5cc459dv6692a5e8ff888187@mail.gmail.com>
	<471B5E66.1030601@cilnu.com>
Date: Mon, 22 Oct 2007 10:21:50 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] Blocking connect(AF_BLUETOOTH, SOCK_STREAM,
	BTPROTO_RFCOMM) => EINPROGRESS
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

I am trying to perform RFCOMM connection to a mobile phone thanks to a 
blocking "connect(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)" (Blocking is 
the only way for me to get a "Connection Refused" return status !), and if 
the phone is still asking for the authorization when the connect times out, 
the connect and leaves with a EINPROGRESS status.

Could you please tell me :
- If there is a way to extend the blocking "connect" timeout ?
- When a connect exists with a "EINPROGRESS" status, does it make sense to 
try another "connect" on the same socket without doing a complete retry 
(close / socket / bind / connect) ?

Thanks a lot,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
