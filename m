Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 9 Aug 2012 19:35:44 +0200
Message-ID: <CA+6PnXy7SVDd-s_Pe=yKL2F_ggJ7mTrP2JcBC8mhD_iY5AsKrw@mail.gmail.com>
Subject: [PATCH BlueZ 0/4] replay: Add initial version of replay tool
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth Replayer is a debugging tool that I created for my
Google Summer of Code project.
It reads dump files in BTSnoop format and replays them on a VHCI interface.

The idea is to emulate scenarios to track down bugs, especially if
they only occur with a specific system setup.
That way the problem can be recorded by the user and debugged by a
developer on his machine.

It supports several ways to configure the replay process, such as
timing controls, emulator integration and different actions.
More detailed documentation will follow shortly.

One of the current limitations is that the replay can hang for several
reasons (packets coming in in the wrong order or with wrong timing).
At the moment the only workaround is to create a config file and tweak
the sequence by hand.

I couldn't implement all of my ideas within the GSoC time frame, such
as a flexible processing order of packets in the sequence or a more
powerful config parser.
For now I will focus on documentation and bug fixes / improvements
based on feedback.

The tool is broken down into several patches, each adding more
features and complexity.
Feedback, comments or any other remarks are very welcome!

Regards,
Anton
