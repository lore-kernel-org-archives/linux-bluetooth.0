Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1220050803-30362-1-git-send-email-npelly@google.com>
References: <1220050803-30362-1-git-send-email-npelly@google.com>
Date: Sat, 30 Aug 2008 10:58:42 +0200
Message-Id: <1220086722.7145.33.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Advertise Telephony service class
	when	device offers headset AG or handsfree AG
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Nick,

>  src/sdpd-service.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index cf120b8..df9017e 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -125,6 +125,8 @@ static void update_svclass_list(void)
>  		case INTERCOM_SVCLASS_ID:
>  		case FAX_SVCLASS_ID:
>  		case SAP_SVCLASS_ID:
> +		case HEADSET_AGW_SVCLASS_ID:
> +		case HANDSFREE_AGW_SVCLASS_ID:
>  			val |= 0x40;	/* Telephony */
>  			break;
>  		case AUDIO_SOURCE_SVCLASS_ID:

do you have a reference to a spec. for this one. The automatic service
class adjustment has been done according to the spec. I could have
missed one or two, but I am quite sure I didn't. So while it looks okay,
we have to make sure that we didn't violate the specs.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
