Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45800229.4040805@nokia.com>
Date: Wed, 13 Dec 2006 15:37:45 +0200
From: Luciano Coelho <luciano.coelho@nokia.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1162893409.5068.23.camel@localhost>
In-Reply-To: <1162893409.5068.23.camel@localhost>
Subject: Re: [Bluez-devel] Patch with small CoD changes in hciconfig and
	hcitool
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

Hello,

Has anyone had the time to look into this patch I submited a while ago? 
It's really a simple patch and not very critical, but it's very useful 
in certain test scenarios.

I've shown this patch to Johan previously and he thought it was ok.  
Would anyone have the time to take a look at it? It would be nice to 
have it included in the main bluez tree...

Cheers,
Luca.

Luciano Coelho wrote:
> Hi all,
>
> I was using hciconfig to perform some tests and I realized that there
> were a few omissions and small mistakes in the way hciconfig and hcitool
> were converting CoD information to strings.
>
> I've created a small patch to fix this.  It's the first patch I send to
> this list, so forgive me if there is any "childish" mistake or style
> flaw in it ;-) Any comments are welcome.
>
> Cheers,
> Luca.
>   
> ------------------------------------------------------------------------
>
> --- tools/hciconfig.c	26 Jul 2006 13:09:44 -0000	1.82
> +++ tools/hciconfig.c	7 Nov 2006 09:47:46 -0000
> @@ -597,16 +597,51 @@
>  			return "Gaming/Toy";
>  		}
>  		break;
> -	case 5:	/* peripheral */
> -		switch(minor) {
> +	case 5:	/* peripheral */ {
> +		static char cls_str[48]; cls_str[0] = 0;
> +
> +		switch(minor & 48) {
>  		case 16:
> -			return "Keyboard";
> +			strncpy(cls_str, "Keyboard", sizeof(cls_str));
> +			break;
>  		case 32:
> -			return "Pointing device";
> +			strncpy(cls_str, "Pointing device", sizeof(cls_str));
> +			break;
>  		case 48:
> -			return "Combo keyboard/pointing device";
> +			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
> +			break;
>  		}
> -		break;
> +		if((minor & 15) && (strlen(cls_str) > 0))
> +			strcat(cls_str, "/");
> +
> +		switch(minor & 15) {
> +		case 0:
> +			break;
> +		case 1:
> +			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 2:
> +			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 3:
> +			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 4:
> +			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 5:
> +			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 6:
> +			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		default:
> +			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		}
> +		if(strlen(cls_str) > 0)
> +			return cls_str;
> +	}
>  	case 6:	/* imaging */
>  		if (minor & 4)
>  			return "Display";
> @@ -617,6 +652,34 @@
>  		if (minor & 32)
>  			return "Printer";
>  		break;
> +	case 7: /* wearable */
> +		switch(minor) {
> +		case 1:
> +			return "Wrist Watch";
> +		case 2:
> +			return "Pager";
> +		case 3:
> +			return "Jacket";
> +		case 4:
> +			return "Helmet";
> +		case 5:
> +			return "Glasses";
> +		}
> +		break;
> +	case 8: /* toy */
> +		switch(minor) {
> +		case 1:
> +			return "Robot";
> +		case 2:
> +			return "Vehicle";
> +		case 3:
> +			return "Doll / Action Figure";
> +		case 4:
> +			return "Controller";
> +		case 5:
> +			return "Game";
> +		}
> +		break;
>  	case 63:	/* uncategorised */
>  		return "";
>  	}
> Index: tools/hcitool.c
> ===================================================================
> RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
> retrieving revision 1.91
> diff -u -r1.91 hcitool.c
> --- tools/hcitool.c	29 Sep 2006 11:42:14 -0000	1.91
> +++ tools/hcitool.c	7 Nov 2006 09:47:47 -0000
> @@ -245,16 +245,51 @@
>  			return "Gaming/Toy";
>  		}
>  		break;
> -	case 5:	/* peripheral */
> -		switch(minor) {
> +	case 5:	/* peripheral */ {
> +		static char cls_str[48]; cls_str[0] = 0;
> +
> +		switch(minor & 48) {
>  		case 16:
> -			return "Keyboard";
> +			strncpy(cls_str, "Keyboard", sizeof(cls_str));
> +			break;
>  		case 32:
> -			return "Pointing device";
> +			strncpy(cls_str, "Pointing device", sizeof(cls_str));
> +			break;
>  		case 48:
> -			return "Combo keyboard/pointing device";
> +			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
> +			break;
>  		}
> +		if((minor & 15) && (strlen(cls_str) > 0))
> +			strcat(cls_str, "/");
> +
> +		switch(minor & 15) {
> +		case 0:
> +			break;
> +		case 1:
> +			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 2:
> +			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 3:
> +			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 4:
> +			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		case 5:
> +			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
>  		break;
> +		case 6:
> +			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		default:
> +			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
> +			break;
> +		}
> +		if(strlen(cls_str) > 0)
> +			return cls_str;
> +	}
>  	case 6:	/* imaging */
>  		if (minor & 4)
>  			return "Display";
> @@ -265,6 +300,34 @@
>  		if (minor & 32)
>  			return "Printer";
>  		break;
> +	case 7: /* wearable */
> +		switch(minor) {
> +		case 1:
> +			return "Wrist Watch";
> +		case 2:
> +			return "Pager";
> +		case 3:
> +			return "Jacket";
> +		case 4:
> +			return "Helmet";
> +		case 5:
> +			return "Glasses";
> +		}
> +		break;
> +	case 8: /* toy */
> +		switch(minor) {
> +		case 1:
> +			return "Robot";
> +		case 2:
> +			return "Vehicle";
> +		case 3:
> +			return "Doll / Action Figure";
> +		case 4:
> +			return "Controller";
> +		case 5:
> +			return "Game";
> +		}
> +		break;
>  	case 63:	/* uncategorised */
>  		return "";
>  	}
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
