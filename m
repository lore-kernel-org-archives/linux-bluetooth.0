Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4560409D.8040001@surrel.org>
References: <45603A25.9080806@surrel.org>
	<1163934784.11790.0.camel@localhost>  <4560409D.8040001@surrel.org>
Date: Mon, 20 Nov 2006 09:16:23 +0100
Message-Id: <1164010583.28397.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] PATCH for dund :
	correct	--dialup	behavior	(Tomtom GPS)
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

Hi Valentin,

> It's my really first contribution to the GPL world, and I'm not familiar 
> with the developpment tools. :-)

don't worry. We tell you, but I think the difference between a context
diff and unified diff is quite clear. I simply can't review any diff
that is not in unified format. Actually this should be default, but it
isn't.

> This one might be better... (it works for me with "patch < mypatch" in 
> the correct directory)
> 
> --- sdp.c       2006-05-23 14:48:37.000000000 +0200
> +++ sdp.c       2006-11-19 11:37:10.000000000 +0100
> @@ -171,6 +171,9 @@ int dun_sdp_search(bdaddr_t *src, bdaddr
>         case ACTIVESYNC:
>                 sdp_uuid128_create(&svclass, (void *) async_uuid);
>                 break;
> +       case DIALUP:
> +               sdp_uuid16_create(&svclass, DIALUP_NET_SVCLASS_ID);
> +               break;
>         default:
>                 sdp_uuid16_create(&svclass, LAN_ACCESS_SVCLASS_ID);
>                 break;

Patch has been committed to the CVS. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
