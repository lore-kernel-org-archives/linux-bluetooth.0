Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Message-ID: <000c01c49c4a$ca42b9a0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-devel] Rfcomm Use Count
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 16 Sep 2004 17:10:50 -0700

Marcel,

I have a simple way to reproduce at least part of this bug. I don't have =
an
up-to-date x86 machine to try this on, but I suspect you'll see the same
behaviour:

1. Compile and run the attached code on one machine
2. Connect to it from another machine using: rctest -n -P1 <bd_addr>
3. Hit ctrl-c on rctest
4. Hit ctrl-c on bzt (or whatever you called the compiled code)
5. lsmod and look at the rfcomm use count.

I think the problem stems from rfcomm_cleanup_listen() and
bluez_accept_dequeue(). Bluez_accept_dequeue() won't return the socket =
if it
is in the closed state, and so rfcomm_cleanup_listen() can't fully =
cleanup.

And if accept is called before rfcomm_cleanup_listen(), then (I think) =
the
socket will be unlinked from the accept queue (by accept) but not =
killed,
and so also will not get cleaned up.

Things appear to work if you reverse the order of steps 3 and 4.

I'd send you a patch if I had a simple one, but I don't know what the =
best
approach is. On solution may be to make bluez_accept_dequeue() always =
return
the socket regardless of state and then fix anything that calls
bluez_accept_dequeue() to handle the possibility of a closed socket =
being
returned.

-Daryl.

--- test code below ---
// bzt.c

#include <stdio.h>
#include <errno.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char *argv[])
{
	struct sockaddr_rc loc_addr;
	int s;
=09
	if((s =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		printf("Can't create server socket:
%s(%d)\n",strerror(errno), errno);
		return -1;
	}
=09
	loc_addr.rc_family =3D AF_BLUETOOTH;
	bacpy(&loc_addr.rc_bdaddr, BDADDR_ANY);
	loc_addr.rc_channel =3D 1;
	if(bind(s,(struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
		printf("Can't bind %s(%d)\n",strerror(errno), errno);
		return -1;
	}
=09
	if(listen(s,10)) {
		printf("Can't listen %s(%d)\n",strerror(errno),errno);
		return -1;
	}
=09
	printf("Listening...\n");
	while(1) sleep(999);
=09
	return 0;
}



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
