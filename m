Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Mary-Beth Sherwood <daniel.james.sherwood@googlemail.com>
Date: Wed, 5 Jul 2017 08:41:52 +0100
Message-ID: <CAC9jHiekNXEPqE3BDNXGwsThBUcKo1N2-VRa8nkvPfVYmf78eQ@mail.gmail.com>
Subject: Detection of RFCOMM TTY disconnection
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I am trying to write an application using RFCOMM and have everything
working fine except for being able to detect RFCOMM remote
disconnection when the RFCOMM TTY is used.

If the raw RFCOMM socket is used, then as soon as the remote end
disconnects the profile, the socket receives an error, however if the
TTY is instantiated, then the behaviour seems to be different.
1) Firstly, the socket itself has already been marked as closed so it
is not possible to monitor it for errors.
2) If a client is reading from the TTY, then the active read() returns 0.
3) If a client if polling the TTY (for POLLERR | POLLHUP), then no
notification appears to occur.

Due to the architecture of the application, the process reading the
TTY is completely separate from the process managing the state of the
Bluetooth stack and there is no simple way to communicate the
disconnection between these processes.

I have reproduced this behaviour using standard Bluez tools on the
following platform as shown below:
* Platform - Raspberry Pi 3
* OS - Raspbian
* Kernel - 4.9.28
* Bluez - 5.43

 1) Add SP profile using sdptool

     >sudo sdptool add SP

 2) Start rfcomm command

    >sudo rfcomm listen hci0 1
    Waiting for connection on channel 1

3) Remote connect from PC - rfcomm command reports

    Connection from <ADDRESS> to /dev/rfcomm0
    Press CTRL-C for hangup

4) Start terminal

    >miniterm.py /dev/rfcomm0
    --- Miniterm on /dev/rfcomm0  9600,8,N,1 ---
    --- Quit: Ctrl +] | Menu: Ctrl+T | Help: Ctrl+T followed by Ctrl+H ---

 5) Data transfer then works as expected

 6) Remote disconnect from PC - miniterm command reports

     --- exit ---
    Exception in thread rx:
    Traceback (most recent call last):
      File "/usr/lib/python2.7/threading.py", line 801, in __bootstrap_inner
        self.run()
      File "/usr/lib/python2.7/threading.py", line 754, in run
        self.__target(*self.__args, **self.__kwargs)
      File "/usr/bin/miniterm.py", line 452, in reader
        data = self.serial.read(self.serial.in_waiting or 1)
      File "/usr/lib/python2.7/dist-packages/serial/serialposix.py",
line 490, in read
        'device reports readiness to read but returned no data '
    SerialException: device reports readiness to read but returned no
data (device disconnected or multiple access on port?)

7) At this point, rfcomm command is still running, /dev/rfcomm0 still
exists and miniterm can open it again without reporting any errors
(but not transfer any data).

The Bluez rfcomm tool does appear to be attempting to be notified when
the TTY is disconnected (see lines 563-570 of tools/rfcomm.c however
it appears that the TTY never generated any error or hangup events.

Could someone clarify whether this is the expected behaviour - or
whether this is a bug in Bluez/Kernel that should be investigated
further.

Cheers

Daniel Sherwood
