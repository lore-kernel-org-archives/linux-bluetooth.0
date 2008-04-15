Return-Path: <cyrus@holtmann.org>
Message-ID: <4804EEE9.4030500@suse.de>
Date: Tue, 15 Apr 2008 20:07:37 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <194c6ea30804110133x276fd249p245cb6cbfd699f48@mail.gmail.com>	<E673024B-BC5B-44C7-806D-38CA69FD680E@holtmann.org>	<48008B46.3080601@suse.de>
	<0D66FC67-0CE2-4BFD-BA90-4627158FD98D@holtmann.org>
In-Reply-To: <0D66FC67-0CE2-4BFD-BA90-4627158FD98D@holtmann.org>
Subject: Re: [Bluez-users] bluez3.30 audio/serial plugin issue
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann schrieb:
> I would like to ignore it, but I can't. Can you do a ls -la inside the
> installed plugins directory. Maybe libtool is messing this up. Or

seife@stoetzler:~> ls -la /usr/lib64/bluetooth/plugins/
total 204
drwxr-xr-x 2 root root  4096 10. Apr 14:07 .
drwxr-xr-x 3 root root  4096  9. Apr 07:09 ..
-rw-r--r-- 1 root root   794  9. Apr 07:09 libinput.la
-rwxr-xr-x 1 root root 53680  9. Apr 07:09 libinput.so
-rw-r--r-- 1 root root   806  9. Apr 07:09 libnetwork.la
-rwxr-xr-x 1 root root 58896  9. Apr 07:09 libnetwork.so
-rw-r--r-- 1 root root   800  9. Apr 07:09 libserial.la
-rwxr-xr-x 1 root root 53888  9. Apr 07:09 libserial.so

then i built a package without "--enable-glib", and i removed the .la files:
seife@stoetzler:~> ls -la /usr/lib64/bluetooth/plugins/
total 220
drwxr-xr-x 2 root root  4096 15. Apr 20:03 .
drwxr-xr-x 3 root root  4096 15. Apr 20:01 ..
-rwxr-xr-x 1 root root 64758 15. Apr 20:01 libinput.so
-rwxr-xr-x 1 root root 71327 15. Apr 20:01 libnetwork.so
-rwxr-xr-x 1 root root 65302 15. Apr 20:01 libserial.so

alas, it does not work:
Apr 15 20:03:26 stoetzler hcid[27467]: Device hci0 has been activated
Apr 15 20:03:26 stoetzler hcid[27467]: Starting SDP server
Apr 15 20:03:26 stoetzler hcid[27467]: Can't load plugin:
/usr/lib64/bluetooth/plugins/libnetwork.so: invalid mode for dlopen(): Inva=
lid
argument
Apr 15 20:03:26 stoetzler hcid[27467]: Can't load plugin:
/usr/lib64/bluetooth/plugins/libserial.so: invalid mode for dlopen(): Inval=
id
argument
Apr 15 20:03:26 stoetzler hcid[27467]: Can't load plugin:
/usr/lib64/bluetooth/plugins/libinput.so: invalid mode for dlopen(): Invalid
argument

-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
