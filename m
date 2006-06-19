Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44965A3C.20002@palmsource.com>
Date: Mon, 19 Jun 2006 10:03:08 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C7ADD.1040503@palmsource.com>
	<447E951C.6040400@xmission.com>	<447EA02C.3070703@palmsource.com>
	<44850D2C.9080708@xmission.com>
In-Reply-To: <44850D2C.9080708@xmission.com>
Subject: Re: [Bluez-devel] First try
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


>I had a look at your a2dp patches to move globals into the
>per-connection struct. It all looks like a clear improvement. I didn't
>have any problems with changes in quality after the change.
>
>Would you like to check things out of cvs and verify it works for you?
>  =

>
Sorry for the long silence, I'm working on something else. I'm pleased =

you integrated my previous patch, it works well.

I tried two headset at a time. It does'nt crash, but I have bad sound. I =

believe this is due to bandwith limit. My bluetooth dongle is USB so =

there is enough bandwith.  And bluetooth is 700 kb/s so I thought it =

should be enough to pass sbc data. I believed sbc was 128 kb/s. Maybe it =

is per channel... Can you confirm?

Thank you!
Fr=E9d=E9ric.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
