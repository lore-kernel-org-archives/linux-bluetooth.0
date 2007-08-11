Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDOEDOCAAA.leiyu@kcoe.cn>
References: <EJENLMBEOLKAMCJFBFMDOEDOCAAA.leiyu@kcoe.cn>
Date: Sat, 11 Aug 2007 20:29:06 +0200
Message-Id: <1186856946.6698.50.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a strange problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Leiyu,

> I meet a  problem, when I cross compile bluez-utils-2.25 using gcc-2.95.3,  I port it do target board and run it , it is ok,it does not need shared library file
> but  I cross compile bluez-utils-2.25 using gcc-3.3.2 ,it compile successfully too, but when I port it do target board and run it, it need shared library file 
> 
> ./hciconfig: error while loading shared libraries: libbluetooth.so.1: cannot load shared object file: No such file or directory
> 
> $ldd hciconfig , it display:  not a dynamic executable
> 
> Could anyone help me to explain this? thanks

you messed up the linking of libbluetooth. However the 2.25 version is
ancient and no longer supported. Use bluez-utils-3.14 for a change.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
