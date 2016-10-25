Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 25 Oct 2016 12:04:36 -0400
From: Don Zickus <dzickus@redhat.com>
To: luiz.von.dentz@intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Commit 375d02473fb prevents obexd from accepting profile connections
Message-ID: <20161025160436.GB35881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I was testing 5.42 with my OBEX testsuite and noticed it stopped working due
to the following commit:

commit 375d02473fb7f8b90e39bc79001ab6f97a81bd3b
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Aug 8 13:33:35 2016 +0300

    core/service: Fix setting connecting state

    If the profile don't implement .accept callback it means it cannot
    connect in this mode, which is normally used for GATT profiles, so the
    code shall not assume the service will start connecting and instead just
    return an error.

diff --git a/src/service.c b/src/service.c
index 0da14ab..f387fc4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -197,7 +197,7 @@ int service_accept(struct btd_service *service)
        }

        if (!service->profile->accept)
-               goto done;
+               return -ENOSYS;

        err = service->profile->accept(service);
        if (!err)


It seems all the OBEX profiles lack an .accept function and therefore get
rejected now?

Unless my test environment is misconfigured.  Basically, I have two machines
next to each other, one runs a python script to register an authorization
agent and obex agent and then sits there waiting for remote connections.
The other machine tries to walk through the various obex apis to connect
with the server and exchange data.

Any setup of an obex connection with the server is terminated and my tests
fail.  Thoughts?

Cheers,
Don

