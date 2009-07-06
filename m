Return-Path: <cyrus@holtmann.org>
Subject: Re: bug? kernel does not send HCI Create Connection Cancel Command
 on  shutdown() or close() of a connecting rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
References: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
	 <1242787757.3147.13.camel@localhost.localdomain>
	 <35c90d960905201457i508c678fqeb696cce32ae63be@mail.gmail.com>
	 <35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 16:31:16 -0700
Message-Id: <1246923076.3384.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >>> I found that neither close() nor shutdown() on a RFCOMM socket that is
> >>> currently connecting will cause the kernel to send HCI Create
> >>> Connection Cancel Command. This seems like a problem, since this means
> >>> there is no way to cancel an outgoing connection - even in the single
> >>> threaded case.
> >>>
> >>> Ideally for our use case both shutdown() and close() would cause the
> >>> Create Connection Cancel command to be sent.
> >>>
> >>> It is easy to check this with a code snippet like:
> >>>
> >>>     fd = _socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> >>>     flags = fcntl(fd, F_GETFL);
> >>>     fcntl(fd, F_SETFL, flags | O_NONBLOCK);
> >>>     connect(fd, (struct sockaddr *) &addr, sizeof(struct sockaddr));
> >>>
> >>>     sleep(1);
> >>>     shutdown(fd, SHUT_RDWR);
> >>>     sleep(1);
> >>>     close(fd);
> >>>
> >>> Following this with hcidump you can see the Create Connection command
> >>> sent, but it does not get canceled on close or shutdown.
> >>>
> >>> 2009-05-19 17:55:16.098103 < HCI Command: Create Connection
> >>> (0x01|0x0005) plen 13
> >>>     bdaddr 00:11:22:33:44:55 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >>> 2009-05-19 17:55:16.118305 > HCI Event: Command Status (0x0f) plen 4
> >>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> >>>
> >>> <--- shutdown()
> >>> <--- close()
> >>>
> >>> 2009-05-19 17:55:26.361744 > HCI Event: Connect Complete (0x03) plen 11
> >>>     status 0x04 handle 1 bdaddr 00:11:22:33:44:55 type ACL encrypt 0x00
> >>>     Error: Page Timeout
> >>> 2009-05-19 17:55:33.119251 < HCI Command: Create Connection
> >>> (0x01|0x0005) plen 13
> >>>     bdaddr 00:11:22:33:44:55 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >>> 2009-05-19 17:55:33.139240 > HCI Event: Command Status (0x0f) plen 4
> >>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> >>>
> >>>
> >>> Tested on 2.6.29.
> >>>
> >>> Is this behavior intentional or is this a bug?
> >>
> >> I know that I tested this massively with non-blocking sockets and there
> >> is works perfectly fine. No idea why shutdown() or close() is not
> >> catching this.
> >>
> >> Please check with 2.6.30-rc6 kernel since the Simple Pairing changes
> >> might have broken something here.
> >
> > I tested on the following kernels:
> >
> > Android 2.6.27 (2.6.27 + several bluetooth-next.git patches)
> > Android 2.6.29 (2.6.29 + several bluetooth-next.git patches)
> > 2.6.28 (Ubuntu 9.10)
> >
> > All with the same results.
> >
> > I don't have easy access to a 2.6.30 kernel right now.
> >
> > Thanks for letting us know this is not intentional behavior.
> 
> FYI: I still see this issue on 2.6.31-rc1
> 
> Any suggestions of where to begin debugging this? I will look at it today.
> 
> $ uname -a
> Linux npelly-kernel 2.6.31-020631rc1gc0d1117-generic
> #020631rc1gc0d1117 SMP Wed Jul 1 09:04:38 UTC 2009 i686 GNU/Linux
> 
> $ hcidump -XVt
> 2009-07-06 11:46:53.792864 < HCI Command: Create Connection
> (0x01|0x0005) plen 13
>     bdaddr 00:01:02:0A:0B:0C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> 2009-07-06 11:46:53.800563 > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> 2009-07-06 11:46:58.923825 > HCI Event: Connect Complete (0x03) plen 11
>     status 0x04 handle 0 bdaddr 00:01:02:0A:0B:0C type ACL encrypt 0x00
>     Error: Page Timeout
> 
> $ strace ./a.out
> [...]
> socket(PF_BLUETOOTH, SOCK_STREAM, 3)    = 3
> fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
> fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
> connect(3, {sa_family=AF_BLUETOOTH,
> sa_data="\f\v\n\2\1\0\4\10\2\0\0\0\t\207"...}, 10) = -1 EINPROGRESS
> (Operation now in progress)
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({1, 0}, {1, 0})               = 0
> shutdown(3, 2 /* send and receive */)   = 0
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({1, 0}, {1, 0})               = 0
> close(3)                                = 0
> exit_group(0)                           = ?
> 
> $ cat sock_shutdown_bug.c
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <fcntl.h>
> 
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> 
> int main(int argc, char **argv) {
>     int fd;
>     int ret;
>     long flags;
>     struct sockaddr_rc addr;
> 
>     addr.rc_family = AF_BLUETOOTH;
>     str2ba("00:01:02:0A:0B:0C", &addr.rc_bdaddr);
>     addr.rc_channel = 4;
> 
>     fd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>     flags = fcntl(fd, F_GETFL);
>     fcntl(fd, F_SETFL, flags | O_NONBLOCK);
> 
>     connect(fd, (struct sockaddr *)&addr, sizeof(struct sockaddr_rc));
> 
>     sleep(1);
>     shutdown(fd, SHUT_RDWR);
>     sleep(1);
>     close(fd);
> }

this would be the program to test L2CAP:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <fcntl.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>

int main(int argc, char **argv) {
    int fd;
    int ret;
    long flags;
    struct sockaddr_l2 addr;

    addr.l2_family = AF_BLUETOOTH;
    str2ba("00:01:02:0A:0B:0C", &addr.l2_bdaddr);
    addr.l2_psm = htobs(1);
    addr.l2_cid = 0;

    fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
    flags = fcntl(fd, F_GETFL);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);

    connect(fd, (struct sockaddr *)&addr, sizeof(addr));

    sleep(1);
    shutdown(fd, SHUT_RDWR);
    sleep(1);
    close(fd);
}

Regards

Marcel


