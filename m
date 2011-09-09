Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJD6O4KmmdrTLSj6Kj2PThFnkaFpcHp6y51b6a-LGygPw94e3g@mail.gmail.com>
References: <CAJD6O4KmmdrTLSj6Kj2PThFnkaFpcHp6y51b6a-LGygPw94e3g@mail.gmail.com>
Date: Fri, 9 Sep 2011 11:22:30 -0700
Message-ID: <CAJD6O4+-e73hB1ody_cq-38HwF9p2ESQwQDAY-io_7bzHz3nFQ@mail.gmail.com>
Subject: Re: Logitec MX5500 Bluetooth Version mismatch causing
 non-connectivity, workaround found
From: Glenn Phillips <glenn@coriolis-storm.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 9, 2011 at 11:07 AM, Glenn Phillips
<glenn@coriolis-storm.com> wrote:

    Hello, I have recently become aware of and have since experienced
some issues with my Logitec MX 5500 BT Kb/mouse combo.  After some
recent updates to my Sabayon linux(gentoo) system I have been unable
to use my Keyboard without modifying my udev rules.
    I have generated a bug report on our bugzilla already here:
http://bugs.sabayon.org/process_bug.cgi

    Link to /var/log/messages output http://pastebin.sabayon.org/pastie/7014
    and link to my workaround:
http://ubuntuforums.org/archive/index.php/t-1466806.html

    However I do not believe this is a good solution as this may break
other Logitec devices that rely on bluetooth functionality rather than
being able to fall back on usb only.

    current version of bluez - 4.96-r1
    previous working version - 4.93

    Thank you
