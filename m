Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 17:05:04 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: torvalds@linux-foundation.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, linville@tuxdriver.com
Subject: Revert "Bluetooth: fix shutdown on SCO sockets"
Message-ID: <20110511200503.GH22065@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Linus,

Commit f21ca5fff6e548833fa5ee8867239a8378623150 can cause a NULL dereference
if we call shutdown in a bluetooth SCO socket and doesn't wait the shutdown
completion to call close(). Please revert it. I may have a fix for it soon,
but we don't have time anymore, so revert is the way to go. ;)

Regards,


commit f21ca5fff6e548833fa5ee8867239a8378623150
Author: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
Date:   Fri Apr 8 17:10:41 2011 +0300

    Bluetooth: fix shutdown on SCO sockets
    
    shutdown should wait for SCO link to be properly disconnected before
    detroying the socket, otherwise an application using the socket may
    assume link is properly disconnected before it really happens which
    can be a problem when e.g synchronizing profile switch.
    
    Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://profusion.mobi
