Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus support
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076267396.2670.58.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076274445.14742.73.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 22:07:25 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

On Sun, 2004-02-08 at 20:09, Marcel Holtmann wrote:
> I already looked at your stuff. Nice work btw.

Thanks!

> At the moment I am more concerned on how the D-Bus interface should
> look like than a real implementation. 

I will send you the interface proposal in another e-mail. It's largely
implemented and used by the Gnome Bluetooth Configuration tool already,
but it's possible to modify of course.

> You now that an important part for me is the security. For example a 
> user can see what devices a paired and it can delete a pairing, but 
> it don't have to see the link key itself. This is the job of the 
> daemon that provides this interface. The same applies for changing 
> device settings and storing them on the harddisk.

I agree. This is the way the new proposed hcid is implemented.

> My favourite storage is Berkeley DB.

That's an interesting idea, you mentioned that before. Can you
elaborate, please? 

Here are some advantages of using textfiles (as default) for hcid
storage:

   1. Textfiles are intuitive to use and debug because they work
      with any tool (emacs, grep, awk, perl etc.)

   2. Small to medium size storage files have always been text
      files in Unix/Linux (/etc/passwd, /etc/hosts etc.)

   3. Textfile routines are very lightweight and efficient.

Please understand that although it does work, applications should
use the DBus interface instead of manipulating these files directly.

Here's how it's implemented in the proposed hcid. The default location
of these files is something to discuss. File layout:

   $ ls -l /etc/bluetooth/keytab*
   -rw-r--r-- 1 root root  98 Feb  8 18:29 /etc/bluetooth/keytab
   -rw-r--r-- 1 root root 147 Feb  8 16:56 /etc/bluetooth/keytab-
   -rw------- 1 root root 138 Feb  8 18:29 /etc/bluetooth/keytab.shadow
   -rw------- 1 root root 207 Feb  8 16:56 /etc/bluetooth/keytab.shadow-

   $ ls -l /etc/bluetooth/nametab*
   -rw-r--r-- 1 root root 115 Feb  8 16:00 /etc/bluetooth/nametab
   -rw-r--r-- 1 root root  86 Feb  8 15:02 /etc/bluetooth/nametab-

The dash files ("keytab-" etc.) are backup files. The "keytab" file is 
readable by all. The "keytab.shadow" is only r/w-able by root. Contents:

   $ cat /etc/bluetooth/keytab
   # sba              dba                type    create time
   00:03:C9:2A:C4:A8  00:07:E0:0C:1B:3F  0       1076252948
   00:10:DC:E9:EF:20  00:80:37:AA:7A:DA  0       1076253156

   $ cat /etc/bluetooth/keytab.shadow
   # sba              dba                key
   00:03:C9:2A:C4:A8  00:07:E0:0C:1B:3F  2f66d0364a1eea2fae680af948bb3299
   00:10:DC:E9:EF:20  00:80:37:AA:7A:DA  2855bdc30b49254902d5deebe24c24ce

   $ cat /etc/bluetooth/nametab
   # bdaddr                name
   00:00:08:04:DE:C8       Fuzz Buzz
   00:80:37:AA:7A:DA       Fredrik T39
   00:07:E0:0C:1B:3F       Fredrik TT

Fredrik
