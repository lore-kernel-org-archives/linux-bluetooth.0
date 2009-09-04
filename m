Return-Path: <cyrus@holtmann.org>
Message-ID: <177499.67132.qm@web94915.mail.in2.yahoo.com>
Date: Fri, 4 Sep 2009 17:59:25 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: promisc mode and broadcast BT sockets
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I remember that eth0 had some flags which sets the raw sockets into promisc mode, so that we can receive the sockets on the interface even if we are not the intended host.
does something like this exist for BT sockets ?

If a user-space process is creating the socket, I understand that the process which does _create, _bind would get the events which it is supposed to, but how ?

example: I run hcitool scan, and a remote pairing request comes in, would the hcitool process also have access to the pairing request ?

if YES- then good - my work is done,
but if NO -- How do I make it to ? + How do I make it receive if the socket is created and does in-kernel socket calls [the hacked up way of get_fs/set_fs of KERNEL_DS].


Thanks in advance.


      Love Cricket? Check out live scores, photos, video highlights and more. Click here http://cricket.yahoo.com

