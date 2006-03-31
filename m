Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <442D37DF.8030201@gmx.net>
From: Whoopie <whoopie79@gmx.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------050304030809060000080900"
Subject: [Bluez-devel] [PATCH] snd-bt-sco and new mutex API in kernel 2.6.16
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 31 Mar 2006 16:08:31 +0200

This is a multi-part message in MIME format.
--------------050304030809060000080900
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached a patch to use the new mutex API introduced in kernel 2.6.16.
It's backwards compatible.

Best regards,
Whoopie


--------------050304030809060000080900
Content-Type: text/x-patch;
 name="btsco-mutex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="btsco-mutex.patch"

--- btsco.c.orig	2006-03-31 14:37:18.000000000 +0200
+++ btsco.c	2006-03-31 14:41:10.000000000 +0200
@@ -65,6 +65,15 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,15)
+#include <linux/mutex.h>
+#else
+#define mutex semaphore
+#define mutex_init init_MUTEX
+#define mutex_lock down
+#define mutex_unlock up
+#endif
+
 #ifndef SNDRV_HWDEP_IFACE_BLUETOOTH
 #define SNDRV_HWDEP_IFACE_BLUETOOTH (SNDRV_HWDEP_IFACE_EMUX_WAVETABLE + 1)
 #endif
@@ -139,15 +148,15 @@
 	struct completion thread_done;
 
 	volatile int thread_exit;
-	struct semaphore thread_sem;
+	struct mutex thread_sem;
 
 	volatile struct socket *sco_sock;
-	struct semaphore sock_sem;
+	struct mutex sock_sem;
 	wait_queue_head_t wait;
 
-	struct semaphore playback_sem;
+	struct mutex playback_sem;
 	struct snd_card_bt_sco_pcm *playback;
-	struct semaphore capture_sem;
+	struct mutex capture_sem;
 	struct snd_card_bt_sco_pcm *capture;
 } snd_card_bt_sco_t;
 
@@ -435,8 +444,8 @@
 	    );
 
 	/* Ensure any references to this in our thread have finished */
-	down(&bt_sco->playback_sem);
-	up(&bt_sco->playback_sem);
+	mutex_lock(&bt_sco->playback_sem);
+	mutex_unlock(&bt_sco->playback_sem);
 
 	atomic_dec(&bt_sco->playback_count);
 	spin_lock_irq(&bt_sco->count_changed_lock);
@@ -458,8 +467,8 @@
 	    );
 
 	/* Ensure any references to this in our thread have finished */
-	down(&bt_sco->capture_sem);
-	up(&bt_sco->capture_sem);
+	mutex_lock(&bt_sco->capture_sem);
+	mutex_unlock(&bt_sco->capture_sem);
 
 	atomic_dec(&bt_sco->capture_count);
 	spin_lock_irq(&bt_sco->count_changed_lock);
@@ -700,7 +709,7 @@
 		err = 0;
 		/*  Interrupt any socket operations, so that we may
 		 *  change the socket */
-		down(&bt_sco->sock_sem);
+		mutex_lock(&bt_sco->sock_sem);
 		kill_proc(bt_sco->thread_pid, SIGINT, 1);
 		if (bt_sco->sco_sock) {
 			dprintk("Disposing of previous socket count %d\n",
@@ -729,7 +738,7 @@
 				}
 			}
 		}
-		up(&bt_sco->sock_sem);
+		mutex_unlock(&bt_sco->sock_sem);
 		break;
 	case SNDRV_BT_SCO_IOCTL_REQ_INFO:
 		spin_lock_irq(&bt_sco->count_changed_lock);
@@ -888,7 +897,7 @@
 	set_fs(KERNEL_DS);
 
 	dprintk("snd-bt-scod thread starting\n");
-	up(&bt_sco->thread_sem);
+	mutex_unlock(&bt_sco->thread_sem);
 
 	do {
 
@@ -912,11 +921,11 @@
 		if (bt_sco->thread_exit)
 			break;
 
-		down(&bt_sco->sock_sem);
+		mutex_lock(&bt_sco->sock_sem);
 		sock = (struct socket *)bt_sco->sco_sock;
 		if (sock)
 			get_file(sock->file);
-		up(&bt_sco->sock_sem);
+		mutex_unlock(&bt_sco->sock_sem);
 
 		if (!sock)
 			continue;
@@ -1011,14 +1020,14 @@
 			}
 #endif
 #endif /* any of them */
-			down(&bt_sco->capture_sem);
+			mutex_lock(&bt_sco->capture_sem);
 			if (bt_sco->capture) {
 				snd_card_bt_sco_pcm_receive
 				    (bt_sco->capture, buf, len);
 			}
-			up(&bt_sco->capture_sem);
+			mutex_unlock(&bt_sco->capture_sem);
 
-			down(&bt_sco->playback_sem);
+			mutex_lock(&bt_sco->playback_sem);
 
 			if (bt_sco->playback || !bt_sco->loopback) {
 				memset(buf, 0, len);
@@ -1055,7 +1064,7 @@
 					buf[notzero] = 0;
 				}
 			}
-			up(&bt_sco->playback_sem);
+			mutex_unlock(&bt_sco->playback_sem);
 
 #if 0
 			/* This chunk of code lets us record (using arecord)
@@ -1072,7 +1081,7 @@
 			   which is unsigned, whereas we are dealing with signed).
 			 */
 
-			down(&bt_sco->capture_sem);
+			mutex_lock(&bt_sco->capture_sem);
 			if (bt_sco->capture) {
 				snd_card_bt_sco_pcm_receive
 				    (bt_sco->capture, "\001\002\003\004", 4);
@@ -1081,7 +1090,7 @@
 				snd_card_bt_sco_pcm_receive
 				    (bt_sco->capture, "\004\003\002\001", 4);
 			}
-			up(&bt_sco->capture_sem);
+			mutex_unlock(&bt_sco->capture_sem);
 #endif
 			msg.msg_flags = 0;
 			msg.msg_iov = &iov;
@@ -1151,11 +1160,11 @@
 	bt_sco->card = card;
 
 	init_completion(&bt_sco->thread_done);
-	init_MUTEX(&bt_sco->thread_sem);
-	down(&bt_sco->thread_sem);
-	init_MUTEX(&bt_sco->sock_sem);
-	init_MUTEX(&bt_sco->capture_sem);
-	init_MUTEX(&bt_sco->playback_sem);
+	mutex_init(&bt_sco->thread_sem);
+	mutex_lock(&bt_sco->thread_sem);
+	mutex_init(&bt_sco->sock_sem);
+	mutex_init(&bt_sco->capture_sem);
+	mutex_init(&bt_sco->playback_sem);
 	init_waitqueue_head(&bt_sco->wait);
 	init_waitqueue_head(&bt_sco->hwdep_wait);
 	spin_lock_init(&bt_sco->mixer_changed_lock);
@@ -1170,7 +1179,7 @@
 		goto __nodev;
 	}
 
-	down(&bt_sco->thread_sem);
+	mutex_lock(&bt_sco->thread_sem);
 
 	if ((err = snd_card_bt_sco_pcm(bt_sco)) < 0)
 		goto __nodev;


--------------050304030809060000080900--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
