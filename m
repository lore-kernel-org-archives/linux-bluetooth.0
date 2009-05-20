Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Nick Pelly <npelly@google.com>
Date: Tue, 19 May 2009 18:20:25 -0700
Message-ID: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
Subject: bug? kernel does not send HCI Create Connection Cancel Command on
	shutdown() or close() of a connecting rfcomm socket
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I found that neither close() nor shutdown() on a RFCOMM socket that is
currently connecting will cause the kernel to send HCI Create
Connection Cancel Command. This seems like a problem, since this means
there is no way to cancel an outgoing connection - even in the single
threaded case.

Ideally for our use case both shutdown() and close() would cause the
Create Connection Cancel command to be sent.

It is easy to check this with a code snippet like:

    fd = _socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
    flags = fcntl(fd, F_GETFL);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);
    connect(fd, (struct sockaddr *) &addr, sizeof(struct sockaddr));

    sleep(1);
    shutdown(fd, SHUT_RDWR);
    sleep(1);
    close(fd);

Following this with hcidump you can see the Create Connection command
sent, but it does not get canceled on close or shutdown.

2009-05-19 17:55:16.098103 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:11:22:33:44:55 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-05-19 17:55:16.118305 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1

<--- shutdown()
<--- close()

2009-05-19 17:55:26.361744 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 1 bdaddr 00:11:22:33:44:55 type ACL encrypt 0x00
    Error: Page Timeout
2009-05-19 17:55:33.119251 < HCI Command: Create Connection
(0x01|0x0005) plen 13
    bdaddr 00:11:22:33:44:55 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-05-19 17:55:33.139240 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1


Tested on 2.6.29.

Is this behavior intentional or is this a bug?

Nick
