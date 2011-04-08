Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Subject: HDP, can't read data from fd which Acquire from HealthChannel
Message-ID: <OF2953F661.C5E1B3A9-ON4825786C.000D1F6C-4825786C.000D35E6@cn.ibm.com>
From: Yi Hui Fan <yihuifan@cn.ibm.com>
Date: Fri, 8 Apr 2011 10:24:01 +0800
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dears

I'd like to build a demo for HDP sink. I try to use the DBUS API provided 
by Bluez. But there is a problem with unix fd to receive data.

I can get fd by calling HealthChannel.Acquire method.  following is the 
code I write to read data according the sock I got.

        fd_set rfds;
        struct timeval tv;
        int rv;
        char buff[1024];

        FD_ZERO(&rfds);
        FD_SET(sock, &rfds);
        tv.tv_sec = 10;
        tv.tv_usec = 500;

        rv = select(sock+1, &rfds, NULL, NULL, &tv);

        rv = recv(sock, buff, 1024, 0);

rv is always return 0 when I call select method. I can't get anything.

Any problem with these codes?

Thanks &
Best regards,

Yihui,Fan
