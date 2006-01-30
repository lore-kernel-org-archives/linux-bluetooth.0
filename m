Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43DE77BA.7060406@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Multi channel A2DP streaming
References: <20060130200806.D2BED445F3@smtp3-g19.free.fr>
In-Reply-To: <20060130200806.D2BED445F3@smtp3-g19.free.fr>
Content-Type: text/plain; charset=windows-1252
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 30 Jan 2006 13:31:54 -0700

Grégory

> As you know the bandwidth of Bluetooth is limited, and it’s not possible
> to transmit two high qualities A2DP streaming by using the SBC Codec. Is
> it possible to use the MP3 codec with Bluez stack?

If you have an a2dp sink that can support mp3, you will be able to fit
in more or higher-quality streams. I'd guess mp3 compresses to about
half the size of a comparably-lossy sbc. If you want the mp3 sink to run
linux, we need your help in extending a2recv to advertise and accept
mp3. It needs to do this according to the bluetooth spec.

You can always change the compression parameters. With high-quality sbc
settings I think about 400kbps is used up. Two streams will fit if you
reduce the quality settings. The difference in quality may not be that
noticable with the cheap earphones most people are using with portable
headsets.

Giving a2play more '-t' flags will make it use lower quality settings,
but I need to change it so it doesn't switch to 4 subbands. Victor
figures 4 subbands uses more bandwitch than 8.

> Do you know, how many high quality audio fluxes in parallel it’s
> possible to have with a BT V1.2 and a BT V2 EDR module?

But are the a2dp sink devices running edr?

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
