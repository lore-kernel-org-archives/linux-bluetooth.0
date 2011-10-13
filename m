Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLYbLDtR2_o+9a2_Z+b+UHntLbzknj9D1n-JN5qUwDWRw@mail.gmail.com>
References: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
	<1318469712-6639-1-git-send-email-kengyu@ubuntu.com>
	<CABBYNZLYbLDtR2_o+9a2_Z+b+UHntLbzknj9D1n-JN5qUwDWRw@mail.gmail.com>
Date: Thu, 13 Oct 2011 14:23:01 +0300
Message-ID: <CABBYNZLetRKb=RQoq0XffCg7LwKK8B8p3kRq8Ws-44NdA3An-A@mail.gmail.com>
Subject: Re: [RFC] Bluez: Fix the adapter is not initialised after resume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Keng-Yu Lin <kengyu@ubuntu.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 13, 2011 at 10:35 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Thanks for the patch, but I suspect this may cause some problems if we
> didn't receive all the pending information, do you have bluetoothd
> logs showing the sequence of the events leading to this?
>
> --

Ive been able to reproduce it myself, it is not all the time that it
happens but when it does happen it is because we missed a command
(might be a kernel bug). We have a workaround for this already but it
doesn't work most of the times because the adapter is not up so it
doesn't accept commands, the following should fix the problem:

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9fb28c8..d0ba3ad 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1482,21 +1482,6 @@ static void read_local_name_complete(int index,
read_local_name_rp *rp)

        DBG("Got name for hci%d", index);

-       /* Even though it shouldn't happen (assuming the kernel behaves
-        * properly) it seems like we might miss the very first
-        * initialization commands that the kernel sends. So check for
-        * it here (since read_local_name is one of the last init
-        * commands) and resend the first ones if we haven't seen
-        * their results yet */
-
-       if (hci_test_bit(PENDING_FEATURES, &dev->pending))
-               hci_send_cmd(dev->sk, OGF_INFO_PARAM,
-                                       OCF_READ_LOCAL_FEATURES, 0, NULL);
-
-       if (hci_test_bit(PENDING_VERSION, &dev->pending))
-               hci_send_cmd(dev->sk, OGF_INFO_PARAM,
-                                       OCF_READ_LOCAL_VERSION, 0, NULL);
-
        if (!dev->pending && dev->up)
                init_adapter(index);
 }
@@ -2502,8 +2487,31 @@ static void device_devup_setup(int index)
        hci_send_cmd(dev->sk, OGF_HOST_CTL, OCF_READ_STORED_LINK_KEY,
                                        READ_STORED_LINK_KEY_CP_SIZE, &cp);

-       if (!dev->pending)
+       if (!dev->pending) {
                init_adapter(index);
+               return;
+       }
+
+       /* Even though it shouldn't happen (assuming the kernel behaves
+        * properly) it seems like we might miss the very first
+        * initialization commands that the kernel sends. So check for
+        * it here and resend the ones we haven't seen their results yet */
+
+       if (hci_test_bit(PENDING_FEATURES, &dev->pending))
+               hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+                                       OCF_READ_LOCAL_FEATURES, 0, NULL);
+
+       if (hci_test_bit(PENDING_VERSION, &dev->pending))
+               hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+                                       OCF_READ_LOCAL_VERSION, 0, NULL);
+
+       if (hci_test_bit(PENDING_NAME, &dev->pending))
+               hci_send_cmd(dev->sk, OGF_HOST_CTL,
+                                       OCF_READ_LOCAL_NAME, 0, 0);
+
+       if (hci_test_bit(PENDING_BDADDR, &dev->pending))
+               hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+                                       OCF_READ_BD_ADDR, 0, NULL);
 }

 static void init_pending(int index)

-- 
Luiz Augusto von Dentz
