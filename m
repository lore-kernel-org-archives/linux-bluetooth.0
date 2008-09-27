Return-Path: <cyrus@holtmann.org>
Message-Id: <3B81408E-617A-46F5-A8D2-89C70E4E97FD@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <48DD699C.9090307@dell.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-6--570359728
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Bluetoothd crashing on 4.7
Date: Sun, 28 Sep 2008 00:12:56 +0300
References: <48DD699C.9090307@dell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail-6--570359728
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi Mario,

On Sep 27, 2008, at 2:00, Mario Limonciello wrote:
> I recently packaged bluez 4.7 for possible inclusion in Ubuntu  
> intrepid
> [1].  Upon doing some basic testing with it, I've run into a situation
> where when I try to pair with a keyboard, bluetoothd crashes.  If I  
> run
> it under valgrind, bluetoothd survives the crash, and the keyboard  
> works
> [2].  If I run it with gdb, it comes down, and I get a trace at
> least[3].  If I run it without a debugger, keyboard doesn't properly  
> work.

This is probably caused by my cleanup/rewrite patches for the pairing  
logic in 4.7. Based on the gdb trace the attached patch should fix the  
issue. It's also pushed to the kernel.org git and should appear in the  
next release.

Johan

--Apple-Mail-6--570359728
Content-Disposition: attachment;
	filename=bluetoothd-segfault.patch
Content-Type: application/octet-stream;
	x-unix-mode=0664;
	name="bluetoothd-segfault.patch"
Content-Transfer-Encoding: 7bit

commit cccde44377fc5bb5d9db51ca6b4fcb790c7d24ba
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Sat Sep 27 14:08:42 2008 -0700

    Fix potential NULL pointer dereference

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 795df0a..eea166e 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -518,7 +518,7 @@ void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer,
 
 	bonding = adapter_get_bonding_info(adapter);
 
-	if (bacmp(&bonding->bdaddr, peer))
+	if (bonding && bacmp(&bonding->bdaddr, peer))
 		bonding = NULL;
 
 	if (status == 0) {

--Apple-Mail-6--570359728
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-6--570359728--
