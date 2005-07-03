Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42C7A344.4060700@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] emporia/mega-Headset and btsco problems
References: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>	<42C70688.9050407@xmission.com> <20050703004746.45b60662.andy.boehler@gmx.at>
In-Reply-To: <20050703004746.45b60662.andy.boehler@gmx.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 03 Jul 2005 02:35:16 -0600

maybe something like this... i wish the whole thing wasn't such a big 
ugly function...

diff -u -b -B -w -p -r1.28 btsco.c
--- btsco.c     17 Jun 2005 15:57:42 -0000      1.28
+++ btsco.c     3 Jul 2005 08:27:12 -0000
@@ -80,7 +80,7 @@ struct action {
         char *cmd;
  };

-static volatile int terminate = 0, ring = 0, hupped = 0, reconnect = 0;
+static volatile int terminate = 0, ring = 0, hupped = 0, reconnect = 0, 
rfreconnect = 0;
  static int verbose = 0;

  static void sig_term(int sig)
@@ -589,6 +589,8 @@ int main(int argc, char *argv[])
         sigaction(SIGCHLD, &sa, NULL);
         sigaction(SIGPIPE, &sa, NULL);

+       do {
+
         /* connect rfcomm control channel */
         if ((rd = rfcomm_connect(&local, &bdaddr, channel)) < 0) {
                 perror("Can't connect RFCOMM channel");
@@ -682,6 +684,7 @@ int main(int argc, char *argv[])
                                         fflush(stdout);
                                 }
                                 terminate = 1;
+                               rfreconnect = 1;
                         }

                         // control transmission events for volume and 
channel control
@@ -890,6 +893,11 @@ int main(int argc, char *argv[])
                         hupped = 0;
                 }
         }
+       if(rfreconnect) {
+               rfreconnect = 0;
+               terminate = 0;
+       }
+       } while(!terminate);

         if (sco_mode == CONNECTED) {
                 close(sd);


Andreas Böhler wrote:
> Hi, thanks for the quick reply;
> 
> 
>>One thing we have needed to do for a long time that would help this is 
>>to rebuild the rfcomm connection when it goes bad (or even make it 
>>happen on demand). With other headsets, the rfcomm connection only goes 
>>bad if the headset goes out of range. Holding the rfcomm connection open 
>>isn't great anyway because I think it prevents a laptop from suspending.
> 
> 
> yeah, the best way to handle my particular headset would be if btsco reconnects the rfcomm-channel after it is lost!
> May I ask someone if it is possible to supply such a patch? I would really do it myself, if I had the necessary C-skills....
> 
> thanks, 
> 
> andy
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
