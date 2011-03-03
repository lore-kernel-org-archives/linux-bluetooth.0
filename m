Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 2 Mar 2011 16:50:01 -0800
Message-ID: <AANLkTi=1qnQh+vpcWgBQKAO5bTfANJQ-x0WFd5gg0DYS@mail.gmail.com>
Subject: cannot setup multiple connection using RFCOMM
From: Han <keepsimple@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a client / server application running over bluetooth using
RFCOMM as transport.  I am using socket API in C with AF_BLUETOOTH,
SOCK_STREAM and BTPROTO_RFCOMM.

One issue I see is that I cannot have more than 1 client connected to
the same server over the RFCOMM.  The server listens on channel 1 and
forks a child process after accepting the connection, and the parent
process continues to listen. But the 2nd client always gets "Device or
resource busy".   Is there something I need to do to enable multiple
client connections ?

thanks.
Han
