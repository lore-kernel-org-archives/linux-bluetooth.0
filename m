Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOT_U5aVg7PcOToHRPww3jg=KpOy-n=p3a5BgEXO8kXeAwLtvQ@mail.gmail.com>
References: <CAOT_U5aVg7PcOToHRPww3jg=KpOy-n=p3a5BgEXO8kXeAwLtvQ@mail.gmail.com>
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Tue, 12 Dec 2017 16:22:19 +0100
Message-ID: <CAOT_U5bmJ5ibBV2uGQZpbYHMN2=JtTc7qHsJ7mWiK5qvWfRjyQ@mail.gmail.com>
Subject: Fwd: Consistent enumeration of a btattached controller
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a controller that is attached with btattach
as a systemd service:

/usr/bin/btattach -B /dev/ttyACM0 -S 1000000

The same command seems to result in different
enumerations. Sometimes its:

$ busctl tree org.bluez
=E2=94=94=E2=94=80/org
  =E2=94=94=E2=94=80/org/bluez
    =E2=94=94=E2=94=80/org/bluez/hci1

other times:

$ busctl tree org.bluez
=E2=94=94=E2=94=80/org
  =E2=94=94=E2=94=80/org/bluez
    =E2=94=94=E2=94=80/org/bluez/hci0

Is there a way to have fixed enumeration?
