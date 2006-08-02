Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <30252b3b0608020926w1482ff40l777c86989b5e50ea@mail.gmail.com>
Date: Thu, 3 Aug 2006 00:26:23 +0800
From: "Anton Bolshakov" <anton@bolshakov.name>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <30252b3b0608020908m4c97c870uf70aca79f1b33aab@mail.gmail.com>
MIME-Version: 1.0
References: <30252b3b0608020908m4c97c870uf70aca79f1b33aab@mail.gmail.com>
Subject: Re: [Bluez-devel] btsco 100% cpu utilization
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi list,

I found that btsco kernel module hands with 100% utilization if a
bluethooth connection get interrupted during using it with the follow
message in the syslog:
"file_count is 2 (expected 3)"


                 /* Expect this to be 3 because we (this thead) have a copy,
                    the driver process keeps one, and the app has the
 socket open.
                  */
                 if (file_count(sock->file) != 3) {
                         dprintk("file_count is %d (expected 3)\n",
                                 file_count(sock->file));
                 }


It seems error doesn't handle here properly.
file_count equals 1 if you stop a conversation.
file_count equals 2 if it got disconnected during a conversation.

The simple patch will be adding the check:
                 if (file_count(sock-file) ==2) break;

but this is not proper solution because it won't open new connection after this.

ps
sorry for sending you the draft mail in the previous mail.

Regards,
Anton

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
