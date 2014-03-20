Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
Date: Thu, 20 Mar 2014 16:12:06 -0700
Message-ID: <CAHrH25QQgap+Uw3=T0YLb6vvGt=hBus181LW_VBJEX0+5Dmy0A@mail.gmail.com>
Subject: Re: Removing GAttrib.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> To that end, I'd like to figure out what's the best way to approach
> this. Clearly, the GAttrib dependency runs deep: the API provided in
> attrib/gatt.h uses GAttrib and is used by src/device.c and pretty much
> all the GATT based profile implementations. The profiles seem to use
> the callback interface defined in src/attio.h which is how src/device
> allows the profiles to access it's internal GAttrib instance.
> attrib/gatt.h is also currently used by gatttool.

In addition to the above, I realized that recent changes to
android/gatt also use GAttrib. So adding that to list too.
