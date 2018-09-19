Return-Path: <lramos.prof@yahoo.com.br>
Date: Wed, 19 Sep 2018 09:18:49 -0300
From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PINGBACK] Patches for ath3k with possible issues
Message-ID: <20180919121849.GA29863@giustizia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I sent these messages some time ago and as I am not a frequent patch
developer and hence not used to send patches to the community, I'd like
to know if you have been aware of them.

I haven't received any replies so far.

The patches were sent in sequence of this "heading" message and are
trivial, however, very useful for my case. Only to remember, they print
messages in case of errors in two specific operations in the ath3k
kernel module.


Many thanks,

Luiz Carlos Ramos
lramos dot prof at yahoo dot com dot br
São Paulo - Brazil


----- Forwarded message from Luiz Carlos Ramos <lramos.prof@yahoo.com.br> -----

Date: Fri, 7 Sep 2018 20:35:31 -0300
From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Patches for ath3k with possible issues
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello,

I think I have found some smaller problems related to a specific
Bluetooth adapter that isn't working fine in a laptop that is with me
from some time. In fact, only now I've found enough time to dig into the
code and try to make some experiments.

The Bluetooth adapter is an Atheros, identified by VID/PID 0cf3:0036,
running in a x86_64 laptop.

The problems are just like that:

1- when the laptop starts, Bluetooth always work; however, I found that
the "switch vid/pid" operation doesn't work, returning -32 ("EPIPE")

2- after a suspend or hibernate, when it resumes, sometimes the firmware
download doesn't work. It stops before sending all pieces and when it
happens, it returns code -32 ("EPIPE")

3- there are cases also where after a resume, the switch VID/PID works
and the adapter changes its identification to 0cf3:3007

4- in cases 2 and 3, sometimes the bluetooth daemon doesn't recognize
the adapter anymore. In my tests, I can restore operation doing in
sequence: rmmod ath3k, insmod ath3k, kill bluetooth daemon and start
bluetooth daemon again

Even not knowing the problem in detail right now, I can send some
patches which helped me to collect the information above, specially the
return code of the switch VID/PID operation and the state of the
firmware load when the error happens. I'll send you next two patches
which addresses these two things, and hopefully this can help someone
else that stays in trouble with problems like those.

Many thanks,

Luiz Carlos Ramos
lramos dot prof at yahoo dot com dot br
São Paulo - Brazil


----- End forwarded message -----
