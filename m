Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 24 Apr 2007 20:55:49 +0200
From: Marc Haber <mh+bluez-devel@zugschlus.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070424185549.GE6853@torres.zugschlus.de>
References: <5FD5754DDBA0B1499B5A0B4BB5419485D8E1FC@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485D8E1FC@fmsmsx411.amr.corp.intel.com>
Subject: Re: [Bluez-devel] Plugz and btsco
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

On Thu, Apr 05, 2007 at 07:14:15AM -0700, Allyn, Mark A wrote:
> I want to make sure, if I use the plugz (with headsetd and a2dpd), I do
> not need to
> have the btsco daemon nor the snd_bt_sco device. Is that correct?
>  
> I am attempting to use skype with a bluetooth headset. I am not seeing
> the device 
> in the menu on skype.
>  
> I tried using alsa's aplay, but I am getting an error saying:
> 'channels count non available'.

Pardon me for jumping in: My headset does not yet work ("ALSA lib
pcm_sco.c:277:(sco_headset_hw_params) Unable to set number of SCO
buffers : please upgrade your Kernel !" while running kernel 2.6.20.7,
but my system does not crash even if I do not have the SCO flow
control patch applied.

Can this "Unable to set number of SCO buffers" error be related to
having an unpatched kernel?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 2323190

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
