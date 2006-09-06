Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FE3B33.6040405@xmission.com>
Date: Tue, 05 Sep 2006 21:06:27 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1012FED83@pdsmsx411.ccr.corp.intel.com>
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1012FED83@pdsmsx411.ccr.corp.intel.com>
Subject: Re: [Bluez-devel] Big patch to a2dpd
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

Lea

You seem to be proposing two different changes below. Do we need to
discuss which one is best?

thanks
Brad

> I've tried it on my XScale board. It is perfect but only one line to be modified to make default alsa device work smoothly. See below patch: 
> The better way is to modify the code in alsa_transfer_raw(), I think, as below: 
> 
> 	case -EPIPE:
> 		// To manage underrun, we will try to recover from error state
> 		if(xrun_recovery(alsa->playback_handle, result) == 0)
> 			result = 0;
> 		DBG("EPIPE(%d)", result);
> 		break;
> 	case -ESTRPIPE:
> 		if(xrun_recovery(alsa->playback_handle, result) == 0)
> 			result=0;
> 		DBG("ESTRPIPE(%d)", result);
> 		break;
> 	}
> 
> ========patch begin========
> --- a2dpd.c.old	2006-09-02 13:53:31.601040096 +0800
> +++ a2dpd.c	2006-09-02 13:14:53.065511072 +0800
> @@ -716,7 +716,7 @@
>  								blockstart += blocksize;
>  								ibytespersecond += transfer;
>  								a2dp_timer_notifyframe(&TimerInfos);
> -							} else {
> +							} else if (! (lpDevice->bredirectalsa)){
>  								printf("Error in a2dp_transfer_raw\n");
>  								bError = 1;
>  							}
> ========patch end========
>  
> Thanks,
> Lea

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
