Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: bnep and refcnt
Date: Sun, 7 Mar 2004 16:25:01 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403071625.01627.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

after browsing the Linux 2.6 code there is a remark in net/core/dev.c that 
state what the problem with the following message that I get is 

unregister_netdevice: waiting for bnep0 to become free. Usage count = 6

The comment with the function in dev.c states that this error is caused by 
buggy protocols that should unregister after receiving notification that the 
devices they are using has been unregistered.  They should call 
unregister_netdev which decreases the refcnt.

Can anybody help me tracking down this problem I have with explaning which 
protocols could be using bnep0 ?

W
