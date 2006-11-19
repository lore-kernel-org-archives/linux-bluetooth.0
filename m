Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4560409D.8040001@surrel.org>
Date: Sun, 19 Nov 2006 12:31:41 +0100
From: Valentin SURREL <dev@surrel.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45603A25.9080806@surrel.org> <1163934784.11790.0.camel@localhost>
In-Reply-To: <1163934784.11790.0.camel@localhost>
Subject: Re: [Bluez-devel] PATCH for dund : correct
 --dialup	behavior	(Tomtom GPS)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann a =E9crit :
> Hi Valentin,
>
> please create a unified diff, because I can't read these context diffs.
>
> Regards
>
> Marcel
>
>   =

Hi,

It's my really first contribution to the GPL world, and I'm not familiar =

with the developpment tools. :-)

This one might be better... (it works for me with "patch < mypatch" in =

the correct directory)

--- sdp.c       2006-05-23 14:48:37.000000000 +0200
+++ sdp.c       2006-11-19 11:37:10.000000000 +0100
@@ -171,6 +171,9 @@ int dun_sdp_search(bdaddr_t *src, bdaddr
        case ACTIVESYNC:
                sdp_uuid128_create(&svclass, (void *) async_uuid);
                break;
+       case DIALUP:
+               sdp_uuid16_create(&svclass, DIALUP_NET_SVCLASS_ID);
+               break;
        default:
                sdp_uuid16_create(&svclass, LAN_ACCESS_SVCLASS_ID);
                break;

Valentin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
