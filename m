Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 14 Nov 2009 12:45:00 +0200
Message-ID: <dfb262380911140245v20973542v61cc82ba1071064d@mail.gmail.com>
Subject: 'cat /dev/rfcomm0' yields strange data
From: Ramagudi Naziir <naziirr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

# rfcomm watch /dev/rfcomm0 1 muahahahah
Waiting for connection on channel 1
Connection from xxx to /dev/rfcomm0
Press CTRL-C for hangup


on another terminal:


# cat /dev/rfcomm0

^J^J^J
^J^J^J



^J



^J



^J^J



^^J
...
...

and these character output goes on and on for a minute or so until it stops.

Any idea what is it ? is it supposed to be here ?
I was expecting the 'cat' command to show me only data that was sent
from the remote end
(e.g. If I do on the remote peer 'echo bla > /dev/rfcomm0' I do see
the bla here on the local 'cat').

thank you for the help
naziir
