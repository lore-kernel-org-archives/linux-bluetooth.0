Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christopher =?ISO-8859-1?Q?Bergstr=F6m?= <christopher@netsyncro.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <41E0AA3D.5010107@xmission.com>
References: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com>
	 <1105222194.27527.12.camel@linux.site>  <41E0AA3D.5010107@xmission.com>
Content-Type: multipart/alternative; boundary="=-hYPjE4JvnfJcemSoZ1sA"
Message-Id: <1105256377.14750.7.camel@linux.site>
Mime-Version: 1.0
Subject: [Bluez-users] btsco kernel make (simple error I'm sure)
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
Date: Sun, 09 Jan 2005 08:39:36 +0100


--=-hYPjE4JvnfJcemSoZ1sA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After ./bootstrap && ./configure

I cd into the /kernel directory..

and running make gives this error..


username@linux:~/btsco> cd kernel/
username@linux:~/btsco/kernel> make
make[1]: Entering directory `/usr/src/linux-2.6.8-24.10'
Makefile:465: .config: No such file or directory
 
WARNING: Symbol version dump /usr/src/linux-2.6.8-24.10/Module.symvers
is  missing, modules will have CONFIG_MODVERSIONS disabled.
 
  CC [M]  /home/username/btsco/kernel/btsco.o
/bin/sh: scripts/basic/fixdep: No such file or directory
make[2]: *** [/home/username/btsco/kernel/btsco.o] Error 1
make[1]: *** [_module_/home/cusernamem/btsco/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.8-24.10'
make: *** [default] Error 2


(I've read the README, all links referring to the README and a quick
tutorial on rebuilding kernel and kernel modules.)  Nothing really jumps
out as the answer unless I should have this stuff in a different
directory?  (There are a couple fixdep on my computer, but I'm not sure
if I should ln -s it somewhere..)  Sorry for the newbie question..

--=-hYPjE4JvnfJcemSoZ1sA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.2.4">
</HEAD>
<BODY>
After ./bootstrap &amp;&amp; ./configure<BR>
<BR>
I cd into the /kernel directory..<BR>
<BR>
and running make gives this error..<BR>
<BR>
<BR>
username@linux:~/btsco&gt; cd kernel/<BR>
username@linux:~/btsco/kernel&gt; make<BR>
make[1]: Entering directory `/usr/src/linux-2.6.8-24.10'<BR>
Makefile:465: .config: No such file or directory<BR>
 <BR>
WARNING: Symbol version dump /usr/src/linux-2.6.8-24.10/Module.symvers is&nbsp; missing, modules will have CONFIG_MODVERSIONS disabled.<BR>
 <BR>
&nbsp; CC [M]&nbsp; /home/username/btsco/kernel/btsco.o<BR>
/bin/sh: scripts/basic/fixdep: No such file or directory<BR>
make[2]: *** [/home/username/btsco/kernel/btsco.o] Error 1<BR>
make[1]: *** [_module_/home/cusernamem/btsco/kernel] Error 2<BR>
make[1]: Leaving directory `/usr/src/linux-2.6.8-24.10'<BR>
make: *** [default] Error 2<BR>
<BR>
<BR>
(I've read the README, all links referring to the README and a quick tutorial on rebuilding kernel and kernel modules.)&nbsp; Nothing really jumps out as the answer unless I should have this stuff in a different directory?&nbsp; (There are a couple fixdep on my computer, but I'm not sure if I should ln -s it somewhere..)&nbsp; Sorry for the newbie question..
</BODY>
</HTML>

--=-hYPjE4JvnfJcemSoZ1sA--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
