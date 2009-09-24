Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 24 Sep 2009 12:05:03 +0200
Subject: Compiling bluez for python in /usr/local
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E0C80070A@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I just compiled bluez-4.53 on a system with python at /usr/local/bin/python - unless I messed up somewhere, it seems simple-agent and the other python scripts still expected to find python at /usr/bin/python.

Whilst this can be fixed with a symlink, it might be better that the scripts refer to the actual location of python?

Regards, John
