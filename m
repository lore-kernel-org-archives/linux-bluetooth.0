Return-Path: <cyrus@holtmann.org>
Message-ID: <1346165.1248430092866.JavaMail.root@safetgram>
Date: Fri, 24 Jul 2009 20:08:15 +1000
From: John Freeman <johnf@optimation.com.au>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Intermittent "Address already in use" error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am developing an application that is similar to a Hands-free service
written in python.

 From time to time, I encounter an "Address already in use" error when
attempting to bind a socket to a particular local adapter.  The python
code looks like:

    Listener = BluetoothSocket(SCO)
    Listener.bind((addr1, ))
    Listener.listen(1)

strace shows this as:

    3328  socket(PF_BLUETOOTH, SOCK_SEQPACKET, 2)               = 5
    3328  bind(5, {sa_family=AF_BLUETOOTH, 
sa_data="\xa2\xc7\x07\x83\x15\x00\x13\xad\x76\x2d\xf4\xf2\x42\x09"...}, 8) = 0
    3328  listen(5, 1)                                          = 0

Subsequently, in a separate python thread (is this significant?), I issue:

    sock, whence = Listener.accept()

strace shows this as:

    3343  accept(5,  <unfinished ...>
    ...
    3343  accept(5,  <unfinished ...>
    ...
    3343  <... accept resumed> {sa_family=AF_BLUETOOTH, 
sa_data="\x4e\xe4\xec\xfd\x1d\x00\xb4\x3b\x82\x04\x20\x04\xbb\xb7"...}, [8]) = 10

After many send() and recv() calls on the socket, it is closed.

Sometimes, the accept-recv-send-close cycle is repeated a number of times.

At the conclusion of the program the Listener socket is always closed.
Because, initially, it looked like the problem was related to not
closing this socket, I added logging so that I could be absolutely
sure it had been closed.

Now that you understand what the program does, we can get down to
explaining the problem.

I can run the program muliple times with no error, but occasionally
the

    Listener.bind((addr1, ))

raises a Bluetooth error (98, 'Address already in use')

When this happens, I find that there is a file /sys/class/bluetooth/sco
that contains:

    A2:C7:07:83:15:00 00:00:00:00:00:00 4

When we don't experience this problem, this file doesn't exist or is empty.

The contents of the file correspond to the bind() call, but I would
expect this to be cleaned-up on a close() of the listener.  Usually it
is, but sometimes not.  There are no obvious correlations with external
events as far as I can tell.

The problem persists as long as /sys/class/bluetooth/sco is non-empty,
and I have not discovered any way to continue other than to reboot,
which causes the file to disappear.

Any pointers on where to look next would be greatly appreciated.
